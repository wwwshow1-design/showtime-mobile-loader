import asyncio
import json
import os
import time
import re
from collections import defaultdict
from datetime import datetime
from zoneinfo import ZoneInfo

import aiosqlite
import discord
from aiohttp import web
from discord.ext import commands
from dotenv import load_dotenv

load_dotenv()

BOT_TOKEN = os.getenv("DISCORD_BOT_TOKEN", "").strip()
GUILD_ID = int(os.getenv("DISCORD_GUILD_ID", "0") or 0)
ALLOWED_USERS = {
    int(x.strip())
    for x in os.getenv("DISCORD_USER_IDS", "").split(",")
    if x.strip().isdigit()
}
AGENT_TOKEN = os.getenv("AGENT_TOKEN", "").strip()
DEVICE_ID = os.getenv("CONTROL_DEVICE_ID", "market-mobile-1").strip()
HOST = os.getenv("CONTROL_HOST", "0.0.0.0").strip()
PORT = int(os.getenv("CONTROL_PORT", "8765"))
DB_PATH = os.getenv("DB_PATH", "market_control.db").strip()

KST = ZoneInfo("Asia/Seoul")
PAGE_SIZE = 8
RAW_SCANNER_BASE = "https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/market-scanner/v3.4.0/"


CLASS_KO = {
    "Air": "공중",
    "Ground": "지상",
    "Naval": "해군",
    "Drone": "드론",
    "Soldier": "군인",
    "Tool": "무기",
    "Armor": "갑옷",
}

def now_ts() -> int:
    return int(time.time())

def fmt_kst(ts):
    if not ts:
        return "-"
    dt = datetime.fromtimestamp(float(ts), tz=KST)
    ampm = "오전" if dt.hour < 12 else "오후"
    hour = dt.hour % 12 or 12
    return f"{dt.year % 100:02d}년 {dt.month:02d}월 {dt.day:02d}일 {ampm} {hour:02d}시 {dt.minute:02d}분:{dt.second:02d}초"

def normalize_search(text: str) -> str:
    return "".join((text or "").lower().split())

def comma(value) -> str:
    try:
        return f"{int(value):,}"
    except Exception:
        return "?"

def is_allowed(user_id: int) -> bool:
    return not ALLOWED_USERS or user_id in ALLOWED_USERS

async def deny_if_needed(interaction: discord.Interaction) -> bool:
    if is_allowed(interaction.user.id):
        return False
    if interaction.response.is_done():
        await interaction.followup.send("이 관제판을 사용할 권한이 없습니다.", ephemeral=True)
    else:
        await interaction.response.send_message("이 관제판을 사용할 권한이 없습니다.", ephemeral=True)
    return True


def contains_any(text, words):
    text = (text or "").lower()
    return any(word.lower() in text for word in words)

def classify_vehicle(item):
    text = f"{item.get('name','')} {item.get('id','')}".lower()
    naval = [
        "submarine","sub ","destroyer","battleship","warship","frigate","cruiser",
        "missouri","bismarck","yacht","boat","ship","naval","dinghy","corvette",
        "uav carrier","aircraft carrier","super carrier","carrier ship","hovercraft",
        "patrol boat","gunboat","jetski","jet ski","sea","ocean","amphibious assault",
    ]
    if contains_any(text, naval) and "air carrier" not in text:
        return "Naval"

    air = [
        "jet","plane","fighter","bomber","helicopter","heli","apache","black hawk",
        "chinook","osprey","hind","little bird","cobra","havoc","ka-","mi-","uh-",
        "f14","f-14","f15","f-15","f16","f-16","f18","f-18","f22","f-22","f35","f-35",
        "a10","a-10","a37","a-37","a50","a-50","ac119","ac-119","ac130","ac-130",
        "b1","b-1","b2","b-2","b52","b-52","c130","c-130","su-","mig","rafale",
        "eurofighter","typhoon","gripen","mirage","tornado","vulcan","spitfire",
        "mustang","flying","air carrier","ahrla","awacs","beriev","antonov","drone plane",
    ]
    if contains_any(text, air):
        return "Air"
    return "Ground"

async def bootstrap_catalog():
    try:
        parts = []
        async with __import__("aiohttp").ClientSession() as session:
            for i in range(1, 13):
                url = RAW_SCANNER_BASE + f"part{i:02d}.txt"
                async with session.get(url, timeout=20) as response:
                    response.raise_for_status()
                    parts.append(await response.text())
        source = "".join(parts)
        match = re.search(r"local CATALOG_JSON\s*=\s*\[==\[(.*?)\]==\]", source, re.S)
        if not match:
            print("Catalog bootstrap skipped: CATALOG_JSON not found")
            return
        items = json.loads(match.group(1))
        for item in items:
            if item.get("class") == "Vehicle":
                item["class"] = classify_vehicle(item)
        await store.replace_catalog(items)
        print(f"Catalog loaded from scanner: {len(items)} items")
    except Exception as exc:
        print(f"Catalog bootstrap failed: {exc}")


