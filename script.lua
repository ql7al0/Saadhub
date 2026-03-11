-- [[ SAADHUB EDITION - TBT2 - TEAM CHECK & DRAGGABLE ]] --

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

-- وظيفة جعل الزر قابلاً للسحب
local function makeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = obj.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    userInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- 1. واجهة SAADHUB (المقدمة)
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "SaadHub_Final_TeamCheck"
mainGui.ResetOnSpawn = false 
mainGui.IgnoreGuiInset = true
mainGui.Parent = player:WaitForChild("PlayerGui")

local function startIntro()
    local frame = Instance.new("Frame", mainGui)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.ZIndex = 1000
    task.wait(1)
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "SAADHUB"
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.TextSize = 100
    label.Font = Enum.Font.SourceSansBold
    label.ZIndex = 1001
    task.wait(2)
    frame:Destroy()
end
task.spawn(startIntro)

-- 2. الزر القابل للسحب (ON/OFF)
local active = true
local toggle = Instance.new("TextButton", mainGui)
toggle.Size = UDim2.new(0, 100, 0, 45)
toggle.Position = UDim2.new(0.05, 0, 0.4, 0)
toggle.Text = "ON"
toggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 20
Instance.new("UICorner", toggle)

makeDraggable(toggle)

toggle.MouseButton1Click:Connect(function()
    active = not active
    toggle.Text = active and "ON" or "OFF"
    toggle.BackgroundColor3 = active and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 40)
end)

-- 3. وظيفة البحث عن أقرب "خصم" (تجاهل الفريق)
local function getClosestEnemy()
    local closestDist = math.huge
    local closestChar = nil
    for _, v in pairs(game.Players:GetPlayers()) do
        -- الشرط الجديد: ليس أنا + لديه شخصية + ليس من فريقي + حي
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
            -- فحص الفريق (إذا اللعبة فيها نظام فرق)
            if v.Team ~= player.Team or v.Team == nil then 
                local dist = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestChar = v.Character
                end
            end
        end
    end
    return closestChar
end

-- 4. محرك الحركة الأصلي
runService.Heartbeat:Connect(function()
    if active and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local root = player.Character.HumanoidRootPart
        local hum = player.Character.Humanoid
        local bomb = player.Character:FindFirstChildOfClass("Tool")
        
        if bomb then
            local targetChar = getClosestEnemy()
            if targetChar then
                local targetRoot = targetChar.HumanoidRootPart
                hum.AutoRotate = true 
                local direction = (targetRoot.Position - root.Position)
                
                if direction.Magnitude > 1.5 then
                    root.Velocity = Vector3.new(direction.Unit.X * 30, root.Velocity.Y, direction.Unit.Z * 30)
                else
                    root.Velocity = Vector3.new(0, root.Velocity.Y, 0)
                end
            end
        end
    end
end)
