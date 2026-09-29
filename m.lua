local Players=game:GetService("Players")
local TeleportService=game:GetService("TeleportService")
local ProximityPromptService=game:GetService("ProximityPromptService")
local UserInputService=game:GetService("UserInputService")
local TRADE_PLACE_ID=134708228958679
local SELF_URL="https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/m.lua?v=delta10"
local BASE="https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/market-scanner/v3.4.0/"
local PATCH_URL="https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/market-scanner/patch_v341.lua"
local PATCH342_URL="https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/market-scanner/patch_v342.lua"
local PATCH343_URL="https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/market-scanner/patch_v343.lua"
local REMOTE_AGENT_URL="https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/market-scanner/remote_agent_heartbeat_v1.lua"

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
box.Size=UDim2.fromOffset(410,210)
box.BackgroundColor3=Color3.fromRGB(20,22,28)
box.BorderSizePixel=0
box.Parent=gui
Instance.new("UICorner",box).CornerRadius=UDim.new(0,10)

local title=Instance.new("TextLabel")
title.Position=UDim2.fromOffset(12,8)
title.Size=UDim2.new(1,-24,0,28)
title.BackgroundTransparency=1
title.Text="Market Scanner · Delta"
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
status.TextSize=14
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

local function lower(v)
    return string.lower(tostring(v or ""))
end

local function promptFullName(prompt)
    local ok,name=pcall(function() return prompt:GetFullName() end)
    return ok and name or tostring(prompt.Name)
end

local function scorePrompt(prompt)
    local text=lower(prompt.ActionText).." "..lower(prompt.ObjectText).." "..lower(prompt.Name).." "..lower(promptFullName(prompt))
    local score=0
    local strong={"trade","trading","market","marketplace","terminal","exchange","auction","거래소"}
    local entry={"enter","entry","입장"}
    local npc={"trader","merchant","dealer","seller","vendor","npc"}
    for _,k in ipairs(strong) do
        if string.find(text,k,1,true) then score+=100 end
    end
    for _,k in ipairs(npc) do
        if string.find(text,k,1,true) then score+=35 end
    end
    for _,k in ipairs(entry) do
        if string.find(text,k,1,true) then score+=20 end
    end
    return score,text
end

local function getPromptPart(prompt)
    local p=prompt.Parent
    if not p then return nil end
    if p:IsA("Attachment") then p=p.Parent end
    if p and p:IsA("BasePart") then return p end
    if p and p:IsA("Model") then
        return p.PrimaryPart or p:FindFirstChildWhichIsA("BasePart",true)
    end
    local model=p and p:FindFirstAncestorOfClass("Model")
    if model then
        return model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart",true)
    end
    return nil
end

