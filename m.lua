local Players=game:GetService("Players")
local TeleportService=game:GetService("TeleportService")
local TRADE_PLACE_ID=134708228958679
local SELF_URL="https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/m.lua?v=delta3"
local BASE="https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/market-scanner/v3.4.0/"

local player=Players.LocalPlayer
if not player then
    local deadline=os.clock()+15
    repeat task.wait(0.1) player=Players.LocalPlayer until player or os.clock()>=deadline
end

local gui=Instance.new("ScreenGui")
gui.Name="MarketScannerDeltaDebug"
gui.ResetOnSpawn=false
gui.DisplayOrder=100000

local parent
if type(gethui)=="function" then
    local ok,res=pcall(gethui)
    if ok and res then parent=res end
end
if not parent then
    local ok,res=pcall(function() return game:GetService("CoreGui") end)
    if ok and res then parent=res end
end
if not parent and player then
    parent=player:FindFirstChildOfClass("PlayerGui") or player:WaitForChild("PlayerGui",10)
end
if parent then gui.Parent=parent end

local box=Instance.new("Frame")
box.AnchorPoint=Vector2.new(0.5,0.5)
box.Position=UDim2.fromScale(0.5,0.5)
box.Size=UDim2.fromOffset(390,180)
box.BackgroundColor3=Color3.fromRGB(20,22,28)
box.BorderSizePixel=0
box.Parent=gui
Instance.new("UICorner",box).CornerRadius=UDim.new(0,10)

local title=Instance.new("TextLabel")
title.Position=UDim2.fromOffset(12,8)
title.Size=UDim2.new(1,-24,0,28)
title.BackgroundTransparency=1
title.Text="Market Scanner · Delta 진단"
title.TextColor3=Color3.new(1,1,1)
title.Font=Enum.Font.GothamBold
title.TextSize=18
title.TextXAlignment=Enum.TextXAlignment.Left
title.Parent=box

local status=Instance.new("TextLabel")
status.Position=UDim2.fromOffset(12,42)
status.Size=UDim2.new(1,-24,1,-54)
status.BackgroundTransparency=1
status.TextColor3=Color3.fromRGB(230,233,240)
status.Font=Enum.Font.Code
status.TextSize=15
status.TextWrapped=true
status.TextXAlignment=Enum.TextXAlignment.Left
status.TextYAlignment=Enum.TextYAlignment.Top
status.Text="로더 시작됨"
status.Parent=box

local function setStatus(text)
    status.Text=tostring(text)
    print("[MarketScannerDelta] "..tostring(text))
end

local function fail(stage,err)
    setStatus("❌ "..stage.."\n"..tostring(err).."\n\n이 화면을 캡처해서 보내주세요.")
end

local function httpGet(url)
    local ok,data=pcall(function() return game:HttpGet(url) end)
    if ok and type(data)=="string" and #data>0 then return data end

    local req
    if type(request)=="function" then req=request
    elseif type(http_request)=="function" then req=http_request
    elseif type(syn)=="table" and type(syn.request)=="function" then req=syn.request end

    if req then
        local ok2,res=pcall(req,{Url=url,Method="GET"})
        if ok2 and type(res)=="table" then
            local body=res.Body or res.body
            if type(body)=="string" and #body>0 then return body end
        end
    end
    return nil,data
end

local okMain,mainErr=xpcall(function()
    if not player then error("LocalPlayer 없음") end
    setStatus("✅ 로더 실행 OK\n계정: "..player.Name.."\nPlaceId: "..tostring(game.PlaceId))
    task.wait(1)

    if game.PlaceId~=TRADE_PLACE_ID then
        setStatus("✅ 로더 실행 OK\n⚠ 거래소 서버가 아님\n거래소로 이동 요청 중...\n현재 PlaceId: "..tostring(game.PlaceId))

        local q
        if type(queue_on_teleport)=="function" then q=queue_on_teleport
        elseif type(queueonteleport)=="function" then q=queueonteleport
        elseif type(syn)=="table" and type(syn.queue_on_teleport)=="function" then q=syn.queue_on_teleport end
        if q then pcall(q,'loadstring(game:HttpGet("'..SELF_URL..'"))()') end

        local okTp,tpErr=pcall(function() TeleportService:Teleport(TRADE_PLACE_ID,player) end)
        if not okTp then error("Teleport 실패: "..tostring(tpErr)) end
        return
    end

    local parts={}
    local total=0
    for i=1,12 do
        setStatus("✅ 델타 + GitHub OK\n📥 본체 다운로드 "..i.." / 12\n받은 크기: "..tostring(total).." bytes")
        local data,lastErr
        for attempt=1,3 do
            data,lastErr=httpGet(BASE..string.format("part%02d.txt",i).."?v=delta3")
            if data then break end
            task.wait(0.4)
        end
        if not data then error("part"..string.format("%02d",i).." 다운로드 실패: "..tostring(lastErr)) end
        parts[i]=data
        total+=#data
    end

    setStatus("✅ 12 / 12 다운로드 완료\n총 "..tostring(total).." bytes\n🔧 코드 합치는 중...")
    task.wait(0.5)

    local source=table.concat(parts)
    source=source:gsub('local ACCOUNT = "Onyyxten2020"','local ACCOUNT = '..string.format('%q',player.Name),1)
    source=source:gsub('MarketSelectedScanner_Onyyxten2020_config%.json','MarketSelectedScanner_'..player.Name..'_config.json',1)

    setStatus("✅ 다운로드 완료\n🔧 컴파일 검사 중...\n소스 크기: "..tostring(#source).." bytes")
    task.wait(0.5)

    local fn,compileErr=loadstring(source)
    if not fn then error("컴파일 오류: "..tostring(compileErr)) end

    setStatus("✅ 컴파일 성공\n▶ V3.4.0 실행 중...")
    task.wait(0.5)

    local okRun,runErr=xpcall(fn,debug.traceback)
    if not okRun then error("본체 실행 오류: "..tostring(runErr)) end

    setStatus("✅ 본체 실행 함수 완료\n스캐너 UI가 뒤에 열렸는지 확인하세요.")
    task.delay(3,function()
        if gui and gui.Parent then gui:Destroy() end
    end)
end,debug.traceback)

if not okMain then
    fail("진단 중 오류",mainErr)
end
