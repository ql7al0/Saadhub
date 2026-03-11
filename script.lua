-- [[ SAADHUB EDITION - TBT2 MOD ]] --

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

-- 1. واجهة SAADHUB (المقدمة اللي طلبتها بالضبط)
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "SaadHub_TBT2_Official"
mainGui.ResetOnSpawn = false 
mainGui.IgnoreGuiInset = true
mainGui.Parent = player:WaitForChild("PlayerGui")

local function startIntro()
    local frame = Instance.new("Frame", mainGui)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0) -- شاشة سوداء بالكامل
    frame.ZIndex = 1000
    
    task.wait(1.5) -- انتظار وهي سوداء
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "SAADHUB"
    label.TextColor3 = Color3.fromRGB(255, 0, 0) -- خط أحمر فاقع
    label.TextSize = 100
    label.Font = Enum.Font.SourceSansBold
    label.ZIndex = 1001
    
    task.wait(2.5) -- عرض الكلمة
    frame:Destroy()
end
task.spawn(startIntro)

-- 2. محرك TBT2 الأساسي (اللحاق والالتصاق)
local active = true -- يشتغل تلقائي بعد المقدمة
local target = nil

-- زر تحكم صغير (اختياري)
local toggle = Instance.new("TextButton", mainGui)
toggle.Size = UDim2.new(0, 120, 0, 40)
toggle.Position = UDim2.new(0.05, 0, 0.4, 0)
toggle.Text = "SAADHUB: ON"
toggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", toggle)

toggle.MouseButton1Click:Connect(function()
    active = not active
    toggle.Text = active and "SAADHUB: ON" or "SAADHUB: OFF"
    toggle.BackgroundColor3 = active and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 40)
end)

-- وظيفة البحث عن الهدف (Targeting)
local function getClosestPlayer()
    local closestDist = math.huge
    local closestChar = nil
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
            local dist = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closestChar = v.Character
            end
        end
    end
    return closestChar
end

-- محرك الحركة (Physics Logic)
runService.Heartbeat:Connect(function()
    if active and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local root = player.Character.HumanoidRootPart
        local hum = player.Character.Humanoid
        
        -- ميزة TBT2: لا يشتغل إلا إذا معك القنبلة
        local bomb = player.Character:FindFirstChildOfClass("Tool")
        
        if bomb then
            local targetChar = getClosestPlayer()
            if targetChar then
                local targetRoot = targetChar.HumanoidRootPart
                
                -- إيقاف دوران الشخصية القسري (عشان تتحكم بالدوران براحتك)
                hum.AutoRotate = true 
                
                -- قوة الالتصاق (Magnet)
                local direction = (targetRoot.Position - root.Position)
                if direction.Magnitude > 1.5 then
                    -- سحب فيزيائي للالتصاق
                    root.Velocity = Vector3.new(direction.Unit.X * 30, root.Velocity.Y, direction.Unit.Z * 30)
                else
                    -- لزقة تامة
                    root.Velocity = Vector3.new(0, root.Velocity.Y, 0)
                end
            end
        else
            -- إذا راحت القنبلة يوقف تماماً
        end
    end
end)