local function findTradePrompt()
    local ranked={}
    local enterOnly={}
    for _,obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and obj.Enabled then
            local score,text=scorePrompt(obj)
            if score>0 then
                ranked[#ranked+1]={prompt=obj,score=score,text=text}
            end
            local action=lower(obj.ActionText)
            if string.find(action,"enter",1,true) or string.find(action,"입장",1,true) then
                enterOnly[#enterOnly+1]=obj
            end
        end
    end
    table.sort(ranked,function(a,b) return a.score>b.score end)
    if ranked[1] and ranked[1].score>=100 then
        return ranked[1].prompt, ranked
    end
    if #enterOnly==1 then
        return enterOnly[1], ranked
    end
    return nil, ranked
end

local function moveNearPrompt(prompt)
    local char=player.Character or player.CharacterAdded:Wait()
    local root=char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart",10)
    if not root then return false,"HumanoidRootPart 없음" end
    local part=getPromptPart(prompt)
    if not part then return false,"프롬프트 위치 파트를 찾지 못함" end

    local maxDist=tonumber(prompt.MaxActivationDistance) or 10
    local dist=(root.Position-part.Position).Magnitude
    if dist>math.max(1,maxDist-1) then
        local offset=math.max(2,math.min(4,maxDist*0.45))
        root.CFrame=part.CFrame*CFrame.new(0,2,offset)
        task.wait(0.8)
    end
    return true
end

local function activatePrompt(prompt)
    local okMove,moveErr=moveNearPrompt(prompt)
    if not okMove then return false,moveErr end

    setStatus("✅ 거래소 NPC 감지\n"..promptFullName(prompt)..
        "\nActionText: "..tostring(prompt.ActionText)..
        "\nObjectText: "..tostring(prompt.ObjectText)..
        "\n\n입장하기 실행 중...")

    if type(fireproximityprompt)=="function" then
        local ok,err=pcall(function() fireproximityprompt(prompt) end)
        if ok then return true,"fireproximityprompt" end
    end

    local ok,err=pcall(function()
        prompt:InputHoldBegin()
        task.wait(math.max(0.15,(tonumber(prompt.HoldDuration) or 0)+0.15))
        prompt:InputHoldEnd()
    end)
    return ok,ok and "InputHold" or err
end

local function queueSelf()
    local q
    if type(queue_on_teleport)=="function" then q=queue_on_teleport
    elseif type(queueonteleport)=="function" then q=queueonteleport
    elseif type(syn)=="table" and type(syn.queue_on_teleport)=="function" then q=syn.queue_on_teleport end
    if q then
        return pcall(q,'loadstring(game:HttpGet("'..SELF_URL..'"))()')
    end
    return false
end

local okMain,mainErr=xpcall(function()
    if not player then error("LocalPlayer 없음") end

    setStatus("✅ 로더 실행 OK\n계정: "..player.Name.."\nPlaceId: "..tostring(game.PlaceId))
    task.wait(0.8)

    if game.PlaceId~=TRADE_PLACE_ID then
        queueSelf()
        setStatus("✅ 로더 실행 OK\n⚠ 일반 서버 감지\n거래소 NPC의 입장 프롬프트 찾는 중...\n현재 PlaceId: "..tostring(game.PlaceId))
        task.wait(0.3)

        local prompt,ranked=findTradePrompt()
        if not prompt then
            local lines={"❌ 거래소 NPC 프롬프트 자동 식별 실패","현재 PlaceId: "..tostring(game.PlaceId),"","찾은 후보:"}
            for i=1,math.min(5,#ranked) do
                local r=ranked[i]
                lines[#lines+1]=tostring(i)..") score "..tostring(r.score).." | "..promptFullName(r.prompt)
                lines[#lines+1]="   Action="..tostring(r.prompt.ActionText).." | Object="..tostring(r.prompt.ObjectText)
            end
            lines[#lines+1]=""
            lines[#lines+1]="이 화면을 캡처해서 보내주세요."
            setStatus(table.concat(lines,"\n"))
            return
        end

        local activated,method=activatePrompt(prompt)
        if not activated then error("거래소 NPC 입장 실행 실패: "..tostring(method)) end

        task.wait(1)
        if game.PlaceId~=TRADE_PLACE_ID then
            setStatus(status.Text.."\n\n✅ 입장 입력 전달 완료 ("..tostring(method)..")\n거래소 이동 응답 대기 중...")
        end
        return
    end

    local parts={}
    local total=0
    for i=1,12 do
        setStatus("✅ 거래소 서버 확인\n📥 본체 다운로드 "..i.." / 12\n받은 크기: "..tostring(total).." bytes")
        local data,lastErr
        for attempt=1,3 do
            data,lastErr=httpGet(BASE..string.format("part%02d.txt",i).."?v=delta6")
            if data then break end
            task.wait(0.4)
        end
        if not data then error("part"..string.format("%02d",i).." 다운로드 실패: "..tostring(lastErr)) end
        parts[i]=data
        total+=#data
    end

    setStatus("✅ 12 / 12 다운로드 완료\n총 "..tostring(total).." bytes\n🔧 V3.4.1 준비 중...")
    task.wait(0.4)

    local source=table.concat(parts)

    setStatus("✅ 본체 다운로드 완료\n🔧 V3.4.1 기능 패치 적용 중...")
    local patchCode,patchDownloadErr=httpGet(PATCH_URL.."?v=341")
    if not patchCode then
        error("V3.4.1 패치 다운로드 실패: "..tostring(patchDownloadErr))
    end
    local patchChunk,patchCompileErr=loadstring(patchCode)
    if not patchChunk then
        error("V3.4.1 패치 컴파일 오류: "..tostring(patchCompileErr))
    end
    local applyPatch=patchChunk()
    if type(applyPatch)~="function" then
        error("V3.4.1 패치 함수 형식 오류")
    end
    local patchedSource,patchErr=applyPatch(source)
    if not patchedSource then
        error("V3.4.1 패치 적용 실패: "..tostring(patchErr))
    end
    source=patchedSource

    setStatus("✅ V3.4.1 적용 완료\n🔧 V3.4.2 기능 패치 적용 중...")
    local patch342Code,patch342DownloadErr=httpGet(PATCH342_URL.."?v=342")
    if not patch342Code then
        error("V3.4.2 패치 다운로드 실패: "..tostring(patch342DownloadErr))
    end
    local patch342Chunk,patch342CompileErr=loadstring(patch342Code)
    if not patch342Chunk then
        error("V3.4.2 패치 컴파일 오류: "..tostring(patch342CompileErr))
    end
    local applyPatch342=patch342Chunk()
    if type(applyPatch342)~="function" then
        error("V3.4.2 패치 함수 형식 오류")
    end
    local patched342Source,patch342Err=applyPatch342(source)
    if not patched342Source then
        error("V3.4.2 패치 적용 실패: "..tostring(patch342Err))
    end
    source=patched342Source

    setStatus("✅ V3.4.2 적용 완료\n🔧 V3.4.3 알림/보고서 패치 적용 중...")
    local patch343Code,patch343DownloadErr=httpGet(PATCH343_URL.."?v=343")
    if not patch343Code then
        error("V3.4.3 패치 다운로드 실패: "..tostring(patch343DownloadErr))
    end
    local patch343Chunk,patch343CompileErr=loadstring(patch343Code)
    if not patch343Chunk then
        error("V3.4.3 패치 컴파일 오류: "..tostring(patch343CompileErr))
    end
    local applyPatch343=patch343Chunk()
    if type(applyPatch343)~="function" then
        error("V3.4.3 패치 함수 형식 오류")
    end
    local patched343Source,patch343Err=applyPatch343(source)
    if not patched343Source then
        error("V3.4.3 패치 적용 실패: "..tostring(patch343Err))
    end
    source=patched343Source

    source=source:gsub('local ACCOUNT = "Onyyxten2020"','local ACCOUNT = '..string.format('%q',player.Name),1)
    source=source:gsub('MarketSelectedScanner_Onyyxten2020_config%.json','MarketSelectedScanner_'..player.Name..'_config.json',1)

    local fn,compileErr=loadstring(source)
    if not fn then error("컴파일 오류: "..tostring(compileErr)) end

    setStatus("✅ 컴파일 성공\n▶ V3.4.3 실행 중...")
    task.wait(0.4)

    local okRun,runErr=xpcall(fn,debug.traceback)
    if not okRun then error("본체 실행 오류: "..tostring(runErr)) end

    local agentCode,agentErr=httpGet(REMOTE_AGENT_URL.."?v=2")
    if agentCode then
        local agentChunk=loadstring(agentCode)
        if agentChunk then
            task.spawn(function()
                local okAgent,runAgentErr=xpcall(agentChunk,debug.traceback)
                if not okAgent then warn("[RemoteAgent] "..tostring(runAgentErr)) end
            end)
        else
            warn("[RemoteAgent] 컴파일 실패")
        end
    else
        warn("[RemoteAgent] 다운로드 실패: "..tostring(agentErr))
    end

    setStatus("✅ 스캐너 실행 완료\n📡 원격 관제 자동 시작")
    task.delay(1.5,function()
        if gui and gui.Parent and box and box.Parent then
            box.AnchorPoint=Vector2.new(0,0)
            box.Position=UDim2.fromOffset(12,58)
            box.Size=UDim2.fromOffset(270,78)
            box.Active=true

            title.Text="📡 원격 관제"
            title.Position=UDim2.fromOffset(12,8)
            title.Size=UDim2.new(1,-58,0,24)
            title.TextSize=15
            title.Active=true

            status.Position=UDim2.fromOffset(12,36)
            status.Size=UDim2.new(1,-24,0,32)
            status.TextSize=12
            status.Text="🟢 실행 중\nDiscord /상태에서 연결 확인"

            local minimize=Instance.new("TextButton")
            minimize.Name="RemoteMinimize"
            minimize.Size=UDim2.fromOffset(34,28)
            minimize.Position=UDim2.new(1,-42,0,6)
            minimize.BackgroundColor3=Color3.fromRGB(45,50,63)
            minimize.BorderSizePixel=0
            minimize.Font=Enum.Font.GothamBold
            minimize.TextSize=14
            minimize.TextColor3=Color3.fromRGB(230,233,240)
            minimize.Text="−"
            minimize.Parent=box
            Instance.new("UICorner",minimize).CornerRadius=UDim.new(0,7)

            local collapsed=false
            local function applyCollapsed()
                if collapsed then
                    box.Size=UDim2.fromOffset(126,40)
                    title.Text="📡 🟢"
                    title.Size=UDim2.new(1,-48,1,0)
                    title.Position=UDim2.fromOffset(12,0)
                    title.TextSize=16
                    status.Visible=false
                    minimize.Text="□"
                    minimize.Position=UDim2.new(1,-38,0,6)
                    minimize.Size=UDim2.fromOffset(30,28)
                else
                    box.Size=UDim2.fromOffset(270,78)
                    title.Text="📡 원격 관제"
                    title.Position=UDim2.fromOffset(12,8)
                    title.Size=UDim2.new(1,-58,0,24)
                    title.TextSize=15
                    status.Visible=true
                    minimize.Text="−"
                    minimize.Position=UDim2.new(1,-42,0,6)
                    minimize.Size=UDim2.fromOffset(34,28)
                end
            end

            minimize.MouseButton1Click:Connect(function()
                collapsed=not collapsed
                applyCollapsed()
            end)

            local dragging=false
            local dragStart=nil
            local startPos=nil
            local dragInput=nil

            title.InputBegan:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.MouseButton1
                    or input.UserInputType==Enum.UserInputType.Touch then
                    dragging=true
                    dragStart=input.Position
                    startPos=box.Position
                    input.Changed:Connect(function()
                        if input.UserInputState==Enum.UserInputState.End then
                            dragging=false
                        end
                    end)
                end
            end)

            title.InputChanged:Connect(function(input)
                if input.UserInputType==Enum.UserInputType.MouseMovement
                    or input.UserInputType==Enum.UserInputType.Touch then
                    dragInput=input
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and input==dragInput and dragStart and startPos then
                    local delta=input.Position-dragStart
                    box.Position=UDim2.new(
                        startPos.X.Scale,
                        startPos.X.Offset+delta.X,
                        startPos.Y.Scale,
                        startPos.Y.Offset+delta.Y
                    )
                end
            end)
        end
    end)
end,debug.traceback)

if not okMain then
    fail("진단 중 오류",mainErr)
end
