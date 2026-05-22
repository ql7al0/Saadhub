-- [[ SAADHUB V102 - PREMIUM UI EDITION (AUTO + DESYNC + QUALITY) - WHITE GOLD THEME ]] --

local player = game.Players.LocalPlayer
local httpService = game:GetService("HttpService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local starterGui = game:GetService("StarterGui")
local coreGui = game:GetService("CoreGui")

-- المتغيرات الأساسية
local active = true
local lockedTarget = nil
local adhesionStrength = 4.0 
local desyncActive = false
local desyncLagValue = 0.2 -- القيمة الافتراضية للبانق
local floatingScale = 1.0

-- متغيرات نظام الحفظ للإشعار والعداد
local updateFileName = "SaadHub_Safe_V102_Premium.json"
local function shouldNotifyUpdate()
    local success, content = pcall(function() return readfile(updateFileName) end)
    if success and content == "done" then return false end
    pcall(function() writefile(updateFileName, "done") end)
    return true
end
local isFirstUpdateNotify = shouldNotifyUpdate()

local liveCount = "1"
task.spawn(function()
    pcall(function() 
        local response = game:HttpGet("https://api.counterapi.dev/v1/saadhub_official_unique/hits/up")
        local data = httpService:JSONDecode(response)
        if data and data.count then liveCount = tostring(data.count) end
    end)
end)

-- [[ 1. الواجهة الجديدة (شاشة البدء البيضاء الذهبية) ]] --
local function createFallingStars(parentFrame, starCount)
    local starImage = "rbxassetid://5475346442" -- نجمة ذهبية
    local starsContainer = Instance.new("Frame", parentFrame)
    starsContainer.Size = UDim2.new(1,0,1,0)
    starsContainer.BackgroundTransparency = 1
    starsContainer.ClipsDescendants = false

    local function spawnStar()
        local star = Instance.new("ImageLabel", starsContainer)
        star.Size = UDim2.new(0, 30, 0, 30)
        star.Position = UDim2.new(math.random() * 0.9, 0, -0.1, 0)
        star.Image = starImage
        star.BackgroundTransparency = 1
        star.Rotation = math.random(0, 360)
        star.ImageColor3 = Color3.fromRGB(255, 215, 0) -- ذهبي

        local tween = tweenService:Create(star, TweenInfo.new(math.random(3,6), Enum.EasingStyle.Linear), {
            Position = UDim2.new(math.random() * 0.9, 0, 1.1, 0),
            Rotation = star.Rotation + math.random(-180, 180)
        })
        tween:Play()
        tween.Completed:Connect(function() star:Destroy() end)
    end

    for _ = 1, starCount do
        task.spawn(spawnStar)
    end
    -- توليد نجوم مستمر
    task.spawn(function()
        while parentFrame.Parent do
            spawnStar()
            task.wait(0.3)
        end
    end)
end

local function createIntroScreen()
    local introGui = Instance.new("ScreenGui")
    introGui.Name = "SaadHub_Intro_New"
    introGui.IgnoreGuiInset = true
    introGui.DisplayOrder = 999
    local s, e = pcall(function() introGui.Parent = coreGui end)
    if not s then introGui.Parent = player.PlayerGui end

    -- خلفية بيضاء
    local whiteBg = Instance.new("Frame", introGui)
    whiteBg.Size = UDim2.new(1,0,1,0)
    whiteBg.BackgroundColor3 = Color3.new(1,1,1)
    whiteBg.BorderSizePixel = 0

    -- نجوم ذهبية تتساقط
    createFallingStars(whiteBg, 20)

    -- صورة السكن (أفتار اللاعب)
    local avatarFrame = Instance.new("ImageLabel", whiteBg)
    avatarFrame.Size = UDim2.new(0, 200, 0, 200)
    avatarFrame.Position = UDim2.new(0.5, -100, 0.25, 0)
    avatarFrame.BackgroundColor3 = Color3.new(1,1,1)
    avatarFrame.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=420&height=420&format=png"
    local avatarStroke = Instance.new("UIStroke", avatarFrame)
    avatarStroke.Color = Color3.fromRGB(255, 215, 0) -- ذهبي
    avatarStroke.Thickness = 4
    Instance.new("UICorner", avatarFrame).CornerRadius = UDim.new(1,0)

    -- زر Start
    local startBtn = Instance.new("TextButton", whiteBg)
    startBtn.Size = UDim2.new(0, 200, 0, 60)
    startBtn.Position = UDim2.new(0.5, -100, 0.65, 0)
    startBtn.Text = "ابدأ"
    startBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
    startBtn.Font = Enum.Font.GothamBold
    startBtn.TextSize = 28
    startBtn.BackgroundColor3 = Color3.new(1,1,1)
    local startStroke = Instance.new("UIStroke", startBtn)
    startStroke.Color = Color3.fromRGB(255, 215, 0)
    startStroke.Thickness = 3
    Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 12)

    startBtn.MouseButton1Click:Connect(function()
        -- تأثير اختفاء المقدمة
        local fade = tweenService:Create(whiteBg, TweenInfo.new(0.6), {BackgroundTransparency = 1})
        for _, v in pairs(whiteBg:GetDescendants()) do
            if v:IsA("TextButton") or v:IsA("ImageLabel") or v:IsA("UIStroke") then
                tweenService:Create(v, TweenInfo.new(0.5), {Transparency = 1}):Play()
            end
        end
        fade:Play()
        fade.Completed:Wait()
        introGui:Destroy()
        createMainMenu()
    end)
