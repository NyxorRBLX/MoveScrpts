local CONFIG = {
	FrontDashBoostSpeed = 120,  -- front dash boost speed of Crimson Flash
	SecondFrontDashBoostSpeed = 160, -- second front dash boost for Crimson Flash
	BoostDuration = .3,        -- Duration of first boost
}


local skillOne = game.Players.LocalPlayer.PlayerGui.Main.Moveset['Cursed Strikes'].ItemName
local skillTwo = game.Players.LocalPlayer.PlayerGui.Main.Moveset['Crushing Blow'].ItemName
local skillThree = game.Players.LocalPlayer.PlayerGui.Main.Moveset['Divergent Fist'].ItemName
local skillThreeTip = game.Players.LocalPlayer.PlayerGui.Main.Moveset['Divergent Fist'].Tip
local skillFour = game.Players.LocalPlayer.PlayerGui.Main.Moveset['Manji Kick'].ItemName

local ultTitle = game.Players.LocalPlayer.PlayerGui.Main.Ultimate.Title
local UltText = game.Players.LocalPlayer.PlayerGui.Main.Ultimate.Bar.Ready.Ready
local UIGradientCustom = game.Players.LocalPlayer.PlayerGui.Main.Ultimate.Bar.Fill.UIGradient
UltText.Text = "WARNING : NO ULT"

UIGradientCustom.Color = ColorSequence.new(Color3.fromRGB(255, 35, 39), Color3.fromRGB(255, 55, 115))

game.Players.LocalPlayer.PlayerGui.Main.Ultimate.Bar.Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local TweenService = game:GetService("TweenService")
local bar = game.Players.LocalPlayer.PlayerGui.Main.Ultimate.Bar.Fill

local darkGrey = Color3.fromRGB(255, 255, 255)
local white = Color3.fromRGB(255, 255, 194)

local tweenInfo = TweenInfo.new(
	3,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut, 
	-1, 
	true 
)

local tweenbar = TweenService:Create(bar, tweenInfo, {BackgroundColor3 = darkGrey})

tweenbar:Play()

skillOne.Text = "Kings Combo"
skillTwo.Text = "Chest Puncture"
skillThree.Text = "Crimson Flash"
skillThreeTip.Text = "Extender"
skillFour.Text = "Epitath"
ultTitle.Text = ""
-- SKILL 1 --

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChatService = game:GetService("Chat")

local cursedStrikesANIM = ReplicatedStorage.Animations.Itadori.CursedStrike
local wideStrikeANIM = ReplicatedStorage.Animations.Todo.Dreams
local overLuckANIM = ReplicatedStorage.Animations.Mahito.FaceBlitz
local bloodEdgeANIM = ReplicatedStorage.Animations.Choso.BloodEdge

local SWAP_DELAY = 0.7 
local PLAY_DURATION = .6 

local isAnimationSequenceActive = false


local function playAnimationSequence(player)
	if isAnimationSequenceActive then return end
	isAnimationSequenceActive = true

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	
	local animations = {
		wideStrike = Instance.new("Animation"),
		overLuck = Instance.new("Animation"),
		bloodedge = Instance.new("Animation")
	}
	local sounds = {
		S1 = Instance.new("Sound", character),
		S2 = Instance.new("Sound", character)
	}
	
	sounds.S1.SoundId = "rbxassetid://6665056047"
	sounds.S2.SoundId = "rbxassetid://5278196952"
	
	animations.wideStrike.AnimationId = wideStrikeANIM.AnimationId
	animations.overLuck.AnimationId = overLuckANIM.AnimationId
	animations.bloodedge.AnimationId = bloodEdgeANIM.AnimationId

	
	local animTracks = {
		wideStrike = humanoid:LoadAnimation(animations.wideStrike),
		overLuck = humanoid:LoadAnimation(animations.overLuck),
		bloodedge = humanoid:LoadAnimation(animations.bloodedge)
	}

	
	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end

	task.spawn(function()
		animTracks.overLuck:Play()
		sounds.S1:Play()
		animTracks.overLuck.TimePosition = 0
		animTracks.overLuck:AdjustSpeed(1.2)
		task.wait(0.6)
		sounds.S2:Play()
		animTracks.overLuck:Stop()
		animTracks.bloodedge:Play()
		task.wait(0.7)
		animTracks.bloodedge:Stop()
		animTracks.wideStrike:Play()
		animTracks.wideStrike.TimePosition = 0.25
		task.wait(1.3)
		animTracks.wideStrike:Stop()

		task.wait(PLAY_DURATION)
		isAnimationSequenceActive = false

		for _, track in pairs(animTracks) do
			track:Stop()
		end
	end)
