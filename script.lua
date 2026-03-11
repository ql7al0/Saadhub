-- [[ SAADHUB ULTIMATE HUB - V5 WITH HIDE FEATURE ]] --

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "SaadHub_Final_v5"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true 
screenGui.DisplayOrder = 999999

local blackBg = Instance.new("Frame", screenGui)
blackBg.Size = UDim2.new(1, 0, 1, 0)
blackBg.BackgroundColor3 = Color3.new(0, 0, 0)
blackBg.ZIndex = 100000 

-- 1. المقدمة (SAADHUB)
local intro = Instance.new("TextLabel", blackBg)
intro.Size = UDim2.new(1, 0, 1, 0)
intro.Text = "SAADHUB"
intro.TextColor3 = Color3.fromRGB(255, 0, 0)
intro.TextSize = 100; intro.Font = "SourceSansBold"
intro.BackgroundTransparency = 1; intro.ZIndex = 100001
task.wait(1.5)
intro:Destroy()

-- 2. شاشة الاختيار
local uiTitle = Instance.new("TextLabel", blackBg)
uiTitle.Size = UDim2.new(1, 0, 0.3, 0); uiTitle.Position = UDim2.new(0, 0, 0.1, 0)
uiTitle.Text = "Choose Your Version"; uiTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
uiTitle.TextSize = 60; uiTitle.Font = "SourceSansBold"; uiTitle.BackgroundTransparency = 1; uiTitle.ZIndex = 100001

local btnAuto = Instance.new("TextButton", blackBg)
btnAuto.Size = UDim2.new(0, 300, 0, 100); btnAuto.Position = UDim2.new(0.5, -320, 0.5, 0)
btnAuto.Text = "النسخة المتطورة\n(V2 Advanced)"; btnAuto.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
btnAuto.TextColor3 = Color3.new(1, 1, 1); btnAuto.TextSize = 25; btnAuto.ZIndex = 100005
Instance.new("UICorner", btnAuto)

local btnNearest = Instance.new("TextButton", blackBg)
btnNearest.Size = UDim2.new(0, 300, 0, 100); btnNearest.Position = UDim2.new(0.5, 20, 0.5, 0)
btnNearest.Text = "سكربت اوتو"; btnNearest.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
btnNearest.TextColor3 = Color3.new(1, 1, 1); btnNearest.TextSize = 25; btnNearest.ZIndex = 100005
Instance.new("UICorner", btnNearest)

-- وظيفة زر النسخة المتطورة (tik:ql.z45)
btnAuto.MouseButton1Click:Connect(function()
    uiTitle:Destroy(); btnAuto:Destroy(); btnNearest:Destroy()
    local tikLabel = Instance.new("TextLabel", blackBg)
    tikLabel.Size = UDim2.new(1, 0, 1, 0); tikLabel.Text = "tik:ql.z45"
    tikLabel.TextColor3 = Color3.fromRGB(255, 0, 0); tikLabel.TextSize = 100
    tikLabel.Font = "SourceSansBold"; tikLabel.BackgroundTransparency = 1; tikLabel.ZIndex = 100010

    spawn(function()
        local s = tick()
        while tick() - s < 4 do
            for _, v in pairs(player.PlayerGui:GetDescendants()) do
                if v:IsA("TextLabel") and v.Text:lower():find("saadhub") and v.Parent ~= blackBg then v:Destroy() end
            end
            task.wait(0.1)
        end
    end)

    loadstring(game:HttpGet("https://raw.githubusercontent.com/ql7al0/Saadhub/main/script.lua"))()
    task.wait(2)
    blackBg:Destroy(); screenGui:Destroy()
end)

