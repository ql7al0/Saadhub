--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

if getgenv().SaadHub_AlreadyExecuted then
	local FlatIdent_378D0 = 0;
	while true do
		if (FlatIdent_378D0 == 0) then
			game:GetService("StarterGui"):SetCore("SendNotification", {Title="تنبيه ⚠️",Text="تم تشغيل السكربت من قبل!",Duration=5});
			return;
		end
	end
end
getgenv().SaadHub_AlreadyExecuted = true;
local player = game.Players.LocalPlayer;
local httpService = game:GetService("HttpService");
local tweenService = game:GetService("TweenService");
local runService = game:GetService("RunService");
local userInputService = game:GetService("UserInputService");
local starterGui = game:GetService("StarterGui");
local lighting = game:GetService("Lighting");
local workspace = game:GetService("Workspace");
local lockedTarget = nil;
local active = true;
local mainBlur = Instance.new("BlurEffect", lighting);
mainBlur.Size = 0;
local mainGui = Instance.new("ScreenGui", player.PlayerGui);
mainGui.ResetOnSpawn = false;
mainGui.IgnoreGuiInset = true;
local openIcon = Instance.new("TextButton", mainGui);
openIcon.Size = UDim2.new(0, 45, 0, 45);
openIcon.Position = UDim2.new(0.02, 0, 0.5, 0);
openIcon.Text = "⚡";
openIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
openIcon.TextColor3 = Color3.new(1, 1, 1);
openIcon.TextSize = 20;
openIcon.Visible = false;
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(0, 8);
local openStroke = Instance.new("UIStroke", openIcon);
openStroke.Color = Color3.fromRGB(170, 0, 0);
openStroke.Thickness = 1.5;
local openDragging, openDragStart, openStartPos;
openIcon.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		local FlatIdent_2953F = 0;
		while true do
			if (FlatIdent_2953F == 0) then
				openDragging = true;
				openDragStart = input.Position;
				FlatIdent_2953F = 1;
			end
			if (FlatIdent_2953F == 1) then
				openStartPos = openIcon.Position;
				break;
			end
		end
	end
end);
userInputService.InputChanged:Connect(function(input)
	if (openDragging and ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch))) then
		local FlatIdent_47A9C = 0;
		local delta;
		while true do
			if (FlatIdent_47A9C == 0) then
				delta = input.Position - openDragStart;
				openIcon.Position = UDim2.new(openStartPos.X.Scale, openStartPos.X.Offset + delta.X, openStartPos.Y.Scale, openStartPos.Y.Offset + delta.Y);
				break;
			end
		end
	end
end);
userInputService.InputEnded:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		openDragging = false;
	end
end);
local mainFrame = Instance.new("Frame", mainGui);
mainFrame.Size = UDim2.new(0, 450, 0, 280);
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -140);
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15);
mainFrame.Visible = false;
mainFrame.ClipsDescendants = true;
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10);
local mainStroke = Instance.new("UIStroke", mainFrame);
mainStroke.Color = Color3.fromRGB(170, 0, 0);
mainStroke.Thickness = 2;
local topBar = Instance.new("Frame", mainFrame);
topBar.Size = UDim2.new(1, 0, 0, 35);
topBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10);
local topBarFix = Instance.new("Frame", topBar);
topBarFix.Size = UDim2.new(1, 0, 0.5, 0);
topBarFix.Position = UDim2.new(0, 0, 0.5, 0);
topBarFix.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
topBarFix.BorderSizePixel = 0;
local title = Instance.new("TextLabel", topBar);
title.Size = UDim2.new(0.5, 0, 1, 0);
title.Position = UDim2.new(0.03, 0, 0, 0);
title.BackgroundTransparency = 1;
title.Text = "SAADHUB V2";
title.TextColor3 = Color3.new(1, 1, 1);
title.Font = Enum.Font.GothamBold;
title.TextSize = 14;
title.TextXAlignment = Enum.TextXAlignment.Left;
local statsLabel = Instance.new("TextLabel", topBar);
statsLabel.Size = UDim2.new(0, 120, 1, 0);
statsLabel.Position = UDim2.new(1, -165, 0, 0);
statsLabel.BackgroundTransparency = 1;
statsLabel.TextColor3 = Color3.fromRGB(170, 0, 0);
statsLabel.Font = Enum.Font.GothamBold;
statsLabel.TextSize = 11;
statsLabel.TextXAlignment = Enum.TextXAlignment.Right;
statsLabel.Text = "FPS: -- | PING: --";
local statsLastTime = tick();
local statsFrameCount = 0;
runService.RenderStepped:Connect(function()
	local FlatIdent_77478 = 0;
	local currentTime;
	while true do
		if (FlatIdent_77478 == 0) then
			statsFrameCount = statsFrameCount + 1;
			currentTime = tick();
			FlatIdent_77478 = 1;
		end
		if (1 == FlatIdent_77478) then
			if ((currentTime - statsLastTime) >= 1) then
				local FlatIdent_63487 = 0;
				local fps;
				local ping;
				while true do
					if (FlatIdent_63487 == 1) then
						pcall(function()
							local FlatIdent_31A5A = 0;
							local pingVal;
							while true do
								if (FlatIdent_31A5A == 0) then
									pingVal = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString();
									ping = string.split(pingVal, " ")[1];
									break;
								end
							end
						end);
						statsLabel.Text = "FPS: " .. fps .. " | PING: " .. ping;
						FlatIdent_63487 = 2;
					end
					if (FlatIdent_63487 == 0) then
						fps = statsFrameCount;
						ping = "0";
						FlatIdent_63487 = 1;
					end
					if (FlatIdent_63487 == 2) then
						statsFrameCount = 0;
						statsLastTime = currentTime;
						break;
					end
				end
			end
			break;
		end
	end
end);
local minimizeBtn = Instance.new("TextButton", topBar);
minimizeBtn.Size = UDim2.new(0, 35, 1, 0);
minimizeBtn.Position = UDim2.new(1, -35, 0, 0);
minimizeBtn.BackgroundTransparency = 1;
minimizeBtn.Text = "-";
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200);
minimizeBtn.Font = Enum.Font.GothamBold;
minimizeBtn.TextSize = 22;
local dragging, dragStart, startPos;
topBar.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		local FlatIdent_5ED46 = 0;
		while true do
			if (FlatIdent_5ED46 == 1) then
				startPos = mainFrame.Position;
				break;
			end
			if (FlatIdent_5ED46 == 0) then
				dragging = true;
				dragStart = input.Position;
				FlatIdent_5ED46 = 1;
			end
		end
	end
