-- Market Scanner Remote Agent V1 - connection test/setup
-- Keeps server URL and AGENT_TOKEN only on this device (writefile), never in GitHub.

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local CONFIG_FOLDER = "MarketScanner"
local CONFIG_FILE = CONFIG_FOLDER .. "/remote_agent.json"

local function getRequest()
    if type(request) == "function" then return request end
    if type(http_request) == "function" then return http_request end
    if type(httprequest) == "function" then return httprequest end
    if syn and type(syn.request) == "function" then return syn.request end
    if http and type(http.request) == "function" then return http.request end
    return nil
end

local function safeReadConfig()
    if not (type(isfile) == "function" and type(readfile) == "function") then
        return nil
    end
    if not isfile(CONFIG_FILE) then
        return nil
    end
    local ok, raw = pcall(readfile, CONFIG_FILE)
    if not ok then return nil end
    local ok2, data = pcall(function()
        return HttpService:JSONDecode(raw)
    end)
    if not ok2 or type(data) ~= "table" then
        return nil
    end
    return data
end

local function safeWriteConfig(serverUrl, token)
    if type(writefile) ~= "function" then
        return false, "Delta에서 writefile을 사용할 수 없어 자동 저장은 건너뜁니다."
    end
    pcall(function()
        if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder(CONFIG_FOLDER) then
            makefolder(CONFIG_FOLDER)
        end
    end)
    local raw = HttpService:JSONEncode({
        server_url = serverUrl,
        token = token,
        device_id = "market-mobile-1",
    })
    local ok, err = pcall(writefile, CONFIG_FILE, raw)
    return ok, err
end

local function trim(s)
    return tostring(s or ""):match("^%s*(.-)%s*$")
end

local function normalizeUrl(url)
    url = trim(url)
    url = url:gsub("/+$", "")
    if url ~= "" and not url:match("^https?://") then
        url = "http://" .. url
    end
    return url
end

local existing = safeReadConfig() or {}

local parent
local okHui, hui = pcall(function()
    return gethui and gethui()
end)
if okHui and hui then
    parent = hui
else
    parent = game:GetService("CoreGui")
end