end

local function onAnimationPlayed(animationTrack)
	if animationTrack.Animation.AnimationId == cursedStrikesANIM.AnimationId then
		playAnimationSequence(Players.LocalPlayer)
	end
end

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.AnimationPlayed:Connect(onAnimationPlayed)

-- SKILL 2 --

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local crushingBlowANIM = ReplicatedStorage.Animations.Itadori.CrushingBlow
local wideStrikeANIM = ReplicatedStorage.Animations.Heian.Cleave
local chosoMelee4ANIM = ReplicatedStorage.Animations.Megumi.Mahoraga.Earthquake

local SWAP_DELAY = 0.01
local PLAY_DURATION = .5 

local isAnimationSequenceActive = false

local function playAnimationSequence(player)
	if isAnimationSequenceActive then return end
	isAnimationSequenceActive = true

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local animations = {
		chosoMelee4 = Instance.new("Animation"),
		wideStrike = Instance.new("Animation")
	}
	local sounds = {
		S1 = Instance.new("Sound", character),
		S2 = Instance.new("Sound", character)
	}
	sounds.S1.SoundId = "rbxassetid://3381874860"
	sounds.S2.SoundId = "rbxassetid://6185936852"
	animations.chosoMelee4.AnimationId = chosoMelee4ANIM.AnimationId
	animations.wideStrike.AnimationId = wideStrikeANIM.AnimationId

	local animTracks = {
		chosoMelee4 = humanoid:LoadAnimation(animations.chosoMelee4),
		wideStrike = humanoid:LoadAnimation(animations.wideStrike)
	}

	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end
	animTracks.wideStrike:Play()
	animTracks.wideStrike.TimePosition = 3.4
	animTracks.wideStrike:AdjustSpeed(1)
	sounds.S1:Play()
	sounds.S2:Play()
	task.wait(.4)
	animTracks.wideStrike:Stop()
	animTracks.chosoMelee4:Play()
	task.wait(0.7)

	task.wait(PLAY_DURATION)
	isAnimationSequenceActive = false

	for _, track in pairs(animTracks) do
		track:Stop()
	end
end


local function onAnimationPlayed(animationTrack)
	if animationTrack.Animation.AnimationId == crushingBlowANIM.AnimationId then
		playAnimationSequence(Players.LocalPlayer)
	end
end

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.AnimationPlayed:Connect(onAnimationPlayed)

-- SKILL 3 --

local function EasingFunction(t, style, direction)
	local styles = {
		Linear = function(p) return p end,
		Cubic = function(p)
			if direction == "Out" then
				return 1 - math.pow(1 - p, 3)
			end
			return p * p * p
		end
	}

	local easingFunc = styles[style] or styles["Linear"]
	return easingFunc(t)
end

local function ApplyBoost(character, direction, boostSpeed)
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChild("Humanoid")
	local camera = workspace.CurrentCamera

	if humanoidRootPart and humanoid then
		local isCurrentlyBoosting = true
		local startTime = tick()

		local boostConnection
		boostConnection = game:GetService("RunService").Heartbeat:Connect(function()
			if not isCurrentlyBoosting then
				boostConnection:Disconnect()
				return
			end

			local elapsed = tick() - startTime
			local progress = math.min(elapsed / CONFIG.BoostDuration, 1)

			local easedProgress = EasingFunction(progress, "Cubic", "Out")

			local boostForce = direction * (boostSpeed * easedProgress)

			humanoidRootPart.Velocity = boostForce

			if progress >= 1 then
				isCurrentlyBoosting = false
				boostConnection:Disconnect()
				humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			end
		end)
	end
end

