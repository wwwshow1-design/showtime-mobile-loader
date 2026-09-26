-- Market Scanner V3.4.1 runtime patch
return function(source)
    -- Normalize two duplicated spaces from the V3.4.0 split upload.
    if #source == 225105 then
        source = source:sub(1, 150598) .. source:sub(150600)
        source = source:sub(1, 131638) .. source:sub(131640)
    end
    if #source ~= 225103 then
        return nil, "기준본 크기 불일치: " .. tostring(#source)
    end
    local edits = {
        {6, 83, [====[Military Tycoon 선택형 거래소 스캐너 V3.4.1 - 24시간 운영 통합
]====]},
        {342, 392, [====[- 군인/드론: 0~5성 개별 조회 지원 (4·5성 기본 OFF)
]====]},
        {2600, 2599, [====[local MAX_STAR = 5
local DEFAULT_ACTIVE_STAR_MAX = 3
]====]},
        {116715, 116714, [====[    "MarketSelectedScannerGuiV341",
]====]},
        {116784, 116951, [====[            "[V3.4.1] 기존 스캐너 창이 열려 있습니다. "
                .. "기존 창의 X를 눌러 종료한 뒤 V3.4.1을 다시 실행해 주세요."
]====]},
        {117944, 117943, [====[    ItemStarUrgentPrices = {},
]====]},
        {119153, 119152, [====[    lastHealthyAt = nil,
]====]},
        {121237, 121236, [====[        configNeedsMigration = true
    end
    if type(decoded.ItemStarUrgentPrices) == "table" then
        config.ItemStarUrgentPrices = decoded.ItemStarUrgentPrices
    else
        config.ItemStarUrgentPrices = {}
]====]},
        {135511, 135533, [====[    for star = 0, MAX_STAR do
]====]},
        {136035, 136112, [====[        existing = {}
        for star = 0, MAX_STAR do
            existing[tostring(star)] = star <= DEFAULT_ACTIVE_STAR_MAX
        end
]====]},
        {136209, 136235, [====[        for star = 0, MAX_STAR do
]====]},
        {136440, 136518, [====[            for star = 0, MAX_STAR do
                existing[tostring(star)] = star <= DEFAULT_ACTIVE_STAR_MAX
            end
        else
            -- 기존 0~3성 설정을 유지하면서 새 4~5성은 안전하게 기본 OFF.
            for star = 0, MAX_STAR do
                local key = tostring(star)
                if existing[key] == nil and existing[star] == nil then
                    existing[key] = star <= DEFAULT_ACTIVE_STAR_MAX
                end
]====]},
        {136580, 136622, [====[local function ensureStarUrgentPrices(item)
    local existing = config.ItemStarUrgentPrices[item.key]
    if type(existing) ~= "table" then
        existing = {}
        config.ItemStarUrgentPrices[item.key] = existing
    end
    return existing
end

local function getUrgentPriceForItem(item, star)
    if item and star ~= nil then
        local starPrices = config.ItemStarUrgentPrices[item.key]
        if type(starPrices) == "table" then
            local individualStar = tonumber(starPrices[tostring(star)] or starPrices[star])
            if individualStar then
                return math.max(0, math.floor(individualStar)), true, "star"
            end
        end
    end

]====]},
        {136713, 136769, [====[        return math.max(0, math.floor(individual)), true, "item"
]====]},
        {136778, 136854, [====[    return math.max(0, math.floor(tonumber(config.UrgentPrice) or 0)), false, "global"
]====]},
        {139693, 139692, [====[    state.lastHealthyAt = os.date("%H:%M:%S")
]====]},
        {151057, 151056, [====[    -- Discord Embed는 필드별 글자 크기 지정이 불가능하므로
    -- 판매 가격을 큰 제목에 배치하고 긴급 기준은 별도 전체폭 필드로 분리한다.
]====]},
        {151336, 151511, [====[            inline = false,
]====]},
        {151574, 151663, [====[            value = "**" .. comma(urgentPrice) .. " 다이아 이하**",
            inline = false,
]====]},
        {151937, 151969, [====[            name = "🆔 서버 식별값",
]====]},
        {152270, 152320, [====[            name = "🎮 발견 서버 입장",
]====]},
        {152505, 152545, [====[            name = "🔄 재고 유지 확인",
]====]},
        {152773, 152818, [====[    local title = "📦 " .. comma(result.Price) .. " 다이아 · 신규 매물"
]====]},
        {152866, 152909, [====[        title = "🚨 " .. comma(result.Price) .. " 다이아 · 긴급 매물"
]====]},
        {152962, 153005, [====[        title = "🔄 " .. comma(result.Price) .. " 다이아 · 재고 유지"
]====]},
        {156433, 156489, [====[        "매물 발견 | " .. tostring(item.ko)
            .. " | " .. tostring(starLabel)
]====]},
        {156550, 156694, [====[]====]},
        {156833, 156884, [====[    local urgentPrice = getUrgentPriceForItem(item, star)
]====]},
        {157207, 157263, [====[                .. " | 서버 식별값 " .. tostring(result.JobId)
]====]},
        {165345, 166050, [====[                tostring(state.cycle) .. "회차 완료"
                    .. " | 조회 " .. tostring(state.scans - baseScans) .. "건"
                    .. " | 발견 " .. tostring(state.finds - baseFinds) .. "건"
                    .. " | 새 알림 " .. tostring(state.alerts - baseAlerts) .. "건"
                    .. " | 중복 " .. tostring(state.duplicates - baseDuplicates) .. "건"
                    .. " | 재고 확인 " .. tostring(state.stockReminders - baseReminders) .. "건"
                    .. " | 오류 " .. tostring(state.errors - baseErrors) .. "건"
]====]},
        {167979, 167992, [====[-- GUI V3.4.1
]====]},
        {168141, 168182, [====[gui.Name = "MarketSelectedScannerGuiV341"
]====]},
        {172105, 172118, [====[    "V3.4.1",
]====]},
        {188756, 188833, [====[            "=== Military Tycoon 거래소 스캐너 V3.4.1 진단 로그 ===",
]====]},
        {190529, 190691, [====[    CHECK = "#70C4A5",
    AUTO = "#70C4A5",
]====]},
        {190931, 190987, [====[}

local LOG_LABEL_KO = {
    INFO = "안내",
    START = "시작",
    CHECK = "점검",
    AUTO = "자동",
    FOUND = "발견",
    DUPLICATE = "중복",
    DISCORD = "디스코드",
    URGENT = "긴급",
    SUCCESS = "완료",
    PERF = "성능",
    WARN = "주의",
    WARNING = "주의",
    ERROR = "오류",
    CYCLE = "회차",
}

-- 화면에는 운영자가 바로 이해할 수 있는 로그만 표시한다.
-- RAW/QUERY/UI-CALL 같은 상세 진단값은 내부에는 남아 있고 '복사'로 확인 가능하다.
local HIDDEN_USER_LOG_KINDS = {
    HOOK = true,
    SCAN = true,
    QUERY = true,
    RAW = true,
    ["RAW-WARN"] = true,
    MATCH = true,
    MISS = true,
    ["UI-CALL"] = true,
    ["UI-RAW"] = true,
]====]},
        {191173, 191172, [====[end

local function userFriendlyLogMessage(message)
    local out = tostring(message or "")
    out = out:gsub("FindItem", "거래소 조회")
    out = out:gsub("TerminalService", "거래소 서비스")
    out = out:gsub("Webhook", "디스코드 알림")
    out = out:gsub("observer", "호출 감시")
    out = out:gsub("Cooldown", "요청 대기")
    out = out:gsub("JobId", "서버 식별값")
    return out
end

local function showUserLog(record)
    local kind = tostring(record and record.kind or "INFO")
    if HIDDEN_USER_LOG_KINDS[kind] then
        return false
    end
    local message = tostring(record and record.message or "")
    -- 상세 시작 목록(Name/ID 나열)은 화면을 도배하므로 복사 로그에서만 유지한다.
    if string.find(message, "Name=", 1, true) or string.find(message, " | ID=", 1, true) then
        return false
    end
    return true
]====]},
        {191549, 191646, [====[    local lines = {}
    local visible = 0
    for i = 1, #logs do
        local r = logs[i]
        if showUserLog(r) then
            local kind = tostring(r.kind or "INFO")
            local color = LOG_HEX[kind] or "#8B95A4"
            local label = LOG_LABEL_KO[kind] or "안내"
            local message = userFriendlyLogMessage(r.message)
            lines[#lines + 1] =
                '<font color="#6C7481">' .. richEscape(r.at) .. '</font>'
                .. '  <font color="' .. color .. '"><b>[' .. richEscape(label) .. ']</b></font>'
                .. '  <font color="#EBEEF4">' .. richEscape(message) .. '</font>'
            visible += 1
            if visible >= 40 then
                break
            end
        end
    end

    if #lines == 0 then
        logText.Text = '<font color="#6C7481">운영 상태를 확인하는 중...</font>'
]====]},
        {191726, 192217, [====[]====]},
        {192263, 192312, [====[    local height = math.max(18, visible * 15 + 4)
]====]},
        {199471, 199570, [====[-- V3.4.1 settings: 메인 620x450은 그대로 두고 기존 설정 팝업 안만 스크롤한다.
]====]},
        {207170, 207281, [====[        "재고 알림 0분 = OFF · 성급 장비는 선택관리에서 성급별 긴급가를 따로 지정할 수 있습니다.",
]====]},
        {209932, 210013, [====[        -- 세부 설정을 열 때 뒤의 선택관리 팝업을 숨겨 겹침을 없앤다.
        dim.Visible = false

        local detailHeight = item.starred and 326 or 190
        local detailDim, detailPanel = makeOverlay("ItemSettingsPopup", 430, detailHeight)
        local restored = false

        local function restoreSelectionPopup()
            if restored then return end
            restored = true
            if detailDim and detailDim.Parent then
                detailDim:Destroy()
            end
            if dim and dim.Parent then
                dim.Visible = true
            end
        end
]====]},
        {210098, 210178, [====[            UDim2.fromOffset(14, 8), UDim2.fromOffset(350, 22), 13, true, C.Text
]====]},
        {210280, 210279, [====[
]====]},
        {210364, 210447, [====[            UDim2.fromOffset(14, 29), UDim2.fromOffset(350, 16), 10, false, C.Muted
]====]},
        {210588, 210670, [====[            detailPanel, "×", UDim2.fromOffset(390, 8), UDim2.fromOffset(28, 28),
]====]},
        {210741, 210787, [====[            restoreSelectionPopup
]====]},
        {210865, 210890, [====[]====]},
        {210920, 211096, [====[            local filter = ensureStarFilter(item)
            local starPrices = ensureStarUrgentPrices(item)

            local summary = textLabel(
                detailPanel, "",
                UDim2.fromOffset(14, 50), UDim2.fromOffset(400, 18), 10, true, C.Muted
]====]},
        {211111, 211225, [====[            summary.ZIndex = 82

            local function refreshSummary()
                local enabled = {}
                for star = 0, MAX_STAR do
                    if filter[tostring(star)] == true then
                        enabled[#enabled + 1] = tostring(star) .. "성"
                    end
                end
                summary.Text = "현재 조회: " .. (#enabled > 0 and table.concat(enabled, " · ") or "없음")
            end

            local h1 = textLabel(detailPanel, "성급", UDim2.fromOffset(16, 72), UDim2.fromOffset(42, 18), 10, true, C.Muted2)
            local h2 = textLabel(detailPanel, "조회 상태", UDim2.fromOffset(72, 72), UDim2.fromOffset(90, 18), 10, true, C.Muted2)
            local h3 = textLabel(detailPanel, "긴급 기준가", UDim2.fromOffset(176, 72), UDim2.fromOffset(145, 18), 10, true, C.Muted2)
            h1.ZIndex, h2.ZIndex, h3.ZIndex = 82, 82, 82

            for star = 0, MAX_STAR do
]====]},
        {211273, 211344, [====[                local y = 93 + star * 34

                local starText = textLabel(
                    detailPanel, starKey .. "성",
                    UDim2.fromOffset(16, y), UDim2.fromOffset(42, 28), 11, true, C.Text
                )
                starText.ZIndex = 82

                local toggle
                local function paintToggle()
]====]},
        {211405, 211584, [====[                    toggle.Text = enabled and "✓ 조회 ON" or "✕ 조회 OFF"
                    toggle.BackgroundColor3 = enabled and C.Green or C.Red
                    refreshSummary()
]====]},
        {211605, 211776, [====[
                toggle = flatButton(
                    detailPanel, "",
                    UDim2.fromOffset(66, y), UDim2.fromOffset(96, 28),
]====]},
        {211905, 212010, [====[                        scheduleConfigSave("성급별 조회 상태 변경")
                        paintToggle()
]====]},
        {212053, 212168, [====[                toggle.ZIndex = 84
                toggle.TextSize = 10
                toggle.MouseLeave:Connect(paintToggle)
                paintToggle()

                local priceBox = Instance.new("TextBox")
                priceBox.Position = UDim2.fromOffset(174, y)
                priceBox.Size = UDim2.fromOffset(144, 28)
                priceBox.BackgroundColor3 = C.Input
                priceBox.BorderSizePixel = 0
                priceBox.ClearTextOnFocus = false
                local savedPrice = tonumber(starPrices[starKey] or starPrices[star])
                local fallbackPrice = tonumber(config.ItemUrgentPrices[item.key])
                    or tonumber(config.UrgentPrice)
                    or 0
                priceBox.Text = savedPrice and comma(savedPrice) or ""
                priceBox.PlaceholderText = "기본 " .. comma(fallbackPrice)
                priceBox.PlaceholderColor3 = C.Muted2
                priceBox.TextColor3 = C.Text
                priceBox.Font = Enum.Font.Code
                priceBox.TextSize = 11
                priceBox.TextXAlignment = Enum.TextXAlignment.Center
                priceBox.ZIndex = 83
                priceBox.Parent = detailPanel
                corner(priceBox, 5)

                local function syncStarPrice()
                    local raw = (priceBox.Text or ""):gsub(",", ""):gsub("%s", "")
                    if raw == "" then
                        starPrices[starKey] = nil
                        scheduleConfigSave("성급별 긴급가 전역값 사용")
                        return
                    end
                    local number = tonumber(raw)
                    if number then
                        starPrices[starKey] = math.max(0, math.floor(number))
                        scheduleConfigSave("성급별 긴급가 변경")
                    end
                end

                priceBox.FocusLost:Connect(function()
                    syncStarPrice()
                    local value = tonumber(starPrices[starKey])
                    priceBox.Text = value and comma(value) or ""
                end)

                local reset = flatButton(
                    detailPanel, "기본값",
                    UDim2.fromOffset(326, y), UDim2.fromOffset(88, 28),
                    C.Button, C.ButtonHover, function()
                        starPrices[starKey] = nil
                        priceBox.Text = ""
                        scheduleConfigSave("성급별 긴급가 전역값 사용")
                    end
                )
                reset.ZIndex = 84
                reset.TextSize = 10
]====]},
        {212185, 212209, [====[
            local note = textLabel(
                detailPanel,
                "빈칸/기본값 = 장비 공통값이 있으면 우선 사용, 없으면 전역값 "
                    .. comma(config.UrgentPrice) .. " · 4·5성은 기본 OFF",
                UDim2.fromOffset(14, 297), UDim2.fromOffset(400, 22), 9, false, C.Muted2
            )
            note.TextWrapped = true
            note.ZIndex = 82
        else
            local priceLabel = textLabel(
                detailPanel, "장비 긴급 기준가",
                UDim2.fromOffset(14, 62), UDim2.fromOffset(130, 22), 10, true, C.Muted
            )
            priceLabel.ZIndex = 82

            local individual = tonumber(config.ItemUrgentPrices[item.key])
            local priceBox = Instance.new("TextBox")
            priceBox.Position = UDim2.fromOffset(150, 58)
            priceBox.Size = UDim2.fromOffset(160, 30)
            priceBox.BackgroundColor3 = C.Input
            priceBox.BorderSizePixel = 0
            priceBox.ClearTextOnFocus = false
            priceBox.Text = individual and comma(individual) or ""
            priceBox.PlaceholderText = "전역 " .. comma(config.UrgentPrice)
            priceBox.PlaceholderColor3 = C.Muted2
            priceBox.TextColor3 = C.Text
            priceBox.Font = Enum.Font.Code
            priceBox.TextSize = 12
            priceBox.TextXAlignment = Enum.TextXAlignment.Center
            priceBox.ZIndex = 83
            priceBox.Parent = detailPanel
            corner(priceBox, 5)

            local function syncIndividualPrice()
                local raw = (priceBox.Text or ""):gsub(",", ""):gsub("%s", "")
                if raw == "" then
                    config.ItemUrgentPrices[item.key] = nil
                    scheduleConfigSave("장비 긴급가 전역값 사용")
                    return
                end
                local number = tonumber(raw)
                if number then
                    config.ItemUrgentPrices[item.key] = math.max(0, math.floor(number))
                    scheduleConfigSave("장비 긴급가 변경")
                end
            end

            priceBox.FocusLost:Connect(function()
                syncIndividualPrice()
                local saved = tonumber(config.ItemUrgentPrices[item.key])
                priceBox.Text = saved and comma(saved) or ""
            end)

            local reset = flatButton(
                detailPanel, "전역값",
                UDim2.fromOffset(318, 58), UDim2.fromOffset(96, 30),
                C.Button, C.ButtonHover, function()
                    config.ItemUrgentPrices[item.key] = nil
                    priceBox.Text = ""
                    scheduleConfigSave("장비 긴급가 전역값 사용")
                end
            )
            reset.ZIndex = 84

            local help = textLabel(
                detailPanel,
                "비워두면 전역 긴급가 " .. comma(config.UrgentPrice) .. " 다이아를 사용합니다.",
                UDim2.fromOffset(14, 104), UDim2.fromOffset(400, 40), 10, false, C.Muted2
            )
            help.TextWrapped = true
            help.ZIndex = 82
]====]},
        {212222, 214401, [====[]====]},
        {224668, 224826, [====[            .. " | " .. tostring(state.cycle) .. "회차"
            .. " | 최근 정상조회 " .. tostring(state.lastHealthyAt or "-")
]====]},
        {224934, 224991, [====[]====]},
    }
    for i = #edits, 1, -1 do
        local e = edits[i]
        source = source:sub(1, e[1] - 1) .. e[3] .. source:sub(e[2] + 1)
    end
    return source
end
