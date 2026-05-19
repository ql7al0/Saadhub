local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ==========================================
-- إضافة واجهة الزر بالشاشة
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

-- حماية الواجهة من المسح (تعمل على برامج التشغيل)
local guiParent = game:GetService("CoreGui") or player:WaitForChild("PlayerGui")
ScreenGui.Parent = guiParent
ScreenGui.Name = "SpeedToggleGui"

-- إعدادات وتصميم الزر
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- أحمر (معطل)
ToggleButton.Position = UDim2.new(0.5, -75, 0.05, 0) -- موقعه أعلى الشاشة في المنتصف
ToggleButton.Size = UDim2.new(0, 150, 0, 45)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "السرعة: متوقفة"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 20
-- ==========================================


local isSpeedEnabled = false
local speedMultiplier = 1.05 -- نسبة الزيادة الخفيفة جداً (1.05)

-- دالة التفعيل والإيقاف (نفس كودك بالضبط بس مجمع عشان يشتغل مع الزر وحرف E)
local function ToggleSpeedLogic()
    isSpeedEnabled = not isSpeedEnabled
    local character = player.Character
    
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            if isSpeedEnabled then
                -- تفعيل السرعة الجديدة
                humanoid.WalkSpeed = humanoid.WalkSpeed * speedMultiplier
                -- تحديث شكل الزر
                ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 255, 50) -- أخضر (مفعل)
                ToggleButton.Text = "السرعة: مفعلة"
            else
                -- الرجوع للسرعة الطبيعية
                humanoid.WalkSpeed = humanoid.WalkSpeed / speedMultiplier
                -- تحديث شكل الزر
                ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- أحمر (معطل)
                ToggleButton.Text = "السرعة: متوقفة"
            end
        end
    end
end

-- ربط ضغطة الماوس على الزر بالدالة
ToggleButton.MouseButton1Click:Connect(ToggleSpeedLogic)

-- سكربتك الأصلي لربط حرف E
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- تجاهل الزر إذا كنت تكتب في الشات عشان ما يشتغل بالغلط
    if gameProcessed then return end 

    -- التأكد من الضغط على حرف E
    if input.KeyCode == Enum.KeyCode.E then
        ToggleSpeedLogic()
    end
end)
