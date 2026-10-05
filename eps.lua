```lua
--========================================================
-- ESP + AIM + VISIBLE CHECK
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--========================================================
-- SETTINGS
--========================================================

local ESP_ENABLED = true
local AIM_ENABLED = false
local VISIBLE_CHECK = true

local AIM_SPEED = 8
local FOV_RADIUS = 150

local TARGET_MODE = "BOTH"
-- BOTH / PLAYERS / BOTS

--========================================================
-- GUI
--========================================================

local oldGui = PlayerGui:FindFirstChild("BeautifulESPMenu")

if oldGui then
	oldGui:Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "BeautifulESPMenu"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 999
Gui.Parent = PlayerGui

--========================================================
-- MAIN MENU
--========================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(390, 500)
Main.Position = UDim2.new(0.5, -195, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(17, 18, 24)
Main.BorderSizePixel = 0
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(75, 80, 105)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.2
MainStroke.Parent = Main

--========================================================
-- HEADER
--========================================================

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 65)
Top.BackgroundColor3 = Color3.fromRGB(24, 25, 34)
Top.BorderSizePixel = 0
Top.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 18)
TopCorner.Parent = Top

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 0, 30)
Title.Position = UDim2.fromOffset(20, 8)
Title.BackgroundTransparency = 1
Title.Text = "ESP  •  AIM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -80, 0, 20)
Subtitle.Position = UDim2.fromOffset(21, 36)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Visual & Aim Settings"
Subtitle.TextColor3 = Color3.fromRGB(145, 148, 165)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Top

--========================================================
-- CLOSE
--========================================================

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(38, 38)
Close.Position = UDim2.new(1, -50, 0, 13)
Close.BackgroundColor3 = Color3.fromRGB(35, 36, 47)
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(230, 230, 235)
Close.TextSize = 25
Close.Font = Enum.Font.GothamBold
Close.AutoButtonColor = false
Close.Parent = Top

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = Close

--========================================================
-- OPEN BUTTON
--========================================================

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.fromOffset(65, 65)
OpenButton.Position = UDim2.fromOffset(20, 250)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 32, 43)
OpenButton.Text = "ESP"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextSize = 17
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.AutoButtonColor = false
OpenButton.Parent = Gui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 16)
OpenCorner.Parent = OpenButton

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(90, 95, 125)
OpenStroke.Thickness = 1.5
OpenStroke.Parent = OpenButton

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
	OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
	Main.Visible = true
	OpenButton.Visible = false
end)

--========================================================
-- CONTENT
--========================================================

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -30, 1, -80)
Content.Position = UDim2.fromOffset(15, 72)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 4
Content.ScrollBarImageTransparency = 0.35
Content.CanvasSize = UDim2.new(0, 0, 0, 620)
Content.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = Content

--========================================================
-- GUI FUNCTIONS
--========================================================

local function createSection(text)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -5, 0, 25)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(115, 120, 145)
	label.TextSize = 12
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = Content

	return label
end

local function createToggle(text, default, callback)

	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, -5, 0, 50)
	Button.BackgroundColor3 = Color3.fromRGB(27, 29, 38)
	Button.BorderSizePixel = 0
	Button.AutoButtonColor = false
	Button.Text = ""
	Button.Parent = Content

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 12)
	Corner.Parent = Button

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, -90, 1, 0)
	Label.Position = UDim2.fromOffset(15, 0)
	Label.BackgroundTransparency = 1
	Label.Text = text
	Label.TextColor3 = Color3.fromRGB(235, 235, 240)
	Label.TextSize = 14
	Label.Font = Enum.Font.GothamMedium
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = Button

	local State = Instance.new("TextLabel")
	State.Size = UDim2.fromOffset(55, 28)
	State.Position = UDim2.new(1, -70, 0.5, -14)
	State.TextColor3 = Color3.fromRGB(255, 255, 255)
	State.TextSize = 11
	State.Font = Enum.Font.GothamBold
	State.Parent = Button

	local StateCorner = Instance.new("UICorner")
	StateCorner.CornerRadius = UDim.new(0, 8)
	StateCorner.Parent = State

	local enabled = default

	local function update()

		State.Text = enabled and "ON" or "OFF"

		if enabled then
			State.BackgroundColor3 = Color3.fromRGB(60, 190, 120)
		else
			State.BackgroundColor3 = Color3.fromRGB(55, 57, 68)
		end

		-- Ошибка внутри функции теперь не ломает GUI
		pcall(function()
			callback(enabled)
		end)
	end

	Button.MouseButton1Click:Connect(function()
		enabled = not enabled
		update()
	end)

	update()

	return Button
end

local function createButton(text, callback)

	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, -5, 0, 46)
	Button.BackgroundColor3 = Color3.fromRGB(27, 29, 38)
	Button.BorderSizePixel = 0
	Button.Text = text
	Button.TextColor3 = Color3.fromRGB(235, 235, 240)
	Button.TextSize = 14
	Button.Font = Enum.Font.GothamMedium
	Button.AutoButtonColor = false
	Button.Parent = Content

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 11)
	Corner.Parent = Button

	Button.MouseButton1Click:Connect(function()
		pcall(callback)
	end)

	return Button
end

--========================================================
-- VISUAL
--========================================================

createSection("VISUAL")

createToggle("ESP", ESP_ENABLED, function(value)
	ESP_ENABLED = value
end)

--========================================================
-- AIM
--========================================================

createSection("AIM ASSIST")

createToggle("Aim Assist", AIM_ENABLED, function(value)
	AIM_ENABLED = value
end)

createToggle("Visible Check", VISIBLE_CHECK, function(value)
	VISIBLE_CHECK = value
end)

--========================================================
-- TARGETS
--========================================================

createSection("TARGETS")

local TargetButton

TargetButton = createButton("Targets: BOTH", function()

	if TARGET_MODE == "BOTH" then
		TARGET_MODE = "PLAYERS"

	elseif TARGET_MODE == "PLAYERS" then
		TARGET_MODE = "BOTS"

	else
		TARGET_MODE = "BOTH"
	end

	TargetButton.Text = "Targets: " .. TARGET_MODE
end)

--========================================================
-- AIM SPEED
--========================================================

createSection("AIM SPEED")

local SpeedButton

SpeedButton = createButton("Aim Speed: " .. AIM_SPEED, function()

	AIM_SPEED = AIM_SPEED + 1

	if AIM_SPEED > 20 then
		AIM_SPEED = 1
	end

	SpeedButton.Text = "Aim Speed: " .. AIM_SPEED
end)

--========================================================
-- FOV
--========================================================

createSection("FOV")

local FOVButton

FOVButton = createButton("FOV Radius: " .. FOV_RADIUS, function()

	FOV_RADIUS = FOV_RADIUS + 25

	if FOV_RADIUS > 300 then
		FOV_RADIUS = 50
	end

	FOVButton.Text = "FOV Radius: " .. FOV_RADIUS
end)

--========================================================
-- ESP SYSTEM
--========================================================

local ESP_FOLDER = Instance.new("Folder")
ESP_FOLDER.Name = "ClientESP"
ESP_FOLDER.Parent = workspace

local ESP_OBJECTS = {}

local function removeESP(character)

	if not character then
		return
	end

	local object = ESP_OBJECTS[character]

	if object then

		pcall(function()
			object:Destroy()
		end)

		ESP_OBJECTS[character] = nil
	end
end

local function createESP(character, color)

	if not character then
		return
	end

	if character == LocalPlayer.Character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not humanoid then
		return
	end

	removeESP(character)

	local highlight = Instance.new("Highlight")

	highlight.Name = "ESPHighlight"
	highlight.Adornee = character
	highlight.FillColor = color
	highlight.OutlineColor = Color3.fromRGB(255, 255, 255)

	highlight.FillTransparency = 0.55
	highlight.OutlineTransparency = 0

	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

	highlight.Parent = ESP_FOLDER

	ESP_OBJECTS[character] = highlight
end

--========================================================
-- PLAYER ESP
--========================================================

local function setupPlayer(player)

	if player == LocalPlayer then
		return
	end

	local function setupCharacter(character)

		task.wait(0.5)

		pcall(function()
			createESP(
				character,
				Color3.fromRGB(70, 150, 255)
			)
		end)
	end

	if player.Character then
		task.spawn(setupCharacter, player.Character)
	end

	player.CharacterAdded:Connect(setupCharacter)
end

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)

Players.PlayerRemoving:Connect(function(player)

	pcall(function()

		if player.Character then
			removeESP(player.Character)
		end

	end)

end)

--========================================================
-- BOT DETECTION
--========================================================

local function isBot(model)

	if not model then
		return false
	end

	if not model:IsA("Model") then
		return false
	end

	if Players:GetPlayerFromCharacter(model) then
		return false
	end

	local humanoid = model:FindFirstChildOfClass("Humanoid")

	if not humanoid then
		return false
	end

	local head = model:FindFirstChild("Head")

	if not head then
		return false
	end

	return true
end

local function scanBots()

	for _, object in ipairs(workspace:GetDescendants()) do

		if isBot(object) then

			if not ESP_OBJECTS[object] then

				pcall(function()

					createESP(
						object,
						Color3.fromRGB(255, 75, 75)
					)

				end)

			end
		end
	end
end

task.spawn(function()

	while task.wait(2) do

		pcall(scanBots)

	end

end)

--========================================================
-- ESP UPDATE
--========================================================

RunService.RenderStepped:Connect(function()

	pcall(function()

		for character, object in pairs(ESP_OBJECTS) do

			if object then

				object.Enabled = ESP_ENABLED

				if character and character.Parent then

					if Players:GetPlayerFromCharacter(character) then

						object.FillColor =
							Color3.fromRGB(70, 150, 255)

					else

						object.FillColor =
							Color3.fromRGB(255, 75, 75)

					end

				else

					ESP_OBJECTS[character] = nil

				end
			end
		end

	end)

end)

--========================================================
-- FOV CIRCLE
--========================================================

local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "FOVCircle"
FOVCircle.BackgroundTransparency = 1
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Position = UDim2.fromScale(0.5, 0.5)
FOVCircle.Size = UDim2.fromOffset(
	FOV_RADIUS * 2,
	FOV_RADIUS * 2
)
FOVCircle.Visible = false
FOVCircle.Parent = Gui

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = FOVCircle

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = Color3.fromRGB(90, 170, 255)
CircleStroke.Thickness = 2
CircleStroke.Transparency = 0.15
CircleStroke.Parent = FOVCircle

--========================================================
-- AIM
--========================================================

local Camera = workspace.CurrentCamera

local function getHead(character)

	if not character then
		return nil
	end

	local head = character:FindFirstChild("Head")

	if head and head:IsA("BasePart") then
		return head
	end

	return nil
end

local function isAlive(character)

	if not character then
		return false
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not humanoid then
		return false
	end

	return humanoid.Health > 0
end

--========================================================
-- SAFE VISIBLE CHECK
--========================================================

local function checkVisible(head)

	-- Если Visible Check выключен,
	-- цель автоматически считается видимой
	if not VISIBLE_CHECK then
		return true
	end

	if not head then
		return false
	end

	if not head.Parent then
		return false
	end

	if not Camera then
		return false
	end

	local success, result = pcall(function()

		local origin = Camera.CFrame.Position

		local direction =
			head.Position - origin

		local params = RaycastParams.new()

		params.FilterType =
			Enum.RaycastFilterType.Exclude

		local filter = {}

		if LocalPlayer.Character then
			table.insert(
				filter,
				LocalPlayer.Character
			)
		end

		params.FilterDescendantsInstances = filter
		params.IgnoreWater = true

		return workspace:Raycast(
			origin,
			direction,
			params
		)

	end)

	-- Если проверка по какой-то причине
	-- выдала ошибку — просто не выбираем цель.
	if not success then
		return false
	end

	-- Ничего между камерой и целью нет
	if result == nil then
		return true
	end

	-- Луч попал непосредственно в модель цели
	local targetCharacter = head.Parent

	if result.Instance:IsDescendantOf(targetCharacter) then
		return true
	end

	return false
end

--========================================================
-- TARGET FILTER
--========================================================

local function allowedTarget(character)

	if not character then
		return false
	end

	local player = Players:GetPlayerFromCharacter(character)

	if player then

		if player == LocalPlayer then
			return false
		end

		if TARGET_MODE == "BOTS" then
			return false
		end

		return true
	end

	if TARGET_MODE == "PLAYERS" then
		return false
	end

	return isBot(character)
end

--========================================================
-- FIND TARGET
--========================================================

local function getClosestTarget()

	if not Camera then
		return nil
	end

	local center = Vector2.new(
		Camera.ViewportSize.X / 2,
		Camera.ViewportSize.Y / 2
	)

	local closestTarget = nil
	local closestDistance = FOV_RADIUS

	for character, object in pairs(ESP_OBJECTS) do

		if character
			and character.Parent
			and object
			and allowedTarget(character)
			and isAlive(character) then

			local head = getHead(character)

			if head then

				local screenPosition, onScreen =
					Camera:WorldToViewportPoint(
						head.Position
					)

				if onScreen then

					local point = Vector2.new(
						screenPosition.X,
						screenPosition.Y
					)

					local distance =
						(point - center).Magnitude

					if distance <= closestDistance then

						-- VISIBLE CHECK
						if checkVisible(head) then

							closestDistance = distance
							closestTarget = head

						end
					end
				end
			end
		end
	end

	return closestTarget
end

--========================================================
-- AIM LOOP
--========================================================

RunService.RenderStepped:Connect(function()

	-- ВАЖНО:
	-- Любая ошибка Aim НЕ ломает GUI/ESP
	pcall(function()

		Camera = workspace.CurrentCamera

		if not Camera then
			return
		end

		-- FOV
		FOVCircle.Size = UDim2.fromOffset(
			FOV_RADIUS * 2,
			FOV_RADIUS * 2
		)

		FOVCircle.Visible = AIM_ENABLED

		if not AIM_ENABLED then
			return
		end

		local target = getClosestTarget()

		if not target then
			return
		end

		local cameraPosition =
			Camera.CFrame.Position

		local desired =
			CFrame.lookAt(
				cameraPosition,
				target.Position
			)

		local smooth =
			math.clamp(
				AIM_SPEED / 20,
				0.02,
				1
			)

		Camera.CFrame =
			Camera.CFrame:Lerp(
				desired,
				smooth
			)

	end)

end)

--========================================================
-- DRAG MENU
--========================================================

local dragging = false
local dragStart
local startPosition

Top.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		dragging = true

		dragStart = input.Position
		startPosition = Main.Position

		input.Changed:Connect(function()

			if input.UserInputState ==
				Enum.UserInputState.End then

				dragging = false

			end

		end)
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

UserInputService.InputBegan:Connect(function(
	input,
	processed
)

	if processed then
		return
	end

	if input.KeyCode ==
		Enum.KeyCode.RightShift then

		Main.Visible =
			not Main.Visible

		OpenButton.Visible =
			not Main.Visible

	end
end)

--========================================================
-- START
--========================================================

print("ESP + AIM + VISIBLE CHECK: LOADED")
```