class Store:
    def __init__(self, path: str):
        self.path = path

    async def init(self):
        async with aiosqlite.connect(self.path) as db:
            await db.executescript(
                """
                PRAGMA journal_mode=WAL;

                CREATE TABLE IF NOT EXISTS agent_state (
                    device_id TEXT PRIMARY KEY,
                    account TEXT NOT NULL DEFAULT '',
                    place_id INTEGER NOT NULL DEFAULT 0,
                    running INTEGER NOT NULL DEFAULT 0,
                    current TEXT NOT NULL DEFAULT '',
                    cycle INTEGER NOT NULL DEFAULT 0,
                    scans INTEGER NOT NULL DEFAULT 0,
                    finds INTEGER NOT NULL DEFAULT 0,
                    urgent_finds INTEGER NOT NULL DEFAULT 0,
                    errors INTEGER NOT NULL DEFAULT 0,
                    scan_order_json TEXT NOT NULL DEFAULT '[]',
                    selected_settings_json TEXT NOT NULL DEFAULT '{}',
                    last_seen INTEGER NOT NULL DEFAULT 0
                );

                CREATE TABLE IF NOT EXISTS catalog (
                    item_key TEXT PRIMARY KEY,
                    name TEXT NOT NULL,
                    ko TEXT NOT NULL,
                    class TEXT NOT NULL,
                    starred INTEGER NOT NULL DEFAULT 0,
                    search_norm TEXT NOT NULL
                );

                CREATE TABLE IF NOT EXISTS listings (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    device_id TEXT NOT NULL,
                    item_key TEXT NOT NULL,
                    item_ko TEXT NOT NULL,
                    item_name TEXT NOT NULL,
                    star_label TEXT NOT NULL,
                    price INTEGER NOT NULL,
                    found_at INTEGER NOT NULL,
                    urgent INTEGER NOT NULL DEFAULT 0,
                    job_id TEXT NOT NULL DEFAULT ''
                );

                CREATE INDEX IF NOT EXISTS idx_listings_found_at
                    ON listings(found_at DESC);

                CREATE TABLE IF NOT EXISTS commands (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    device_id TEXT NOT NULL,
                    command_type TEXT NOT NULL,
                    payload_json TEXT NOT NULL DEFAULT '{}',
                    status TEXT NOT NULL DEFAULT 'pending',
                    result_message TEXT NOT NULL DEFAULT '',
                    created_at INTEGER NOT NULL,
                    ack_at INTEGER NOT NULL DEFAULT 0
                );
                """
            )
            await db.commit()

    async def upsert_heartbeat(self, data: dict):
        async with aiosqlite.connect(self.path) as db:
            await db.execute(
                """
                INSERT INTO agent_state (
                    device_id, account, place_id, running, current, cycle,
                    scans, finds, urgent_finds, errors, scan_order_json,
                    selected_settings_json, last_seen
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ON CONFLICT(device_id) DO UPDATE SET
                    account=excluded.account,
                    place_id=excluded.place_id,
                    running=excluded.running,
                    current=excluded.current,
                    cycle=excluded.cycle,
                    scans=excluded.scans,
                    finds=excluded.finds,
                    urgent_finds=excluded.urgent_finds,
                    errors=excluded.errors,
                    scan_order_json=excluded.scan_order_json,
                    selected_settings_json=excluded.selected_settings_json,
                    last_seen=excluded.last_seen
                """,
                (
                    data.get("device_id", DEVICE_ID),
                    str(data.get("account", "")),
                    int(data.get("place_id", 0) or 0),
                    1 if data.get("running") else 0,
                    str(data.get("current", "")),
                    int(data.get("cycle", 0) or 0),
                    int(data.get("scans", 0) or 0),
                    int(data.get("finds", 0) or 0),
                    int(data.get("urgent_finds", 0) or 0),
                    int(data.get("errors", 0) or 0),
                    json.dumps(data.get("scan_order") or [], ensure_ascii=False),
                    json.dumps(data.get("selected_settings") or {}, ensure_ascii=False),
                    now_ts(),
                ),
            )
            await db.commit()

    async def get_state(self, device_id: str = DEVICE_ID) -> dict:
        async with aiosqlite.connect(self.path) as db:
            db.row_factory = aiosqlite.Row
            row = await (await db.execute(
                "SELECT * FROM agent_state WHERE device_id=?", (device_id,)
            )).fetchone()
        if not row:
            return {
                "device_id": device_id,
                "account": "",
                "place_id": 0,
                "running": False,
                "current": "",
                "cycle": 0,
                "scans": 0,
                "finds": 0,
                "urgent_finds": 0,
                "errors": 0,
                "scan_order": [],
                "selected_settings": {},
                "last_seen": 0,
            }
        d = dict(row)
        d["running"] = bool(d["running"])
        try:
            d["scan_order"] = json.loads(d.pop("scan_order_json"))
        except Exception:
            d["scan_order"] = []
        try:
            d["selected_settings"] = json.loads(d.pop("selected_settings_json"))
        except Exception:
            d["selected_settings"] = {}
        return d

    async def replace_catalog(self, items):
        async with aiosqlite.connect(self.path) as db:
            await db.execute("DELETE FROM catalog")
            rows = []
            for item in items:
                key = str(item.get("key", ""))
                name = str(item.get("name", ""))
                ko = str(item.get("ko", name))
                cls = str(item.get("class", ""))
                starred = 1 if item.get("starred") else 0
                search_norm = normalize_search(f"{ko} {name} {key}")
                if key:
                    rows.append((key, name, ko, cls, starred, search_norm))
            await db.executemany(
                """
                INSERT OR REPLACE INTO catalog
                (item_key,name,ko,class,starred,search_norm)
                VALUES (?,?,?,?,?,?)
                """,
                rows,
            )
            await db.commit()

    async def search_items(self, query="", category=None):
        q = normalize_search(query)
        sql = "SELECT item_key,name,ko,class,starred FROM catalog WHERE 1=1"
        params = []
        if category:
            sql += " AND class=?"
            params.append(category)
        if q:
            sql += " AND search_norm LIKE ?"
            params.append(f"%{q}%")
        sql += " ORDER BY ko COLLATE NOCASE, name COLLATE NOCASE"
        async with aiosqlite.connect(self.path) as db:
            db.row_factory = aiosqlite.Row
            rows = await (await db.execute(sql, params)).fetchall()
        return [dict(x) for x in rows]

    async def get_item(self, item_key):
        async with aiosqlite.connect(self.path) as db:
            db.row_factory = aiosqlite.Row
            row = await (await db.execute(
                "SELECT item_key,name,ko,class,starred FROM catalog WHERE item_key=?",
                (item_key,),
            )).fetchone()
        return dict(row) if row else None

    async def add_listing(self, data):
        async with aiosqlite.connect(self.path) as db:
            await db.execute(
                """
                INSERT INTO listings (
                    device_id,item_key,item_ko,item_name,star_label,
                    price,found_at,urgent,job_id
                ) VALUES (?,?,?,?,?,?,?,?,?)
                """,
                (
                    str(data.get("device_id", DEVICE_ID)),
                    str(data.get("item_key", "")),
                    str(data.get("item_ko", "")),
                    str(data.get("item_name", "")),
                    str(data.get("star_label", "성급 없음")),
                    int(data.get("price", 0) or 0),
                    int(data.get("found_at", now_ts()) or now_ts()),
                    1 if data.get("urgent") else 0,
                    str(data.get("job_id", "")),
                ),
            )
            await db.commit()

    async def get_listings(self, limit=500):
        async with aiosqlite.connect(self.path) as db:
            db.row_factory = aiosqlite.Row
            rows = await (await db.execute(
                "SELECT * FROM listings ORDER BY found_at DESC LIMIT ?", (limit,)
            )).fetchall()
        return [dict(x) for x in rows]

    async def get_today_listings(self):
        now = datetime.now(KST)
        start = datetime(now.year, now.month, now.day, tzinfo=KST).timestamp()
        async with aiosqlite.connect(self.path) as db:
            db.row_factory = aiosqlite.Row
            rows = await (await db.execute(
                "SELECT * FROM listings WHERE found_at>=? ORDER BY found_at ASC",
                (int(start),),
            )).fetchall()
        return [dict(x) for x in rows]

    async def enqueue(self, command_type, payload, device_id=DEVICE_ID):
        async with aiosqlite.connect(self.path) as db:
            cur = await db.execute(
                """
                INSERT INTO commands
                (device_id,command_type,payload_json,status,created_at)
                VALUES (?,?,?,?,?)
                """,
                (
                    device_id,
                    command_type,
                    json.dumps(payload, ensure_ascii=False),
                    "pending",
                    now_ts(),
                ),
            )
            await db.commit()
            return int(cur.lastrowid)

    async def pending_commands(self, device_id):
        async with aiosqlite.connect(self.path) as db:
            db.row_factory = aiosqlite.Row
            rows = await (await db.execute(
                """
                SELECT * FROM commands
                WHERE device_id=? AND status IN ('pending','sent')
                ORDER BY id ASC LIMIT 30
                """,
                (device_id,),
            )).fetchall()
            ids = [row["id"] for row in rows]
            if ids:
                await db.executemany(
                    "UPDATE commands SET status='sent' WHERE id=? AND status='pending'",
                    [(x,) for x in ids],
                )
                await db.commit()
        return [
            {
                "id": row["id"],
                "type": row["command_type"],
                "payload": json.loads(row["payload_json"] or "{}"),
            }
            for row in rows
        ]

    async def ack_command(self, command_id, ok, message):
        async with aiosqlite.connect(self.path) as db:
            await db.execute(
                """
                UPDATE commands
                SET status=?, result_message=?, ack_at=?
                WHERE id=?
                """,
                ("acked" if ok else "failed", message, now_ts(), command_id),
            )
            await db.commit()


