local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local normalSpeed = 16
local targetSpeed = 20
local active = true -- حالة السكربت (مفعل تلقائياً عند التشغيل)

-- [[ 1. واجهة التحكم (الزر مأخوذ من السكربت الثاني بالكامل) ]] --
local mainGui = Instance.new("ScreenGui", player.PlayerGui)
mainGui.ResetOnSpawn = false

local toggle = Instance.new("TextButton", mainGui)
toggle.Size = UDim2.new(0, 140, 0, 45)
toggle.Position = UDim2.new(0.05, 0, 0.4, 0)
toggle.Text = "SAADHUB: ON"
toggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 16
Instance.new("UICorner", toggle)
Instance.new("UIStroke", toggle).Color = Color3.new(1, 1, 1)

-- نظام تحريك الزر بسحبه بالشاشة
local dragCircle = Instance.new("Frame", toggle)
dragCircle.Size = UDim2.new(0, 25, 0, 25)
dragCircle.Position = UDim2.new(0.5, -12.5, 0, -32)
dragCircle.BackgroundTransparency = 1
Instance.new("UICorner", dragCircle).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", dragCircle).Transparency = 1

local dragging, dragStart, startPos
dragCircle.InputBegan:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
        dragging = true; dragStart = input.Position; startPos = toggle.Position 
    end 
end)
UserInputService.InputChanged:Connect(function(input) 
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then 
        local delta = input.Position - dragStart; 
        toggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) 
    end 
end)
UserInputService.InputEnded:Connect(function() dragging = false end)

-- وظيفة تشغيل وإطفاء الزر
local function toggleScript()
    active = not active
    toggle.Text = active and "SAADHUB: ON" or "SAADHUB: OFF"
    toggle.BackgroundColor3 = active and Color3.fromRGB(170, 0, 0) or Color3.fromRGB(40, 40, 40)
end

-- تفعيل الزر عند الضغط عليه
toggle.MouseButton1Click:Connect(toggleScript)


-- [[ 2. منطق السكربت الأول (الأوتوماتيك بدون أي تعديل) ]] --

-- دالة لقراءة وقت القنبلة من اللعبة
local function getBombTime()
    -- بما أنك تستخدم Delta، يمكنك الوصول لواجهة المستخدم (PlayerGui) أو مساحة العمل (Workspace)
    -- هذا المسار افتراضي ويجب تعديله حسب اللعبة التي تلعبها
    
    -- مثال إذا كان العداد في واجهة الشاشة:
    -- pcall(function()
    --     local timerText = player.PlayerGui.BombUI.Timer.Text
    --     return tonumber(timerText)
    -- end)
    
    return -1 -- استبدل هذا الكود بالمسار الصحيح للعداد
end

-- التشغيل في كل إطار (Frame) لضمان الاستقرار
RunService.Heartbeat:Connect(function()
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    -- التحقق من أن الشخصية موجودة وحية
    if humanoid and humanoid.Health > 0 then
        
        -- التحقق أولاً إذا كان الزر شغال (ON)
        if active then
            local bombTime = getBombTime()
            
            -- إذا وصل وقت القنبلة إلى 2
            if bombTime == 2 then
                if humanoid.WalkSpeed ~= targetSpeed then
                    humanoid.WalkSpeed = targetSpeed
                end
            else
                -- إذا كان الوقت مختلفاً، ترجع السرعة إلى 16
                if humanoid.WalkSpeed ~= normalSpeed then
                    humanoid.WalkSpeed = normalSpeed
                end
            end
        else
            -- إذا كان الزر مطفأ (OFF)، ترجع السرعة تلقائياً لوضعها الطبيعي 16
            if humanoid.WalkSpeed ~= normalSpeed then
                humanoid.WalkSpeed = normalSpeed
            end
        end
        
    end
end)