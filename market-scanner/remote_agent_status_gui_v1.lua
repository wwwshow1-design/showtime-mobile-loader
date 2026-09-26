-- Remote Agent visible status panel (no secrets stored here)
local env=(getgenv and getgenv()) or _G
local parent=game:GetService("CoreGui")
pcall(function() if gethui then parent=gethui() end end)

pcall(function()
    local old=parent:FindFirstChild("MarketRemoteStatusV1")
    if old then old:Destroy() end
end)

local gui=Instance.new("ScreenGui")
gui.Name="MarketRemoteStatusV1"
gui.ResetOnSpawn=false
gui.Parent=parent

local frame=Instance.new("Frame")
frame.Size=UDim2.fromOffset(285,92)
frame.Position=UDim2.fromOffset(14,62)
frame.BackgroundColor3=Color3.fromRGB(24,27,34)
frame.BorderSizePixel=0
frame.Parent=gui
Instance.new("UICorner",frame).CornerRadius=UDim.new(0,12)

local title=Instance.new("TextLabel")
title.BackgroundTransparency=1
title.Position=UDim2.fromOffset(14,10)
title.Size=UDim2.new(1,-45,0,22)
title.Font=Enum.Font.GothamBold
title.TextSize=15
title.TextColor3=Color3.fromRGB(240,244,255)
title.TextXAlignment=Enum.TextXAlignment.Left
title.Text="Discord 원격 관제"
title.Parent=frame

local status=Instance.new("TextLabel")
status.BackgroundTransparency=1
status.Position=UDim2.fromOffset(14,38)
status.Size=UDim2.new(1,-28,0,20)
status.Font=Enum.Font.GothamBold
status.TextSize=13
status.TextXAlignment=Enum.TextXAlignment.Left
status.Parent=frame

local info=Instance.new("TextLabel")
info.BackgroundTransparency=1
info.Position=UDim2.fromOffset(14,62)
info.Size=UDim2.new(1,-28,0,18)
info.Font=Enum.Font.Gotham
info.TextSize=11
info.TextColor3=Color3.fromRGB(170,180,198)
info.TextXAlignment=Enum.TextXAlignment.Left
info.Text="20초 주기 · Discord /상태에서 통신 확인"
info.Parent=frame

local close=Instance.new("TextButton")
close.Size=UDim2.fromOffset(28,28)
close.Position=UDim2.new(1,-36,0,7)
close.BackgroundColor3=Color3.fromRGB(45,50,63)
close.BorderSizePixel=0
close.Font=Enum.Font.GothamBold
close.TextSize=14
close.TextColor3=Color3.fromRGB(220,225,238)
close.Text="X"
close.Parent=frame
Instance.new("UICorner",close).CornerRadius=UDim.new(0,8)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

task.spawn(function()
    while gui.Parent do
        local agent=env.MarketRemoteAgentHeartbeatV1
        if type(agent)=="table" and agent.stop~=true then
            status.Text="● 원격 관제 실행 중"
            status.TextColor3=Color3.fromRGB(90,230,145)
        else
            status.Text="● 원격 관제 중지됨"
            status.TextColor3=Color3.fromRGB(255,105,105)
        end
        task.wait(1)
    end
end)
