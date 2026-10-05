```lua
--========================================================
-- COMBAT SYSTEM
-- ESP + AIM ASSIST + FOV + VISIBLE CHECK
-- TRIGGER BOT
-- DRAGGABLE MENU
--
-- Для собственного Roblox-проекта
--========================================================

--========================================================
-- SERVICES
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

print("========================================")
print("COMBAT SYSTEM STARTING")
print("PLAYER:", LocalPlayer.Name)
print("========================================")

--========================================================
-- SETTINGS
--========================================================

local Settings = {

	ESP = true,

	AimAssist = false,

	VisibleCheck = true,

	TriggerBot = false,

	FOV = true,

	AimSpeed = 8,

	FOVRadius = 150,

	TargetMode = "BOTH",

}

--========================================================
-- TARGET STORAGE
--========================================================

local Targets = {}

local ESPFolder = workspace:FindFirstChild("CombatESP")

if ESPFolder then
	ESPFolder:Destroy()
end

ESPFolder = Instance.new("Folder")
ESPFolder.Name = "CombatESP"
ESPFolder.Parent = workspace

--========================================================
-- GUI
--========================================================

local oldGui = PlayerGui:FindFirstChild("CombatSystem")

if oldGui then
	oldGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CombatSystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

--========================================================
-- MAIN FRAME
--========================================================

local Main = Instance.new("Frame")

Main.Name = "Main"
Main.Size = UDim2.new(0, 400, 0, 520)
Main.Position = UDim2.new(0.5, -200, 0.5, -260)

Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Main.BorderSizePixel = 0

Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(80, 80, 100)
MainStroke.Thickness = 1
MainStroke.Transparency = 0.2
MainStroke.Parent = Main

--========================================================
-- TITLE
--========================================================

local Title = Instance.new("TextLabel")

Title.Name = "Title"
Title.Size = UDim2.new(1, -70, 0, 45)
Title.Position = UDim2.new(0, 18, 0, 10)

Title.BackgroundTransparency = 1

Title.Text = "⚡ COMBAT SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 23
Title.Font = Enum.Font.GothamBold

Title.TextXAlignment = Enum.TextXAlignment.Left

Title.Parent = Main

local Subtitle = Instance.new("TextLabel")

Subtitle.Size = UDim2.new(1, -30, 0, 22)
Subtitle.Position = UDim2.new(0, 18, 0, 48)

Subtitle.BackgroundTransparency = 1

Subtitle.Text = "ESP  •  AIM  •  COMBAT"
Subtitle.TextColor3 = Color3.fromRGB(130, 130, 145)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.GothamMedium

Subtitle.TextXAlignment = Enum.TextXAlignment.Left

Subtitle.Parent = Main

--========================================================
-- CLOSE
--========================================================

local Close = Instance.new("TextButton")

Close.Size = UDim2.new(0, 38, 0, 38)
Close.Position = UDim2.new(1, -50, 0, 12)

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

--========================================================
-- CONTENT
--========================================================

local Content = Instance.new("ScrollingFrame")

Content.Name = "Content"

Content.Size = UDim2.new(1, -30, 1, -90)
Content.Position = UDim2.new(0, 15, 0, 82)

Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0

Content.ScrollBarThickness = 4
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y

Content.Parent = Main

local Layout = Instance.new("UIListLayout")

Layout.Padding = UDim.new(0, 7)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

Layout.Parent = Content

--========================================================
-- SECTION
--========================================================

local function Section(text)

	local Label = Instance.new("TextLabel")

	Label.Size = UDim2.new(1, 0, 0, 28)

	Label.BackgroundTransparency = 1

	Label.Text = text
	Label.TextColor3 = Color3.fromRGB(110, 165, 255)
	Label.TextSize = 12
	Label.Font = Enum.Font.GothamBold

	Label.TextXAlignment = Enum.TextXAlignment.Left

	Label.Parent = Content

	return Label
end

--========================================================
-- TOGGLE
--========================================================

local function Toggle(name, default, callback)

	local Button = Instance.new("TextButton")

	Button.Size = UDim2.new(1, 0, 0, 45)

	Button.BackgroundColor3 = Color3.fromRGB(27, 27, 36)

	Button.BorderSizePixel = 0

	Button.Text = ""

	Button.AutoButtonColor = false

	Button.Parent = Content

	local Corner = Instance.new("UICorner")

	Corner.CornerRadius = UDim.new(0, 10)

	Corner.Parent = Button

	local Label = Instance.new("TextLabel")

	Label.Size = UDim2.new(1, -90, 1, 0)

	Label.Position = UDim2.new(0, 14, 0, 0)

	Label.BackgroundTransparency = 1

	Label.Text = name

	Label.TextColor3 = Color3.fromRGB(235, 235, 240)

	Label.TextSize = 14

	Label.Font = Enum.Font.GothamMedium

	Label.TextXAlignment = Enum.TextXAlignment.Left

	Label.Parent = Button

	local State = Instance.new("TextLabel")

	State.Size = UDim2.new(0, 55, 0, 25)

	State.Position = UDim2.new(1, -67, 0.5, -12)

	State.BorderSizePixel = 0

	State.TextSize = 11

	State.Font = Enum.Font.GothamBold

	State.Parent = Button

	local StateCorner = Instance.new("UICorner")

	StateCorner.CornerRadius = UDim.new(0, 8)

	StateCorner.Parent = State

	local value = default

	local function Update()

		if value then

			State.Text = "ON"

			State.BackgroundColor3 =
				Color3.fromRGB(60, 150, 100)

			State.TextColor3 =
				Color3.fromRGB(255, 255, 255)

		else

			State.Text = "OFF"

			State.BackgroundColor3 =
				Color3.fromRGB(70, 70, 80)

			State.TextColor3 =
				Color3.fromRGB(190, 190, 200)

		end

		pcall(callback, value)

	end

	Button.MouseButton1Click:Connect(function()

		value = not value

		Update()

	end)

	Update()

	return Button
end

--========================================================
-- VISUAL
--========================================================

Section("VISUAL")

Toggle("ESP", Settings.ESP, function(value)

	Settings.ESP = value

end)

Toggle("FOV Circle", Settings.FOV, function(value)

	Settings.FOV = value

end)

--========================================================
-- AIM
--========================================================

Section("AIM ASSIST")

Toggle("Aim Assist", Settings.AimAssist, function(value)

	Settings.AimAssist = value

end)

Toggle("Visible Check", Settings.VisibleCheck, function(value)

	Settings.VisibleCheck = value

end)

--========================================================
-- COMBAT
--========================================================

Section("COMBAT")

Toggle("Trigger Bot", Settings.TriggerBot, function(value)

	Settings.TriggerBot = value

end)

--========================================================
-- TARGET MODE
--========================================================

Section("TARGET")

local TargetButton = Instance.new("TextButton")

TargetButton.Size = UDim2.new(1, 0, 0, 45)

TargetButton.BackgroundColor3 =
	Color3.fromRGB(27, 27, 36)

TargetButton.BorderSizePixel = 0

TargetButton.Text =
	"TARGET: " .. Settings.TargetMode

TargetButton.TextColor3 =
	Color3.fromRGB(235, 235, 240)

TargetButton.TextSize = 14

TargetButton.Font = Enum.Font.GothamMedium

TargetButton.Parent = Content

local TargetCorner = Instance.new("UICorner")

TargetCorner.CornerRadius = UDim.new(0, 10)

TargetCorner.Parent = TargetButton

TargetButton.MouseButton1Click:Connect(function()

	if Settings.TargetMode == "BOTH" then

		Settings.TargetMode = "PLAYERS"

	elseif Settings.TargetMode == "PLAYERS" then

		Settings.TargetMode = "BOTS"

	else

		Settings.TargetMode = "BOTH"

	end

	TargetButton.Text =
		"TARGET: " .. Settings.TargetMode

end)

--========================================================
-- AIM SPEED
--========================================================

local SpeedButton = Instance.new("TextButton")

SpeedButton.Size = UDim2.new(1, 0, 0, 45)

SpeedButton.BackgroundColor3 =
	Color3.fromRGB(27, 27, 36)

SpeedButton.BorderSizePixel = 0

SpeedButton.Text =
	"AIM SPEED: " .. Settings.AimSpeed

SpeedButton.TextColor3 =
	Color3.fromRGB(235, 235, 240)

SpeedButton.TextSize = 14

SpeedButton.Font = Enum.Font.GothamMedium

SpeedButton.Parent = Content

local SpeedCorner = Instance.new("UICorner")

SpeedCorner.CornerRadius = UDim.new(0, 10)

SpeedCorner.Parent = SpeedButton

SpeedButton.MouseButton1Click:Connect(function()

	Settings.AimSpeed += 2

	if Settings.AimSpeed > 20 then

		Settings.AimSpeed = 2

	end

	SpeedButton.Text =
		"AIM SPEED: " .. Settings.AimSpeed

end)

--========================================================
-- FOV SIZE
--========================================================

local FOVButton = Instance.new("TextButton")

FOVButton.Size = UDim2.new(1, 0, 0, 45)

FOVButton.BackgroundColor3 =
	Color3.fromRGB(27, 27, 36)

FOVButton.BorderSizePixel = 0

FOVButton.Text =
	"FOV: " .. Settings.FOVRadius

FOVButton.TextColor3 =
	Color3.fromRGB(235, 235, 240)

FOVButton.TextSize = 14

FOVButton.Font = Enum.Font.GothamMedium

FOVButton.Parent = Content

local FOVCorner = Instance.new("UICorner")

FOVCorner.CornerRadius = UDim.new(0, 10)

FOVCorner.Parent = FOVButton

FOVButton.MouseButton1Click:Connect(function()

	Settings.FOVRadius += 25

	if Settings.FOVRadius > 300 then

		Settings.FOVRadius = 50

	end

	FOVButton.Text =
		"FOV: " .. Settings.FOVRadius

end)

--========================================================
-- DRAG MENU
--========================================================

local dragging = false
local dragStart
local startPosition

Title.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		dragging = true

		dragStart = input.Position

		startPosition = Main.Position

	end

end)

UserInputService.InputEnded:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		dragging = false

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType ~=
		Enum.UserInputType.MouseMovement
		and input.UserInputType ~=
		Enum.UserInputType.Touch then

		return
	end

	local delta =
		input.Position - dragStart

	Main.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,

		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y
	)

end)

--========================================================
-- RIGHT SHIFT
--========================================================

UserInputService.InputBegan:Connect(function(input, processed)

	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.RightShift then

		Main.Visible = not Main.Visible

	end

end)

--========================================================
-- FOV CIRCLE
--========================================================

local FOVCircle = Instance.new("Frame")

FOVCircle.Name = "FOVCircle"

FOVCircle.AnchorPoint =
	Vector2.new(0.5, 0.5)

FOVCircle.Position =
	UDim2.new(0.5, 0, 0.5, 0)

FOVCircle.Size =
	UDim2.new(
		0,
		Settings.FOVRadius * 2,
		0,
		Settings.FOVRadius * 2
	)

FOVCircle.BackgroundTransparency = 1

FOVCircle.BorderSizePixel = 0

FOVCircle.Parent = ScreenGui

local FOVCorner2 = Instance.new("UICorner")

FOVCorner2.CornerRadius =
	UDim.new(1, 0)

FOVCorner2.Parent = FOVCircle

local FOVStroke = Instance.new("UIStroke")

FOVStroke.Color =
	Color3.fromRGB(100, 170, 255)

FOVStroke.Thickness = 2

FOVStroke.Transparency = 0.2

FOVStroke.Parent = FOVCircle

--========================================================
-- ESP
--========================================================

local function RemoveESP(model)

	local data = Targets[model]

	if data then

		if data.Highlight then
			data.Highlight:Destroy()
		end

		Targets[model] = nil

	end

end

local function CreateESP(model)

	if not model then
		return
	end

	if not model:IsA("Model") then
		return
	end

	if model == LocalPlayer.Character then
		return
	end

	local humanoid =
		model:FindFirstChildOfClass("Humanoid")

	if not humanoid then
		return
	end

	-- Не создаём второй раз
	if Targets[model] then
		return
	end

	local head =
		model:FindFirstChild("Head")

	if not head then

		head =
			model:FindFirstChild(
				"HumanoidRootPart"
			)

	end

	if not head then
		return
	end

	local isPlayer =
		Players:GetPlayerFromCharacter(model) ~= nil

	local highlight = Instance.new("Highlight")

	highlight.Name = "ESP"

	highlight.Adornee = model

	highlight.DepthMode =
		Enum.HighlightDepthMode.AlwaysOnTop

	highlight.FillTransparency = 0.5

	highlight.OutlineTransparency = 0

	if isPlayer then

		highlight.FillColor =
			Color3.fromRGB(70, 150, 255)

		highlight.OutlineColor =
			Color3.fromRGB(150, 210, 255)

	else

		highlight.FillColor =
			Color3.fromRGB(255, 80, 80)

		highlight.OutlineColor =
			Color3.fromRGB(255, 180, 180)

	end

	highlight.Enabled = Settings.ESP

	highlight.Parent = ESPFolder

	Targets[model] = {

		Model = model,

		Head = head,

		Humanoid = humanoid,

		IsPlayer = isPlayer,

		Highlight = highlight,

	}

	print(
		"ESP TARGET:",
		model:GetFullName()
	)

end

--========================================================
-- SCAN WORKSPACE
--========================================================

local function ScanWorkspace()

	for _, object in ipairs(
		workspace:GetDescendants()
	) do

		if object:IsA("Model") then

			pcall(function()

				CreateESP(object)

			end)

		end

	end

end

ScanWorkspace()

--========================================================
-- NEW OBJECTS
--========================================================

workspace.DescendantAdded:Connect(function(object)

	if object:IsA("Model") then

		task.delay(0.2, function()

			pcall(function()

				CreateESP(object)

			end)

		end)

	end

end)

--========================================================
-- PLAYERS
--========================================================

local function SetupPlayer(player)

	if player == LocalPlayer then
		return
	end

	player.CharacterAdded:Connect(function(character)

		task.wait(0.5)

		pcall(function()

			CreateESP(character)

		end)

	end)

	if player.Character then

		task.wait(0.2)

		pcall(function()

			CreateESP(player.Character)

		end)

	end

end

for _, player in ipairs(
	Players:GetPlayers()
) do

	SetupPlayer(player)

end

Players.PlayerAdded:Connect(function(player)

	SetupPlayer(player)

end)

Players.PlayerRemoving:Connect(function(player)

	if player.Character then

		RemoveESP(player.Character)

	end

end)

--========================================================
-- VISIBLE CHECK
--========================================================

local function IsVisible(target)

	if not Settings.VisibleCheck then
		return true
	end

	if not target then
		return false
	end

	local head = target.Head

	if not head then
		return false
	end

	local character = LocalPlayer.Character

	local origin =
		Camera.CFrame.Position

	local direction =
		head.Position - origin

	local params =
		RaycastParams.new()

	params.FilterType =
		Enum.RaycastFilterType.Exclude

	params.FilterDescendantsInstances = {

		character,

	}

	params.IgnoreWater = true

	local result =
		workspace:Raycast(
			origin,
			direction,
			params
		)

	if not result then
		return true
	end

	return result.Instance:IsDescendantOf(
		target.Model
	)

end

--========================================================
-- TARGET MODE
--========================================================

local function TargetAllowed(target)

	if Settings.TargetMode == "BOTH" then

		return true

	elseif Settings.TargetMode == "PLAYERS" then

		return target.IsPlayer

	elseif Settings.TargetMode == "BOTS" then

		return not target.IsPlayer

	end

	return true

end

--========================================================
-- CLOSEST TARGET
--========================================================

local function GetClosestTarget()

	local center =
		Vector2.new(
			Camera.ViewportSize.X / 2,
			Camera.ViewportSize.Y / 2
		)

	local closest = nil
	local closestDistance =
		Settings.FOVRadius

	for model, target in pairs(Targets) do

		if model
			and model.Parent
			and target.Head
			and target.Humanoid
			and target.Humanoid.Health > 0
			and TargetAllowed(target) then

			local position, onScreen =
				Camera:WorldToViewportPoint(
					target.Head.Position
				)

			if onScreen then

				local screenPosition =
					Vector2.new(
						position.X,
						position.Y
					)

				local distance =
					(screenPosition - center).Magnitude

				if distance <= closestDistance then

					if IsVisible(target) then

						closestDistance = distance

						closest = target

					end

				end

			end

		end

	end

	return closest

end

--========================================================
-- AIM ASSIST
--========================================================

RunService.RenderStepped:Connect(function()

	-- FOV
	if FOVCircle then

		FOVCircle.Visible =
			Settings.FOV

		FOVCircle.Size =
			UDim2.new(
				0,
				Settings.FOVRadius * 2,
				0,
				Settings.FOVRadius * 2
			)

	end

	-- ESP
	for model, target in pairs(Targets) do

		if target.Highlight then

			target.Highlight.Enabled =
				Settings.ESP

		end

		if not model
			or not model.Parent then

			RemoveESP(model)

		end

	end

	-- AIM
	if not Settings.AimAssist then
		return
	end

	local target =
		GetClosestTarget()

	if not target then
		return
	end

	if not target.Head then
		return
	end

	local cameraPosition =
		Camera.CFrame.Position

	local targetPosition =
		target.Head.Position

	local desired =
		CFrame.lookAt(
			cameraPosition,
			targetPosition
		)

	local alpha =
		math.clamp(
			Settings.AimSpeed / 100,
			0.01,
			1
		)

	Camera.CFrame =
		Camera.CFrame:Lerp(
			desired,
			alpha
		)

end)

--========================================================
-- TRIGGER BOT
--========================================================

RunService.RenderStepped:Connect(function()

	if not Settings.TriggerBot then
		return
	end

	local target =
		GetClosestTarget()

	if not target then
		return
	end

	-- Здесь намеренно только определяем цель.
	-- Выстрел должен выполняться через оружейную
	-- систему твоей собственной игры.
end)

--========================================================
-- PERIODIC ESP SCAN
--========================================================

task.spawn(function()

	while ScreenGui.Parent do

		task.wait(2)

		pcall(function()

			ScanWorkspace()

		end)

	end

end)

--========================================================
-- FINAL
--========================================================

print("========================================")
print("COMBAT SYSTEM LOADED")
print("MENU: OK")
print("ESP: OK")
print("FOV: OK")
print("AIM SYSTEM: OK")
print("RIGHT SHIFT: SHOW/HIDE")
print("========================================")
```
