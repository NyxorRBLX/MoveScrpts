local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local moveDirection = Vector3.new(0, 0, 0)
local moveSpeed = 50
local maxSpeed = 100
local acceleration = 5
local isFlightActive = false
local moveConnection

local movementPaused = false

local boostActive = false
local boostCooldown = false
local boostDuration = 5
local boostCooldownTime = 15
local boostMultiplier = 3
local maxBoostSpeed = 400

local maxBoostActive = false
local maxBoostCooldown = false
local maxBoostCooldownTime = 15
local maxBoostAnimationId = "rbxassetid://78547941116306"

local normalBoostActive = false
local normalBoostCooldown = false
local normalBoostDuration = 5
local normalBoostCooldownTime = 15
local normalBoostMultiplier = 2

local idleAnimationId = "rbxassetid://17124063826"
local idleAnimationTrack

-- Movement logic
local function moveCharacter()
	if movementPaused then return end

	local character = LocalPlayer.Character
	if character then
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			local currentVelocity = humanoidRootPart.Velocity
			local targetVelocity = humanoidRootPart.CFrame:VectorToWorldSpace(moveDirection) * moveSpeed
			local newVelocity = currentVelocity:Lerp(targetVelocity, acceleration * RunService.RenderStepped:Wait())
			if newVelocity.Magnitude > maxSpeed then
				newVelocity = newVelocity.Unit * maxSpeed
			end
			humanoidRootPart.Velocity = newVelocity
		end
	end
end

-- Toggle flying state
local function toggleFlight()
	isFlightActive = not isFlightActive
	if isFlightActive then
		moveConnection = RunService.RenderStepped:Connect(moveCharacter)

		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local animation = Instance.new("Animation")
				animation.AnimationId = idleAnimationId
				idleAnimationTrack = humanoid:LoadAnimation(animation)
				idleAnimationTrack:Play()
			end
		end
	else
		if moveConnection then
			moveConnection:Disconnect()
			moveConnection = nil
		end
		moveDirection = Vector3.new(0, 0, 0)

		if idleAnimationTrack then
			idleAnimationTrack:Stop()
			idleAnimationTrack = nil
		end
	end
end

-- Normal boost
local function activateNormalBoost()
	if not normalBoostCooldown and not maxBoostActive then
		normalBoostActive = true
		moveSpeed = moveSpeed * normalBoostMultiplier

		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				print("Normal boost activated!")

				task.delay(normalBoostDuration, function()
					if normalBoostActive then
						normalBoostActive = false
						moveSpeed = moveSpeed / normalBoostMultiplier

						print("Normal boost ended")
						normalBoostCooldown = true
						task.delay(normalBoostCooldownTime, function()
							normalBoostCooldown = false
						end)
					end
				end)
			end
		end
	end
end

-- Max boost
local function activateMaxBoost()
	if not maxBoostCooldown and not normalBoostActive then
		maxBoostActive = true
		moveSpeed = moveSpeed * boostMultiplier
		maxSpeed = maxBoostSpeed
		acceleration = acceleration * boostMultiplier

		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local animation = Instance.new("Animation")
				animation.AnimationId = maxBoostAnimationId
				local animationTrack = humanoid:LoadAnimation(animation)
				animationTrack:Play()
				animationTrack.Priority = Enum.AnimationPriority.Action2

				task.delay(boostDuration, function()
					if maxBoostActive then
						maxBoostActive = false
						moveSpeed = moveSpeed / boostMultiplier
						maxSpeed = 100
						acceleration = acceleration / boostMultiplier
						animationTrack:Stop()

						maxBoostCooldown = true
						task.delay(maxBoostCooldownTime, function()
							maxBoostCooldown = false
						end)
					end
				end)
			end
		end
	end
end

-- Listen for damage and pause movement
local function listenForDamage()
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

	local lastHealth = humanoid.Health

	humanoid.HealthChanged:Connect(function(newHealth)
		if newHealth < lastHealth then
			movementPaused = true
			task.delay(4.5, function()
				movementPaused = false
			end)
		end
		lastHealth = newHealth
	end)
end

-- Hook into character loading
LocalPlayer.CharacterAdded:Connect(function()
	task.wait(1)
	listenForDamage()
end)

if LocalPlayer.Character then
	listenForDamage()
end

-- Input began
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.P then
		toggleFlight()
	elseif isFlightActive then
		if input.KeyCode == Enum.KeyCode.W then
			moveDirection = moveDirection + Vector3.new(0, 0, -1)
		elseif input.KeyCode == Enum.KeyCode.A then
			moveDirection = moveDirection + Vector3.new(-1, 0, 0)
		elseif input.KeyCode == Enum.KeyCode.S then
			moveDirection = moveDirection + Vector3.new(0, 0, 1)
		elseif input.KeyCode == Enum.KeyCode.D then
			moveDirection = moveDirection + Vector3.new(1, 0, 0)
		elseif input.KeyCode == Enum.KeyCode.Space then
			moveDirection = moveDirection + Vector3.new(0, 1, 0)
		elseif input.KeyCode == Enum.KeyCode.C then
			moveDirection = moveDirection + Vector3.new(0, -1, 0)
		elseif input.KeyCode == Enum.KeyCode.E then
			activateNormalBoost()
		elseif input.KeyCode == Enum.KeyCode.R then
			activateMaxBoost()
		end
	end
end)

-- Input ended
UserInputService.InputEnded:Connect(function(input)
	if not isFlightActive then return end

	if input.KeyCode == Enum.KeyCode.W then
		moveDirection = moveDirection - Vector3.new(0, 0, -1)
	elseif input.KeyCode == Enum.KeyCode.A then
		moveDirection = moveDirection - Vector3.new(-1, 0, 0)
	elseif input.KeyCode == Enum.KeyCode.S then
		moveDirection = moveDirection - Vector3.new(0, 0, 1)
	elseif input.KeyCode == Enum.KeyCode.D then
		moveDirection = moveDirection - Vector3.new(1, 0, 0)
	elseif input.KeyCode == Enum.KeyCode.Space then
		moveDirection = moveDirection - Vector3.new(0, 1, 0)
	elseif input.KeyCode == Enum.KeyCode.C then
		moveDirection = moveDirection - Vector3.new(0, -1, 0)
	elseif input.KeyCode == Enum.KeyCode.E then
		if normalBoostActive then
			normalBoostActive = false
			moveSpeed = moveSpeed / normalBoostMultiplier
			print("Normal boost ended")
		end
	elseif input.KeyCode == Enum.KeyCode.R then
		if maxBoostActive then
			maxBoostActive = false
			moveSpeed = moveSpeed / boostMultiplier
			maxSpeed = 100
			acceleration = acceleration / boostMultiplier
		end
	end
end)
RunService.Heartbeat:Connect(function()
	local character = LocalPlayer.Character
	if character then
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if rootPart then
			rootPart.Anchored = movementPaused
		end
	end
end)