end);
userInputService.InputChanged:Connect(function(input)
	if (dragging and ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch))) then
		local FlatIdent_51F42 = 0;
		local delta;
		while true do
			if (FlatIdent_51F42 == 0) then
				delta = input.Position - dragStart;
				mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
				break;
			end
		end
	end
end);
userInputService.InputEnded:Connect(function()
	dragging = false;
end);
local tabsContainer = Instance.new("Frame", mainFrame);
tabsContainer.Size = UDim2.new(1, 0, 0, 35);
tabsContainer.Position = UDim2.new(0, 0, 0, 35);
tabsContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
tabsContainer.BorderSizePixel = 0;
local tabListLayout = Instance.new("UIListLayout", tabsContainer);
tabListLayout.FillDirection = Enum.FillDirection.Horizontal;
tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
local pagesContainer = Instance.new("Frame", mainFrame);
pagesContainer.Size = UDim2.new(1, 0, 1, -70);
pagesContainer.Position = UDim2.new(0, 0, 0, 70);
pagesContainer.BackgroundTransparency = 1;
local pageMain = Instance.new("ScrollingFrame", pagesContainer);
pageMain.Size = UDim2.new(1, 0, 1, 0);
pageMain.BackgroundTransparency = 1;
pageMain.Visible = true;
pageMain.BorderSizePixel = 0;
pageMain.ScrollBarThickness = 5;
pageMain.CanvasSize = UDim2.new(0, 0, 0, 450);
pageMain.ScrollBarImageColor3 = Color3.fromRGB(170, 0, 0);
local pageInfo = Instance.new("Frame", pagesContainer);
pageInfo.Size = UDim2.new(1, 0, 1, 0);
pageInfo.BackgroundTransparency = 1;
pageInfo.Visible = false;
local function createTabButton(name, targetPage)
	local FlatIdent_1D164 = 0;
	local btn;
	while true do
		if (FlatIdent_1D164 == 1) then
			btn.BackgroundTransparency = 1;
			btn.Text = name;
			FlatIdent_1D164 = 2;
		end
		if (FlatIdent_1D164 == 4) then
			return btn;
		end
		if (FlatIdent_1D164 == 3) then
			btn.TextSize = 14;
			btn.MouseButton1Click:Connect(function()
				pageMain.Visible = targetPage == pageMain;
				pageInfo.Visible = targetPage == pageInfo;
				for _, v in pairs(tabsContainer:GetChildren()) do
					if v:IsA("TextButton") then
						v.TextColor3 = ((v == btn) and Color3.new(1, 1, 1)) or Color3.fromRGB(150, 150, 150);
					end
				end
			end);
			FlatIdent_1D164 = 4;
		end
		if (FlatIdent_1D164 == 2) then
			btn.TextColor3 = Color3.fromRGB(150, 150, 150);
			btn.Font = Enum.Font.GothamSemibold;
			FlatIdent_1D164 = 3;
		end
		if (0 == FlatIdent_1D164) then
			btn = Instance.new("TextButton", tabsContainer);
			btn.Size = UDim2.new(0.5, 0, 1, 0);
			FlatIdent_1D164 = 1;
		end
	end
end
local tab1 = createTabButton("COMBAT", pageMain);
local tab2 = createTabButton("INFO", pageInfo);
tab1.TextColor3 = Color3.new(1, 1, 1);
local autoControlText = Instance.new("TextLabel", pageMain);
autoControlText.Size = UDim2.new(0, 150, 0, 20);
autoControlText.Position = UDim2.new(0.5, -75, 0, 0);
autoControlText.BackgroundTransparency = 1;
autoControlText.Text = "AUTO CONTROL";
autoControlText.TextColor3 = Color3.fromRGB(200, 200, 200);
autoControlText.Font = Enum.Font.GothamBold;
autoControlText.TextSize = 13;
autoControlText.TextXAlignment = Enum.TextXAlignment.Center;
local toggle = Instance.new("TextButton", pageMain);
toggle.Size = UDim2.new(0, 150, 0, 28);
toggle.Position = UDim2.new(0.5, -155, 0.1, 0);
toggle.Text = "SHOW BUTTON: ON";
toggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
toggle.TextColor3 = Color3.new(1, 1, 1);
toggle.Font = Enum.Font.GothamBold;
toggle.TextSize = 12;
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6);
Instance.new("UIStroke", toggle).Color = Color3.new(1, 1, 1);
local circleToggleBtn = Instance.new("TextButton", pageMain);
circleToggleBtn.Size = UDim2.new(0, 150, 0, 28);
circleToggleBtn.Position = UDim2.new(0.5, 5, 0.1, 0);
circleToggleBtn.Text = "DRAG CIRCLE: VISIBLE";
circleToggleBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
circleToggleBtn.TextColor3 = Color3.new(1, 1, 1);
circleToggleBtn.Font = Enum.Font.GothamBold;
circleToggleBtn.TextSize = 12;
Instance.new("UICorner", circleToggleBtn).CornerRadius = UDim.new(0, 6);
Instance.new("UIStroke", circleToggleBtn).Color = Color3.new(1, 1, 1);
local adhesionValue = 3;
local sliderBg = Instance.new("Frame", pageMain);
sliderBg.Size = UDim2.new(0, 220, 0, 18);
sliderBg.Position = UDim2.new(0.5, -110, 0.26, 0);
sliderBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0);
Instance.new("UIStroke", sliderBg).Color = Color3.fromRGB(170, 0, 0);
Instance.new("UIStroke", sliderBg).Thickness = 1.5;
local sliderFill = Instance.new("Frame", sliderBg);
sliderFill.Size = UDim2.new((adhesionValue - 1) / 4, 0, 1, 0);
sliderFill.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0);
local sliderText = Instance.new("TextLabel", sliderBg);
sliderText.Size = UDim2.new(1, 0, 1, 0);
sliderText.BackgroundTransparency = 1;
sliderText.Text = "Adhesion Force: " .. adhesionValue;
sliderText.TextColor3 = Color3.new(1, 1, 1);
sliderText.Font = Enum.Font.GothamBold;
sliderText.TextSize = 12;
local sliding = false;
local function updateSlider(input)
	local FlatIdent_1BCFB = 0;
	local relativeX;
	while true do
		if (FlatIdent_1BCFB == 1) then
			adhesionValue = 1 + (relativeX * 4);
			adhesionValue = math.floor(adhesionValue * 10) / 10;
			FlatIdent_1BCFB = 2;
		end
		if (2 == FlatIdent_1BCFB) then
			sliderText.Text = "Adhesion Force: " .. adhesionValue;
			break;
		end
		if (FlatIdent_1BCFB == 0) then
			relativeX = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1);
			sliderFill.Size = UDim2.new(relativeX, 0, 1, 0);
			FlatIdent_1BCFB = 1;
		end
	end