store = Store(DB_PATH)


async def selected_context():
    state = await store.get_state()
    order = state.get("scan_order") or []
    settings = state.get("selected_settings") or {}
    return state, order, settings, set(order)


def status_embed(state):
    age = max(0, now_ts() - int(state.get("last_seen", 0) or 0))
    connected = bool(state.get("last_seen")) and age <= 60
    color = discord.Color.green() if connected and state.get("running") else (
        discord.Color.orange() if connected else discord.Color.red()
    )
    embed = discord.Embed(
        title="📡 거래소 스캐너 상태",
        color=color,
        description=(
            f"{'🟢 연결됨' if connected else '🔴 연결 끊김'}\n"
            f"{'🟢 조사 중' if state.get('running') else '⏸ 조사 정지'}"
        ),
    )
    embed.add_field(name="계정", value=state.get("account") or "-", inline=True)
    embed.add_field(name="현재 회차", value=f"{state.get('cycle',0):,}회", inline=True)
    embed.add_field(name="오류", value=f"{state.get('errors',0):,}건", inline=True)
    embed.add_field(name="현재 조회", value=state.get("current") or "-", inline=False)
    embed.add_field(name="오늘 발견", value=f"{state.get('finds',0):,}건", inline=True)
    embed.add_field(name="긴급 발견", value=f"{state.get('urgent_finds',0):,}건", inline=True)
    embed.add_field(name="모바일 마지막 연결", value=fmt_kst(state.get("last_seen")), inline=False)
    return embed