-- وظيفة زر "سكربت اوتو" (يعطي لأقرب لاعب مع خاصية الإخفاء)
btnNearest.MouseButton1Click:Connect(function()
    blackBg:Destroy()
    
    local runService = game:GetService("RunService")
    local introF = Instance.new("Frame", screenGui)
    introF.Size = UDim2.new(1, 0, 1, 0); introF.BackgroundColor3 = Color3.new(0, 0, 0); introF.ZIndex = 200000
    
    local gBG = Instance.new("ImageLabel", introF)
    gBG.Size = UDim2.new(1,0,1,0); gBG.Image = "rbxassetid://18835824901"; gBG.ZIndex = 200001; gBG.BackgroundTransparency = 1
    
    local sTitle = Instance.new("TextLabel", introF)
    sTitle.Size = UDim2.new(1,0,0,100); sTitle.Position = UDim2.new(0,0,0.1,0); sTitle.Text = "saadhub"; sTitle.TextColor3 = Color3.fromRGB(255,0,0); sTitle.TextSize = 80; sTitle.ZIndex = 200002; sTitle.BackgroundTransparency = 1

    local lFrame = Instance.new("Frame", introF)
    lFrame.Size = UDim2.new(0,400,0,100); lFrame.Position = UDim2.new(0.5,-200,0.6,0); lFrame.BackgroundTransparency = 1; lFrame.ZIndex = 200003

    local bAR = Instance.new("TextButton", lFrame); bAR.Size = UDim2.new(0,180,0,60); bAR.Text = "العربية"; bAR.BackgroundColor3 = Color3.fromRGB(255,0,0); bAR.TextColor3 = Color3.new(1,1,1); bAR.ZIndex = 200004; Instance.new("UICorner", bAR)
    local bEN = Instance.new("TextButton", lFrame); bEN.Size = UDim2.new(0,180,0,60); bEN.Position = UDim2.new(0,220,0,0); bEN.Text = "English"; bEN.BackgroundColor3 = Color3.fromRGB(50,50,50); bEN.TextColor3 = Color3.new(1,1,1); bEN.ZIndex = 200004; Instance.new("UICorner", bEN)

    -- القائمة الرئيسية (Main Menu)
    local mF = Instance.new("Frame", screenGui); mF.Size = UDim2.new(0,240,0,240); mF.Position = UDim2.new(0.1,0,0.4,0); mF.BackgroundColor3 = Color3.fromRGB(20,20,20); mF.Visible = false; mF.Active = true; mF.Draggable = true; Instance.new("UICorner", mF)
    local tL = Instance.new("TextLabel", mF); tL.Size = UDim2.new(1,0,0,40); tL.TextColor3 = Color3.fromRGB(255,0,0); tL.TextSize = 20; tL.BackgroundTransparency = 1
    
    local btnT = Instance.new("TextButton", mF); btnT.Size = UDim2.new(0,210,0,50); btnT.Position = UDim2.new(0.5,-105,0,60); btnT.BackgroundColor3 = Color3.fromRGB(45, 45, 45); btnT.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", btnT)
    local btnC = Instance.new("TextButton", mF); btnC.Size = UDim2.new(0,210,0,50); btnC.Position = UDim2.new(0.5,-105,0,120); btnC.BackgroundColor3 = Color3.fromRGB(45, 45, 45); btnC.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", btnC)
    
    -- زر الإخفاء (Hide)
    local btnH = Instance.new("TextButton", mF); btnH.Size = UDim2.new(0,210,0,50); btnH.Position = UDim2.new(0.5,-105,0,180); btnH.BackgroundColor3 = Color3.fromRGB(255, 0, 0); btnH.TextColor3 = Color3.new(1,1,1); btnH.Text = "Hide / إخفاء"; Instance.new("UICorner", btnH)
    
    -- زر الإظهار (Open Button)
    local openBtn = Instance.new("TextButton", screenGui); openBtn.Size = UDim2.new(0, 80, 0, 30); openBtn.Position = UDim2.new(0, 10, 0.5, 0); openBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0); openBtn.TextColor3 = Color3.new(1,1,1); openBtn.Text = "Open"; openBtn.Visible = false; Instance.new("UICorner", openBtn)

    btnH.MouseButton1Click:Connect(function() mF.Visible = false; openBtn.Visible = true end)
    openBtn.MouseButton1Click:Connect(function() mF.Visible = true; openBtn.Visible = false end)

    local lang = "EN"; local act, gAt, ang = false, 2, 0
    local function setup(l) 
        lang = l; introF:Destroy(); mF.Visible = true
        tL.Text = (l=="AR") and "قائمة سعد هب" or "SAADHUB MENU"
        btnT.Text = (l=="AR") and "يعطي اقرب لاعب: قفل" or "AUTO GIVE: OFF"
        btnC.Text = (l=="AR") and "وقت الانفجار: 2ث" or "Explosion: 2s"
    end
    bAR.MouseButton1Click:Connect(function() setup("AR") end)
    bEN.MouseButton1Click:Connect(function() setup("EN") end)

    btnC.MouseButton1Click:Connect(function() gAt = (gAt % 5) + 1; btnC.Text = (lang=="AR") and "وقت الانفجار: "..gAt.."ث" or "Explosion: "..gAt.."s" end)
    btnT.MouseButton1Click:Connect(function() act = not act; btnT.Text = (lang=="AR") and (act and "يعطي اقرب لاعب: تشغيل" or "يعطي اقرب لاعب: قفل") or (act and "AUTO GIVE: ON" or "AUTO GIVE: OFF"); btnT.BackgroundColor3 = act and Color3.fromRGB(0,170,0) or Color3.fromRGB(45,45,45) end)

    runService.Heartbeat:Connect(function()
        if not act or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
        local r = player.Character.HumanoidRootPart; local t = player.Character:FindFirstChildOfClass("Tool")
        if t then
            local tm = t:FindFirstChild("Timer") or t:FindFirstChild("Tick") or t:FindFirstChild("Time")
            if tm and tm.Value <= gAt then
                local tar = nil; local dist = math.huge
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local d = (r.Position - v.Character.HumanoidRootPart.Position).Magnitude
                        if d < dist then dist = d; tar = v.Character.HumanoidRootPart end
                    end
                end
                if tar then ang = ang + 0.5; r.CFrame = CFrame.new(tar.Position + Vector3.new(math.cos(ang)*2.5, 0, math.sin(ang)*2.5), tar.Position) end
            end
        end
    end)
end)
