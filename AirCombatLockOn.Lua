local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local isLockOnEnabled = false
local targetHumanoidRootPart = nil
local smoothFactor = .4

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
                humanoidRootPart.CFrame = humanoidRootPart.CFrame:Lerp(CFrame.lookAt(humanoidRootPart.Position, targetHumanoidRootPart.Position), smoothFactor)
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, targetHumanoidRootPart.Position), smoothFactor)
            end
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.L then
        toggleLockOn()
    end
end)

RunService.RenderStepped:Connect(updateLockOn)