end
sliderBg.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		local FlatIdent_1BAD7 = 0;
		while true do
			if (FlatIdent_1BAD7 == 0) then
				sliding = true;
				updateSlider(input);
				break;
			end
		end
	end
end);
userInputService.InputChanged:Connect(function(input)
	if (sliding and ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch))) then
		updateSlider(input);
	end
end);
userInputService.InputEnded:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		sliding = false;
	end
end);
local resetTargetBtn = Instance.new("TextButton", pageMain);
resetTargetBtn.Size = UDim2.new(0, 220, 0, 20);
resetTargetBtn.Position = UDim2.new(0.5, -110, 0.36, 0);
resetTargetBtn.Text = "RESET AUTO TARGET";
resetTargetBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0);
resetTargetBtn.TextColor3 = Color3.new(1, 1, 1);
resetTargetBtn.Font = Enum.Font.GothamBold;
resetTargetBtn.TextSize = 11;
Instance.new("UICorner", resetTargetBtn).CornerRadius = UDim.new(0, 4);
Instance.new("UIStroke", resetTargetBtn).Color = Color3.fromRGB(170, 0, 0);
resetTargetBtn.MouseButton1Click:Connect(function()
	local FlatIdent_6053C = 0;
	while true do
		if (FlatIdent_6053C == 1) then
			sliderFill.Size = UDim2.new((adhesionValue - 1) / 4, 0, 1, 0);
			sliderText.Text = "Adhesion Force: " .. adhesionValue;
			FlatIdent_6053C = 2;
		end
		if (FlatIdent_6053C == 0) then
			lockedTarget = nil;
			adhesionValue = 3;
			FlatIdent_6053C = 1;
		end
		if (FlatIdent_6053C == 2) then
			starterGui:SetCore("SendNotification", {Title="إعادة تعيين 🔄",Text="تم مسح الهدف وإعادة الأوتو للوضع الافتراضي!",Duration=3});
			break;
		end
	end
end);
local speedControlText = Instance.new("TextLabel", pageMain);
speedControlText.Size = UDim2.new(0, 150, 0, 20);
speedControlText.Position = UDim2.new(0.5, -75, 0.48, 0);
speedControlText.BackgroundTransparency = 1;
speedControlText.Text = "SPEED CONTROL";
speedControlText.TextColor3 = Color3.fromRGB(200, 200, 200);
speedControlText.Font = Enum.Font.GothamBold;
speedControlText.TextSize = 13;
speedControlText.TextXAlignment = Enum.TextXAlignment.Center;
local speedToggleBtn = Instance.new("TextButton", pageMain);
speedToggleBtn.Size = UDim2.new(0, 150, 0, 28);
speedToggleBtn.Position = UDim2.new(0.5, -75, 0.58, 0);
speedToggleBtn.Text = "SPEED: OFF";
speedToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
speedToggleBtn.TextColor3 = Color3.new(1, 1, 1);
speedToggleBtn.Font = Enum.Font.GothamBold;
speedToggleBtn.TextSize = 12;
Instance.new("UICorner", speedToggleBtn).CornerRadius = UDim.new(0, 6);
Instance.new("UIStroke", speedToggleBtn).Color = Color3.new(1, 1, 1);
local speedActive = false;
speedToggleBtn.MouseButton1Click:Connect(function()
	local FlatIdent_65290 = 0;
	while true do
		if (FlatIdent_65290 == 1) then
			speedToggleBtn.BackgroundColor3 = (speedActive and Color3.fromRGB(170, 0, 0)) or Color3.fromRGB(40, 40, 40);
			if (not speedActive and player.Character and player.Character:FindFirstChild("Humanoid")) then
				player.Character.Humanoid.WalkSpeed = 16;
			end
			break;
		end
		if (FlatIdent_65290 == 0) then
			speedActive = not speedActive;
			speedToggleBtn.Text = (speedActive and "SPEED: ON") or "SPEED: OFF";
			FlatIdent_65290 = 1;
		end
	end
end);
local speedLevel = 1;
local speedValues = {16,18,20,22,25};
local speedSliderBg = Instance.new("Frame", pageMain);
speedSliderBg.Size = UDim2.new(0, 220, 0, 18);
speedSliderBg.Position = UDim2.new(0.5, -110, 0.72, 0);
speedSliderBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
Instance.new("UICorner", speedSliderBg).CornerRadius = UDim.new(1, 0);
Instance.new("UIStroke", speedSliderBg).Color = Color3.fromRGB(170, 0, 0);
Instance.new("UIStroke", speedSliderBg).Thickness = 1.5;
local speedSliderFill = Instance.new("Frame", speedSliderBg);
speedSliderFill.Size = UDim2.new(0, 0, 1, 0);
speedSliderFill.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
Instance.new("UICorner", speedSliderFill).CornerRadius = UDim.new(1, 0);
local speedSliderText = Instance.new("TextLabel", speedSliderBg);
speedSliderText.Size = UDim2.new(1, 0, 1, 0);
speedSliderText.BackgroundTransparency = 1;
speedSliderText.Text = "Speed Level: 1 (Normal)";
speedSliderText.TextColor3 = Color3.new(1, 1, 1);
speedSliderText.Font = Enum.Font.GothamBold;
speedSliderText.TextSize = 12;
local speedSliding = false;
local function updateSpeedSlider(input)
	local FlatIdent_5CA49 = 0;
	local relativeX;
	local speedLabel;
	while true do
		if (FlatIdent_5CA49 == 3) then
			speedSliderText.Text = "Speed Level: " .. speedLevel .. " " .. speedLabel;
			break;
		end
		if (1 == FlatIdent_5CA49) then
			if (speedLevel > 5) then
				speedLevel = 5;
			end
			if (speedLevel < 1) then
				speedLevel = 1;
			end
			FlatIdent_5CA49 = 2;
		end
		if (FlatIdent_5CA49 == 0) then
			relativeX = math.clamp((input.Position.X - speedSliderBg.AbsolutePosition.X) / speedSliderBg.AbsoluteSize.X, 0, 1);
			speedLevel = math.floor((relativeX * 4) + 1.5);
			FlatIdent_5CA49 = 1;
		end
		if (2 == FlatIdent_5CA49) then
			speedSliderFill.Size = UDim2.new((speedLevel - 1) / 4, 0, 1, 0);
			speedLabel = ((speedLevel == 1) and "(Normal)") or ("(" .. speedValues[speedLevel] .. ")");
			FlatIdent_5CA49 = 3;
		end
	end
