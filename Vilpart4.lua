local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local targetAnimId = "rbxassetid://7815618175"
local replacementAnimId = "rbxassetid://17124063826"

local replacementTrack = nil
local humanoid = nil
local wHeld = false

local walkAnimId = "rbxassetid://17124067635" -- Replace with your custom walk animation ID
local runAnimId = "rbxassetid://17124063826"  -- Replace with your custom run animation ID
local idleAnimId1 = "rbxassetid://17124061663" -- Idle has 2 slots, this is the first
local fallAnimId = "rbxassetid://17124061663"	
local jumpAnimId = "rbxassetid://17124061663"								
local function changeAnimations()
	local character = player.Character or player.CharacterAdded:Wait()
	local animate = character:WaitForChild("Animate")

	-- Change walk animation
	if animate:FindFirstChild("walk") and animate.walk:FindFirstChild("WalkAnim") then
		animate.walk.WalkAnim.AnimationId = walkAnimId
	end

	-- Change run animation
	if animate:FindFirstChild("run") and animate.run:FindFirstChild("RunAnim") then
		animate.run.RunAnim.AnimationId = runAnimId
	end

	-- Change run animation
	if animate:FindFirstChild("fall") and animate.fall:FindFirstChild("FallAnim") then
		animate.fall.FallAnim.AnimationId = fallAnimId
	end

	-- Change run animation
	if animate:FindFirstChild("jump") and animate.jump:FindFirstChild("jumpAnim") then
		animate.jump.JumpAnim.AnimationId = fallAnimId
	end

	-- Change idle animations (usually two idle slots)
	if animate:FindFirstChild("idle") then
		local idle = animate.idle
		if idle:FindFirstChild("Animation1") then
			idle.Animation1.AnimationId = idleAnimId1
		end
	end
end

-- Run when player spawns or respawns
player.CharacterAdded:Connect(changeAnimations)

-- If character already exists when script runs
if player.Character then
	changeAnimations()
end

-- Setup character/humanoid
local function setup()
	local character = player.Character or player.CharacterAdded:Wait()
	humanoid = character:WaitForChild("Humanoid")
end

-- Play replacement animation
local function playReplacement()
	if humanoid and not replacementTrack then
		local anim = Instance.new("Animation")
		anim.AnimationId = replacementAnimId
		replacementTrack = humanoid:LoadAnimation(anim)
		replacementTrack.Priority = Enum.AnimationPriority.Action
		replacementTrack:Play()

		replacementTrack.Stopped:Connect(function()
			replacementTrack = nil
		end)
	end
end

-- Stop replacement animation
local function stopReplacement()
	if replacementTrack then
		replacementTrack:Stop()
		replacementTrack = nil
	end
end

-- Listen for key input
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.W then
		wHeld = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W then
		wHeld = false
		stopReplacement()
	end
end)

-- Check animation each frame
RunService.RenderStepped:Connect(function()
	if not humanoid then return end

	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		if track.Animation.AnimationId == targetAnimId then
			if wHeld then
				track:Stop()
				playReplacement()
			else
				track:Stop()
				stopReplacement()
			end
		end
	end

	-- Also stop replacement if W isn't held anymore
	if not wHeld and replacementTrack then
		stopReplacement()
	end
end)

-- Setup on character spawn
player.CharacterAdded:Connect(setup)
if player.Character then
	setup()
end
