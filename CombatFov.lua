local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local minFOV = 55
local maxFOV = 150
local maxMomentum = 180 

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