end
speedSliderBg.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		local FlatIdent_14124 = 0;
		while true do
			if (0 == FlatIdent_14124) then
				speedSliding = true;
				updateSpeedSlider(input);
				break;
			end
		end
	end
end);
userInputService.InputChanged:Connect(function(input)
	if (speedSliding and ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch))) then
		updateSpeedSlider(input);
	end
end);
userInputService.InputEnded:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		speedSliding = false;
	end
end);
local fpsToggleBtn = Instance.new("TextButton", pageMain);
fpsToggleBtn.Size = UDim2.new(0, 220, 0, 26);
fpsToggleBtn.Position = UDim2.new(0.5, -110, 0.86, 0);
fpsToggleBtn.Text = "PERFORMANCE & MODS: OFF";
fpsToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
fpsToggleBtn.TextColor3 = Color3.new(1, 1, 1);
fpsToggleBtn.Font = Enum.Font.GothamBold;
fpsToggleBtn.TextSize = 12;
Instance.new("UICorner", fpsToggleBtn).CornerRadius = UDim.new(0, 6);
Instance.new("UIStroke", fpsToggleBtn).Color = Color3.new(1, 1, 1);
local fpsActive = false;
local fpsConnections = {};
local function applyBombMods(obj)
	pcall(function()
		local FlatIdent_2D2B8 = 0;
		local targetColor;
		while true do
			if (FlatIdent_2D2B8 == 1) then
				if obj:IsA("Tool") then
					for _, part in pairs(obj:GetDescendants()) do
						if (part:IsA("BasePart") or part:IsA("MeshPart")) then
							local FlatIdent_3EEE1 = 0;
							while true do
								if (FlatIdent_3EEE1 == 0) then
									part.Color = targetColor;
									if part:IsA("MeshPart") then
										part.TextureID = "";
									end
									break;
								end
							end
						elseif part:IsA("SpecialMesh") then
							local FlatIdent_39764 = 0;
							while true do
								if (FlatIdent_39764 == 0) then
									part.TextureId = "";
									part.VertexColor = Vector3.new(1, 0.75, 0.8);
									break;
								end
							end
						end
					end
				end
				break;
			end
			if (FlatIdent_2D2B8 == 0) then
				targetColor = Color3.fromRGB(255, 192, 203);
				if obj:IsA("ParticleEmitter") then
					local FlatIdent_29B3D = 0;
					while true do
						if (FlatIdent_29B3D == 0) then
							obj.LockedToPart = true;
							obj.Color = ColorSequence.new(targetColor);
							break;
						end
					end
				elseif obj:IsA("Fire") then
					local FlatIdent_21E03 = 0;
					while true do
						if (FlatIdent_21E03 == 0) then
							obj.Color = targetColor;
							obj.SecondaryColor = targetColor;
							break;
						end
					end
				elseif obj:IsA("Trail") then
					obj.Color = ColorSequence.new(targetColor);
				end
				FlatIdent_2D2B8 = 1;
			end
		end
	end);