pcall(function()
    local old = parent:FindFirstChild("MarketRemoteAgentSetupV1")
    if old then old:Destroy() end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "MarketRemoteAgentSetupV1"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.Parent = parent

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(430, 330)
frame.Position = UDim2.new(0.5, -215, 0.5, -165)
frame.BackgroundColor3 = Color3.fromRGB(24, 27, 34)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(65, 72, 90)
stroke.Thickness = 1
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(20, 16)
title.Size = UDim2.new(1, -40, 0, 34)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(240, 244, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "거래소 원격 관제 · 모바일 연결"
title.Parent = frame

local desc = Instance.new("TextLabel")
desc.BackgroundTransparency = 1
desc.Position = UDim2.fromOffset(20, 52)
desc.Size = UDim2.new(1, -40, 0, 42)
desc.Font = Enum.Font.Gotham
desc.TextSize = 13
desc.TextColor3 = Color3.fromRGB(172, 180, 198)
desc.TextWrapped = true
desc.TextXAlignment = Enum.TextXAlignment.Left
desc.TextYAlignment = Enum.TextYAlignment.Top
desc.Text = "보조컴 주소와 .env의 AGENT_TOKEN을 입력한 뒤 연결 테스트를 누르세요."
desc.Parent = frame

local urlBox = Instance.new("TextBox")
urlBox.Position = UDim2.fromOffset(20, 103)
urlBox.Size = UDim2.new(1, -40, 0, 44)
urlBox.BackgroundColor3 = Color3.fromRGB(34, 38, 48)
urlBox.BorderSizePixel = 0
urlBox.ClearTextOnFocus = false
urlBox.Font = Enum.Font.Gotham
urlBox.TextSize = 14
urlBox.TextColor3 = Color3.fromRGB(240, 244, 255)
urlBox.PlaceholderColor3 = Color3.fromRGB(120, 128, 145)
urlBox.PlaceholderText = "예: http://192.168.0.25:8765"
urlBox.Text = tostring(existing.server_url or "")
urlBox.Parent = frame
Instance.new("UICorner", urlBox).CornerRadius = UDim.new(0, 9)

local tokenBox = Instance.new("TextBox")
tokenBox.Position = UDim2.fromOffset(20, 157)
tokenBox.Size = UDim2.new(1, -40, 0, 44)
tokenBox.BackgroundColor3 = Color3.fromRGB(34, 38, 48)
tokenBox.BorderSizePixel = 0
tokenBox.ClearTextOnFocus = false
tokenBox.Font = Enum.Font.Code
tokenBox.TextSize = 13
tokenBox.TextColor3 = Color3.fromRGB(240, 244, 255)
tokenBox.PlaceholderColor3 = Color3.fromRGB(120, 128, 145)
tokenBox.PlaceholderText = "AGENT_TOKEN"
tokenBox.Text = tostring(existing.token or "")
tokenBox.Parent = frame
Instance.new("UICorner", tokenBox).CornerRadius = UDim.new(0, 9)

local status = Instance.new("TextLabel")
status.BackgroundTransparency = 1
status.Position = UDim2.fromOffset(20, 211)
status.Size = UDim2.new(1, -40, 0, 42)
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.TextColor3 = Color3.fromRGB(172, 180, 198)
status.TextWrapped = true
status.TextXAlignment = Enum.TextXAlignment.Left
status.TextYAlignment = Enum.TextYAlignment.Top
status.Text = "대기 중"
status.Parent = frame

local testButton = Instance.new("TextButton")
testButton.Position = UDim2.fromOffset(20, 263)
testButton.Size = UDim2.new(1, -110, 0, 46)
testButton.BackgroundColor3 = Color3.fromRGB(55, 126, 246)
testButton.BorderSizePixel = 0
testButton.Font = Enum.Font.GothamBold
testButton.TextSize = 15
testButton.TextColor3 = Color3.new(1, 1, 1)
testButton.Text = "연결 테스트 + 저장"
testButton.Parent = frame
Instance.new("UICorner", testButton).CornerRadius = UDim.new(0, 10)

local closeButton = Instance.new("TextButton")
closeButton.Position = UDim2.new(1, -80, 0, 263)
closeButton.Size = UDim2.fromOffset(60, 46)
closeButton.BackgroundColor3 = Color3.fromRGB(47, 52, 64)
closeButton.BorderSizePixel = 0
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.TextColor3 = Color3.fromRGB(220, 225, 238)
closeButton.Text = "닫기"
closeButton.Parent = frame
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 10)

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local busy = false

testButton.MouseButton1Click:Connect(function()
    if busy then return end
    busy = true
    testButton.Text = "연결 확인 중..."

    local req = getRequest()
    if not req then
        status.TextColor3 = Color3.fromRGB(255, 105, 105)
        status.Text = "실패: Delta에서 HTTP request 함수를 찾지 못했습니다."
        testButton.Text = "연결 테스트 + 저장"
        busy = false
        return
    end

    local serverUrl = normalizeUrl(urlBox.Text)
    local token = trim(tokenBox.Text)

    if serverUrl == "" then
        status.TextColor3 = Color3.fromRGB(255, 105, 105)
        status.Text = "보조컴 주소를 입력하세요."
        testButton.Text = "연결 테스트 + 저장"
        busy = false
        return
    end
    if token == "" then
        status.TextColor3 = Color3.fromRGB(255, 105, 105)
        status.Text = "AGENT_TOKEN을 입력하세요."
        testButton.Text = "연결 테스트 + 저장"
        busy = false
        return
    end

    local payload = {
        device_id = "market-mobile-1",
        account = LocalPlayer and LocalPlayer.Name or "unknown",
        place_id = game.PlaceId,
        running = true,
        current = "모바일 연결 테스트",
        cycle = 0,
        scans = 0,
        finds = 0,
        urgent_finds = 0,
        errors = 0,
        scan_order = {},
        selected_settings = {},
    }

    local ok, response = pcall(function()
        return req({
            Url = serverUrl .. "/agent/heartbeat",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["X-Agent-Token"] = token,
            },
            Body = HttpService:JSONEncode(payload),
        })
    end)

    if not ok then
        status.TextColor3 = Color3.fromRGB(255, 105, 105)
        status.Text = "연결 실패: " .. tostring(response)
        testButton.Text = "연결 테스트 + 저장"
        busy = false
        return
    end

    local code = tonumber(response.StatusCode or response.Status or response.status_code or 0) or 0
    if code >= 200 and code < 300 then
        local saved, saveErr = safeWriteConfig(serverUrl, token)
        status.TextColor3 = Color3.fromRGB(100, 230, 150)
        if saved then
            status.Text = "성공! 보조컴 연결 및 설정 저장 완료. Discord에서 /관제 또는 /상태를 확인하세요."
        else
            status.Text = "연결 성공! 단, 설정 자동 저장은 실패했습니다: " .. tostring(saveErr)
        end
        testButton.Text = "연결 성공"
    else
        status.TextColor3 = Color3.fromRGB(255, 105, 105)
        local body = tostring(response.Body or response.body or "")
        if code == 401 then
            status.Text = "실패 (401): AGENT_TOKEN이 보조컴 .env 값과 다릅니다."
        else
            status.Text = "실패: HTTP " .. tostring(code) .. " " .. body:sub(1, 120)
        end
        testButton.Text = "다시 테스트"
    end
    busy = false
end)
