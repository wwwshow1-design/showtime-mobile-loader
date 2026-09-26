-- Market Scanner V3.4.2 runtime patch
-- Applies after patch_v341.lua
return function(source)
    if type(source) ~= "string" or not string.find(source, "V3.4.1", 1, true) then
        return nil, "V3.4.1 기준본이 아닙니다."
    end

    local function replaceOnce(oldText, newText, label)
        local a, b = string.find(source, oldText, 1, true)
        if not a then
            return false, (label or "치환 대상") .. "을 찾지 못했습니다."
        end
        source = source:sub(1, a - 1) .. newText .. source:sub(b + 1)
        return true
    end

    local function replaceAll(oldText, newText)
        local count = 0
        local pos = 1
        while true do
            local a, b = string.find(source, oldText, pos, true)
            if not a then break end
            source = source:sub(1, a - 1) .. newText .. source:sub(b + 1)
            pos = a + #newText
            count += 1
        end
        return count
    end

    local ok, err

    ok, err = replaceOnce(
        "Military Tycoon 선택형 거래소 스캐너 V3.4.1 - 24시간 운영 통합",
        "Military Tycoon 선택형 거래소 스캐너 V3.4.2 - 24시간 운영 통합",
        "버전"
    )
    if not ok then return nil, err end

    ok, err = replaceOnce(
        'local DEFAULT_ACTIVE_STAR_MAX = 3\n',
        'local DEFAULT_ACTIVE_STAR_MAX = 3\nlocal DAILY_REPORT_HOUR = 23\nlocal KST_OFFSET_SECONDS = 9 * 60 * 60\n',
        "일일 보고 상수"
    )
    if not ok then return nil, err end

    ok, err = replaceOnce(
        '    AutoStartScanner = true,\n}',
        '    AutoStartScanner = true,\n    DailyHistory = {Date = "", Items = {}},\n    LastDailyReportDate = "",\n}',
        "일일 기록 설정"
    )
    if not ok then return nil, err end

    ok, err = replaceOnce(
        '    if type(decoded.AutoStartScanner) == "boolean" then\n        config.AutoStartScanner = decoded.AutoStartScanner\n    else\n        config.AutoStartScanner = true\n        configNeedsMigration = true\n    end\n    return true',
        '    if type(decoded.AutoStartScanner) == "boolean" then\n        config.AutoStartScanner = decoded.AutoStartScanner\n    else\n        config.AutoStartScanner = true\n        configNeedsMigration = true\n    end\n    if type(decoded.DailyHistory) == "table" then\n        config.DailyHistory = decoded.DailyHistory\n    else\n        config.DailyHistory = {Date = "", Items = {}}\n        configNeedsMigration = true\n    end\n    if type(decoded.LastDailyReportDate) == "string" then\n        config.LastDailyReportDate = decoded.LastDailyReportDate\n    else\n        config.LastDailyReportDate = ""\n        configNeedsMigration = true\n    end\n    return true',
        "일일 기록 불러오기"
    )
    if not ok then return nil, err end

    ok, err = replaceOnce(
        'local function safeFind(root, ...)',
        [==[
local function kstDateTable(timestamp)
    local unix = tonumber(timestamp) or os.time()
    return os.date("!*t", unix + KST_OFFSET_SECONDS)
end

local function currentKstDateKey(timestamp)
    local t = kstDateTable(timestamp)
    return string.format("%04d-%02d-%02d", t.year, t.month, t.day)
end

local function formatKstDateTime(timestamp)
    local t = kstDateTable(timestamp)
    local meridiem = t.hour < 12 and "오전" or "오후"
    local hour12 = t.hour % 12
    if hour12 == 0 then hour12 = 12 end
    return string.format(
        "%02d년 %02d월 %02d일 %s %02d시 %02d분:%02d초",
        t.year % 100,
        t.month,
        t.day,
        meridiem,
        hour12,
        t.min,
        t.sec
    )
end

local function formatKstDateOnly(timestamp)
    local t = kstDateTable(timestamp)
    return string.format("%02d년 %02d월 %02d일", t.year % 100, t.month, t.day)
end

local function safeFind(root, ...)
]==],
        "한국시간 함수"
    )
    if not ok then return nil, err end

    ok, err = replaceOnce(
        '    healthAlertAt = {},\n}',
        '    healthAlertAt = {},\n    dailyReportAttemptAt = 0,\n}',
        "일일 보고 상태"
    )
    if not ok then return nil, err end

    ok, err = replaceOnce(
        '    pruneSeen(now)\n    return record, isNew\nend\n\nlocal function buildAlert',
        [==[
    pruneSeen(now)
    return record, isNew
end

local function ensureDailyHistory(now)
    now = tonumber(now) or os.time()
    local today = currentKstDateKey(now)
    local history = config.DailyHistory

    if type(history) ~= "table" then
        history = {Date = today, Items = {}}
        config.DailyHistory = history
    end

    if history.Date ~= today then
        history.Date = today
        history.Items = {}
        scheduleConfigSave("일일 발견 기록 날짜 전환")
    end

    if type(history.Items) ~= "table" then
        history.Items = {}
    end

    return history
end

local function recordDailyFind(item, starLabel, result, urgent)
    local now = os.time()
    local history = ensureDailyHistory(now)
    history.Items[#history.Items + 1] = {
        ItemKo = tostring(item.ko or item.name or "?"),
        ItemName = tostring(item.name or "?"),
        Star = tostring(starLabel or "?"),
        Price = tonumber(result.Price) or 0,
        FoundAt = now,
        JobId = tostring(result.JobId or ""),
        ServerName = tostring(result.ServerName or "?"),
        Urgent = urgent == true,
    }
    scheduleConfigSave("오늘 발견 기록")
end

local function sendDailyReport()
    local now = os.time()
    local today = currentKstDateKey(now)
    local history = ensureDailyHistory(now)
    local items = history.Items or {}
    local urgentCount = 0

    for _, row in ipairs(items) do
        if row.Urgent == true then
            urgentCount += 1
        end
    end

    local pageSize = 12
    local totalPages = math.max(1, math.ceil(#items / pageSize))

    for page = 1, totalPages do
        local lines = {}
        local firstIndex = (page - 1) * pageSize + 1
        local lastIndex = math.min(#items, firstIndex + pageSize - 1)

        if #items == 0 then
            lines[1] = "오늘 발견된 신규 매물이 없습니다."
        else
            for index = firstIndex, lastIndex do
                local row = items[index]
                lines[#lines + 1] =
                    (row.Urgent == true and "🚨 " or "• ")
                    .. "**" .. tostring(row.ItemKo) .. "**"
                    .. " · " .. tostring(row.Star)
                    .. " · **" .. comma(row.Price) .. " 다이아**"
                    .. "\n  └ " .. formatKstDateTime(row.FoundAt)
            end
        end

        local payload = {
            username = "Military Tycoon 거래소 스캐너",
            allowed_mentions = {parse = {}},
            embeds = {{
                title = "📊 오늘 거래소 조사 결과 · " .. formatKstDateOnly(now)
                    .. (totalPages > 1 and (" (" .. tostring(page) .. "/" .. tostring(totalPages) .. ")") or ""),
                color = 3447003,
                description = table.concat(lines, "\n"),
                fields = {{
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
                }},
                footer = {
                    text = "조사계정: " .. ACCOUNT
                        .. " · 보고 시각 " .. formatKstDateTime(now)
                }
            }}
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

local function buildAlert
]==],
        "일일 기록 함수"
    )
    if not ok then return nil, err end

    ok, err = replaceOnce(
        '        username = "Military Tycoon 거래소 스캐너",\n        allowed_mentions = {parse={}},\n        embeds = {{\n            title = title,',
        '        username = "Military Tycoon 거래소 스캐너",\n        content = isUrgent and "@everyone" or nil,\n        allowed_mentions = isUrgent and {parse={"everyone"}} or {parse={}},\n        embeds = {{\n            title = title,',
        "긴급 @everyone 멘션"
    )
    if not ok then return nil, err end

    replaceAll(
        'os.date("%Y-%m-%d %H:%M:%S", record.firstSeen)',
        'formatKstDateTime(record.firstSeen)'
    )
    replaceAll(
        'os.date("%Y-%m-%d %H:%M:%S", record.lastSeen)',
        'formatKstDateTime(record.lastSeen)'
    )
    replaceAll(
        'os.date("%Y-%m-%d %H:%M:%S")',
        'formatKstDateTime(os.time())'
    )

    ok, err = replaceOnce(
        '    if state.stopRequested or lifecycle.Closed then\n        return\n    end\n\n    sendGeneralListingAlert(item, starLabel, result, urgentPrice, record, false)',
        '    if state.stopRequested or lifecycle.Closed then\n        return\n    end\n\n    recordDailyFind(item, starLabel, result, urgent)\n    sendGeneralListingAlert(item, starLabel, result, urgentPrice, record, false)',
        "신규 발견 기록"
    )
    if not ok then return nil, err end

    ok, err = replaceOnce(
        '-- 기존 UI 상태 갱신 루프\ntask.spawn(function()',
        [==[
-- 매일 한국시간 오후 11시에 오늘 발견 기록을 Discord로 정리한다.
task.spawn(function()
    while not lifecycle.Closed and gui and gui.Parent do
        local now = os.time()
        local kst = kstDateTable(now)
        local today = currentKstDateKey(now)

        if kst.hour >= DAILY_REPORT_HOUR
            and config.LastDailyReportDate ~= today
            and now - (tonumber(state.dailyReportAttemptAt) or 0) >= 600 then

            state.dailyReportAttemptAt = now
            sendDailyReport()
        end

        task.wait(30)
    end
end)

-- 기존 UI 상태 갱신 루프
task.spawn(function()
]==],
        "일일 보고 루프"
    )
    if not ok then return nil, err end

    replaceAll("V3.4.1", "V3.4.2")
    return source
end