end
fpsToggleBtn.MouseButton1Click:Connect(function()
	fpsActive = not fpsActive;
	if fpsActive then
		local FlatIdent_2C980 = 0;
		local c1;
		local c2;
		while true do
			if (FlatIdent_2C980 == 0) then
				fpsToggleBtn.Text = "PERFORMANCE & MODS: ON";
				fpsToggleBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
				lighting.GlobalShadows = false;
				lighting.FogEnd = 8999999488;
				FlatIdent_2C980 = 1;
			end
			if (1 == FlatIdent_2C980) then
				lighting.ShadowSoftness = 0;
				for _, effect in pairs(lighting:GetChildren()) do
					if (effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or effect:IsA("DepthOfFieldEffect")) then
						effect.Enabled = false;
					end
				end
				for _, part in pairs(workspace:GetDescendants()) do
					if part:IsA("BasePart") then
						local FlatIdent_69D54 = 0;
						while true do
							if (FlatIdent_69D54 == 0) then
								part.CastShadow = false;
								part.Material = Enum.Material.SmoothPlastic;
								break;
							end
						end
					end
				end
				for _, v in pairs(workspace:GetDescendants()) do
					applyBombMods(v);
				end
				FlatIdent_2C980 = 2;
			end
			if (FlatIdent_2C980 == 3) then
				table.insert(fpsConnections, c2);
				starterGui:SetCore("SendNotification", {Title="نجاح",Text="تم تحسين الأداء وتعديل القنبلة والنار!",Duration=5});
				break;
			end
			if (2 == FlatIdent_2C980) then
				for _, v in pairs(game:GetService("Players"):GetDescendants()) do
					applyBombMods(v);
				end
				c1 = workspace.DescendantAdded:Connect(function(descendant)
					task.wait(0.02);
					if fpsActive then
						applyBombMods(descendant);
					end
				end);
				c2 = game:GetService("Players").DescendantAdded:Connect(function(descendant)
					local FlatIdent_6B983 = 0;
					while true do
						if (FlatIdent_6B983 == 0) then
							task.wait(0.02);
							if fpsActive then
								applyBombMods(descendant);
							end
							break;
						end
					end
				end);
				table.insert(fpsConnections, c1);
				FlatIdent_2C980 = 3;
			end
		end
	else
		local FlatIdent_7909D = 0;
		while true do
			if (FlatIdent_7909D == 1) then
				for _, conn in ipairs(fpsConnections) do
					conn:Disconnect();
				end
				fpsConnections = {};
				FlatIdent_7909D = 2;
			end
			if (FlatIdent_7909D == 2) then
				lighting.GlobalShadows = true;
				lighting.ShadowSoftness = 0.2;
				FlatIdent_7909D = 3;
			end
			if (FlatIdent_7909D == 0) then
				fpsToggleBtn.Text = "PERFORMANCE & MODS: OFF";
				fpsToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
				FlatIdent_7909D = 1;
			end
			if (FlatIdent_7909D == 3) then
				for _, effect in pairs(lighting:GetChildren()) do
					if (effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or effect:IsA("DepthOfFieldEffect")) then
						effect.Enabled = true;
					end
				end
				starterGui:SetCore("SendNotification", {Title="توقف",Text="تم إيقاف المودات (قد تتطلب إعادة تشغيل اللعبة لرجوع المجسمات الطبيعية)",Duration=5});
				break;
			end
		end
	end
end);
local infoText = Instance.new("TextLabel", pageInfo);
infoText.Size = UDim2.new(0.9, 0, 0.9, 0);
infoText.Position = UDim2.new(0.05, 0, 0.05, 0);
infoText.BackgroundTransparency = 1;
infoText.Text = "✨ SAADHUB V2 FEATURES ✨\n\n🎯 AUTO CONTROL: تتبع الخصم واللمس السريع\n⚙️ ADHESION FORCE: تحكم بمدى قوة الالتصاق\n🔄 RESET TARGET: تصفير الهدف الحالي\n🏃 SPEED CONTROL: سرعات متعددة للمشي\n🚀 PERFORMANCE MODS: تخفيف الجرافيكس ورفع الأداء\n🔘 FLOATING BUTTON: تشغيل سريع وسحب الشاشة\n👆 DRAG ICON: أيقونة فتح قابلة للسحب\n📊 FPS & PING: مراقبة أداء اللعبة والاتصال";
infoText.TextColor3 = Color3.fromRGB(220, 220, 220);
infoText.Font = Enum.Font.GothamSemibold;
infoText.TextSize = 13;
infoText.TextXAlignment = Enum.TextXAlignment.Left;
infoText.TextYAlignment = Enum.TextYAlignment.Top;
local botEventPlayed = false;
minimizeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false;
	openIcon.Visible = true;
	tweenService:Create(mainBlur, TweenInfo.new(0.3), {Size=0}):Play();
	if (not botEventPlayed and player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then
		botEventPlayed = true;
		task.spawn(function()
			local hrp = player.Character.HumanoidRootPart;
			player.Character.Archivable = true;
			local bot1 = player.Character:Clone();
			bot1.Name = "WarningDancerBot";
			for _, v in pairs(bot1:GetDescendants()) do
				if v:IsA("BaseScript") then
					v:Destroy();
				end
			end
			local head = bot1:FindFirstChild("Head") or bot1:FindFirstChild("Torso");
			if head then
				local FlatIdent_23B66 = 0;
				local bg;
				local txt;
				while true do
					if (FlatIdent_23B66 == 1) then
						bg.AlwaysOnTop = true;
						txt = Instance.new("TextLabel", bg);
						txt.Size = UDim2.new(1, 0, 1, 0);
						FlatIdent_23B66 = 2;
					end
					if (FlatIdent_23B66 == 3) then
						txt.TextStrokeTransparency = 0;
						txt.TextStrokeColor3 = Color3.new(0, 0, 0);
						txt.TextScaled = true;
						FlatIdent_23B66 = 4;
					end
					if (FlatIdent_23B66 == 0) then
						bg = Instance.new("BillboardGui", head);
						bg.Size = UDim2.new(0, 350, 0, 60);
						bg.StudsOffset = Vector3.new(0, 3.5, 0);
						FlatIdent_23B66 = 1;
					end
					if (4 == FlatIdent_23B66) then
						txt.Font = Enum.Font.GothamBlack;
						break;
					end
					if (FlatIdent_23B66 == 2) then
						txt.BackgroundTransparency = 1;
						txt.Text = "انتبه لا تلعب بوحشيه قد يسبب باند";
						txt.TextColor3 = Color3.fromRGB(255, 30, 30);
						FlatIdent_23B66 = 3;
					end
				end
			end
			local spawnPos = hrp.CFrame * CFrame.new(0, 0, -6);
			bot1:PivotTo(CFrame.new(spawnPos.Position, hrp.Position));
			bot1.Parent = workspace;
			local hum1 = bot1:FindFirstChildOfClass("Humanoid");
			if hum1 then
				local FlatIdent_6DC53 = 0;
				local anim;
				while true do
					if (0 == FlatIdent_6DC53) then
						anim = Instance.new("Animation");
						anim.AnimationId = ((hum1.RigType == Enum.HumanoidRigType.R15) and "rbxassetid://507771019") or "rbxassetid://181525546";
						FlatIdent_6DC53 = 1;
					end
					if (1 == FlatIdent_6DC53) then
						pcall(function()
							local FlatIdent_68E92 = 0;
							local track;
							while true do
								if (FlatIdent_68E92 == 0) then
									track = hum1:LoadAnimation(anim);
									track:Play();
									break;
								end
							end
						end);
						break;
					end
				end
			end
			task.wait(3);
			if bot1.PrimaryPart then
				local FlatIdent_6C033 = 0;
				local explosion;
				local highlight;
				while true do
					if (FlatIdent_6C033 == 1) then
						explosion.BlastPressure = 50000;
						explosion.DestroyJointRadiusPercent = 0;
						explosion.Parent = workspace;
						FlatIdent_6C033 = 2;
					end
					if (FlatIdent_6C033 == 3) then
						highlight.FillColor = Color3.new(1, 0, 0);
						highlight.FillTransparency = 0.5;
						break;
					end
					if (FlatIdent_6C033 == 0) then
						explosion = Instance.new("Explosion");
						explosion.Position = bot1.PrimaryPart.Position;
						explosion.BlastRadius = 8;
						FlatIdent_6C033 = 1;
					end
					if (FlatIdent_6C033 == 2) then
						bot1:BreakJoints();
						for _, part in pairs(bot1:GetChildren()) do
							if part:IsA("BasePart") then
								part.Velocity = Vector3.new(math.random(-80, 80), math.random(50, 120), math.random(-80, 80));
							end
						end
						highlight = Instance.new("Highlight", bot1);
						FlatIdent_6C033 = 3;
					end
				end
			end
			task.wait(3.5);
			if bot1 then
				bot1:Destroy();
			end
		end);
	end
end);
openIcon.MouseButton1Click:Connect(function()
	local FlatIdent_47ABB = 0;
	while true do
		if (FlatIdent_47ABB == 1) then
			tweenService:Create(mainBlur, TweenInfo.new(0.3), {Size=22}):Play();
			break;
		end
		if (FlatIdent_47ABB == 0) then
			mainFrame.Visible = true;
			openIcon.Visible = false;
			FlatIdent_47ABB = 1;
		end
	end
end);
local floatingToggle = Instance.new("TextButton", mainGui);
floatingToggle.Size = UDim2.new(0, 140, 0, 45);
floatingToggle.Position = UDim2.new(0.05, 0, 0.4, 0);
floatingToggle.Text = "SAADHUB: ON";
floatingToggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
floatingToggle.TextColor3 = Color3.new(1, 1, 1);
floatingToggle.Font = Enum.Font.GothamBold;
floatingToggle.TextSize = 16;
floatingToggle.Visible = false;
Instance.new("UICorner", floatingToggle);
Instance.new("UIStroke", floatingToggle).Color = Color3.new(1, 1, 1);
local dragCircle = Instance.new("Frame", floatingToggle);
dragCircle.Size = UDim2.new(0, 25, 0, 25);
dragCircle.Position = UDim2.new(0.5, -12.5, 0, -32);
dragCircle.BackgroundColor3 = Color3.new(1, 1, 1);
dragCircle.BackgroundTransparency = 0;
Instance.new("UICorner", dragCircle).CornerRadius = UDim.new(1, 0);
local dragStroke = Instance.new("UIStroke", dragCircle);
dragStroke.Thickness = 1.2;
dragStroke.Color = Color3.new(1, 1, 1);
dragStroke.Transparency = 0;
local floatingDragging, dragStart, startPos;
dragCircle.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		local FlatIdent_45D37 = 0;
		while true do
			if (FlatIdent_45D37 == 1) then
				startPos = floatingToggle.Position;
				break;
			end
			if (FlatIdent_45D37 == 0) then
				floatingDragging = true;
				dragStart = input.Position;
				FlatIdent_45D37 = 1;
			end
		end
	end
