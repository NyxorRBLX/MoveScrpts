local CONFIG = {
	FrontDashBoostSpeed = 320,  -- front dash boost speed of Crimson Flash
	SecondFrontDashBoostSpeed = 160, -- second front dash boost for Crimson Flash
	BackDashBoostSpeed = 20, -- second front dash boost for Crimson Flash
	BoostDuration = .3,        -- Duration of first boost
}
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Hotbar = player.PlayerGui.Hotbar.Backpack.Hotbar
local UltBar = player.PlayerGui.ScreenGui.MagicHealth.Health.Bar.Bar
local UltGlow = player.PlayerGui.ScreenGui.MagicHealth.Health.Glow
local UltG = player.PlayerGui.ScreenGui.MagicHealth.Ult
local UltText = player.PlayerGui.ScreenGui.MagicHealth.TextLabel
UltText.Text = "TRULY INVINCIBLE"
UltText.TextColor3 = Color3.fromRGB(255, 226, 24)
UltText.Position = UDim2.new(UltText.Position.X.Scale, UltText.Position.X.Offset, UltText.Position.Y.Scale, 22)
UltText.TextSize = 20
UltText.TextLabel.TextSize = 20
UltG.TextSize = 0
UltG.TextLabel.TextSize = 0
local darkBlue = Color3.fromRGB(0, 102, 204) -- Blue
local lightBlue = Color3.fromRGB(32, 118, 255) -- Light Blue
UltBar.ImageColor3 = lightBlue
UltGlow.ImageColor3 = Color3.fromRGB(111, 111, 255)

local tweenInfo = TweenInfo.new(
	2.5, -- duration
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut,
	-1, -- loop forever
	true -- reverse
)

local pulseTween = TweenService:Create(UltBar, tweenInfo, {
	ImageColor3 = lightBlue
})

pulseTween:Play()

local skillOne = Hotbar["1"].Base
local skillTwo = Hotbar["2"].Base
local skillThree = Hotbar["3"].Base
local skillFour = Hotbar["4"].Base


skillOne.ToolName.Text = "Viltrum Smash"
skillTwo.ToolName.Text = "Flow Barrage"
skillThree.ToolName.Text = "Omni Kick"
skillFour.ToolName.Text = "Knuckle Maker"

-- SKILL 1 --

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local SWAP_DELAY = 0.7 
local PLAY_DURATION = .2

local isAnimationSequenceActive = false
local idleAnimationTrack
local function playAnimationSequence(player)
	if isAnimationSequenceActive then return end
	isAnimationSequenceActive = true

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end


	local animations = {
		new1 = Instance.new("Animation"),
		new2 = Instance.new("Animation")
	}
	local sounds = {
		S1 = Instance.new("Sound", character),
		S2 = Instance.new("Sound", character)
	}

	sounds.S1.SoundId = "rbxassetid://117605899760975" 
	sounds.S2.SoundId = "rbxassetid://5278196952"

	animations.new1.AnimationId = "rbxassetid://12983333733"
	animations.new2.AnimationId = "rbxassetid://17278415853"

	local animTracks = {
		new1 = humanoid:LoadAnimation(animations.new1),
		new2 = humanoid:LoadAnimation(animations.new2)
	}

	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end


	task.spawn(function()
		animTracks.new1:Play()
		sounds.S1:Play()
		animTracks.new1.TimePosition = 4
		animTracks.new1:AdjustSpeed(2.8)
		task.wait(0.3)
		animTracks.new2:Play()
		animTracks.new2.TimePosition = 11
		animTracks.new2:AdjustSpeed(2.4)
		animTracks.new1:Stop()
		task.wait(.8)
		task.wait(0.5)
		animTracks.new2:Stop()
		task.wait(PLAY_DURATION)
		isAnimationSequenceActive = false

		for _, track in pairs(animTracks) do
			track:Stop()
		end
	end)
end


local function onAnimationPlayed(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://10468665991" then
		playAnimationSequence(Players.LocalPlayer)
	end
end


local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.AnimationPlayed:Connect(onAnimationPlayed)

-- SKILL 3 --


local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local SWAP_DELAY = 0.7 
local PLAY_DURATION = .2

local isAnimationSequenceActive = false
local rootLockConnection = nil

local function playAnimationSequence3(player)
	if isAnimationSequenceActive then return end
	isAnimationSequenceActive = true

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")

	if not humanoid or not humanoidRootPart or not torso then return end

	local animations = {
		drop = Instance.new("Animation"),
		drop1 = Instance.new("Animation")
	}
	local sounds = {
		S1 = Instance.new("Sound", character),
		S2 = Instance.new("Sound", character)
	}

	sounds.S1.SoundId = "rbxassetid://90992723091327"
	sounds.S2.SoundId = "rbxassetid://8187671085"

	animations.drop.AnimationId = "rbxassetid://17420452843"
	animations.drop1.AnimationId = "rbxassetid://12832505612"

	local animTracks = {
		Drop = humanoid:LoadAnimation(animations.drop),
		Drop1 = humanoid:LoadAnimation(animations.drop1),
	}

	-- Stop all current animations
	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end

	-- LockOn2 functionality
	local function LockOn2()
		local nearestRootPart
		local nearestDistance = 145

		for _, otherPlayer in ipairs(Players:GetPlayers()) do
			if otherPlayer ~= player then
				local otherCharacter = otherPlayer.Character
				if otherCharacter then
					local otherHumanoidRootPart = otherCharacter:FindFirstChild("HumanoidRootPart")
					if otherHumanoidRootPart then
						local distance = (humanoidRootPart.Position - otherHumanoidRootPart.Position).Magnitude
						if distance < nearestDistance then
							nearestDistance = distance
							nearestRootPart = otherHumanoidRootPart
						end
					end
				end
			end
		end

		if nearestRootPart then
			local targetPosition = nearestRootPart.Position - (nearestRootPart.CFrame.LookVector * -3)
			local targetCFrame = CFrame.new(targetPosition)

			local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
			local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})

			tween:Play()
			tween.Completed:Connect(function()
				humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, nearestRootPart.Position + nearestRootPart.CFrame.LookVector)
				humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			end)
		end
	end

	-- Save initial positions


	-- Animation sequence
	task.spawn(function()
		animTracks.Drop1:Play()
		sounds.S1:Play()
		animTracks.Drop1.TimePosition = 1
		LockOn2()
		task.wait(0.1)
		sounds.S2:Play()
		task.wait(0.2)
		animTracks.Drop1:Stop()
		animTracks.Drop:Play()
		animTracks.Drop.TimePosition = 16
		animTracks.Drop:AdjustSpeed(1.5)
		task.wait(1 + PLAY_DURATION)

		for _, track in pairs(animTracks) do
			track:Stop()
		end

		isAnimationSequenceActive = false
		for _, track in pairs(animTracks) do
			track:Stop()
		end
	end)
