-- [[ SAADHUB OFFICIAL - FULL VERSION V102 (GREEN SENSE) ]] --

local player = game.Players.LocalPlayer
local httpService = game:GetService("HttpService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local starterGui = game:GetService("StarterGui")

-- [[ نظام الحفظ للإشعار الجديد - يظهر مرة واحدة للأبد ]] --
local updateFileName = "SaadHub_TeamCheck_Notify.json"
local function shouldNotifyUpdate()
    local success, content = pcall(function() return readfile(updateFileName) end)
    if success and content == "done" then return false end
    pcall(function() writefile(updateFileName, "done") end)
    return true
end
local isFirstUpdateNotify = shouldNotifyUpdate()

-- [[ نظام الحفظ الأصلي للإشعار الأول ]] --
local fileName = "SaadHub_Global_Check.json"
local function shouldNotify()
    local success, content = pcall(function() return readfile(fileName) end)
    if success and content == "done" then return false end
    pcall(function() writefile(fileName, "done") end)
    return true
end
local isFirstTime = shouldNotify()

-- [[ 1. نظام العداد (Live Users) ]] --
local liveCount = "1"
task.spawn(function()
    pcall(function() 
        local response = game:HttpGet("https://api.counterapi.dev/v1/saadhub_official_unique/hits/up")
        local data = httpService:JSONDecode(response)
        if data and data.count then liveCount = tostring(data.count) end
    end)
end)

-- [[ 2. واجهة المقدمة (نفس تنسيقك الأصلي بالملي) ]] --
local introGui = Instance.new("ScreenGui", player.PlayerGui)
introGui.Name = "SaadHub_Intro_System"; introGui.IgnoreGuiInset = true; introGui.DisplayOrder = 999

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

local downLabel = Instance.new("TextLabel", blackFrame)
downLabel.Size = UDim2.new(1, 0, 0, 20); downLabel.Position = UDim2.new(0, 0, 0.66, 0)
downLabel.Text = "Downloading..."; downLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8); downLabel.TextSize = 14; downLabel.Font = Enum.Font.GothamBold; downLabel.BackgroundTransparency = 1

local ownerInfo = Instance.new("TextLabel", blackFrame)
ownerInfo.Size = UDim2.new(1, 0, 0, 20); ownerInfo.Position = UDim2.new(0, 0, 0.88, 0)
ownerInfo.Text = "OWNER: 🇸🇦 tik:ql.z45"; ownerInfo.TextColor3 = Color3.fromRGB(180, 180, 180); ownerInfo.TextSize = 15; ownerInfo.Font = Enum.Font.GothamBold; ownerInfo.BackgroundTransparency = 1

local liveUsers = Instance.new("TextLabel", blackFrame)
liveUsers.Size = UDim2.new(1, 0, 0, 20); liveUsers.Position = UDim2.new(0, 0, 0.93, 0)
liveUsers.Text = "LIVE USERS: " .. liveCount; liveUsers.TextColor3 = Color3.new(1, 1, 1); liveUsers.TextSize = 17; liveUsers.Font = Enum.Font.GothamBold; liveUsers.BackgroundTransparency = 1

-- [[ 3. تشغيل الأنيميشن والإشعارات ]] --
task.spawn(function()
    local t = tweenService:Create(loadBar, TweenInfo.new(4), {Size = UDim2.new(1, 0, 1, 0)})
    t:Play(); t.Completed:Wait()
    downLabel.Text = "Completed! ✅"; task.wait(0.5)
    local fade = tweenService:Create(blackFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
    for _, v in pairs(blackFrame:GetDescendants()) do pcall(function() if v:IsA("TextLabel") or v:IsA("Frame") or v:IsA("ImageLabel") then tweenService:Create(v, TweenInfo.new(0.8), {Transparency = 1}):Play() end end) end
    fade:Play(); fade.Completed:Wait(); introGui:Destroy()
    
    -- الإشعار الجديد يظهر هنا بعد المقدمة (مرة واحدة فقط للأبد)
    if isFirstUpdateNotify then
        starterGui:SetCore("SendNotification", {
            Title = "SAADHUB UPDATED! ✅",
            Text = "تم إضافة فحص الفريق التلقائي (الأخضر)",
            Icon = "rbxassetid://13054812323",
            Duration = 6
        })
    end

    if isFirstTime then
        starterGui:SetCore("SendNotification", {Title = "SAADHUB UPDATED! ✅", Text = "تم تحديث الالتصاق وإضافة حماية", Icon = "rbxassetid://13054812323", Duration = 5})
    end
    task.wait(300)
    starterGui:SetCore("SendNotification", {Title = "SAADHUB SUPPORT 💬", Text = "للبلاغ والاستفسار tik:saadhub6", Duration = 10})
end)

-- [[ 4. واجهة التحكم القابلة للسحب ]] --
local mainGui = Instance.new("ScreenGui", player.PlayerGui); mainGui.ResetOnSpawn = false
local toggle = Instance.new("TextButton", mainGui)
toggle.Size = UDim2.new(0, 140, 0, 45); toggle.Position = UDim2.new(0.05, 0, 0.4, 0); toggle.Text = "SAADHUB: ON"
toggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0); toggle.TextColor3 = Color3.new(1, 1, 1); toggle.Font = Enum.Font.GothamBold; toggle.TextSize = 16; Instance.new("UICorner", toggle)
Instance.new("UIStroke", toggle).Color = Color3.new(1, 1, 1)

local dragging, dragStart, startPos
toggle.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; dragStart = input.Position; startPos = toggle.Position end end)
userInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - dragStart; toggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
toggle.InputEnded:Connect(function() dragging = false end)

-- [[ 5. منطق فحص التوهج الأخضر (Highlight Check) ]] --
local function isEnemy(v)
    if not v or v == player or not v.Character then return false end
    
    local hl = v.Character:FindFirstChildOfClass("Highlight")
    if hl then
        local c = hl.FillColor
        if c.G > c.R and c.G > c.B then return false end
    end
    
    local colorName = tostring(v.TeamColor):lower()
    if colorName:find("green") or colorName:find("lime") then return false end
    
    if player.Team ~= nil and v.Team ~= nil then
        if player.Team == v.Team then return false end
    end
    
    return true 
end

-- [[ 6. منطق الالتصاق "اللحم" ]] --
local active = true
local lockedTarget = nil

toggle.MouseButton1Click:Connect(function()
    active = not active; toggle.Text = active and "SAADHUB: ON" or "SAADHUB: OFF"
    toggle.BackgroundColor3 = active and Color3.fromRGB(170, 0, 0) or Color3.fromRGB(40, 40, 40)
    if not active then lockedTarget = nil end
end)

runService.RenderStepped:Connect(function()
    if active and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
        if player.Character:FindFirstChildOfClass("Tool") then
            local targetPlr = lockedTarget and game.Players:GetPlayerFromCharacter(lockedTarget)
            if not lockedTarget or not lockedTarget.Parent or lockedTarget.Humanoid.Health <= 0 or (targetPlr and not isEnemy(targetPlr)) then
                local cDist = math.huge; lockedTarget = nil
                for _, v in pairs(game.Players:GetPlayers()) do
                    if isEnemy(v) and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                        local d = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                        if d < cDist then cDist = d; lockedTarget = v.Character end
                    end
                end
            end
            if lockedTarget and lockedTarget:FindFirstChild("HumanoidRootPart") then
                local dist = (lockedTarget.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if dist > 0.5 then
                    player.Character.Humanoid:Move((lockedTarget.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Unit, false) 
                end
            end
        else lockedTarget = nil end
    end
end)
