-- [[ SAADHUB OFFICIAL - PRESTIGE & LIVE COUNTER ]] --

local player = game.Players.LocalPlayer
local httpService = game:GetService("HttpService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

-- 1. واجهة المقدمة السوداء (المطورة)
local introGui = Instance.new("ScreenGui", player.PlayerGui)
introGui.Name = "SaadHub_Intro_System"
introGui.IgnoreGuiInset = true
introGui.DisplayOrder = 999

local blackFrame = Instance.new("Frame", introGui)
blackFrame.Size = UDim2.new(1, 0, 1, 0)
blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)
blackFrame.ZIndex = 1

-- نصوص المنتصف
local title = Instance.new("TextLabel", blackFrame)
title.Size = UDim2.new(1, 0, 0.1, 0)
title.Position = UDim2.new(0, 0, 0.45, 0)
title.Text = "SAADHUB | ACTIVE"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.TextSize = 45
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.ZIndex = 2

local subTitle = Instance.new("TextLabel", blackFrame)
subTitle.Size = UDim2.new(1, 0, 0.1, 0)
subTitle.Position = UDim2.new(0, 0, 0.55, 0)
subTitle.Text = "SAADHUB | tik:saadhub6"
subTitle.TextColor3 = Color3.new(1, 1, 1)
subTitle.TextSize = 20
subTitle.Font = Enum.Font.Code
subTitle.BackgroundTransparency = 1
subTitle.ZIndex = 2

-- منطقة الأونر والعداد الأبيض (تحت يسار)
local bottomContainer = Instance.new("Frame", blackFrame)
bottomContainer.Size = UDim2.new(0, 400, 0, 50)
bottomContainer.Position = UDim2.new(0.03, 0, 0.9, 0)
bottomContainer.BackgroundTransparency = 1
bottomContainer.ZIndex = 2

local ownerLabel = Instance.new("TextLabel", bottomContainer)
ownerLabel.Size = UDim2.new(0, 200, 1, 0)
ownerLabel.Text = "OWNER: 🇸🇦 tik:ql.z45"
ownerLabel.TextColor3 = Color3.new(1, 1, 1)
ownerLabel.TextSize = 16
ownerLabel.Font = Enum.Font.GothamBold
ownerLabel.BackgroundTransparency = 1
ownerLabel.ZIndex = 3

local onlineDot = Instance.new("Frame", bottomContainer)
onlineDot.Size = UDim2.new(0, 10, 0, 10)
onlineDot.Position = UDim2.new(0, 195, 0.35, 0)
onlineDot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
onlineDot.ZIndex = 3
Instance.new("UICorner", onlineDot).CornerRadius = UDim.new(1, 0)

local liveUsersLabel = Instance.new("TextLabel", bottomContainer)
liveUsersLabel.Size = UDim2.new(0, 100, 1, 0)
liveUsersLabel.Position = UDim2.new(0, 210, 0, 0)
liveUsersLabel.Text = "1" 
liveUsersLabel.TextColor3 = Color3.new(1, 1, 1) -- الرقم بالأبيض
liveUsersLabel.TextSize = 16
liveUsersLabel.Font = Enum.Font.GothamBold
liveUsersLabel.BackgroundTransparency = 1
liveUsersLabel.ZIndex = 3

-- تشغيل العداد الفعلي (Bypass System)
task.spawn(function()
    local url = "https://api.countapi.xyz/hit/saadhub_final_real_v9/visits"
    pcall(function() 
        local response = game:HttpGet(url)
        local data = httpService:JSONDecode(response)
        liveUsersLabel.Text = tostring(data.value)
    end)
end)

-- أنيميشن اختفاء المقدمة
task.spawn(function()
    task.wait(4)
    local fade = tweenService:Create(blackFrame, TweenInfo.new(1.2), {BackgroundTransparency = 1})
    for _, v in pairs(blackFrame:GetDescendants()) do
        if v:IsA("TextLabel") then tweenService:Create(v, TweenInfo.new(0.8), {TextTransparency = 1}):Play() end
        if v:IsA("Frame") then tweenService:Create(v, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play() end
    end
    fade:Play()
    fade.Completed:Wait()
    introGui:Destroy()
end)

--- [ 2. واجهة السكربت الفعلي - SAADHUB ELITE ] ---

local mainGui = Instance.new("ScreenGui", player.PlayerGui)
mainGui.Name = "SaadHub_Elite"
mainGui.ResetOnSpawn = false 
mainGui.IgnoreGuiInset = true

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

-- كود السحب (Dragging)
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

--- [ 3. منطق الالتصاق والتبع (No Team Check) ] ---

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
        -- تم حذف فحص الفريق لضمان الالتصاق بالجميع
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
                
                hum.WalkSpeed = 22 -- سرعة مطاردة ممتازة
                
                if distance > 1.5 then
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