end

-- [[ 2. القائمة الرئيسية بالأبيض والذهبي ]] --
local function createMainMenu()
    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "SaadHub_Main"
    mainGui.ResetOnSpawn = false
    pcall(function() mainGui.Parent = coreGui end)
    if not mainGui.Parent then mainGui.Parent = player.PlayerGui end

    -- زر عائم (مربع أحمر صغير كما في الأصل ولكن بألوان متناسقة)
    local floatingToggle = Instance.new("TextButton", mainGui)
    floatingToggle.Size = UDim2.new(0, 150, 0, 45)
    floatingToggle.Position = UDim2.new(0.05, 0, 0.4, 0)
    floatingToggle.Text = "SAADHUB: ON"
    floatingToggle.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    floatingToggle.TextColor3 = Color3.new(0,0,0)
    floatingToggle.Font = Enum.Font.GothamBold
    floatingToggle.TextSize = 15
    Instance.new("UICorner", floatingToggle).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", floatingToggle).Color = Color3.fromRGB(255, 255, 255)
    floatingToggle.Visible = false

    local dragCircle = Instance.new("Frame", floatingToggle)
    dragCircle.Size = UDim2.new(0, 25, 0, 25)
    dragCircle.Position = UDim2.new(0.5, -12.5, 0, -32)
    dragCircle.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    Instance.new("UICorner", dragCircle).CornerRadius = UDim.new(1, 0)

    local fDragging, fDragStart, fStartPos
    dragCircle.InputBegan:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            fDragging = true; fDragStart = input.Position; fStartPos = floatingToggle.Position 
        end 
    end)
    userInputService.InputChanged:Connect(function(input) 
        if fDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then 
            local delta = input.Position - fDragStart; 
            floatingToggle.Position = UDim2.new(fStartPos.X.Scale, fStartPos.X.Offset + delta.X, fStartPos.Y.Scale, fStartPos.Y.Offset + delta.Y) 
        end 
    end)
    userInputService.InputEnded:Connect(function() fDragging = false end)

    -- النافذة الرئيسية
    local mainFrame = Instance.new("Frame", mainGui)
    mainFrame.Size = UDim2.new(0, 420, 0, 340)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -170)
    mainFrame.BackgroundColor3 = Color3.new(1,1,1)
    mainFrame.BorderSizePixel = 0
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", mainFrame)
    stroke.Color = Color3.fromRGB(255, 215, 0)
    stroke.Thickness = 2

    -- نجوم ذهبية تتساقط داخل القائمة
    createFallingStars(mainFrame, 15)

    -- أيقونة صغيرة
    local miniIcon = Instance.new("ImageButton", mainGui)
    miniIcon.Size = UDim2.new(0, 50, 0, 50)
    miniIcon.Position = UDim2.new(0.05, 0, 0.2, 0)
    miniIcon.Image = "rbxassetid://13054812323"
    miniIcon.BackgroundColor3 = Color3.new(1,1,1)
    miniIcon.Visible = false
    Instance.new("UICorner", miniIcon).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", miniIcon).Color = Color3.fromRGB(255, 215, 0)

    local topBar = Instance.new("Frame", mainFrame)
    topBar.Size = UDim2.new(1, 0, 0, 45)
    topBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)
    
    local titleTxt = Instance.new("TextLabel", topBar)
    titleTxt.Size = UDim2.new(0.7, 0, 1, 0)
    titleTxt.Position = UDim2.new(0, 15, 0, 0)
    titleTxt.Text = "SAADHUB | V102"
    titleTxt.TextColor3 = Color3.new(1,1,1)
    titleTxt.Font = Enum.Font.GothamBold
    titleTxt.TextSize = 16
    titleTxt.BackgroundTransparency = 1
    titleTxt.TextXAlignment = Enum.TextXAlignment.Left

    local minBtn = Instance.new("TextButton", topBar)
    minBtn.Size = UDim2.new(0, 35, 0, 35)
    minBtn.Position = UDim2.new(1, -45, 0, 5)
    minBtn.Text = "—"
    minBtn.TextColor3 = Color3.new(1,1,1)
    minBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 14
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

    local dragging, dragStart, startPos
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = mainFrame.Position
        end
    end)
    userInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    userInputService.InputEnded:Connect(function() dragging = false end)

    minBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false; miniIcon.Visible = true end)
    miniIcon.MouseButton1Click:Connect(function() mainFrame.Visible = true; miniIcon.Visible = false end)

    local tabFrame = Instance.new("Frame", mainFrame)
    tabFrame.Size = UDim2.new(1, -30, 0, 35)
    tabFrame.Position = UDim2.new(0, 15, 0, 60)
    tabFrame.BackgroundTransparency = 1

    local autoTab = Instance.new("TextButton", tabFrame)
    autoTab.Size = UDim2.new(0.48, 0, 1, 0)
    autoTab.Text = "تحكم الاوتو"
    autoTab.Font = Enum.Font.GothamSemibold
    autoTab.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    autoTab.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", autoTab).CornerRadius = UDim.new(0, 6)
    
    local ghostTab = Instance.new("TextButton", tabFrame)
    ghostTab.Size = UDim2.new(0.48, 0, 1, 0)
    ghostTab.Position = UDim2.new(0.52, 0, 0, 0)
    ghostTab.Text = "Desync واتصال"
    ghostTab.Font = Enum.Font.GothamSemibold
    ghostTab.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    ghostTab.TextColor3 = Color3.new(0,0,0)
    Instance.new("UICorner", ghostTab).CornerRadius = UDim.new(0, 6)

    local page1 = Instance.new("Frame", mainFrame)
    page1.Size = UDim2.new(1, -30, 1, -110)
    page1.Position = UDim2.new(0, 15, 0, 110)
    page1.BackgroundTransparency = 1

    local page2 = Instance.new("Frame", mainFrame)
    page2.Size = UDim2.new(1, -30, 1, -110)
    page2.Position = UDim2.new(0, 15, 0, 110)
    page2.BackgroundTransparency = 1
    page2.Visible = false

    autoTab.MouseButton1Click:Connect(function()
        page1.Visible = true; page2.Visible = false
        autoTab.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        ghostTab.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    end)
    ghostTab.MouseButton1Click:Connect(function()
        page1.Visible = false; page2.Visible = true
        ghostTab.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        autoTab.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    end)

    -- صفحة 1 (الاوتو)
    local toggleAutoBtn = Instance.new("TextButton", page1)
    toggleAutoBtn.Size = UDim2.new(1, 0, 0, 40)
    toggleAutoBtn.Position = UDim2.new(0, 0, 0, 0)
    toggleAutoBtn.Text = "إظهار/إخفاء الزر العائم"
    toggleAutoBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    toggleAutoBtn.TextColor3 = Color3.new(0,0,0)
    toggleAutoBtn.Font = Enum.Font.GothamSemibold
    toggleAutoBtn.TextSize = 14
    Instance.new("UICorner", toggleAutoBtn).CornerRadius = UDim.new(0, 6)

    toggleAutoBtn.MouseButton1Click:Connect(function()
        floatingToggle.Visible = not floatingToggle.Visible
        toggleAutoBtn.BackgroundColor3 = floatingToggle.Visible and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(230, 230, 230)
    end)

    local fSizeLabel = Instance.new("TextLabel", page1)
    fSizeLabel.Size = UDim2.new(0.5, 0, 0, 40)
    fSizeLabel.Position = UDim2.new(0, 0, 0, 50)
    fSizeLabel.Text = "حجم الزر العائم:"
    fSizeLabel.TextColor3 = Color3.new(0.2,0.2,0.2)
    fSizeLabel.Font = Enum.Font.GothamSemibold
    fSizeLabel.TextSize = 14
    fSizeLabel.BackgroundTransparency = 1
    fSizeLabel.TextXAlignment = Enum.TextXAlignment.Left

    local fMinus = Instance.new("TextButton", page1)
    fMinus.Size = UDim2.new(0, 40, 0, 35)
    fMinus.Position = UDim2.new(0.6, 0, 0, 52)
    fMinus.Text = "-"
    fMinus.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    fMinus.TextColor3 = Color3.new(0,0,0)
    fMinus.Font = Enum.Font.GothamBold
    Instance.new("UICorner", fMinus).CornerRadius = UDim.new(0, 6)

    local fPlus = Instance.new("TextButton", page1)
    fPlus.Size = UDim2.new(0, 40, 0, 35)
    fPlus.Position = UDim2.new(0.8, 10, 0, 52)
    fPlus.Text = "+"
    fPlus.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    fPlus.TextColor3 = Color3.new(0,0,0)
    fPlus.Font = Enum.Font.GothamBold
    Instance.new("UICorner", fPlus).CornerRadius = UDim.new(0, 6)

    fMinus.MouseButton1Click:Connect(function()
        if floatingScale > 0.5 then 
            floatingScale = floatingScale - 0.1 
            floatingToggle.Size = UDim2.new(0, 150 * floatingScale, 0, 45 * floatingScale)
            floatingToggle.TextSize = 15 * floatingScale
        end
    end)
    fPlus.MouseButton1Click:Connect(function()
        if floatingScale < 2.0 then 
            floatingScale = floatingScale + 0.1 
            floatingToggle.Size = UDim2.new(0, 150 * floatingScale, 0, 45 * floatingScale)
            floatingToggle.TextSize = 15 * floatingScale
        end
    end)

    local adhLabel = Instance.new("TextLabel", page1)
    adhLabel.Size = UDim2.new(1, 0, 0, 30)
    adhLabel.Position = UDim2.new(0, 0, 0, 100)
    adhLabel.Text = "قوة الالتصاق والمسافة"
    adhLabel.TextColor3 = Color3.new(0.2,0.2,0.2)
    adhLabel.Font = Enum.Font.GothamBold
    adhLabel.TextSize = 16
    adhLabel.BackgroundTransparency = 1
    adhLabel.TextXAlignment = Enum.TextXAlignment.Center

    local adhMinus = Instance.new("TextButton", page1)
    adhMinus.Size = UDim2.new(0, 45, 0, 45)
    adhMinus.Position = UDim2.new(0.2, -10, 0, 140)
    adhMinus.Text = "-"
    adhMinus.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    adhMinus.TextColor3 = Color3.new(0,0,0)
    adhMinus.Font = Enum.Font.GothamBold
    adhMinus.TextSize = 25
    Instance.new("UICorner", adhMinus).CornerRadius = UDim.new(0, 6)

    local adhValueTxt = Instance.new("TextLabel", page1)
    adhValueTxt.Size = UDim2.new(0, 80, 0, 45)
    adhValueTxt.Position = UDim2.new(0.5, -40, 0, 140)
    adhValueTxt.Text = tostring(adhesionStrength)
    adhValueTxt.TextColor3 = Color3.new(0,0,0)
    adhValueTxt.Font = Enum.Font.GothamBold
    adhValueTxt.TextSize = 22
    adhValueTxt.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    Instance.new("UICorner", adhValueTxt).CornerRadius = UDim.new(0, 6)

    local adhPlus = Instance.new("TextButton", page1)
    adhPlus.Size = UDim2.new(0, 45, 0, 45)
    adhPlus.Position = UDim2.new(0.8, -35, 0, 140)
    adhPlus.Text = "+"
    adhPlus.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    adhPlus.TextColor3 = Color3.new(0,0,0)
    adhPlus.Font = Enum.Font.GothamBold
    adhPlus.TextSize = 25
    Instance.new("UICorner", adhPlus).CornerRadius = UDim.new(0, 6)

    adhMinus.MouseButton1Click:Connect(function()
        if adhesionStrength > 1 then adhesionStrength = adhesionStrength - 0.5; adhValueTxt.Text = tostring(adhesionStrength) end
    end)
    adhPlus.MouseButton1Click:Connect(function()
        if adhesionStrength < 20 then adhesionStrength = adhesionStrength + 0.5; adhValueTxt.Text = tostring(adhesionStrength) end
    end)

    local function toggleScript()
        active = not active
        floatingToggle.Text = active and "SAADHUB: ON" or "SAADHUB: OFF"
        floatingToggle.BackgroundColor3 = active and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(200, 200, 200)
        if not active then lockedTarget = nil end
    end
    floatingToggle.MouseButton1Click:Connect(toggleScript)
    userInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 then toggleScript() end
    end)

    -- صفحة 2 (Desync & اتصال)
    -- زر تفعيل الديسينك
    local desyncBtn = Instance.new("TextButton", page2)
    desyncBtn.Size = UDim2.new(1, 0, 0, 45)
    desyncBtn.Position = UDim2.new(0, 0, 0, 0)
    desyncBtn.Text = "تفعيل الديسينك (Lag Switch)"
    desyncBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    desyncBtn.TextColor3 = Color3.new(0,0,0)
    desyncBtn.Font = Enum.Font.GothamSemibold
    desyncBtn.TextSize = 15
    Instance.new("UICorner", desyncBtn).CornerRadius = UDim.new(0, 6)

    desyncBtn.MouseButton1Click:Connect(function()
        desyncActive = not desyncActive
        if desyncActive then
            desyncBtn.Text = "Desync: ON"
            desyncBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
            -- يبدأ التبديل في الـ RenderStepped
        else
            desyncBtn.Text = "تفعيل الديسينك (Lag Switch)"
            desyncBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
            pcall(function() settings().Network.IncomingReplicationLag = 0 end)
        end
    end)

    -- صندوق إدخال قيمة البانق المخصصة
    local customPingInput = Instance.new("TextBox", page2)
    customPingInput.Size = UDim2.new(0.6, -5, 0, 40)
    customPingInput.Position = UDim2.new(0, 0, 0, 60)
    customPingInput.PlaceholderText = "قيمة البانق (بالثواني مثل 0.2)"
    customPingInput.Text = "0.2"
    customPingInput.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    customPingInput.TextColor3 = Color3.new(0,0,0)
    customPingInput.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", customPingInput).CornerRadius = UDim.new(0, 6)

    -- زر تعيين القيمة
    local setPingBtn = Instance.new("TextButton", page2)
    setPingBtn.Size = UDim2.new(0.35, -5, 0, 40)
    setPingBtn.Position = UDim2.new(0.65, 5, 0, 60)
    setPingBtn.Text = "تعيين"
    setPingBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    setPingBtn.TextColor3 = Color3.new(0,0,0)
    setPingBtn.Font = Enum.Font.GothamSemibold
    setPingBtn.TextSize = 14
    Instance.new("UICorner", setPingBtn).CornerRadius = UDim.new(0, 6)
    setPingBtn.MouseButton1Click:Connect(function()
        local val = tonumber(customPingInput.Text)
        if val and val >= 0 then
            desyncLagValue = val
        end
    end)

    -- زران للبانق السريع (خفيف / عالي)
    local lightLagBtn = Instance.new("TextButton", page2)
    lightLagBtn.Size = UDim2.new(0.48, 0, 0, 45)
    lightLagBtn.Position = UDim2.new(0, 0, 0, 115)
    lightLagBtn.Text = "بانق خفيف (0.15)"
    lightLagBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    lightLagBtn.TextColor3 = Color3.new(0,0,0)
    lightLagBtn.Font = Enum.Font.GothamSemibold
    lightLagBtn.TextSize = 14
    Instance.new("UICorner", lightLagBtn).CornerRadius = UDim.new(0, 6)
    lightLagBtn.MouseButton1Click:Connect(function()
        desyncLagValue = 0.15
        customPingInput.Text = "0.15"
    end)

    local heavyLagBtn = Instance.new("TextButton", page2)
    heavyLagBtn.Size = UDim2.new(0.48, 0, 0, 45)
    heavyLagBtn.Position = UDim2.new(0.52, 0, 0, 115)
    heavyLagBtn.Text = "بانق عالي (0.5)"
    heavyLagBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    heavyLagBtn.TextColor3 = Color3.new(0,0,0)
    heavyLagBtn.Font = Enum.Font.GothamSemibold
    heavyLagBtn.TextSize = 14
    Instance.new("UICorner", heavyLagBtn).CornerRadius = UDim.new(0, 6)
    heavyLagBtn.MouseButton1Click:Connect(function()
        desyncLagValue = 0.5
        customPingInput.Text = "0.5"
    end)

    -- زر الجودة (كما هو)
    local qualityBtn = Instance.new("TextButton", page2)
    qualityBtn.Size = UDim2.new(1, 0, 0, 45)
    qualityBtn.Position = UDim2.new(0, 0, 0, 175)
    qualityBtn.Text = "تفعيل الجودة (إزالة الانفجارات)"
    qualityBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    qualityBtn.TextColor3 = Color3.new(1,1,1)
    qualityBtn.Font = Enum.Font.GothamSemibold
    qualityBtn.TextSize = 14
    Instance.new("UICorner", qualityBtn).CornerRadius = UDim.new(0, 6)

    qualityBtn.MouseButton1Click:Connect(function()
        local function clean(v)
            if v:IsA("Explosion") then
                v.Visible = false; v.BlastRadius = 0; v.BlastPressure = 0
                task.wait(); v:Destroy()
            end
            if v:IsDescendantOf(game.Players) or (v.Parent and v.Parent:FindFirstChild("Humanoid")) then return end
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.CastShadow = false
                if v.Color.r < 0.2 and v.Color.g < 0.2 and v.Color.b < 0.2 then v.Color = Color3.fromRGB(255, 255, 255) end
            elseif v:IsA("Decal") or v:IsA("Texture") then
                if v.Name ~= "face" then v:Destroy() end
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") then v:Destroy() end
        end
        for _, v in pairs(game.Workspace:GetDescendants()) do pcall(clean, v) end
        game.Workspace.DescendantAdded:Connect(function(v) pcall(clean, v) end)
        qualityBtn.Text = "تم تفعيل الجودة ✅"; qualityBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 0)
    end)