end

-- Detect animation play
local function onAnimationPlayed3(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://10471336737" then
		playAnimationSequence3(Players.LocalPlayer)
	end
end

-- Setup
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.AnimationPlayed:Connect(onAnimationPlayed3)


-- SKILL 4 --

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local SWAP_DELAY = 1.6 
local PLAY_DURATION = .2

local isAnimationSequenceActive = false
local idleAnimationTrack
local function playAnimationSequence2(player)
	if isAnimationSequenceActive then return end
	isAnimationSequenceActive = true

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end


	local animations = {
		new1 = Instance.new("Animation"),
		new2 = Instance.new("Animation"),
		new3 = Instance.new("Animation")
	}
	local sounds = {
		S1 = Instance.new("Sound", character),
		S2 = Instance.new("Sound", character)
	}

	sounds.S1.SoundId = "rbxassetid://72892830917317"
	sounds.S2.SoundId = "rbxassetid://5278196952"

	animations.new1.AnimationId = "rbxassetid://18179181663"
	animations.new2.AnimationId = "rbxassetid://13927612951"
	animations.new3.AnimationId = "rbxassetid://16944265635"

	local animTracks = {
		new1 = humanoid:LoadAnimation(animations.new1),
		new2 = humanoid:LoadAnimation(animations.new2),
		new3 = humanoid:LoadAnimation(animations.new3)
	}

	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end

	-- dash here !!!!!!

	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end


	task.spawn(function()
		animTracks.new3:Play()
		animTracks.new3:AdjustSpeed(1)
		task.wait(0.3)
		animTracks.new3:Stop()
		animTracks.new1:Play()
		sounds.S1:Play()
		animTracks.new1.TimePosition = 0.2
		task.wait(0.9)
		animTracks.new2:Play()
		animTracks.new2:AdjustSpeed(.8)
		animTracks.new2.TimePosition = 2
		animTracks.new1:Stop()
		task.wait(.7)
		animTracks.new2:Stop()
		task.wait(PLAY_DURATION)
		isAnimationSequenceActive = false

		for _, track in pairs(animTracks) do
			track:Stop()
		end
	end)
end


local function onAnimationPlayed2(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://12510170988" then
		playAnimationSequence2(Players.LocalPlayer)
	end
end


local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.AnimationPlayed:Connect(onAnimationPlayed2)


-- SKILL 2 --

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local SWAP_DELAY = 1.6 
local PLAY_DURATION = .2

local isAnimationSequenceActive = false
local idleAnimationTrack
local function playAnimationSequence4(player)
	if isAnimationSequenceActive then return end
	isAnimationSequenceActive = true

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end


	local animations = {
		new1 = Instance.new("Animation"),
		new2 = Instance.new("Animation")
	}
	

	local S1 = Instance.new("Sound", character)
	local S2 = Instance.new("Sound", character)


	S1.SoundId = "rbxassetid://87633021650739"
	S2.SoundId = "rbxassetid://7837530737"

	animations.new1.AnimationId = "rbxassetid://13560306510"
	animations.new2.AnimationId = "rbxassetid://15090141089"

	local animTracks = {
		new1 = humanoid:LoadAnimation(animations.new1),
		new2 = humanoid:LoadAnimation(animations.new2)
	}

	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end

	task.spawn(function()
		animTracks.new1:Play()
		S1:Play()
		animTracks.new1:AdjustSpeed(2)
		task.wait(0.34)
		S2:Play()
		animTracks.new1:Stop()
		animTracks.new2:Play()
		animTracks.new2:AdjustSpeed(20)
		task.wait(1.1)
		animTracks.new2:Stop()
			
		task.wait(PLAY_DURATION)
		isAnimationSequenceActive = false

		for _, track in pairs(animTracks) do
			track:Stop()
		end
	end)
end


local function onAnimationPlayed4(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://10466974800" then
		playAnimationSequence4(Players.LocalPlayer)
	end
end


local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.AnimationPlayed:Connect(onAnimationPlayed4)
