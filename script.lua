-- [[ SAADHUB OFFICIAL - PRESTIGE & LIVE COUNTER ]] --

local player = game.Players.LocalPlayer
local httpService = game:GetService("HttpService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local starterGui = game:GetService("StarterGui")

-- [ نظام الذاكرة لمرة واحدة - One Time Notify ] --
if shared.SaadHubGlobalNotified == nil then 
    shared.SaadHubGlobalNotified = false 
end

local function sendOfficialNotify()
    if shared.SaadHubGlobalNotified == false then
        shared.SaadHubGlobalNotified = true -- نغير الحالة عشان ما يظهر مرة ثانية
        pcall(function()
            starterGui:SetCore("SendNotification", {
                Title = "SAADHUB UPDATED! ✅";
                Text = "تم تحديث السكربت وتم تضبيط الأمان أعلى (سرعة 16)";
                Duration = 5;
            })
        end)
    end
end

-- 1. واجهة المقدمة السوداء (المطورة مع خط التحميل)
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

-- [ خط التحميل - Loading Bar ] --
local loadingBackground = Instance.new("Frame", blackFrame)
loadingBackground.Size = UDim2.new(0, 300, 0, 5) -- عرض الخط
loadingBackground.Position = UDim2.new(0.5, -150, 0.65, 0) -- مكانه تحت النص
loadingBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- لون الخلفية رمادي غامق
loadingBackground.BorderSizePixel = 0
loadingBackground.ZIndex = 2
Instance.new("UICorner", loadingBackground).CornerRadius = UDim.new(1, 0) -- حواف دائرية

local loadingBar = Instance.new("Frame", loadingBackground)
loadingBar.Size = UDim2.new(0, 0, 1, 0) -- يبدأ من صفر
loadingBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- لون التحميل أحمر
loadingBar.BorderSizePixel = 0
loadingBar.ZIndex = 3
Instance.new("UICorner", loadingBar).CornerRadius = UDim.new(1, 0) -- حواف دائرية

local loadingText = Instance.new("TextLabel", blackFrame)
loadingText.Size = UDim2.new(0, 100, 0, 20)
loadingText.Position = UDim2.new(0.5, -50, 0.68, 0)
loadingText.Text = "Downloading..."
loadingText.TextColor3 = Color3.new(1, 1, 1)
loadingText.TextSize = 12
loadingText.Font = Enum.Font.GothamMedium
loadingText.BackgroundTransparency = 1
loadingText.ZIndex = 2

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

local liveUsersLabel = Instance.new("TextLabel", bottomContainer)
liveUsersLabel.Size = UDim2.new(0, 100, 1, 0)
liveUsersLabel.Position = UDim2.new(0, 210, 0, 0)
liveUsersLabel.Text = "1" 
liveUsersLabel.TextColor3 = Color3.new(1, 1, 1)
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

-- أنيميشن اختفاء المقدمة + أنيميشن خط التحميل
task.spawn(function()
    -- أنيميشن خط التحميل يمتلئ خلال 4 ثواني
    local tweenInfo = TweenInfo.new(4, Enum.EasingStyle.Linear) -- 4 ثواني، حركة خطية
    local loadingTween = tweenService:Create(loadingBar, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
    loadingTween:Play()
    
    -- نغير النص تدريجياً
    task.delay(1.5, function() loadingText.Text = "Verifying..." end)
    task.delay(3, function() loadingText.Text = "Complete!" end)
    
    -- ننتظر حتى ينتهي التحميل تماماً (4 ثواني)
    loadingTween.Completed:Wait()
    
    -- أنيميشن اختفاء الشاشة السوداء والنصوص
    local fade = tweenService:Create(blackFrame, TweenInfo.new(1.2), {BackgroundTransparency = 1})
    for _, v in pairs(blackFrame:GetDescendants()) do
        if v:IsA("TextLabel") then tweenService:Create(v, TweenInfo.new(0.8), {TextTransparency = 1}):Play() end
        if v:IsA("Frame") then tweenService:Create(v, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play() end
    end
    fade:Play()
    fade.Completed:Wait()
    introGui:Destroy()
    
    -- استدعاء الإشعار الرسمي (مرة واحدة فقط)
    sendOfficialNotify()
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
                
                -- تم تعديل السرعة إلى 16 للحماية القصوى من البند
                hum.WalkSpeed = 16 
                
                if distance > 1.0 then
                    local direction = (targetRoot.Position - root.Position).Unit
                    hum:Move(direction, false) 
                else
                    hum:Move(Vector3.new(0,0,0), false)
                end
            else
                hum:Move(Vector3.new(0,0,0), false)
            end
        else
            -- إعادة السرعة للطبيعي في حال عدم حمل الأداة
            hum.WalkSpeed = 16
        end
    end
end)