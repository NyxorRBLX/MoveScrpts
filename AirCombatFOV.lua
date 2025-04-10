local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local minFOV = 70
local maxFOV = 120
local maxMomentum = 100
local smoothFactor = 0.1  -- Lower = smoother

local targetFOV = minFOV

local function updateFOV()
	local character = LocalPlayer.Character
	if character then
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			local momentum = humanoidRootPart.Velocity.Magnitude
			targetFOV = minFOV + (maxFOV - minFOV) * math.min(momentum / maxMomentum, 1)
		end
	end

	-- Smooth interpolation to targetFOV
	Camera.FieldOfView = Camera.FieldOfView + (targetFOV - Camera.FieldOfView) * smoothFactor
end

RunService.RenderStepped:Connect(updateFOV)
