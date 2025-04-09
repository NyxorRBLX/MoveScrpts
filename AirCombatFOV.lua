local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local minFOV = 70
local maxFOV = 120
local maxMomentum = 100  -- Adjust this value to set the momentum threshold for max FOV

local function updateFOV()
    local character = LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local momentum = humanoidRootPart.Velocity.Magnitude
            local fov = minFOV + (maxFOV - minFOV) * math.min(momentum / maxMomentum, 1)
            Camera.FieldOfView = fov
        end
    end
end

RunService.RenderStepped:Connect(updateFOV)

