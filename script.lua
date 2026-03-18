-- [[ SAADHUB OFFICIAL - ALL FEATURES + DRAGGABLE ]] --

local player = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")
local httpService = game:GetService("HttpService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local starterGui = game:GetService("StarterGui")

-- نظام الحفظ الأبدي للإشعار
local fileName = "SaadHub_Final_Full_V3.json"
local function shouldNotify()
    local success, content = pcall(function() return readfile(fileName) end)
    if success and content == "done" then return false end
    pcall(function() writefile(fileName, "done") end)
    return true
end
local isFirstTime = shouldNotify()

-- 1. واجهة المقدمة (تنسيق احترافي بمسافات)
local introGui = Instance.new("ScreenGui", player.PlayerGui)
introGui.Name = "SaadHub_Intro_System"; introGui.IgnoreGuiInset = true; introGui.DisplayOrder = 999

local blackFrame = Instance.new("Frame", introGui)
blackFrame.Size = UDim2.new(1, 0, 1, 0); blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)

-- اللوقو
local logo = Instance.new("ImageLabel", blackFrame)
logo.Size = UDim2.new(0, 80, 0, 80); logo.Position = UDim2.new(0.5, -40, 0.15, 0)
logo.Image = "rbxassetid://13054812323"; logo.BackgroundTransparency = 1

-- العنوان الرئيسي
local title = Instance.new("TextLabel", blackFrame)
title.Size = UDim2.new(1, 0, 0, 50); title.Position = UDim2.new(0, 0, 0.38, 0)
title.Text = "SAADHUB | ACTIVE"; title.TextColor3 = Color3.fromRGB(255, 0, 0); title.TextSize = 50; title.Font = Enum.Font.GothamBold; title.BackgroundTransparency = 1

-- اليوزر نيم (تحت العنوان بمسافة)
local subTitle = Instance.new("TextLabel", blackFrame)
subTitle.Size = UDim2.new(1, 0, 0, 20); subTitle.Position = UDim2.new(0, 0, 0.52, 0)
subTitle.Text = "SAADHUB  |  tik:saadhub6"; subTitle.TextColor3 = Color3.new(1, 1, 1); subTitle.TextSize = 18; subTitle.Font = Enum.Font.Code; subTitle.BackgroundTransparency = 1

-- خط التحميل
local loadBg = Instance.new("Frame", blackFrame)
loadBg.Size = UDim2.new(0, 320, 0, 5); loadBg.Position = UDim2.new(0.5, -160, 0.62, 0)
loadBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30); loadBg.BorderSizePixel = 0; Instance.new("UICorner", loadBg)

local loadBar = Instance.new("Frame", loadBg)
loadBar.Size = UDim2.new(0, 0, 1, 0); loadBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0); loadBar.BorderSizePixel = 0; Instance.new("UICorner", loadBar)

-- كلمة Downloading تحت الخط مباشرة
local downLabel = Instance.new("TextLabel", blackFrame)
downLabel.Size = UDim2.new(1, 0, 0, 20); downLabel.Position = UDim2.new(0, 0, 0.66, 0)
downLabel.Text = "Downloading..."; downLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8); downLabel.TextSize = 14; downLabel.Font = Enum.Font.GothamBold; downLabel.BackgroundTransparency = 1

-- نصوص الأسفل (الأونر والعداد)
local ownerInfo = Instance.new("TextLabel", blackFrame)
ownerInfo.Size = UDim2.new(1, 0, 0, 20); ownerInfo.Position = UDim2.new(0, 0, 0.88, 0)
ownerInfo.Text = "OWNER: 🇸🇦 tik:S"; ownerInfo.TextColor3 = Color3.fromRGB(180, 180, 180); ownerInfo.TextSize = 15; ownerInfo.Font = Enum.Font.GothamBold; ownerInfo.BackgroundTransparency = 1

local liveUsers = Instance.new("TextLabel", blackFrame)
liveUsers.Size = UDim2.new(1, 0, 0, 20); liveUsers.Position = UDim2.new(0, 0, 0.93, 0)
liveUsers.Text = "LIVE USERS: 1"; liveUsers.TextColor3 = Color3.new(1, 1, 1); liveUsers.TextSize = 17; liveUsers.Font = Enum.Font.GothamBold; liveUsers.BackgroundTransparency = 1

-- تحديث العداد
task.spawn(function()
    pcall(function() 
        local data = httpService:JSONDecode(game:HttpGet("https://api.countapi.xyz/hit/saadhub_final_real_v9/visits"))
        liveUsers.Text = "LIVE USERS: " .. tostring(data.value)
    end)
end)

-- أنيميشن التحميل والاختفاء
task.spawn(function()
    local t = tweenService:Create(loadBar, TweenInfo.new(4, Enum.EasingStyle.Sine), {Size = UDim2.new(1, 0, 1, 0)})
    t:Play(); t.Completed:Wait()
    downLabel.Text = "Completed! ✅"; task.wait(0.5)
    local fade = tweenService:Create(blackFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
    for _, v in pairs(blackFrame:GetDescendants()) do
        pcall(function() if v:IsA("TextLabel") or v:IsA("Frame") or v:IsA("ImageLabel") then tweenService:Create(v, TweenInfo.new(0.8), {Transparency = 1}):Play() end end)
    end
    fade:Play(); fade.Completed:Wait(); introGui:Destroy()
    
    if isFirstTime then
        starterGui:SetCore("SendNotification", {
            Title = "SAADHUB UPDATED! ✅";
            Text = "تم تفعيل حماية الأمان (Speed: 16)";
            Duration = 6;
        })
    end
end)

--- [ 2. واجهة التحكم القابلة للسحب ] ---
local mainGui = Instance.new("ScreenGui", player.PlayerGui); mainGui.ResetOnSpawn = false
local toggle = Instance.new("TextButton", mainGui)
toggle.Size = UDim2.new(0, 140, 0, 45); toggle.Position = UDim2.new(0.05, 0, 0.4, 0); toggle.Text = "SAADHUB: ON"
toggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0); toggle.TextColor3 = Color3.new(1, 1, 1); toggle.Font = Enum.Font.GothamBold; toggle.TextSize = 16; Instance.new("UICorner", toggle)
Instance.new("UIStroke", toggle).Color = Color3.new(1, 1, 1)

-- منطق السحب المطور
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    toggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
toggle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = toggle.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
toggle.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
userInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)

--- [ 3. منطق التفعيل والتبع (سرعة 16) ] ---
local active = true
toggle.MouseButton1Click:Connect(function()
    active = not active
    toggle.Text = active and "SAADHUB: ON" or "SAADHUB: OFF"
    toggle.BackgroundColor3 = active and Color3.fromRGB(170, 0, 0) or Color3.fromRGB(40, 40, 40)
end)

runService.RenderStepped:Connect(function()
    if active and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
        -- كود التبع يعمل مع الأدوات
        if player.Character:FindFirstChildOfClass("Tool") then
            local cDist, cChar = math.huge, nil
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                    local d = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                    if d < cDist then cDist = d; cChar = v.Character end
                end
            end
            if cChar and (cChar.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude > 1.2 then
                player.Character.Humanoid:Move((cChar.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Unit, false) 
            end
        end
    end
end)
