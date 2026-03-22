-- [[ SAADHUB OFFICIAL - V102 (20 PULSE + CIRCLE DRAG) ]] --

local player = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

-- [[ 1. واجهة المقدمة (تصميمك الأصلي بالملي) ]] --
local introGui = Instance.new("ScreenGui", player.PlayerGui)
introGui.Name = "SaadHub_Intro"; introGui.IgnoreGuiInset = true; introGui.DisplayOrder = 999
local blackFrame = Instance.new("Frame", introGui)
blackFrame.Size = UDim2.new(1, 0, 1, 0); blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)

local logo = Instance.new("ImageLabel", blackFrame)
logo.Size = UDim2.new(0, 80, 0, 80); logo.Position = UDim2.new(0.5, -40, 0.15, 0)
logo.Image = "rbxassetid://13054812323"; logo.BackgroundTransparency = 1

local title = Instance.new("TextLabel", blackFrame)
title.Size = UDim2.new(1, 0, 0, 50); title.Position = UDim2.new(0, 0, 0.38, 0)
title.Text = "SAADHUB | ACTIVE"; title.TextColor3 = Color3.fromRGB(255, 0, 0); title.TextSize = 50; title.Font = Enum.Font.GothamBold; title.BackgroundTransparency = 1

local subTitle = Instance.new("TextLabel", blackFrame)
subTitle.Size = UDim2.new(1, 0, 0, 20); subTitle.Position = UDim2.new(0, 0, 0.52, 0)
subTitle.Text = "SAADHUB  |  tik:saadhub6"; subTitle.TextColor3 = Color3.new(1, 1, 1); subTitle.TextSize = 18; subTitle.Font = Enum.Font.Code; subTitle.BackgroundTransparency = 1

local loadBg = Instance.new("Frame", blackFrame)
loadBg.Size = UDim2.new(0, 320, 0, 5); loadBg.Position = UDim2.new(0.5, -160, 0.62, 0)
loadBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30); loadBg.BorderSizePixel = 0; Instance.new("UICorner", loadBg)

local loadBar = Instance.new("Frame", loadBg)
loadBar.Size = UDim2.new(0, 0, 1, 0); loadBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0); loadBar.BorderSizePixel = 0; Instance.new("UICorner", loadBar)

task.spawn(function()
    tweenService:Create(loadBar, TweenInfo.new(3), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(3.5)
    local fade = tweenService:Create(blackFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
    for _, v in pairs(blackFrame:GetDescendants()) do pcall(function() tweenService:Create(v, TweenInfo.new(0.8), {ImageTransparency = 1, TextTransparency = 1, BackgroundTransparency = 1}):Play() end) end
    fade:Play(); fade.Completed:Wait(); introGui:Destroy()
end)

-- [[ 2. واجهة التحكم (السحب محصور في الدائرة فقط) ]] --
local mainGui = Instance.new("ScreenGui", player.PlayerGui); mainGui.ResetOnSpawn = false
local toggle = Instance.new("TextButton", mainGui)
toggle.Size = UDim2.new(0, 140, 0, 45); toggle.Position = UDim2.new(0.05, 0, 0.4, 0)
toggle.Text = "SAADHUB: ON"; toggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0); toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold; toggle.TextSize = 16; Instance.new("UICorner", toggle)
Instance.new("UIStroke", toggle).Color = Color3.new(1, 1, 1)

local dragCircle = Instance.new("Frame", toggle)
dragCircle.Size = UDim2.new(0, 25, 0, 25); dragCircle.Position = UDim2.new(0.5, -12.5, 0, -32)
dragCircle.BackgroundColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", dragCircle).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", dragCircle).Thickness = 1.5

local dragging, dragStart, startPos
dragCircle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = toggle.Position
    end
end)
userInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        toggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
userInputService.InputEnded:Connect(function() dragging = false end)

-- [[ 3. منطق الالتصاق واللمس (20 نبضة) ]] --
local active = true
local lockedTarget = nil

local function isEnemy(v)
    if not v or v == player or not v.Character then return false end
    if player.Team ~= nil and v.Team ~= nil and player.Team == v.Team then return false end
    return true 
end

toggle.MouseButton1Click:Connect(function()
    active = not active; toggle.Text = active and "SAADHUB: ON" or "SAADHUB: OFF"
    toggle.BackgroundColor3 = active and Color3.fromRGB(170, 0, 0) or Color3.fromRGB(40, 40, 40)
end)

runService.RenderStepped:Connect(function()
    if active and player.Character and player.Character:FindFirstChild("Humanoid") then
        local tool = player.Character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
        if tool then
            if tool.Parent == player.Backpack then player.Character.Humanoid:EquipTool(tool) end
            if not lockedTarget or not lockedTarget.Parent or lockedTarget.Humanoid.Health <= 0 then
                local cDist = math.huge; lockedTarget = nil
                for _, v in pairs(game.Players:GetPlayers()) do
                    if isEnemy(v) and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local d = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                        if d < cDist then cDist = d; lockedTarget = v.Character end
                    end
                end
            end
            if lockedTarget and lockedTarget:FindFirstChild("HumanoidRootPart") then
                local tRoot = lockedTarget.HumanoidRootPart
                local dist = (tRoot.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if dist > 1.2 then player.Character.Humanoid:Move((tRoot.Position - player.Character.HumanoidRootPart.Position).Unit, false) end
                local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("Part")
                if handle and dist < 4 then
                    -- تم التعديل لـ 20 نبضة كما طلبت
                    for i = 1, 20 do firetouchinterest(tRoot, handle, 0); firetouchinterest(tRoot, handle, 1) end
                end
            end
        end
    end
end)