local function SecondApplyBoost(character, direction, boostSpeed)
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChild("Humanoid")
	local camera = workspace.CurrentCamera

	if humanoidRootPart and humanoid then
		local isCurrentlyBoosting = true
		local startTime = tick()

		local boostConnection
		boostConnection = game:GetService("RunService").Heartbeat:Connect(function()
			if not isCurrentlyBoosting then
				boostConnection:Disconnect()
				return
			end

			local elapsed = tick() - startTime
			local progress = math.min(elapsed / .2, 1)

			local easedProgress = EasingFunction(progress, "Quad", "In")

			local boostForce = direction * (boostSpeed * easedProgress)

			humanoidRootPart.Velocity = boostForce

			if progress >= 1 then
				isCurrentlyBoosting = false
				boostConnection:Disconnect()
				humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			end
		end)
	end
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local divergentFistANIM = ReplicatedStorage.Animations.Itadori.Variants.DivergentFist1
local mahitoUltANIM = ReplicatedStorage.Animations.Megumi.Mahoraga.Takedown
local cleaveFrANIM = ReplicatedStorage.Animations.Hakari.RoughEnergy
local ClimaxANIM = ReplicatedStorage.Animations.Todo.ClimaxJump
local ChaseANIM = ReplicatedStorage.Animations.Mahito.Variants.ChaseArmor
local SoundForm1 = 17765816057
local SoundForm2 = 300208109

local SWAP_DELAY = 0.1 
local PLAY_DURATION = .2

local isAnimationSequenceActive = false

local function playAnimationSequence(player)
	if isAnimationSequenceActive then return end
	isAnimationSequenceActive = true

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local animations = {
		mahitoUlt = Instance.new("Animation"),
		cleaveFr = Instance.new("Animation"),
		Climax = Instance.new("Animation"),
		Chase = Instance.new("Animation")
	}

	local sounds = {
		S1 = Instance.new("Sound", character),
		S2 = Instance.new("Sound", character)
	}
	sounds.S1.SoundId = "rbxassetid://6665054578"
	sounds.S2.SoundId = "rbxassetid://3374531743"
	animations.mahitoUlt.AnimationId = mahitoUltANIM.AnimationId
	animations.cleaveFr.AnimationId = cleaveFrANIM.AnimationId
	animations.Climax.AnimationId = ClimaxANIM.AnimationId
	animations.Chase.AnimationId = ChaseANIM.AnimationId




	local animTracks = {
		mahitoUlt = humanoid:LoadAnimation(animations.mahitoUlt),
		cleaveFr = humanoid:LoadAnimation(animations.cleaveFr),
		Climax = humanoid:LoadAnimation(animations.Climax),
		Chase = humanoid:LoadAnimation(animations.Chase)
	}

	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end

	task.spawn(function()
		local character = player.Character
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		local lookVector = humanoidRootPart.CFrame.LookVector
		local boostDirection = Vector3.new(lookVector.X, 0, lookVector.Z).Unit

		animTracks.mahitoUlt:Play()
		sounds.S1:Play()
		task.wait(0.12)
		animTracks.mahitoUlt:Stop()
		animTracks.cleaveFr:Play()
		animTracks.cleaveFr:AdjustSpeed(2.5)
		ApplyBoost(character, boostDirection, CONFIG.FrontDashBoostSpeed)
		task.wait(.1)
		animTracks.Climax:Play()
		animTracks.Climax.TimePosition = 5.7
		task.wait(.1)

		animTracks.cleaveFr:Stop()
		task.wait(1.2)

		sounds.S2:Play()
		animTracks.Chase:Play()
		animTracks.Chase:AdjustSpeed(.9)
		animTracks.Climax:Stop()

		task.wait(.2)
		local NewlookVector = humanoidRootPart.CFrame.LookVector
		SecondApplyBoost(character, NewlookVector, CONFIG.SecondFrontDashBoostSpeed)
		task.wait(.8)
		animTracks.Chase:Stop()
		task.wait(PLAY_DURATION)
		isAnimationSequenceActive = false

		for _, track in pairs(animTracks) do
			track:Stop()
		end
	end)
end

local function onAnimationPlayed(animationTrack)
	if animationTrack.Animation.AnimationId == divergentFistANIM.AnimationId then
		playAnimationSequence(Players.LocalPlayer)
	end
end

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.AnimationPlayed:Connect(onAnimationPlayed)


-- SKILL 4 --

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ManjiKickANIM = ReplicatedStorage.Animations.Itadori.ManjiKick
local KickANIM = ReplicatedStorage.Animations.Hakari.Counter
local CountANIM = ReplicatedStorage.Animations.Megumi.Mahoraga.Parry

local SWAP_DELAY = 0.1
local PLAY_DURATION = 1.2 

