```lua
--==================================================
-- COMBAT MENU - SAFE VERSION
-- Меню создаётся ПЕРВЫМ
-- Ошибка ESP/AIM не должна сломать меню
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

print("COMBAT MENU: START")

--==================================================
-- SETTINGS
--==================================================

local ESP_ENABLED = true
local AIM_ENABLED = false
local VISIBLE_CHECK = true
local TRIGGERBOT_ENABLED = false
local SILENT_AIM_ENABLED = false

local AIM_SPEED = 8
local FOV_RADIUS = 150
local TARGET_MODE = "BOTH"

--==================================================
-- GUI
--==================================================

local oldGui = PlayerGui:FindFirstChild("CombatMenu")

if oldGui then
	oldGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CombatMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

print("COMBAT MENU: GUI CREATED")

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 420, 0, 560)
Main.Position = UDim2.new(0.5, -210, 0.5, -280)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 16)
Corner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(70, 70, 90)
Stroke.Thickness = 1
Stroke.Transparency = 0.2
Stroke.Parent = Main

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -30, 0, 55)
Title.Position = UDim2.new(0, 15, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "⚡ COMBAT MENU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, -30, 0, 25)
Subtitle.Position = UDim2.new(0, 15, 0, 52)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "ESP • AIM • COMBAT"
Subtitle.TextColor3 = Color3.fromRGB(130, 130, 145)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Main

--==================================================
-- CLOSE BUTTON
--==================================================

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Size = UDim2.new(0, 38, 0, 38)
Close.Position = UDim2.new(1, -50, 0, 15)
Close.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(255, 100, 100)
Close.TextSize = 25
Close.Font = Enum.Font.GothamBold
Close.BorderSizePixel = 0
Close.Parent = Main

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = Close

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -30, 1, -100)
Content.Position = UDim2.new(0, 15, 0, 90)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 4
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Content

--==================================================
-- SECTION
--==================================================

local function createSection(text)
	local Label = Instance.new("TextLabel")

	Label.Size = UDim2.new(1, 0, 0, 28)
	Label.BackgroundTransparency = 1

	Label.Text = text
	Label.TextColor3 = Color3.fromRGB(120, 170, 255)
	Label.TextSize = 13
	Label.Font = Enum.Font.GothamBold

	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = Content

	return Label
end

--==================================================
-- TOGGLE
--==================================================

local function createToggle(name, defaultValue, callback)

	local Button = Instance.new("TextButton")

	Button.Size = UDim2.new(1, 0, 0, 48)
	Button.BackgroundColor3 = Color3.fromRGB(27, 27, 36)
	Button.BorderSizePixel = 0

	Button.Text = ""
	Button.AutoButtonColor = false

	Button.Parent = Content

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 10)
	Corner.Parent = Button

	local Label = Instance.new("TextLabel")

	Label.Size = UDim2.new(1, -80, 1, 0)
	Label.Position = UDim2.new(0, 15, 0, 0)
	Label.BackgroundTransparency = 1

	Label.Text = name
	Label.TextColor3 = Color3.fromRGB(235, 235, 240)
	Label.TextSize = 14
	Label.Font = Enum.Font.GothamMedium
	Label.TextXAlignment = Enum.TextXAlignment.Left

	Label.Parent = Button

	local State = Instance.new("TextLabel")

	State.Size = UDim2.new(0, 55, 0, 25)
	State.Position = UDim2.new(1, -65, 0.5, -12)

	State.BorderSizePixel = 0
	State.TextSize = 11
	State.Font = Enum.Font.GothamBold

	State.Parent = Button

	local StateCorner = Instance.new("UICorner")
	StateCorner.CornerRadius = UDim.new(0, 8)
	StateCorner.Parent = State

	local value = defaultValue

	local function update()

		if value then

			State.Text = "ON"
			State.BackgroundColor3 = Color3.fromRGB(60, 150, 100)
			State.TextColor3 = Color3.fromRGB(255, 255, 255)

		else

			State.Text = "OFF"
			State.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
			State.TextColor3 = Color3.fromRGB(190, 190, 200)

		end

		pcall(callback, value)
	end

	Button.MouseButton1Click:Connect(function()

		value = not value

		update()

	end)

	update()

	return Button
end

--==================================================
-- VISUAL
--==================================================

createSection("VISUAL")

createToggle("ESP", ESP_ENABLED, function(value)

	ESP_ENABLED = value

	print("ESP:", value)

end)

--==================================================
-- AIM
--==================================================

createSection("AIM ASSIST")

createToggle("Aim Assist", AIM_ENABLED, function(value)

	AIM_ENABLED = value

	print("AIM:", value)

end)

createToggle("Visible Check", VISIBLE_CHECK, function(value)

	VISIBLE_CHECK = value

	print("VISIBLE CHECK:", value)

end)

--==================================================
-- COMBAT
--==================================================

createSection("COMBAT")

createToggle("Trigger Bot", TRIGGERBOT_ENABLED, function(value)

	TRIGGERBOT_ENABLED = value

	print("TRIGGER BOT:", value)

end)

createToggle("Silent Aim", SILENT_AIM_ENABLED, function(value)

	SILENT_AIM_ENABLED = value

	print("SILENT AIM:", value)

end)

--==================================================
-- TARGET MODE
--==================================================

createSection("TARGET")

local TargetButton = Instance.new("TextButton")

TargetButton.Size = UDim2.new(1, 0, 0, 48)
TargetButton.BackgroundColor3 = Color3.fromRGB(27, 27, 36)
TargetButton.BorderSizePixel = 0

TargetButton.Text = "TARGET: BOTH"
TargetButton.TextColor3 = Color3.fromRGB(235, 235, 240)
TargetButton.TextSize = 14
TargetButton.Font = Enum.Font.GothamMedium

TargetButton.Parent = Content

local TargetCorner = Instance.new("UICorner")
TargetCorner.CornerRadius = UDim.new(0, 10)
TargetCorner.Parent = TargetButton

TargetButton.MouseButton1Click:Connect(function()

	if TARGET_MODE == "BOTH" then

		TARGET_MODE = "PLAYERS"

	elseif TARGET_MODE == "PLAYERS" then

		TARGET_MODE = "BOTS"

	else

		TARGET_MODE = "BOTH"

	end

	TargetButton.Text = "TARGET: " .. TARGET_MODE

	print("TARGET MODE:", TARGET_MODE)

end)

--==================================================
-- AIM SPEED
--==================================================

createSection("AIM SETTINGS")

local SpeedButton = Instance.new("TextButton")

SpeedButton.Size = UDim2.new(1, 0, 0, 48)
SpeedButton.BackgroundColor3 = Color3.fromRGB(27, 27, 36)
SpeedButton.BorderSizePixel = 0

SpeedButton.Text = "AIM SPEED: " .. AIM_SPEED
SpeedButton.TextColor3 = Color3.fromRGB(235, 235, 240)
SpeedButton.TextSize = 14
SpeedButton.Font = Enum.Font.GothamMedium

SpeedButton.Parent = Content

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 10)
SpeedCorner.Parent = SpeedButton

SpeedButton.MouseButton1Click:Connect(function()

	AIM_SPEED += 2

	if AIM_SPEED > 20 then
		AIM_SPEED = 2
	end

	SpeedButton.Text = "AIM SPEED: " .. AIM_SPEED

end)

--==================================================
-- FOV
--==================================================

local FOVButton = Instance.new("TextButton")

FOVButton.Size = UDim2.new(1, 0, 0, 48)
FOVButton.BackgroundColor3 = Color3.fromRGB(27, 27, 36)
FOVButton.BorderSizePixel = 0

FOVButton.Text = "FOV: " .. FOV_RADIUS
FOVButton.TextColor3 = Color3.fromRGB(235, 235, 240)
FOVButton.TextSize = 14
FOVButton.Font = Enum.Font.GothamMedium

FOVButton.Parent = Content

local FOVCorner = Instance.new("UICorner")
FOVCorner.CornerRadius = UDim.new(0, 10)
FOVCorner.Parent = FOVButton

FOVButton.MouseButton1Click:Connect(function()

	FOV_RADIUS += 25

	if FOV_RADIUS > 300 then
		FOV_RADIUS = 50
	end

	FOVButton.Text = "FOV: " .. FOV_RADIUS

end)

--==================================================
-- DRAGGING
--==================================================

local dragging = false
local dragStart
local startPosition

Title.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = Main.Position

	end

end)

Title.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = false

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType ~= Enum.UserInputType.MouseMovement
		and input.UserInputType ~= Enum.UserInputType.Touch then
		return
	end

	local delta = input.Position - dragStart

	Main.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,
		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y
	)

end)

--==================================================
-- RIGHT SHIFT
--==================================================

UserInputService.InputBegan:Connect(function(input, processed)

	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.RightShift then

		Main.Visible = not Main.Visible

	end

end)

--==================================================
-- FINAL
--==================================================

print("================================")
print("COMBAT MENU: SUCCESS")
print("RightShift = SHOW/HIDE")
print("================================")
```
