-- Market Scanner Remote Agent Heartbeat V1
-- Purpose: keep the Discord control server aware that the Delta mobile is alive.
-- Reads private server URL/token from MarketScanner/remote_agent.json created by setup V1.

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local CONFIG_FILE = "MarketScanner/remote_agent.json"
local HEARTBEAT_SECONDS = 20

local env = (getgenv and getgenv()) or _G
if env.MarketRemoteAgentHeartbeatV1 then
    env.MarketRemoteAgentHeartbeatV1.stop = true
    task.wait(0.2)
end

local controller = { stop = false }
env.MarketRemoteAgentHeartbeatV1 = controller

local function getRequest()
    if type(request) == "function" then return request end
    if type(http_request) == "function" then return http_request end
    if type(httprequest) == "function" then return httprequest end
    if syn and type(syn.request) == "function" then return syn.request end
    if http and type(http.request) == "function" then return http.request end
    return nil
end

local function loadConfig()
    if type(isfile) ~= "function" or type(readfile) ~= "function" or not isfile(CONFIG_FILE) then
        return nil, "저장된 원격 관제 설정이 없습니다. remote_agent_setup_v1.lua를 먼저 실행하세요."
    end
    local ok, raw = pcall(readfile, CONFIG_FILE)
    if not ok then return nil, tostring(raw) end
    local ok2, data = pcall(function()
        return HttpService:JSONDecode(raw)
    end)
    if not ok2 or type(data) ~= "table" then
        return nil, "원격 관제 설정 파일을 읽지 못했습니다."
    end
    return data
end

local config, configErr = loadConfig()
if not config then
    warn("[RemoteAgent] " .. tostring(configErr))
    return
end

local req = getRequest()
if not req then
    warn("[RemoteAgent] Delta HTTP request 함수를 찾지 못했습니다.")
    return
end

local serverUrl = tostring(config.server_url or ""):gsub("/+$", "")
local token = tostring(config.token or "")
local deviceId = tostring(config.device_id or "market-mobile-1")

if serverUrl == "" or token == "" then
    warn("[RemoteAgent] server_url 또는 token이 비어 있습니다.")
    return
end

local function postHeartbeat()
    local payload = {
        device_id = deviceId,
        account = LocalPlayer and LocalPlayer.Name or "unknown",
        place_id = game.PlaceId,
        running = true,
        current = "모바일 연결 유지 테스트",
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
        warn("[RemoteAgent] heartbeat 실패: " .. tostring(response))
        return false
    end

    local code = tonumber(response.StatusCode or response.Status or response.status_code or 0) or 0
    if code < 200 or code >= 300 then
        warn("[RemoteAgent] heartbeat HTTP " .. tostring(code))
        return false
    end
    return true
end

task.spawn(function()
    local first = true
    while not controller.stop do
        local ok = postHeartbeat()
        if first then
            print(ok and "[RemoteAgent] 연결 유지 시작 (20초 주기)" or "[RemoteAgent] 첫 heartbeat 실패")
            first = false
        end
        local waited = 0
        while waited < HEARTBEAT_SECONDS and not controller.stop do
            task.wait(1)
            waited += 1
        end
    end
    print("[RemoteAgent] 연결 유지 종료")
end)
