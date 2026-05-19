local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- إنشاء الواجهة (GUI)
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

-- حماية الواجهة لتجنب الرصد السهل
ScreenGui.Parent = game.CoreGui 
ScreenGui.Name = "AutoKillUI"

-- تصميم الزر
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 150, 0, 50)
ToggleButton.Position = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "تشغيل القتل"
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 20

local isToggled = false

-- وظيفة استهداف الفريق الخصم
local function targetOpponents()
    for _, player in ipairs(Players:GetPlayers()) do
        -- التحقق من أن اللاعب ليس أنت، وأنه في فريق مختلف
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                -- محاولة تصفير الصحة أو تدمير الهيومانويد
                player.Character.Humanoid.Health = 0
            end
        end
    end
end

-- برمجة زر التشغيل والإيقاف
ToggleButton.MouseButton1Click:Connect(function()
    isToggled = not isToggled
    if isToggled then
        ToggleButton.Text = "إيقاف القتل"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        ToggleButton.Text = "تشغيل القتل"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- تكرار العملية باستمرار إذا كان الزر مفعل
RunService.RenderStepped:Connect(function()
    if isToggled then
        targetOpponents()
    end
end)