end

-- بدء الواجهة الجديدة
createIntroScreen()

-- [[ 3. نظام الأيمبوت والالتصاق + Desync ]] --
local function isEnemy(v)
    if not v or v == player or not v.Character then return false end
    local hl = v.Character:FindFirstChildOfClass("Highlight")
    if hl and (hl.FillColor.G > hl.FillColor.R) then return false end
    if player.Team ~= nil and v.Team ~= nil and player.Team == v.Team then return false end
    return true 
end

local function fastTouch(targetChar, tool)
    local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("Part")
    if handle and targetChar:FindFirstChild("HumanoidRootPart") then
        local dist = (player.Character.HumanoidRootPart.Position - targetChar.HumanoidRootPart.Position).Magnitude
        if dist < (adhesionStrength + 2.5) then
            task.spawn(function()
                for i = 1, 15 do
                    firetouchinterest(targetChar.HumanoidRootPart, handle, 0)
                    firetouchinterest(targetChar.HumanoidRootPart, handle, 1)
                end
            end)
        end
    end
end

-- عداد للديسينك (يبدل كل عدة فريمات)
local desyncCounter = 0
runService.RenderStepped:Connect(function()
    -- نظام الديسينك (يبدل بين بانق عالي و 0)
    if desyncActive then
        desyncCounter = (desyncCounter + 1) % 10
        if desyncCounter < 5 then
            pcall(function() settings().Network.IncomingReplicationLag = desyncLagValue end)
        else
            pcall(function() settings().Network.IncomingReplicationLag = 0 end)
        end
    end

    if active and player.Character and player.Character:FindFirstChild("Humanoid") then
        local bpTool = player.Backpack:FindFirstChildOfClass("Tool")
        if bpTool then player.Character.Humanoid:EquipTool(bpTool) end

        local tool = player.Character:FindFirstChildOfClass("Tool")
        if tool then
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
                local targetRoot = lockedTarget.HumanoidRootPart
                local myRoot = player.Character.HumanoidRootPart
                local dist = (targetRoot.Position - myRoot.Position).Magnitude
                
                local dynamicOffset = adhesionStrength + (math.random(-5, 5) / 10) 
                
                if dist > dynamicOffset and not desyncActive then
                    player.Character.Humanoid:Move((targetRoot.Position - myRoot.Position).Unit, false) 
                end

                fastTouch(lockedTarget, tool)
            end
        else lockedTarget = nil end
    end
end)