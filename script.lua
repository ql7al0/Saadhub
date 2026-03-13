local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", sg)

-- تصميم اللوحة
frame.Size = UDim2.new(0, 300, 0, 100)
frame.Position = UDim2.new(0.5, -150, 0.1, 0) -- تطلع فوق في النص
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", frame)

-- نص التحديث
local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1, 0, 1, 0)
txt.Text = "🚀 SAADHUB UPDATED!\nتم تحديث ميزة الالتصاق"
txt.TextColor3 = Color3.new(1, 1, 1)
txt.BackgroundTransparency = 1
txt.TextSize = 18
txt.Font = Enum.Font.GothamBold

-- تختفي اللوحة بعد 5 ثواني تلقائياً
task.wait(5)
frame:Destroy()
-- [[ SAADHUB EDITION - PRESTIGE VERSION ]] --

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

-- 1. واجهة SAADHUB
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "SaadHub_Elite"
mainGui.ResetOnSpawn = false 
mainGui.IgnoreGuiInset = true
mainGui.Parent = player:WaitForChild("PlayerGui")

-- وظيفة المقدمة (اختياري لك)
local function startIntro()
    local introFrame = Instance.new("Frame", mainGui)
    introFrame.Size = UDim2.new(1, 0, 1, 0)
    introFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    introFrame.ZIndex = 1000
    
    local label = Instance.new("TextLabel", introFrame)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "SAADHUB"
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.TextSize = 1 -- نبدأ بحجم صغير جداً
    label.Font = Enum.Font.SpecialElite -- خط فخم
    label.TextTransparency = 1 -- نبدأ شفاف
    label.ZIndex = 1001

    -- تأثير الظهور والتحجيم (Tweening)
    local fadeInInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local fadeIn = tweenService:Create(label, fadeInInfo, {TextSize = 100, TextTransparency = 0})
    
    fadeIn:Play()
    fadeIn.Completed:Wait()
    
    task.wait(1) -- وقفة هيبة
    
    -- تأثير الاختفاء
    local fadeOut = tweenService:Create(introFrame, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundTransparency = 1})
    tweenService:Create(label, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
    
    fadeOut:Play()
    fadeOut.Completed:Wait()
    introFrame:Destroy()
end
task.spawn(startIntro)

-- 2. الزر القابل للسحب (تصميم مطور)
local toggle = Instance.new("TextButton", mainGui)
toggle.Size = UDim2.new(0, 140, 0, 45)
toggle.Position = UDim2.new(0.05, 0, 0.4, 0)
toggle.Text = "SAADHUB: ON"
toggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 16
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", toggle)
stroke.Color = Color3.new(1, 1, 1)
stroke.Thickness = 1.5

-- كود السحب
local dragging, dragInput, dragStart, startPos
toggle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = toggle.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
toggle.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
userInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        toggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- 3. منطق المشي الطبيعي (Natural Follow)
local active = true
toggle.MouseButton1Click:Connect(function()
    active = not active
    toggle.Text = active and "SAADHUB: ON" or "SAADHUB: OFF"
    toggle.BackgroundColor3 = active and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(40, 40, 40)
end)

local function getClosestPlayer()
    local closestDist = math.huge
    local closestChar = nil
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local dist = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closestChar = v.Character
            end
        end
    end
    return closestChar
end

runService.RenderStepped:Connect(function()
    if active and player.Character and player.Character:FindFirstChild("Humanoid") then
        local hum = player.Character.Humanoid
        local root = player.Character.HumanoidRootPart
        local bomb = player.Character:FindFirstChildOfClass("Tool")
        
        if bomb then
            local targetChar = getClosestPlayer()
            if targetChar then
                local targetRoot = targetChar.HumanoidRootPart
                local distance = (targetRoot.Position - root.Position).Magnitude
                
                hum.WalkSpeed = 16
                
                if distance > 1.8 then
                    local direction = (targetRoot.Position - root.Position).Unit
                    hum:Move(direction, false) 
                else
                    hum:Move(Vector3.new(0,0,0), false)
                end
            else
                hum:Move(Vector3.new(0,0,0), false)
            end
        end
    end
end)
