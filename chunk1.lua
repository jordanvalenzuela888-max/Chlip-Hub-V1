-- CHLIP HUB V1 - CHUNK 1: Services & Unlock Functions
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

-- Unlock Base Helper Functions
local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

local function getClosestPlot()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return end
    local hrp = getHRP()
    local closest, dist = nil, math.huge
    for _,plot in pairs(plots:GetChildren()) do
        local part = plot:FindFirstChildWhichIsA("BasePart")
        if part then
            local d = (hrp.Position - part.Position).Magnitude
            if d < dist then
                dist = d
                closest = plot
            end
        end
    end
    return closest
end

local function findPrompts(obj, found)
    for _,v in pairs(obj:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            table.insert(found, v)
        end
    end
end

function smartUnlock(floorNumber)
    local plot = getClosestPlot()
    if not plot then warn("No plot nearby") return end
    local unlockFolder = plot:FindFirstChild("Unlock")
    if not unlockFolder then warn("No Unlock folder") return end
    
    local floors = {}
    for _,item in pairs(unlockFolder:GetChildren()) do
        local pos
        if item:IsA("Model") then
            pos = item:GetPivot().Position
        elseif item:IsA("BasePart") then
            pos = item.Position
        end
        if pos then
            table.insert(floors,{obj = item, height = pos.Y})
        end
    end
    
    table.sort(floors,function(a,b) return a.height < b.height end)
    if floorNumber > #floors then warn("Floor not found") return end
    
    local target = floors[floorNumber].obj
    local prompts = {}
    findPrompts(target,prompts)
    for _,p in pairs(prompts) do fireproximityprompt(p) end
    print("Unlocked floor:",floorNumber)
end

-- Return services for next chunks
return {
    Players = Players,
    player = player,
    playerGui = playerGui,
    RunService = RunService,
    Stats = Stats,
    TweenService = TweenService,
    UserInputService = UserInputService,
    TeleportService = TeleportService,
    smartUnlock = smartUnlock
}
