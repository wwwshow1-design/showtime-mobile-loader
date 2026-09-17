local Players=game:GetService("Players")
local StarterGui=game:GetService("StarterGui")
local TeleportService=game:GetService("TeleportService")
local TRADE_PLACE_ID=134708228958679
local SELF_URL="https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/m.lua"
local BASE="https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/market-scanner/v3.4.0/"

local function notify(title,text,duration)
    pcall(function()
        StarterGui:SetCore("SendNotification",{
            Title=title or "Market Scanner",
            Text=text or "",
            Duration=duration or 6
        })
    end)
end

local player=Players.LocalPlayer
if not player then
    local deadline=os.clock()+15
    repeat task.wait(0.1) player=Players.LocalPlayer until player or os.clock()>=deadline
end
if not player then
    notify("Market Scanner","LocalPlayer를 찾지 못했습니다.",8)
    error("Market Scanner loader: LocalPlayer not found")
end

if game.PlaceId~=TRADE_PLACE_ID then
    local queued=false
    local q
    if type(queue_on_teleport)=="function" then q=queue_on_teleport end
    if not q and type(queueonteleport)=="function" then q=queueonteleport end
    if not q and type(syn)=="table" and type(syn.queue_on_teleport)=="function" then q=syn.queue_on_teleport end
    if not q and type(fluxus)=="table" and type(fluxus.queue_on_teleport)=="function" then q=fluxus.queue_on_teleport end
    if q then
        local ok=pcall(q,'loadstring(game:HttpGet("'..SELF_URL..'"))()')
        queued=ok
    end
    if queued then
        notify("Market Scanner","거래소 서버로 이동 후 자동 재실행합니다.",7)
    else
        notify("Market Scanner","거래소 서버로 이동합니다. 이동 후 같은 1줄을 다시 실행해주세요.",9)
    end
    local ok,err=pcall(function() TeleportService:Teleport(TRADE_PLACE_ID,player) end)
    if not ok then
        notify("Market Scanner","거래소 이동 실패: "..tostring(err),10)
        error("Market Scanner teleport failed: "..tostring(err))
    end
    return
end

notify("Market Scanner","V3.4.0 불러오는 중...",4)
local parts={}
for i=1,12 do
    local url=BASE..string.format("part%02d.txt",i)
    local ok,data
    for attempt=1,3 do
        ok,data=pcall(function() return game:HttpGet(url) end)
        if ok and type(data)=="string" and #data>0 then break end
        task.wait(0.5)
    end
    if not ok or type(data)~="string" or #data==0 then
        local msg="part "..i.." 다운로드 실패"
        notify("Market Scanner",msg,10)
        error("Market Scanner loader: "..msg)
    end
    parts[i]=data
end

local source=table.concat(parts)
source=source:gsub('local ACCOUNT = "Onyyxten2020"','local ACCOUNT = '..string.format('%q',player.Name),1)
source=source:gsub('MarketSelectedScanner_Onyyxten2020_config%.json','MarketSelectedScanner_'..player.Name..'_config.json',1)

local fn,compileErr=loadstring(source)
if not fn then
    notify("Market Scanner","컴파일 오류: "..tostring(compileErr),12)
    error("Market Scanner compile error: "..tostring(compileErr))
end

local ok,runErr=pcall(fn)
if not ok then
    notify("Market Scanner","실행 오류: "..tostring(runErr),12)
    error("Market Scanner runtime error: "..tostring(runErr))
end
