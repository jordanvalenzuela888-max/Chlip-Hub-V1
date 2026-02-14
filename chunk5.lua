-- CHLIP HUB V1 - CHUNK 5: Left Scroll Toggles 1-5
return function(services)
    local scrollFrame = services.LeftScrollUI.scrollFrame
    local listLayout = services.LeftScrollUI.listLayout
    local player = services.LeftScrollUI.player
    
    local function createToggle(name, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Name = name .. "Toggle"
        toggleFrame.Size = UDim2.new(1, -10, 0, 35)
        toggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        toggleFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
        toggleFrame.BorderSizePixel = 1
        toggleFrame.Parent = scrollFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = toggleFrame
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Size = UDim2.new(0.6, 0, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 12
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = toggleFrame
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Name = "ToggleBtn"
        toggleBtn.Size = UDim2.new(0, 40, 0, 20)
        toggleBtn.Position = UDim2.new(1, -50, 0.5, -10)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        toggleBtn.Text = "OFF"
        toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleBtn.TextSize = 10
        toggleBtn.Font = Enum.Font.GothamBold
        toggleBtn.Parent = toggleFrame
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 10)
        toggleCorner.Parent = toggleBtn
        
        local enabled = false
        toggleBtn.MouseButton1Click:Connect(function()
            enabled = not enabled
            if enabled then
                toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                toggleBtn.Text = "ON"
            else
                toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                toggleBtn.Text = "OFF"
            end
            callback(enabled)
        end)
        return toggleFrame
    end
    
    -- FPS BOOST
    createToggle("FPS Boost", function(enabled)
        if not enabled then return end
        local Lighting = game:GetService("Lighting")
        local Workspace = game:GetService("Workspace")
        local Terrain = Workspace:FindFirstChildOfClass("Terrain")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            Lighting.Brightness = 1
            Lighting.EnvironmentDiffuseScale = 0
            Lighting.EnvironmentSpecularScale = 0
        end)
        
        for _,v in pairs(game:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
            if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
        
        for _,v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            end
            if v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
        end
        
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 1
        end
        
        local function removeClothing(char)
            for _,v in pairs(char:GetDescendants()) do
                if v:IsA("Clothing") or v:IsA("Accessory") then v:Destroy() end
                if v:IsA("MeshPart") and (v.Name:lower():find("hair") or v.Name:lower():find("hat")) then v:Destroy() end
                if v:IsA("SurfaceAppearance") then v:Destroy() end
            end
        end
        
        if LocalPlayer.Character then removeClothing(LocalPlayer.Character) end
        LocalPlayer.CharacterAdded:Connect(removeClothing)
        print("FPS Boost Enabled ✅")
    end)
    
    -- XRAY
    createToggle("Xray", function(enabled)
        local Workspace = game:GetService("Workspace")
        local TRANSPARENCY = 0.85
        local saved = {}
        local xrayConnection = nil
        
        local function isWallOrFloor(part)
            if not part:IsA("BasePart") then return false end
            if not part.Anchored or not part.CanCollide then return false end
            local name = part.Name:lower()
            if not (name:find("wall") or name:find("floor") or name:find("base") or name:find("plot")) then return false end
            local p = part.Parent and part.Parent.Name:lower() or ""
            if p:find("dropper") or p:find("collector") or p:find("machine") or p:find("button") or p:find("upgrader") then return false end
            return true
        end
        
        local function applyXray()
            for _,v in ipairs(Workspace:GetDescendants()) do
                if isWallOrFloor(v) then
                    if not saved[v] then saved[v] = v.LocalTransparencyModifier end
                    v.LocalTransparencyModifier = TRANSPARENCY
                end
            end
        end
        
        local function restoreXray()
            for part, original in pairs(saved) do
                if part and part.Parent then part.LocalTransparencyModifier = original end
            end
            saved = {}
        end
        
        if enabled then
            applyXray()
            xrayConnection = Workspace.DescendantAdded:Connect(function(v)
                if isWallOrFloor(v) then
                    saved[v] = v.LocalTransparencyModifier
                    v.LocalTransparencyModifier = TRANSPARENCY
                end
            end)
            print("Xray Enabled ✅")
        else
            if xrayConnection then xrayConnection:Disconnect() xrayConnection = nil end
            restoreXray()
            print("Xray Disabled ❌")
        end
    end)
    
    -- FLOOR STEAL
    createToggle("Floor Steal", function(enabled)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer
        
        if not _G.FloorStealData then
            _G.FloorStealData = {platform = nil, followConnection = nil, charAddedConnection = nil}
        end
        local data = _G.FloorStealData
        
        local function getHRP()
            local char = player.Character
            if char then return char:FindFirstChild("HumanoidRootPart") end
            return nil
        end
        
        local function updatePlatform()
            local hrp = getHRP()
            if hrp and data.platform and data.platform.Parent then
                data.platform.Position = hrp.Position - Vector3.new(0, 3, 0)
            end
        end
        
        if enabled then
            if data.followConnection then data.followConnection:Disconnect() end
            if data.platform then data.platform:Destroy() end
            
            data.platform = Instance.new("Part")
            data.platform.Size = Vector3.new(12, 1, 12)
            data.platform.Anchored = true
            data.platform.CanCollide = true
            data.platform.Transparency = 1
            data.platform.Name = "StealPlatform"
            data.platform.Parent = workspace
            
            data.followConnection = RunService.RenderStepped:Connect(updatePlatform)
            
            if data.charAddedConnection then data.charAddedConnection:Disconnect() end
            data.charAddedConnection = player.CharacterAdded:Connect(function()
                task.wait(0.5)
                if data.followConnection then data.followConnection:Disconnect() end
                data.followConnection = RunService.RenderStepped:Connect(updatePlatform)
            end)
            print("Floor Steal Enabled ✅")
        else
            if data.followConnection then data.followConnection:Disconnect() data.followConnection = nil end
            if data.charAddedConnection then data.charAddedConnection:Disconnect() data.charAddedConnection = nil end
            if data.platform then data.platform:Destroy() data.platform = nil end
            print("Floor Steal Disabled ❌")
        end
    end)
    
    -- ESP PLAYER
    createToggle("Esp Player", function(enabled)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        if not _G.PlayerESPData then
            _G.PlayerESPData = {espFolder = nil, espObjects = {}, updateLoop = nil, playerRemovingConnection = nil}
        end
        local data = _G.PlayerESPData
        
        local function createESP(plr)
            if plr == LocalPlayer then return end
            if data.espObjects[plr] then return end
            local char = plr.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            local hl = Instance.new("Highlight")
            hl.Adornee = char
            hl.FillColor = Color3.new(0, 0, 0)
            hl.FillTransparency = 0.3
            hl.OutlineColor = Color3.new(1, 1, 1)
            hl.OutlineTransparency = 0
            hl.Parent = data.espFolder
            
            local bb = Instance.new("BillboardGui")
            bb.Adornee = hrp
            bb.Size = UDim2.new(0, 160, 0, 40)
            bb.StudsOffset = Vector3.new(0, 3, 0)
            bb.AlwaysOnTop = true
            bb.Parent = data.espFolder
            
            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.TextScaled = true
            txt.Font = Enum.Font.GothamBold
            txt.TextStrokeTransparency = 0
            txt.TextColor3 = Color3.new(1, 1, 1)
            txt.Parent = bb
            
            data.espObjects[plr] = {highlight = hl, label = txt, root = hrp}
        end
        
        local function removeESP(plr)
            if data.espObjects[plr] then
                for _, v in pairs(data.espObjects[plr]) do
                    if typeof(v) == "Instance" then v:Destroy() end
                end
                data.espObjects[plr] = nil
            end
        end
        
        local function clearAllESP()
            for plr, _ in pairs(data.espObjects) do removeESP(plr) end
            data.espObjects = {}
        end
        
        if enabled then
            if data.espFolder then data.espFolder:Destroy() end
            data.espFolder = Instance.new("Folder", workspace)
            data.espFolder.Name = "PlayerESP"
            
            data.updateLoop = true
            task.spawn(function()
                while data.updateLoop do
                    local myChar = LocalPlayer.Character
                    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    for _, plr in pairs(Players:GetPlayers()) do
                        if plr ~= LocalPlayer then
                            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                                createESP(plr)
                                if myHRP and data.espObjects[plr] then
                                    local dist = math.floor((myHRP.Position - data.espObjects[plr].root.Position).Magnitude)
                                    data.espObjects[plr].label.Text = plr.Name .. " | " .. dist .. " studs"
                                end
                            else
                                removeESP(plr)
                            end
                        end
                    end
                    task.wait(0.01)
                end
            end)
            data.playerRemovingConnection = Players.PlayerRemoving:Connect(removeESP)
            print("Player ESP Enabled ✅")
        else
            data.updateLoop = nil
            if data.playerRemovingConnection then data.playerRemovingConnection:Disconnect() data.playerRemovingConnection = nil end
            clearAllESP()
            if data.espFolder then data.espFolder:Destroy() data.espFolder = nil end
            print("Player ESP Disabled ❌")
        end
    end)
    
    -- INFINITE JUMP
    createToggle("Infinite Jump", function(enabled)
        local Players = game:GetService("Players")
        local UserInputService = game:GetService("UserInputService")
        local player = Players.LocalPlayer
        
        if not _G.InfiniteJumpData then
            _G.InfiniteJumpData = {jumpConnection = nil, charAddedConnection = nil, active = false}
        end
        local data = _G.InfiniteJumpData
        
        local function setup(char)
            local hrp = char:WaitForChild("HumanoidRootPart")
            if data.jumpConnection then data.jumpConnection:Disconnect() end
            data.jumpConnection = UserInputService.JumpRequest:Connect(function()
                if data.active and hrp and hrp.Parent then
                    hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 50, hrp.AssemblyLinearVelocity.Z)
                end
            end)
        end
        
        if enabled then
            if data.active then return end
            data.active = true
            if player.Character then setup(player.Character) end
            if data.charAddedConnection then data.charAddedConnection:Disconnect() end
            data.charAddedConnection = player.CharacterAdded:Connect(setup)
            print("Infinite Jump Enabled ✅")
        else
            if not data.active then return end
            data.active = false
            if data.jumpConnection then data.jumpConnection:Disconnect() data.jumpConnection = nil end
            if data.charAddedConnection then data.charAddedConnection:Disconnect() data.charAddedConnection = nil end
            print("Infinite Jump Disabled ❌")
        end
    end)
    
    print("Left Scroll Toggles 1-5 Loaded")
    return services
end