end);
userInputService.InputChanged:Connect(function(input)
	if (floatingDragging and ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch))) then
		local FlatIdent_90A41 = 0;
		local delta;
		while true do
			if (FlatIdent_90A41 == 0) then
				delta = input.Position - dragStart;
				floatingToggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
				break;
			end
		end
	end
end);
userInputService.InputEnded:Connect(function()
	floatingDragging = false;
end);
local circleVisible = true;
circleToggleBtn.MouseButton1Click:Connect(function()
	local FlatIdent_386FF = 0;
	while true do
		if (2 == FlatIdent_386FF) then
			circleToggleBtn.BackgroundColor3 = (circleVisible and Color3.fromRGB(170, 0, 0)) or Color3.fromRGB(40, 40, 40);
			if not circleVisible then
				starterGui:SetCore("SendNotification", {Title="توضيح 💡",Text="تم إخفاء شكل الدائرة فقط، لا يزال بإمكانك السحب من نفس المكان!",Duration=5});
			end
			break;
		end
		if (FlatIdent_386FF == 0) then
			circleVisible = not circleVisible;
			dragCircle.BackgroundTransparency = (circleVisible and 0) or 1;
			FlatIdent_386FF = 1;
		end
		if (1 == FlatIdent_386FF) then
			dragStroke.Transparency = (circleVisible and 0) or 1;
			circleToggleBtn.Text = (circleVisible and "DRAG CIRCLE: VISIBLE") or "DRAG CIRCLE: HIDDEN";
			FlatIdent_386FF = 2;
		end
	end
end);
task.spawn(function()
	while true do
		local FlatIdent_92569 = 0;
		while true do
			if (FlatIdent_92569 == 0) then
				task.wait(math.random(15, 35) / 100);
				if mainFrame.Visible then
					local FlatIdent_6D9D2 = 0;
					local star;
					local fallTime;
					local tween;
					while true do
						if (FlatIdent_6D9D2 == 1) then
							star.TextColor3 = Color3.fromRGB(math.random(200, 255), 0, 0);
							star.TextSize = math.random(10, 16);
							star.Font = Enum.Font.GothamBold;
							FlatIdent_6D9D2 = 2;
						end
						if (FlatIdent_6D9D2 == 2) then
							star.Position = UDim2.new(math.random(0, 100) / 100, -10, 0, -20);
							fallTime = math.random(15, 30) / 10;
							tween = tweenService:Create(star, TweenInfo.new(fallTime, Enum.EasingStyle.Linear), {Position=UDim2.new(star.Position.X.Scale, star.Position.X.Offset, 1, 20),Rotation=math.random(90, 360)});
							FlatIdent_6D9D2 = 3;
						end
						if (FlatIdent_6D9D2 == 3) then
							tween:Play();
							tween.Completed:Connect(function()
								star:Destroy();
							end);
							break;
						end
						if (FlatIdent_6D9D2 == 0) then
							star = Instance.new("TextLabel", mainFrame);
							star.BackgroundTransparency = 1;
							star.Text = "★";
							FlatIdent_6D9D2 = 1;
						end
					end
				end
				break;
			end
		end
	end
end);
task.spawn(function()
	local FlatIdent_72421 = 0;
	local introGui;
	local introText;
	local stroke;
	while true do
		if (FlatIdent_72421 == 6) then
			floatingToggle.Visible = true;
			break;
		end
		if (FlatIdent_72421 == 1) then
			introText.Position = UDim2.new(0, 0, 0.45, 0);
			introText.BackgroundTransparency = 1;
			introText.Text = "⚡ COME BACK SAADHUB ⚡";
			introText.TextColor3 = Color3.new(1, 1, 1);
			FlatIdent_72421 = 2;
		end
		if (FlatIdent_72421 == 0) then
			introGui = Instance.new("ScreenGui", player.PlayerGui);
			introGui.ResetOnSpawn = false;
			introText = Instance.new("TextLabel", introGui);
			introText.Size = UDim2.new(1, 0, 0.1, 0);
			FlatIdent_72421 = 1;
		end
		if (5 == FlatIdent_72421) then
			tweenService:Create(stroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Transparency=1}):Play();
			task.wait(0.6);
			introGui:Destroy();
			mainFrame.Visible = true;
			FlatIdent_72421 = 6;
		end
		if (FlatIdent_72421 == 3) then
			stroke.Color = Color3.new(0, 0, 0);
			stroke.Thickness = 3.5;
			stroke.Transparency = 1;
			tweenService:Create(mainBlur, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size=22}):Play();
			FlatIdent_72421 = 4;
		end
		if (FlatIdent_72421 == 2) then
			introText.Font = Enum.Font.GothamBold;
			introText.TextSize = 46;
			introText.TextTransparency = 1;
			stroke = Instance.new("UIStroke", introText);
			FlatIdent_72421 = 3;
		end
		if (FlatIdent_72421 == 4) then
			tweenService:Create(introText, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency=0}):Play();
			tweenService:Create(stroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency=0}):Play();
			task.wait(3.2);
			tweenService:Create(introText, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {TextTransparency=1}):Play();
			FlatIdent_72421 = 5;
		end
	end
