local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local isLockOnEnabled = false
local targetHumanoidRootPart = nil
local smoothFactor = 0.9
local Char = LocalPlayer.Character
-- Cooldown Settings
local lastTeleportTime = 0
local TELEPORT_COOLDOWN = 12
local teleportOnCooldown = false

-- GUI Setup
local cooldownGui = Instance.new("ScreenGui")
cooldownGui.Name = "TeleportCooldownGUI"
cooldownGui.ResetOnSpawn = false
cooldownGui.Parent = PlayerGui

local cooldownLabel = Instance.new("TextLabel")
cooldownLabel.Size = UDim2.new(0, 200, 0, 50)
cooldownLabel.Position = UDim2.new(1, -210, 1, -60)
cooldownLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
cooldownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
cooldownLabel.TextScaled = true
cooldownLabel.Font = Enum.Font.GothamBold
cooldownLabel.Text = ""
cooldownLabel.Visible = false
cooldownLabel.Parent = cooldownGui

-- Teleport sound
local teleportSound = Instance.new("Sound", Char)
teleportSound.SoundId = "rbxassetid://3077287610" -- Replace with your sound ID
teleportSound.Volume = 1
teleportSound.Name = "TeleportSound"


-- Cooldown ready sound
local cooldownReadySound = Instance.new("Sound", Char)
cooldownReadySound.SoundId = "rbxassetid://9126073011" -- Replace with your sound ID
cooldownReadySound.Volume = 1
cooldownReadySound.Name = "CooldownReadySound"

local function findNearestHumanoidRootPart()
	local character = LocalPlayer.Character
	if not character then return nil end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then return nil end

	local nearestDistance = math.huge
	local nearestHumanoidRootPart = nil

	for _, player in Players:GetPlayers() do
		if player ~= LocalPlayer then
			local otherCharacter = player.Character
			if otherCharacter then
				local otherHumanoidRootPart = otherCharacter:FindFirstChild("HumanoidRootPart")
				if otherHumanoidRootPart then
					local distance = (humanoidRootPart.Position - otherHumanoidRootPart.Position).Magnitude
					if distance < nearestDistance then
						nearestDistance = distance
						nearestHumanoidRootPart = otherHumanoidRootPart
					end
				end
			end
		end
	end

	return nearestHumanoidRootPart
end

local function toggleLockOn()
	isLockOnEnabled = not isLockOnEnabled
	if isLockOnEnabled then
		targetHumanoidRootPart = findNearestHumanoidRootPart()
	else
		targetHumanoidRootPart = nil
	end
end

local function updateLockOn()
	if isLockOnEnabled and targetHumanoidRootPart then
		local character = LocalPlayer.Character
		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				humanoidRootPart.CFrame = humanoidRootPart.CFrame:Lerp(
					CFrame.lookAt(humanoidRootPart.Position, targetHumanoidRootPart.Position),
					smoothFactor
				)
				Camera.CFrame = Camera.CFrame:Lerp(
					CFrame.lookAt(Camera.CFrame.Position, targetHumanoidRootPart.Position),
					smoothFactor
				)
			end
		end
	end
end

local function updateCooldownUI()
	while teleportOnCooldown do
		local timeLeft = math.ceil(TELEPORT_COOLDOWN - (tick() - lastTeleportTime))
		if timeLeft <= 0 then
			teleportOnCooldown = false
			cooldownLabel.Visible = false
			cooldownReadySound:Play()
		else
			cooldownLabel.Text = "Teleport Ready in: " .. timeLeft .. "s"
			cooldownLabel.Visible = true
		end
		wait(1)
	end
end

local function teleportBehindTarget()
	if not (isLockOnEnabled and targetHumanoidRootPart) then return end

	local currentTime = tick()
	if currentTime - lastTeleportTime < TELEPORT_COOLDOWN then
		warn("Teleport is on cooldown!")
		return
	end

	lastTeleportTime = currentTime
	teleportOnCooldown = true
	task.spawn(updateCooldownUI)

	local character = LocalPlayer.Character
	if not character then return end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then return end

	local targetPos = targetHumanoidRootPart.Position
	local backOffset = targetHumanoidRootPart.CFrame.LookVector * -3
	local newPos = targetPos + backOffset

	local newCFrame = CFrame.new(newPos, targetHumanoidRootPart.Position)
	humanoidRootPart.CFrame = newCFrame

	-- Play teleport sound
	teleportSound:Play()
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.L then
		toggleLockOn()
	elseif input.KeyCode == Enum.KeyCode.T then
		teleportBehindTarget()
	end
end)

RunService.RenderStepped:Connect(updateLockOn)
