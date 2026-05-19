local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local isSpeedEnabled = false
local speedMultiplier = 1.3 -- نسبة الزيادة الخفيفة (1.3)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- تجاهل الزر إذا كنت تكتب في الشات عشان ما يشتغل بالغلط
    if gameProcessed then return end 

    -- التأكد من الضغط على حرف E
    if input.KeyCode == Enum.KeyCode.E then
        isSpeedEnabled = not isSpeedEnabled
        local character = player.Character
        
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                if isSpeedEnabled then
                    -- تفعيل السرعة الجديدة
                    humanoid.WalkSpeed = humanoid.WalkSpeed * speedMultiplier
                else
                    -- الرجوع للسرعة الطبيعية
                    humanoid.WalkSpeed = humanoid.WalkSpeed / speedMultiplier
                end
            end
        end
    end
end)
