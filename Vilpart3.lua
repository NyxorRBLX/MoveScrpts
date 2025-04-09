local Players = game:GetService("Players")
local player = Players.LocalPlayer
local walkAnimId = "rbxassetid://17124067635" 
local runAnimId = "rbxassetid://17124063826"  
local idleAnimId1 = "rbxassetid://17124061663" 
local idleAnimId1 = "rbxassetid://17124061663" 
local function changeAnimations()
	local character = player.Character or player.CharacterAdded:Wait()
	local animate = character:WaitForChild("Animate")
	if animate:FindFirstChild("walk") and animate.walk:FindFirstChild("WalkAnim") then
animate.walk.WalkAnim.AnimationId = walkAnimId
end
	if animate:FindFirstChild("run") and animate.run:FindFirstChild("RunAnim") then
		animate.run.RunAnim.AnimationId = runAnimId
	end
	if animate:FindFirstChild("idle") then
		local idle = animate.idle
	if idle:FindFirstChild("Animation1") then
idle.Animation1.AnimationId = idleAnimId1
end
end
end
player.CharacterAdded:Connect(changeAnimations)
if player.Character then
	changeAnimations()
end
