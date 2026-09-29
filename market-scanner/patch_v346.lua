-- Market Scanner V3.4.6 runtime patch
-- Applies after patch_v342.lua
-- Discord alert readability + grouped daily report
return function(source)
    if type(source) ~= "string" or not string.find(source, "V3.4.2", 1, true) then
        return nil, "V3.4.2 기준본이 아닙니다."
    end

    local function replaceBlock(startNeedle, endNeedle, replacement, label)
        local a = string.find(source, startNeedle, 1, true)
        if not a then
            return false, (label or "블록") .. " 시작점을 찾지 못했습니다."
        end
        local b = string.find(source, endNeedle, a + #startNeedle, true)
        if not b then
            return false, (label or "블록") .. " 끝점을 찾지 못했습니다."
        end
        source = source:sub(1, a - 1) .. replacement .. source:sub(b)
        return true
    end

    local ok, err

    ok, err = replaceBlock(
        "local function sendDailyReport()",
        "\n\nlocal function buildAlert",
        [==[
local function sendDailyReport()
    local now = os.time()
    local today = currentKstDateKey(now)
    local history = ensureDailyHistory(now)
    local items = history.Items or {}
    local urgentCount = 0

    local function formatKstTimeOnly(timestamp)
        local t = kstDateTable(timestamp)
        local meridiem = t.hour < 12 and "오전" or "오후"
        local hour12 = t.hour % 12
        if hour12 == 0 then hour12 = 12 end
        return string.format(
            "%s %02d시 %02d분:%02d초",
            meridiem,
            hour12,
            t.min,
            t.sec
        )
    end

    local grouped = {}
    local itemOrder = {}

    for _, row in ipairs(items) do
        if row.Urgent == true then
            urgentCount += 1
        end

        local itemName = tostring(row.ItemKo or row.ItemName or "?")
        local starLabel = tostring(row.Star or "?")

        if type(grouped[itemName]) ~= "table" then
            grouped[itemName] = {
                stars = {},
                starOrder = {},
            }
            itemOrder[#itemOrder + 1] = itemName
        end

        local itemGroup = grouped[itemName]
        if type(itemGroup.stars[starLabel]) ~= "table" then
            itemGroup.stars[starLabel] = {}
            itemGroup.starOrder[#itemGroup.starOrder + 1] = starLabel
        end

        itemGroup.stars[starLabel][#itemGroup.stars[starLabel] + 1] = row
    end

    local function starRank(label)
        local n = tonumber(tostring(label):match("(%d+)"))
        if n then return n end
        return 999
    end

    local pages = {}
    local current = ""
    local PAGE_LIMIT = 3400

    local function flushPage()
        if current ~= "" then
            pages[#pages + 1] = current
            current = ""
        end
    end

    local function appendText(text)
        text = tostring(text or "")
        if current ~= "" and #current + #text > PAGE_LIMIT then
            flushPage()
        end
        current = current .. text
    end

    if #items == 0 then
        pages[1] = "오늘 발견된 신규 매물이 없습니다."
    else
        for _, itemName in ipairs(itemOrder) do
            local itemGroup = grouped[itemName]
            table.sort(itemGroup.starOrder, function(a, b)
                local ar = starRank(a)
                local br = starRank(b)
                if ar == br then return tostring(a) < tostring(b) end
                return ar < br
            end)

            for _, starLabel in ipairs(itemGroup.starOrder) do
                local rows = itemGroup.stars[starLabel]
                table.sort(rows, function(a, b)
                    return (tonumber(a.FoundAt) or 0) < (tonumber(b.FoundAt) or 0)
                end)

                local header =
                    "━━━━━━━━━━━━━━━━━━\n"
                    .. "⭐ **" .. itemName .. " · " .. starLabel .. "**\n\n"

                if current ~= "" and #current + #header > PAGE_LIMIT then
                    flushPage()
                end
                appendText(header)

                for _, row in ipairs(rows) do
                    local entry =
                        "💎 **" .. comma(row.Price) .. " 다이아**"
                        .. (row.Urgent == true and " 🚨" or "")
                        .. "\n"
                        .. formatKstTimeOnly(row.FoundAt)
                        .. "\n\n"

                    if current ~= "" and #current + #entry > PAGE_LIMIT then
                        flushPage()
                        appendText(
                            "━━━━━━━━━━━━━━━━━━\n"
                            .. "⭐ **" .. itemName .. " · " .. starLabel .. " (계속)**\n\n"
                        )
                    end

                    appendText(entry)
                end

                appendText("━━━━━━━━━━━━━━━━━━\n\n")
            end
        end

        flushPage()
    end

    local totalPages = math.max(1, #pages)

    for page = 1, totalPages do
        local embed = {
            title = "📊 오늘 거래소 조사 결과"
                .. (totalPages > 1 and (" (" .. tostring(page) .. "/" .. tostring(totalPages) .. ")") or ""),
            color = 3447003,
            description = pages[page] or "오늘 발견된 신규 매물이 없습니다.",
            footer = {
                text = "조사계정: " .. ACCOUNT
                    .. " · 보고 시각 " .. formatKstTimeOnly(now)
            }
        }

        if page == 1 then
            embed.fields = {{
                name = "오늘 신규 발견",
                value = tostring(#items) .. "건",
                inline = true,
            }, {
                name = "긴급 발견",
                value = tostring(urgentCount) .. "건",
                inline = true,
            }, {
                name = "현재 세션 오류",
                value = tostring(state.errors) .. "건",
                inline = true,
            }}
        end

        local payload = {
            username = "Military Tycoon 거래소 스캐너",
            allowed_mentions = {parse = {}},
            embeds = {embed},
        }

        local sent, sendErr = sendWebhookPayload(payload)
        if not sent then
            addLog("ERROR", "오늘 조사 결과 전송 실패 | " .. tostring(sendErr))
            return false
        end

        if page < totalPages then
            task.wait(0.7)
        end
    end

    config.LastDailyReportDate = today
    scheduleConfigSave("오늘 조사 결과 전송 완료")
    addLog("SUCCESS", "오늘 거래소 조사 결과 Discord 전송 완료 | 발견 "
        .. tostring(#items) .. "건 | 긴급 " .. tostring(urgentCount) .. "건")
    return true
end
]==],
        "일일 보고"
    )
    if not ok then return nil, err end

    ok, err = replaceBlock(
        "local function buildAlert",
        "\n\nlocal function sendGeneralListingAlert",
        [==[
local function buildAlert(item, starLabel, result, alertKind, urgentPrice, record)
    local joinUrl = buildJoinUrl(result.JobId)
    local isUrgent = alertKind == "URGENT"
    local isReminder = alertKind == "REMINDER"

    local function formatKstShortDateTime(timestamp)
        local t = kstDateTable(timestamp)
        local meridiem = t.hour < 12 and "오전" or "오후"
        local hour12 = t.hour % 12
        if hour12 == 0 then hour12 = 12 end
        return string.format(
            "%02d월 %02d일 %s %02d시 %02d분:%02d초",
            t.month,
            t.day,
            meridiem,
            hour12,
            t.min,
            t.sec
        )
    end

    local fields = {
        {
            name = "📦 아이템",
            value = "**" .. tostring(item.ko) .. "**\n" .. tostring(item.name),
            inline = false,
        },
        {
            name = "💎 가격",
            value = "**" .. comma(result.Price) .. " 다이아**",
            inline = false,
        },
        {
            name = "⭐ 성급",
            value = tostring(starLabel),
            inline = false,
        },
        {
            name = "🖥 서버",
            value = tostring(result.ServerName)
                .. " (" .. tostring(result.Players or "?")
                .. "/" .. tostring(result.Max or "?") .. ")",
            inline = false,
        },
        {
            name = "🆔 서버 식별값",
            value = tostring(result.JobId),
            inline = false,
        },
        {
            name = "👤 판매자",
            value = "검색 단계에서는 확인 불가",
            inline = false,
        },
    }

    if joinUrl then
        fields[#fields + 1] = {
            name = "🎮 발견 서버 입장",
            value = "[PC/모바일 바로 입장](" .. joinUrl .. ")",
            inline = false,
        }
    end

    if isReminder and record then
        fields[#fields + 1] = {
            name = "🔄 재고 유지 확인",
            value = "최초 발견: " .. formatKstShortDateTime(record.firstSeen)
                .. "\n마지막 확인: " .. formatKstShortDateTime(record.lastSeen),
            inline = false,
        }
    end

    local statusText = "신규 매물"
    local color = 3066993
    local prefix = "📦 "

    if isUrgent then
        statusText = "긴급 매물"
        color = 15158332
        prefix = "🚨 "
    elseif isReminder then
        statusText = "재고 유지"
        color = 3447003
        prefix = "🔄 "
    end

    local title =
        prefix
        .. tostring(item.ko)
        .. " · "
        .. comma(result.Price)
        .. " 다이아 · "
        .. statusText

    return {
        username = "Military Tycoon 거래소 스캐너",
        content = isUrgent and "@everyone" or nil,
        allowed_mentions = isUrgent and {parse={"everyone"}} or {parse={}},
        embeds = {{
            title = title,
            color = color,
            fields = fields,
            footer = {
                text = "조사계정: " .. ACCOUNT
                    .. " · " .. formatKstShortDateTime(os.time())
            }
        }}
    }
end
]==],
        "매물 알림"
    )
    if not ok then return nil, err end

    source = source:gsub("V3%.4%.2", "V3.4.6")
    return source
end