local isAnimationSequenceActive = false
local function playAnimationSequence(player)
	if isAnimationSequenceActive then return end
	isAnimationSequenceActive = true

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local animations = {
		Kick = Instance.new("Animation"),
		Count = Instance.new("Animation")
	}

	local sounds = {
		S1 = Instance.new("Sound", character),
		S2 = Instance.new("Sound", character)
	}
	animations.Kick.AnimationId = KickANIM.AnimationId
	animations.Count.AnimationId = CountANIM.AnimationId
	sounds.S1.SoundId = "rbxassetid://3373995015"
	sounds.S2.SoundId = "rbxassetid://5669008914"


	local animTracks = {
		Kick = humanoid:LoadAnimation(animations.Kick),
		Count = humanoid:LoadAnimation(animations.Count)
	}

	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end

	task.spawn(function()
		local character = player.Character
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		local lookVector = humanoidRootPart.CFrame.LookVector
		local boostDirection = Vector3.new(lookVector.X, 0, lookVector.Z).Unit

		animTracks.Count:Play()
		sounds.S1:Play()
		wait(.3)
		sounds.S2:Play()
		animTracks.Kick:Play()
		animTracks.Kick.TimePosition = 1
		animTracks.Count:Stop()
		task.wait(.8)


		task.wait(PLAY_DURATION)
		isAnimationSequenceActive = false

		for _, track in pairs(animTracks) do
			track:Stop()
		end
	end)
end

local function onAnimationPlayed(animationTrack)
	if animationTrack.Animation.AnimationId == ManjiKickANIM.AnimationId then
		playAnimationSequence(Players.LocalPlayer)
	end
end

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.AnimationPlayed:Connect(onAnimationPlayed)



-- ULT --

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UltAnim = ReplicatedStorage.Animations.Itadori.Ultimate
local hakariCounterANIM = ReplicatedStorage.Animations.Misc.S.Form
local IdleAnim = ReplicatedStorage.Animations.Misc.S.Idle
local SoundForm = ReplicatedStorage.Sounds.Misc.S.Form


local SWAP_DELAY = 0.1 
local PLAY_DURATION = 3.2 

local isAnimationSequenceActive = false

local function playAnimationSequence(player)
	if isAnimationSequenceActive then return end
	isAnimationSequenceActive = true

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local animations = {
		hakariCounter = Instance.new("Animation"),
		idle = Instance.new("Animation")
	}

	local sounds = {
		FormSound = Instance.new("Sound")
	}
	animations.hakariCounter.AnimationId = hakariCounterANIM.AnimationId
	animations.idle.AnimationId = IdleAnim.AnimationId
	sounds.FormSound.SoundId = SoundForm.SoundId
	local animTracks = {
		hakariCounter = humanoid:LoadAnimation(animations.hakariCounter),
		idle = humanoid:LoadAnimation(animations.idle)
	}

	for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end

	task.spawn(function()
		local character = player.Character
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		sounds.FormSound.Parent = humanoidRootPart
		sounds.FormSound:Play()

		animTracks.hakariCounter:Play()
		task.wait(2)

		task.wait(PLAY_DURATION)
		isAnimationSequenceActive = false

		for _, track in pairs(animTracks) do
			track:Stop()
		end
	end)
end

local function onAnimationPlayed(animationTrack)
	if animationTrack.Animation.AnimationId == UltAnim.AnimationId then
		playAnimationSequence(Players.LocalPlayer)
	end
end


local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
humanoid.AnimationPlayed:Connect(onAnimationPlayed)
local localPlayer = game:GetService("Players").LocalPlayer
local localCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()

local function triggerParticleEffect()
	for _, part in pairs(localCharacter:GetChildren()) do
		if part:IsA("BasePart") then
			local attach = Instance.new("Attachment")
			local particles = Instance.new("ParticleEmitter")

			attach.Name = "TOKYOISSOKIDI"
			attach.Parent = part

			particles.Brightness = 5
			particles.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), 
				ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
			})
			particles.Drag = 3
			particles.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
			particles.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
			particles.Lifetime = NumberRange.new(0.5)
			particles.LightEmission = -1
			particles.LockedToPart = true
			particles.Rate = 2.5
			particles.Size = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 2),
				NumberSequenceKeypoint.new(1, 2)
			})
			particles.Speed = NumberRange.new(0)
			particles.Texture = "http://www.roblox.com/asset/?id=14904853757"
			particles.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.2, 0.49),
				NumberSequenceKeypoint.new(0.5, 0.51),
				NumberSequenceKeypoint.new(0.8, 0.49),
				NumberSequenceKeypoint.new(1, 1)
			})
			particles.ZOffset = -1
			particles.Parent = attach
		end
	end
end

triggerparticleeffects()