end);
local updateFileName = "SaadHub_Safe_V2_Jitter.json";
local function shouldNotifyUpdate()
	local FlatIdent_8325F = 0;
	local success;
	local content;
	while true do
		if (FlatIdent_8325F == 1) then
			pcall(function()
				writefile(updateFileName, "done");
			end);
			return true;
		end
		if (FlatIdent_8325F == 0) then
			success, content = pcall(function()
				return readfile(updateFileName);
			end);
			if (success and (content == "done")) then
				return false;
			end
			FlatIdent_8325F = 1;
		end
	end
end
local isFirstUpdateNotify = shouldNotifyUpdate();
local liveCount = "1";
task.spawn(function()
	pcall(function()
		local FlatIdent_634AF = 0;
		local response;
		local data;
		while true do
			if (0 == FlatIdent_634AF) then
				response = game:HttpGet("https://api.counterapi.dev/v1/saadhub_official_unique/hits/up");
				data = httpService:JSONDecode(response);
				FlatIdent_634AF = 1;
			end
			if (FlatIdent_634AF == 1) then
				if (data and data.count) then
					liveCount = tostring(data.count);
				end
				break;
			end
		end
	end);
end);
task.spawn(function()
	if isFirstUpdateNotify then
		starterGui:SetCore("SendNotification", {Title="SHIELD ACTIVE 🛡️",Text="تم تفعيل السرعة القصوى مع الحماية!",Icon="rbxassetid://13054812323",Duration=6});
	end
end);
local function isEnemy(v)
	local FlatIdent_21297 = 0;
	local hl;
	while true do
		if (FlatIdent_21297 == 1) then
			if (hl and (hl.FillColor.G > hl.FillColor.R)) then
				return false;
			end
			if ((player.Team ~= nil) and (v.Team ~= nil) and (player.Team == v.Team)) then
				return false;
			end
			FlatIdent_21297 = 2;
		end
		if (FlatIdent_21297 == 2) then
			return true;
		end
		if (FlatIdent_21297 == 0) then
			if (not v or (v == player) or not v.Character) then
				return false;
			end
			hl = v.Character:FindFirstChildOfClass("Highlight");
			FlatIdent_21297 = 1;
		end
	end
