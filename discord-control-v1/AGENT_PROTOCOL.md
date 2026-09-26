# Market Scanner Discord Control V1 - Agent Protocol

## 구조

Delta 모바일 <-> 집 PC API <-> SQLite <-> Discord Bot

Discord Bot 토큰은 PC에만 저장합니다. Delta에는 Bot 토큰을 넣지 않습니다.

## 인증

모바일 요청은 아래 헤더를 사용합니다.

```
X-Agent-Token: <AGENT_TOKEN>
```

## 1. 생존/상태 전송

`POST /agent/heartbeat`

예시:

```json
{
  "device_id": "market-mobile-1",
  "account": "Onyyxten2020",
  "place_id": 134708228958679,
  "running": true,
  "current": "슈퍼 에이스 파일럿 · 2성",
  "cycle": 128,
  "scans": 8240,
  "finds": 21,
  "urgent_finds": 4,
  "errors": 0,
  "scan_order": ["Soldier|649", "Soldier|26"],
  "selected_settings": {
    "Soldier|649": {
      "stars": [0,1,2,3],
      "star_prices": {"0":600000,"1":1200000}
    }
  }
}
```

권장 주기: 20~30초.

## 2. 카탈로그 동기화

`POST /agent/catalog`

모바일 시작 시 1회 전송합니다.

```json
{
  "device_id": "market-mobile-1",
  "items": [
    {
      "key": "Soldier|649",
      "name": "Super Ace Pilot",
      "ko": "슈퍼 에이스 파일럿",
      "class": "Soldier",
      "starred": true
    }
  ]
}
```

Discord 검색은 한글명/영문명/내부 ID를 모두 대상으로 하고 공백과 대소문자를 무시합니다.

## 3. 발견 기록 전송

`POST /agent/listing`

```json
{
  "device_id": "market-mobile-1",
  "item_key": "Soldier|26",
  "item_ko": "공군 사령관",
  "item_name": "Air Commander",
  "star_label": "0성",
  "price": 300000,
  "found_at": 1790438414,
  "urgent": false,
  "job_id": "..."
}
```

`found_at`은 판매자가 등록한 시간이 아니라 스캐너가 최초 발견한 시각입니다.

## 4. Discord -> 모바일 명령

모바일은 `GET /agent/commands/{device_id}`를 5~10초마다 확인합니다.

명령 예:

```json
[
  {"id":1,"type":"add_item","payload":{"key":"Vehicle|214"}},
  {"id":2,"type":"move_item","payload":{"key":"Vehicle|214","delta":-1}},
  {"id":3,"type":"remove_item","payload":{"key":"Vehicle|214"}},
  {"id":4,"type":"pause","payload":{}}
]
```

지원 예정 명령:

- `add_item`: 조사목록 맨 마지막에 추가
- `remove_item`: 목록에서만 제거하고 기존 성급/긴급가 설정 보존
- `move_item`: delta -1 = 한 칸 위, +1 = 한 칸 아래
- `set_stars`: 조회 성급 변경
- `set_star_prices`: 성급별 긴급가 변경
- `pause`
- `resume`

적용 후:

`POST /agent/commands/{id}/ack`

```json
{"device_id":"market-mobile-1","ok":true,"message":"적용 완료"}
```
