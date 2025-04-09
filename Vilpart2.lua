local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local character = Player.Character or Player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local gui = Player.PlayerGui
local screenGui = gui.ScreenGui
local isUlted = character:GetAttribute("Ulted")

local Dash = "12772543293" 
local Dash2 = "17838006839" 
local m1 = "13491635433" 
local m2 = "17325522388"
local m3 = "14001963401"
local m4 = "15162694192"
local ult = "17292505729"
local slam = "16571909908"
local upper = "10503381238"
pcall(function() getgenv().dash:Disconnect() end)
getgenv().dash = humanoid.AnimationPlayed:Connect(function(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://10479335397" then
		local anim1 = Instance.new("Animation")
		local anim2 = Instance.new("Animation")
		anim1.AnimationId = "rbxassetid://" .. Dash
		anim2.AnimationId = "rbxassetid://" .. Dash2
		local loadedAnim1 = humanoid:LoadAnimation(anim1)
		local loadedAnim2 = humanoid:LoadAnimation(anim2)

		loadedAnim1.Priority = Enum.AnimationPriority.Action3
		loadedAnim2.Priority = Enum.AnimationPriority.Action3
		loadedAnim1:Play()
		loadedAnim1.TimePosition = 2
		loadedAnim1:AdjustSpeed(-1.2)
		task.wait(0.2)
		loadedAnim2:Play()
		loadedAnim2:AdjustSpeed(1)
		task.wait(0.1)
		loadedAnim1:Stop()
		task.wait(0.5)
		loadedAnim2:Stop()

	end
end)
getgenv().two = humanoid.AnimationPlayed:Connect(function(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://10469630950" then
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. m2
		local loadedAnim = humanoid:LoadAnimation(anim)
		
		loadedAnim.Priority = Enum.AnimationPriority.Action2
		loadedAnim:Play()
		loadedAnim:AdjustSpeed(1.5)
	end
end)
pcall(function() getgenv().one:Disconnect() end)
getgenv().one = humanoid.AnimationPlayed:Connect(function(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://10469493270" then
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. m1
		local loadedAnim = humanoid:LoadAnimation(anim)
		local S = Instance.new("Sound", character)

		S.SoundId = "rbxassetid://140546969502476"
		S:Play()
		loadedAnim.Priority = Enum.AnimationPriority.Action2
		loadedAnim:Play()
		loadedAnim:AdjustSpeed(1.5)
	end
end)
pcall(function() getgenv().two:Disconnect() end)
getgenv().two = humanoid.AnimationPlayed:Connect(function(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://10469630950" then
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. m2
		local loadedAnim = humanoid:LoadAnimation(anim)
		local S = Instance.new("Sound", character)

		S.SoundId = "rbxassetid://76551316507680"
		S:Play()
		loadedAnim.Priority = Enum.AnimationPriority.Action2
		loadedAnim:Play()
		loadedAnim:AdjustSpeed(1.5)
	end
end)
pcall(function() getgenv().three:Disconnect() end)
getgenv().three = humanoid.AnimationPlayed:Connect(function(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://10469639222" then
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. m3
		local loadedAnim = humanoid:LoadAnimation(anim)
		local S = Instance.new("Sound", character)

		S.SoundId = "rbxassetid://6938585721"
		S:Play()
		loadedAnim.Priority = Enum.AnimationPriority.Action2
		loadedAnim:Play()
		loadedAnim:AdjustSpeed(1.7)
	end
end)
pcall(function() getgenv().four:Disconnect() end)
getgenv().four = humanoid.AnimationPlayed:Connect(function(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://10469643643" then
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. m4
		local loadedAnim = humanoid:LoadAnimation(anim)
		local S = Instance.new("Sound", character)

		S.SoundId = "rbxassetid://90992723091327"
		S:Play()
		loadedAnim.Priority = Enum.AnimationPriority.Action2
		loadedAnim:Play()
		loadedAnim:AdjustSpeed(1.5)
	end
end)
pcall(function() getgenv().ult:Disconnect() end)
getgenv().ult = humanoid.AnimationPlayed:Connect(function(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://12447707844" then
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. ult
		local loadedAnim = humanoid:LoadAnimation(anim)
		local S = Instance.new("Sound", character)
		local S2 = Instance.new("Sound", character)
		S2.Volume = 0.1
		
		S2.SoundId = "rbxassetid://117807300745911"
		S.SoundId = "rbxassetid://8541282266"
		S2:Play()
		S:Play()
		loadedAnim.Priority = Enum.AnimationPriority.Action2
		loadedAnim:Play()
		loadedAnim:AdjustSpeed(1.5)
	end
end)
pcall(function() getgenv().slam:Disconnect() end)
getgenv().ult = humanoid.AnimationPlayed:Connect(function(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://10470104242" then
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. slam
		local loadedAnim = humanoid:LoadAnimation(anim)
		local S = Instance.new("Sound", character)
		S.SoundId = "rbxassetid://136740106410252"
		S:Play()
		loadedAnim.Priority = Enum.AnimationPriority.Action2
		loadedAnim:Play()
		loadedAnim.TimePosition = 1.65
		loadedAnim:AdjustSpeed(2)
	end
end)
pcall(function() getgenv().upper:Disconnect() end)
getgenv().upper = humanoid.AnimationPlayed:Connect(function(animationTrack)
	if animationTrack.Animation.AnimationId == "rbxassetid://10503381238" then
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. upper
		local loadedAnim = humanoid:LoadAnimation(anim)
		local S = Instance.new("Sound", character)
		S.SoundId = "rbxassetid://135344570425077"
		S:Play()
		loadedAnim.Priority = Enum.AnimationPriority.Action2
		loadedAnim:Play()
		loadedAnim:AdjustSpeed(1.1)
	end
end)