def main_embed(state):
    age = max(0, now_ts() - int(state.get("last_seen", 0) or 0))
    online = bool(state.get("last_seen")) and age <= 60
    embed = discord.Embed(
        title="📡 MARKET SCANNER",
        description="**거래소 원격 관제 V1**",
        color=discord.Color.green() if online and state.get("running") else discord.Color.dark_grey(),
    )
    embed.add_field(
        name="상태",
        value=("🟢 정상 작동 중" if online and state.get("running")
               else "🟡 연결됨 · 조사 정지" if online
               else "🔴 모바일 연결 없음"),
        inline=False,
    )
    embed.add_field(name="현재 조회", value=state.get("current") or "-", inline=False)
    embed.add_field(name="현재 회차", value=f"{state.get('cycle',0):,}회", inline=True)
    embed.add_field(name="오늘 발견", value=f"{state.get('finds',0):,}건", inline=True)
    embed.add_field(name="긴급 발견", value=f"{state.get('urgent_finds',0):,}건", inline=True)
    embed.add_field(name="최근 모바일 연결", value=fmt_kst(state.get("last_seen")), inline=False)
    embed.set_footer(text="버튼을 눌러 원격 관제 메뉴를 엽니다.")
    return embed


async def build_item_list_embed(items, selected, title, page):
    pages = max(1, (len(items) + PAGE_SIZE - 1) // PAGE_SIZE)
    page = max(0, min(page, pages - 1))
    start = page * PAGE_SIZE
    current = items[start:start + PAGE_SIZE]
    lines = []
    for i, item in enumerate(current):
        check = " ✅" if item["item_key"] in selected else ""
        lines.append(f"**{start+i+1}. {item['ko']}**\n{item['name']}{check}")
    embed = discord.Embed(
        title=title,
        description="\n\n".join(lines) if lines else "검색 결과가 없습니다.",
        color=discord.Color.blurple(),
    )
    embed.set_footer(text=f"총 {len(items)}개 · {page+1} / {pages} 페이지")
    return embed, current, page, pages


def item_detail_embed(item, order, settings):
    key = item["item_key"]
    selected = key in order
    pos = order.index(key) + 1 if selected else None
    cls = CLASS_KO.get(item.get("class"), item.get("class") or "-")
    embed = discord.Embed(
        title=f"{'⭐ ' if item.get('starred') else ''}{item['ko']}",
        description=item["name"],
        color=discord.Color.green() if selected else discord.Color.blurple(),
    )
    embed.add_field(name="분류", value=cls, inline=True)
    embed.add_field(name="성급", value="있음" if item.get("starred") else "없음", inline=True)
    embed.add_field(
        name="상태",
        value=f"✅ 현재 조사 중 · {pos}번째" if selected else "현재 조사하지 않음",
        inline=False,
    )
    if selected and item.get("starred"):
        cfg = settings.get(key) or {}
        stars = cfg.get("stars") or []
        embed.add_field(
            name="조회 성급",
            value=" · ".join(f"{x}성" for x in stars) if stars else "없음",
            inline=False,
        )
    return embed


class SearchModal(discord.ui.Modal, title="장비 이름 검색"):
    query = discord.ui.TextInput(
        label="한글 또는 영문 장비 이름",
        placeholder="예: 슈퍼에이스 / superace / 공군 / commander",
        max_length=80,
    )

    async def on_submit(self, interaction):
        if await deny_if_needed(interaction):
            return
        items = await store.search_items(str(self.query))
        _, _, _, selected = await selected_context()
        title = f'🔎 "{self.query}" 검색 결과'
        embed, _, _, _ = await build_item_list_embed(items, selected, title, 0)
        await interaction.response.send_message(
            embed=embed, view=ItemListView(items, title, 0), ephemeral=True
        )


class CategoryButton(discord.ui.Button):
    def __init__(self, label, category, row):
        super().__init__(label=label, style=discord.ButtonStyle.secondary, row=row)
        self.category = category

    async def callback(self, interaction):
        if await deny_if_needed(interaction):
            return
        items = await store.search_items("", self.category)
        _, _, _, selected = await selected_context()
        title = f"📦 {self.label} 장비"
        embed, _, _, _ = await build_item_list_embed(items, selected, title, 0)
        await interaction.response.send_message(
            embed=embed, view=ItemListView(items, title, 0), ephemeral=True
        )


class SearchHubView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=600)
        cats = [
            ("전체", None, 0), ("공중", "Air", 0), ("지상", "Ground", 0), ("해군", "Naval", 0),
            ("드론", "Drone", 1), ("군인", "Soldier", 1), ("무기", "Tool", 1), ("갑옷", "Armor", 1),
        ]
        for label, category, row in cats:
            self.add_item(CategoryButton(label, category, row))

    @discord.ui.button(label="🔍 이름으로 검색", style=discord.ButtonStyle.primary, row=2)
    async def search_name(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        await interaction.response.send_modal(SearchModal())


class ItemSelect(discord.ui.Select):
    def __init__(self, current_items, parent_view):
        options = [
            discord.SelectOption(
                label=item["ko"][:100],
                description=item["name"][:100],
                value=item["item_key"],
            )
            for item in current_items
        ]
        if not options:
            options = [discord.SelectOption(label="결과 없음", value="__none__")]
        super().__init__(
            placeholder="장비 선택",
            min_values=1,
            max_values=1,
            options=options,
            row=0,
            disabled=not bool(current_items),
        )
        self.parent_view = parent_view

    async def callback(self, interaction):
        if await deny_if_needed(interaction):
            return
        key = self.values[0]
        if key == "__none__":
            return
        item = await store.get_item(key)
        _, order, settings, _ = await selected_context()
        if not item:
            await interaction.response.send_message("장비 정보를 찾지 못했습니다.", ephemeral=True)
            return
        await interaction.response.edit_message(
            embed=item_detail_embed(item, order, settings),
            view=ItemDetailView(item),
        )


class ItemListView(discord.ui.View):
    def __init__(self, items, title, page=0):
        super().__init__(timeout=600)
        self.items = items
        self.title = title
        self.page = max(0, page)
        current = items[self.page * PAGE_SIZE:(self.page + 1) * PAGE_SIZE]
        self.add_item(ItemSelect(current, self))

    async def redraw(self, interaction, page):
        _, _, _, selected = await selected_context()
        embed, _, page, _ = await build_item_list_embed(self.items, selected, self.title, page)
        await interaction.response.edit_message(
            embed=embed, view=ItemListView(self.items, self.title, page)
        )

    @discord.ui.button(label="◀ 이전", style=discord.ButtonStyle.secondary, row=1)
    async def prev_page(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        await self.redraw(interaction, max(0, self.page - 1))

    @discord.ui.button(label="다음 ▶", style=discord.ButtonStyle.secondary, row=1)
    async def next_page(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        pages = max(1, (len(self.items) + PAGE_SIZE - 1) // PAGE_SIZE)
        await self.redraw(interaction, min(pages - 1, self.page + 1))

    @discord.ui.button(label="🔍 다시 검색", style=discord.ButtonStyle.primary, row=1)
    async def search_again(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        await interaction.response.send_modal(SearchModal())


class PriceModal(discord.ui.Modal, title="긴급가 설정"):
    star = discord.ui.TextInput(
        label="성급",
        placeholder="성급 장비: 0~5 / 성급 없는 장비: 비워두기",
        required=False,
        max_length=1,
    )
    price = discord.ui.TextInput(label="긴급가", placeholder="예: 600000", max_length=15)

    def __init__(self, item):
        super().__init__()
        self.item = item

    async def on_submit(self, interaction):
        if await deny_if_needed(interaction):
            return
        raw = str(self.price).replace(",", "").strip()
        if not raw.isdigit():
            await interaction.response.send_message("가격은 숫자로 입력해주세요.", ephemeral=True)
            return
        price = int(raw)
        if self.item.get("starred"):
            star = str(self.star).strip()
            if star not in {"0","1","2","3","4","5"}:
                await interaction.response.send_message("성급은 0~5 중 하나를 입력해주세요.", ephemeral=True)
                return
            cmd = await store.enqueue(
                "set_star_prices",
                {"key": self.item["item_key"], "prices": {star: price}},
            )
        else:
            cmd = await store.enqueue(
                "set_item_price",
                {"key": self.item["item_key"], "price": price},
            )
        await interaction.response.send_message(
            f"✅ 긴급가 변경 명령 #{cmd} 전송 완료\n모바일 적용 후 상태가 갱신됩니다.",
            ephemeral=True,
        )


class StarToggleButton(discord.ui.Button):
    def __init__(self, star, enabled, view_ref):
        super().__init__(
            label=f"{star}성 {'ON' if enabled else 'OFF'}",
            style=discord.ButtonStyle.success if enabled else discord.ButtonStyle.danger,
            row=star // 3,
        )
        self.star = star
        self.enabled_state = enabled
        self.view_ref = view_ref

    async def callback(self, interaction):
        if await deny_if_needed(interaction):
            return
        if self.enabled_state:
            self.view_ref.stars.discard(self.star)
        else:
            self.view_ref.stars.add(self.star)
        cmd = await store.enqueue(
            "set_stars",
            {"key": self.view_ref.item["item_key"], "stars": sorted(self.view_ref.stars)},
        )
        view = StarSettingsView(self.view_ref.item, self.view_ref.stars)
        text = " · ".join(f"{x}성" for x in sorted(self.view_ref.stars)) or "없음"
        embed = discord.Embed(
            title=f"⭐ {self.view_ref.item['ko']} · 조회 성급",
            description=f"현재 선택: **{text}**\n\n명령 #{cmd} 전송됨",
            color=discord.Color.blurple(),
        )
        await interaction.response.edit_message(embed=embed, view=view)


class StarSettingsView(discord.ui.View):
    def __init__(self, item, stars):
        super().__init__(timeout=600)
        self.item = item
        self.stars = set(int(x) for x in stars)
        for star in range(6):
            self.add_item(StarToggleButton(star, star in self.stars, self))


class RemoveConfirmView(discord.ui.View):
    def __init__(self, item):
        super().__init__(timeout=120)
        self.item = item

    @discord.ui.button(label="✅ 제거하기", style=discord.ButtonStyle.danger)
    async def confirm(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        cmd = await store.enqueue("remove_item", {"key": self.item["item_key"]})
        await interaction.response.edit_message(
            content=(
                f"✅ **{self.item['ko']}** 제거 명령 #{cmd} 전송 완료\n"
                "성급/긴급가 설정값은 보존됩니다."
            ),
            embed=None,
            view=None,
        )

    @discord.ui.button(label="취소", style=discord.ButtonStyle.secondary)
    async def cancel(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        await interaction.response.edit_message(content="제거를 취소했습니다.", embed=None, view=None)


class ItemDetailView(discord.ui.View):
    def __init__(self, item):
        super().__init__(timeout=600)
        self.item = item

    async def current(self):
        state, order, settings, selected = await selected_context()
        return state, order, settings, self.item["item_key"] in selected

    @discord.ui.button(label="➕ 조사 장비에 추가", style=discord.ButtonStyle.success, row=0)
    async def add_item(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        _, _, _, selected = await self.current()
        if selected:
            await interaction.response.send_message("이미 조사 중인 장비입니다.", ephemeral=True)
            return
        cmd = await store.enqueue("add_item", {"key": self.item["item_key"]})
        await interaction.response.send_message(
            f"✅ **{self.item['ko']}** 추가 명령 #{cmd} 전송 완료\n"
            "새 장비는 현재 조회 순서의 맨 마지막에 추가됩니다.",
            ephemeral=True,
        )

    @discord.ui.button(label="⭐ 성급 설정", style=discord.ButtonStyle.primary, row=0)
    async def stars(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        _, _, settings, _ = await self.current()
        if not self.item.get("starred"):
            await interaction.response.send_message("이 장비는 성급 설정이 없습니다.", ephemeral=True)
            return
        cfg = settings.get(self.item["item_key"]) or {}
        stars = cfg.get("stars") or [0,1,2,3]
        embed = discord.Embed(
            title=f"⭐ {self.item['ko']} · 조회 성급",
            description="버튼을 누르면 ON/OFF가 바뀝니다.",
            color=discord.Color.blurple(),
        )
        await interaction.response.send_message(
            embed=embed, view=StarSettingsView(self.item, stars), ephemeral=True
        )

    @discord.ui.button(label="💎 긴급가 설정", style=discord.ButtonStyle.primary, row=0)
    async def prices(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        await interaction.response.send_modal(PriceModal(self.item))

    @discord.ui.button(label="↑ 한 칸 위", style=discord.ButtonStyle.secondary, row=1)
    async def move_up(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        cmd = await store.enqueue("move_item", {"key": self.item["item_key"], "delta": -1})
        await interaction.response.send_message(f"↑ 한 칸 위 이동 명령 #{cmd} 전송 완료", ephemeral=True)

    @discord.ui.button(label="↓ 한 칸 아래", style=discord.ButtonStyle.secondary, row=1)
    async def move_down(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        cmd = await store.enqueue("move_item", {"key": self.item["item_key"], "delta": 1})
        await interaction.response.send_message(f"↓ 한 칸 아래 이동 명령 #{cmd} 전송 완료", ephemeral=True)

    @discord.ui.button(label="❌ 조사에서 제거", style=discord.ButtonStyle.danger, row=1)
    async def remove(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        await interaction.response.send_message(
            f"⚠ **{self.item['ko']}**을 조사 목록에서 제거할까요?\n"
            "기존 성급/긴급가 설정은 보존됩니다.",
            view=RemoveConfirmView(self.item),
            ephemeral=True,
        )


class SelectionSelect(discord.ui.Select):
    def __init__(self, items):
        options = [
            discord.SelectOption(label=x["ko"][:100], description=x["name"][:100], value=x["item_key"])
            for x in items
        ]
        if not options:
            options = [discord.SelectOption(label="선택 장비 없음", value="__none__")]
        super().__init__(
            placeholder="관리할 장비 선택",
            options=options,
            disabled=not bool(items),
            row=0,
        )

    async def callback(self, interaction):
        if await deny_if_needed(interaction):
            return
        if self.values[0] == "__none__":
            return
        item = await store.get_item(self.values[0])
        _, order, settings, _ = await selected_context()
        if not item:
            await interaction.response.send_message("장비 정보를 찾지 못했습니다.", ephemeral=True)
            return
        await interaction.response.edit_message(
            embed=item_detail_embed(item, order, settings),
            view=ItemDetailView(item),
        )


class SelectionListView(discord.ui.View):
    def __init__(self, items, page=0):
        super().__init__(timeout=600)
        self.items = items
        self.page = page
        current = items[page * PAGE_SIZE:(page + 1) * PAGE_SIZE]
        self.add_item(SelectionSelect(current))

    @classmethod
    async def build(cls, page=0):
        _, order, _, _ = await selected_context()
        catalog = {x["item_key"]: x for x in await store.search_items()}
        items = [catalog[k] for k in order if k in catalog]
        pages = max(1, (len(items) + PAGE_SIZE - 1) // PAGE_SIZE)
        page = max(0, min(page, pages - 1))
        start = page * PAGE_SIZE
        current = items[start:start + PAGE_SIZE]
        lines = [
            f"**{start+i+1}. {x['ko']}**\n{x['name']}"
            for i, x in enumerate(current)
        ]
        embed = discord.Embed(
            title="📋 선택 관리",
            description="\n\n".join(lines) if lines else "현재 조사 중인 장비가 없습니다.",
            color=discord.Color.blurple(),
        )
        embed.set_footer(text=f"현재 {len(items)}개 · {page+1} / {pages} 페이지")
        return embed, cls(items, page), pages

    @discord.ui.button(label="◀ 이전", style=discord.ButtonStyle.secondary, row=1)
    async def prev(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        embed, view, _ = await SelectionListView.build(max(0, self.page - 1))
        await interaction.response.edit_message(embed=embed, view=view)

    @discord.ui.button(label="다음 ▶", style=discord.ButtonStyle.secondary, row=1)
    async def next(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        _, _, pages = await SelectionListView.build(self.page)
        embed, view, _ = await SelectionListView.build(min(pages - 1, self.page + 1))
        await interaction.response.edit_message(embed=embed, view=view)

    @discord.ui.button(label="➕ 장비 추가", style=discord.ButtonStyle.success, row=1)
    async def add(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        await interaction.response.send_modal(SearchModal())


def listing_pages(rows, max_chars=3200):
    if not rows:
        return ["발견 기록이 없습니다."]
    chunks, cur = [], ""
    for row in rows:
        block = (
            f"**{row['item_ko']} · {row['star_label']}**\n"
            f"• {comma(row['price'])} 다이아 · {fmt_kst(row['found_at'])}"
            f"{' 🚨' if row['urgent'] else ''}\n\n"
        )
        if cur and len(cur) + len(block) > max_chars:
            chunks.append(cur.rstrip())
            cur = ""
        cur += block
    if cur:
        chunks.append(cur.rstrip())
    return chunks


class PagerView(discord.ui.View):
    def __init__(self, title, pages, page=0):
        super().__init__(timeout=600)
        self.title = title
        self.pages = pages
        self.page = page

    async def render(self, interaction, page):
        page = max(0, min(page, len(self.pages)-1))
        embed = discord.Embed(
            title=self.title,
            description=self.pages[page],
            color=discord.Color.blurple(),
        )
        embed.set_footer(text=f"{page+1} / {len(self.pages)} 페이지")
        await interaction.response.edit_message(
            embed=embed, view=PagerView(self.title, self.pages, page)
        )

    @discord.ui.button(label="◀ 이전", style=discord.ButtonStyle.secondary)
    async def prev(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        await self.render(interaction, self.page - 1)

    @discord.ui.button(label="다음 ▶", style=discord.ButtonStyle.secondary)
    async def next(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        await self.render(interaction, self.page + 1)


def today_stat_pages(rows):
    if not rows:
        return ["오늘 발견된 신규 매물이 없습니다."]

    grouped = defaultdict(list)
    buckets = [0, 0, 0, 0]
    for row in rows:
        grouped[(row["item_ko"], row["star_label"])].append(row)
        h = datetime.fromtimestamp(row["found_at"], tz=KST).hour
        buckets[min(3, h // 6)] += 1

    prefix = (
        f"**⏰ 전체 발견 시간대**\n"
        f"00~06시  {buckets[0]}건\n"
        f"06~12시  {buckets[1]}건\n"
        f"12~18시  {buckets[2]}건\n"
        f"18~24시  {buckets[3]}건\n\n"
    )

    pages, cur = [], prefix
    for (item_ko, star_label), entries in grouped.items():
        header = f"**{item_ko} · {star_label}**\n"
        if len(cur) + len(header) > 3200:
            pages.append(cur.rstrip())
            cur = ""
        cur += header
        for row in entries:
            line = f"• {comma(row['price'])} 다이아 · {fmt_kst(row['found_at'])}"
            if row["urgent"]:
                line += " 🚨"
            line += "\n"
            if len(cur) + len(line) > 3200:
                pages.append(cur.rstrip())
                cur = f"**{item_ko} · {star_label} (계속)**\n"
            cur += line
        cur += "\n"
    if cur:
        pages.append(cur.rstrip())
    return pages


class OpsView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=600)

    @discord.ui.button(label="⏸ 조사 정지", style=discord.ButtonStyle.danger)
    async def pause(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        cmd = await store.enqueue("pause", {})
        await interaction.response.send_message(f"⏸ 정지 명령 #{cmd} 전송 완료", ephemeral=True)

    @discord.ui.button(label="▶ 조사 시작", style=discord.ButtonStyle.success)
    async def resume(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        cmd = await store.enqueue("resume", {})
        await interaction.response.send_message(f"▶ 시작 명령 #{cmd} 전송 완료", ephemeral=True)


class MainPanelView(discord.ui.View):
    def __init__(self):
        super().__init__(timeout=None)

    @discord.ui.button(label="🔎 장비 검색", style=discord.ButtonStyle.primary, custom_id="market:search", row=0)
    async def search(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        embed = discord.Embed(
            title="🔎 장비 찾기",
            description="카테고리를 고르거나 이름으로 검색하세요.",
            color=discord.Color.blurple(),
        )
        await interaction.response.send_message(embed=embed, view=SearchHubView(), ephemeral=True)

    @discord.ui.button(label="📋 선택 관리", style=discord.ButtonStyle.primary, custom_id="market:selected", row=0)
    async def selected(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        embed, view, _ = await SelectionListView.build(0)
        await interaction.response.send_message(embed=embed, view=view, ephemeral=True)

    @discord.ui.button(label="📦 발견 기록", style=discord.ButtonStyle.secondary, custom_id="market:records", row=1)
    async def records(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        pages = listing_pages(await store.get_listings(limit=500))
        embed = discord.Embed(title="📦 발견 기록", description=pages[0], color=discord.Color.blurple())
        embed.set_footer(text=f"1 / {len(pages)} 페이지")
        await interaction.response.send_message(
            embed=embed, view=PagerView("📦 발견 기록", pages, 0), ephemeral=True
        )

    @discord.ui.button(label="📊 오늘 통계", style=discord.ButtonStyle.secondary, custom_id="market:today", row=1)
    async def today(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        pages = today_stat_pages(await store.get_today_listings())
        title = f"📊 오늘 거래소 조사 결과 · {datetime.now(KST).strftime('%y년 %m월 %d일')}"
        embed = discord.Embed(title=title, description=pages[0], color=discord.Color.blue())
        embed.set_footer(text=f"1 / {len(pages)} 페이지")
        await interaction.response.send_message(
            embed=embed, view=PagerView(title, pages, 0), ephemeral=True
        )

    @discord.ui.button(label="📡 상태", style=discord.ButtonStyle.secondary, custom_id="market:status", row=2)
    async def status(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        await interaction.response.send_message(
            embed=status_embed(await store.get_state()), ephemeral=True
        )

    @discord.ui.button(label="⚙ 운영 설정", style=discord.ButtonStyle.secondary, custom_id="market:ops", row=2)
    async def ops(self, interaction, button):
        if await deny_if_needed(interaction):
            return
        state = await store.get_state()
        embed = discord.Embed(
            title="⚙ 운영 설정",
            description=f"조사 상태: {'🟢 실행 중' if state.get('running') else '⏸ 정지'}",
            color=discord.Color.dark_grey(),
        )
        await interaction.response.send_message(embed=embed, view=OpsView(), ephemeral=True)


intents = discord.Intents.default()
bot = commands.Bot(command_prefix="!", intents=intents)


@bot.tree.command(name="관제", description="거래소 스캐너 원격 관제판을 엽니다.")
async def control_panel(interaction):
    if await deny_if_needed(interaction):
        return
    await interaction.response.send_message(
        embed=main_embed(await store.get_state()), view=MainPanelView()
    )


@bot.tree.command(name="상태", description="집에 둔 거래소 스캐너의 현재 상태를 확인합니다.")
async def quick_status(interaction):
    if await deny_if_needed(interaction):
        return
    await interaction.response.send_message(
        embed=status_embed(await store.get_state()), ephemeral=True
    )


async def check_agent_token(request):
    return bool(AGENT_TOKEN) and request.headers.get("X-Agent-Token", "") == AGENT_TOKEN


async def api_health(request):
    return web.json_response({"ok": True, "time": now_ts()})


async def api_heartbeat(request):
    if not await check_agent_token(request):
        raise web.HTTPUnauthorized()
    data = await request.json()
    data["device_id"] = str(data.get("device_id") or DEVICE_ID)
    await store.upsert_heartbeat(data)
    return web.json_response({"ok": True, "server_time": now_ts()})


async def api_catalog(request):
    if not await check_agent_token(request):
        raise web.HTTPUnauthorized()
    data = await request.json()
    items = data.get("items") or []
    if not isinstance(items, list):
        raise web.HTTPBadRequest(text="items must be a list")
    await store.replace_catalog(items)
    return web.json_response({"ok": True, "count": len(items)})


async def api_listing(request):
    if not await check_agent_token(request):
        raise web.HTTPUnauthorized()
    await store.add_listing(await request.json())
    return web.json_response({"ok": True})


async def api_commands(request):
    if not await check_agent_token(request):
        raise web.HTTPUnauthorized()
    rows = await store.pending_commands(request.match_info["device_id"])
    return web.json_response(rows, dumps=lambda x: json.dumps(x, ensure_ascii=False))


async def api_ack(request):
    if not await check_agent_token(request):
        raise web.HTTPUnauthorized()
    command_id = int(request.match_info["command_id"])
    data = await request.json()
    await store.ack_command(command_id, bool(data.get("ok")), str(data.get("message", "")))
    return web.json_response({"ok": True})


api_runner = None

async def start_api():
    global api_runner
    app = web.Application(client_max_size=4 * 1024 * 1024)
    app.router.add_get("/health", api_health)
    app.router.add_post("/agent/heartbeat", api_heartbeat)
    app.router.add_post("/agent/catalog", api_catalog)
    app.router.add_post("/agent/listing", api_listing)
    app.router.add_get("/agent/commands/{device_id}", api_commands)
    app.router.add_post("/agent/commands/{command_id}/ack", api_ack)
    api_runner = web.AppRunner(app)
    await api_runner.setup()
    await web.TCPSite(api_runner, HOST, PORT).start()
    print(f"API listening on {HOST}:{PORT}")


@bot.event
async def on_ready():
    print(f"Discord bot ready: {bot.user}")


async def setup():
    await store.init()
    await bootstrap_catalog()
    await start_api()
    bot.add_view(MainPanelView())
    if GUILD_ID:
        guild = discord.Object(id=GUILD_ID)
        bot.tree.copy_global_to(guild=guild)
        await bot.tree.sync(guild=guild)
        print(f"Guild commands synced: {GUILD_ID}")
    else:
        await bot.tree.sync()
        print("Global commands synced")


async def main():
    if not BOT_TOKEN:
        raise RuntimeError("DISCORD_BOT_TOKEN이 비어 있습니다.")
    if not AGENT_TOKEN:
        raise RuntimeError("AGENT_TOKEN이 비어 있습니다.")
    await setup()
    try:
        await bot.start(BOT_TOKEN)
    finally:
        if api_runner:
            await api_runner.cleanup()


if __name__ == "__main__":
    asyncio.run(main())