end
local function fastTouch(targetChar, tool)
	local FlatIdent_59C45 = 0;
	local handle;
	while true do
		if (FlatIdent_59C45 == 0) then
			handle = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("Part");
			if (handle and targetChar:FindFirstChild("HumanoidRootPart")) then
				local FlatIdent_869A9 = 0;
				local dist;
				while true do
					if (FlatIdent_869A9 == 0) then
						dist = (player.Character.HumanoidRootPart.Position - targetChar.HumanoidRootPart.Position).Magnitude;
						if (dist < 3.8) then
							task.spawn(function()
								for i = 1, 15 do
									local FlatIdent_276C2 = 0;
									while true do
										if (FlatIdent_276C2 == 0) then
											firetouchinterest(targetChar.HumanoidRootPart, handle, 0);
											firetouchinterest(targetChar.HumanoidRootPart, handle, 1);
											break;
										end
									end
								end
							end);
						end
						break;
					end
				end
			end
			break;
		end
	end
end
local function toggleScript()
	local FlatIdent_6D68E = 0;
	while true do
		if (FlatIdent_6D68E == 0) then
			active = not active;
			floatingToggle.Text = (active and "SAADHUB: ON") or "SAADHUB: OFF";
			FlatIdent_6D68E = 1;
		end
		if (FlatIdent_6D68E == 1) then
			floatingToggle.BackgroundColor3 = (active and Color3.fromRGB(170, 0, 0)) or Color3.fromRGB(40, 40, 40);
			if not active then
				lockedTarget = nil;
			end
			break;
		end
	end
end
floatingToggle.MouseButton1Click:Connect(toggleScript);
local buttonVisible = true;
toggle.MouseButton1Click:Connect(function()
	local FlatIdent_854BA = 0;
	while true do
		if (FlatIdent_854BA == 0) then
			buttonVisible = not buttonVisible;
			floatingToggle.Visible = buttonVisible;
			FlatIdent_854BA = 1;
		end
		if (FlatIdent_854BA == 1) then
			toggle.Text = (buttonVisible and "SHOW BUTTON: ON") or "SHOW BUTTON: OFF";
			toggle.BackgroundColor3 = (buttonVisible and Color3.fromRGB(170, 0, 0)) or Color3.fromRGB(40, 40, 40);
			break;
		end
	end
end);
runService.RenderStepped:Connect(function()
	if (player.Character and player.Character:FindFirstChild("Humanoid")) then
		if speedActive then
			player.Character.Humanoid.WalkSpeed = speedValues[speedLevel];
		end
		if active then
			local FlatIdent_43626 = 0;
			local bpTool;
			local tool;
			while true do
				if (FlatIdent_43626 == 1) then
					tool = player.Character:FindFirstChildOfClass("Tool");
					if tool then
						local FlatIdent_8FBAE = 0;
						local targetPlr;
						while true do
							if (FlatIdent_8FBAE == 0) then
								targetPlr = lockedTarget and game.Players:GetPlayerFromCharacter(lockedTarget);
								if (not lockedTarget or not lockedTarget.Parent or (lockedTarget.Humanoid.Health <= 0) or (targetPlr and not isEnemy(targetPlr))) then
									local cDist = math.huge;
									lockedTarget = nil;
									for _, v in pairs(game.Players:GetPlayers()) do
										if (isEnemy(v) and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and (v.Character.Humanoid.Health > 0)) then
											local FlatIdent_3C1AA = 0;
											local d;
											while true do
												if (FlatIdent_3C1AA == 0) then
													d = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude;
													if (d < cDist) then
														local FlatIdent_3C8BC = 0;
														while true do
															if (FlatIdent_3C8BC == 0) then
																cDist = d;
																lockedTarget = v.Character;
																break;
															end
														end
													end
													break;
												end
											end
										end
									end
								end
								FlatIdent_8FBAE = 1;
							end
							if (FlatIdent_8FBAE == 1) then
								if (lockedTarget and lockedTarget:FindFirstChild("HumanoidRootPart")) then
									local FlatIdent_71EE8 = 0;
									local targetRoot;
									local myRoot;
									local dist;
									local smartOffset;
									while true do
										if (FlatIdent_71EE8 == 0) then
											targetRoot = lockedTarget.HumanoidRootPart;
											myRoot = player.Character.HumanoidRootPart;
											FlatIdent_71EE8 = 1;
										end
										if (FlatIdent_71EE8 == 2) then
											if (dist > smartOffset) then
												player.Character.Humanoid:Move((targetRoot.Position - myRoot.Position).Unit, false);
											end
											fastTouch(lockedTarget, tool);
											break;
										end
										if (1 == FlatIdent_71EE8) then
											dist = (targetRoot.Position - myRoot.Position).Magnitude;
											smartOffset = adhesionValue;
											FlatIdent_71EE8 = 2;
										end
									end
								end
								break;
							end
						end
					else
						lockedTarget = nil;
					end
					break;
				end
				if (0 == FlatIdent_43626) then
					bpTool = player.Backpack:FindFirstChildOfClass("Tool");
					if bpTool then
						player.Character.Humanoid:EquipTool(bpTool);
					end
					FlatIdent_43626 = 1;
				end
			end
		end
	end
end);