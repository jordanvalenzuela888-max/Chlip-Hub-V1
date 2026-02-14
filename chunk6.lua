-- CHLIP HUB V1 - CHUNK 6: Left Scroll Toggles 6-9 + Draggable
return function(services)
    local UserInputService = services.UserInputService
    local scrollFrame = services.LeftScrollUI.scrollFrame
    local listLayout = services.LeftScrollUI.listLayout
    local mainFrame2 = services.LeftScrollUI.mainFrame
    local player = services.player
    
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
    
    -- ANTI BEE
    createToggle("Anti Bee", function(enabled)
        if not enabled then return end
        local Lighting = game:GetService("Lighting")
        
        local FOV_MANAGER = {
            Active = false,
            Connection = nil,
            TargetFOV = 70,
            Push = function(self)
                self.Active = true
                self.Connection = game:GetService("RunService").RenderStepped:Connect(function()
                    if not self.Active then return end
                    local camera = workspace.CurrentCamera
                    if camera and camera.FieldOfView ~= self.TargetFOV then
                        camera.FieldOfView = self.TargetFOV
                    end
                end)
            end,
            Pop = function(self)
                self.Active = false
                if self.Connection then self.Connection:Disconnect() self.Connection = nil end
            end
        }
        
        local ANTI_BEE = {
            Enabled = false,
            Connections = {},
            Enable = function(self)
                if self.Enabled then return end
                self.Enabled = true
                local function clean()
                    for _, obj in pairs(Lighting:GetChildren()) do
                        if obj:IsA("BlurEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("BloomEffect") then
                            obj:Destroy()
                        end
                    end
                end
                clean()
                table.insert(self.Connections, Lighting.DescendantAdded:Connect(function(v)
                    if v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") then v:Destroy() end
                end))
                table.insert(self.Connections, workspace.DescendantAdded:Connect(function(v)
                    if v:IsA("Sound") and v.Name:lower():find("buzz") then v.Volume = 0 v:Stop() end
                end))
                FOV_MANAGER:Push()
            end,
            Disable = function(self)
                if not self.Enabled then return end
                self.Enabled = false
                for _, conn in ipairs(self.Connections) do if typeof(conn) == "RBXScriptConnection" then conn:Disconnect() end end
                table.clear(self.Connections)
                FOV_MANAGER:Pop()
            end
        }
        
        ANTI_BEE:Enable()
        print("Anti Bee Enabled ✅")
    end)
    
    -- ANTI TURRENT
    createToggle("Anti Turrent", function(enabled)
        local RunService = game:GetService("RunService")
        
        if not _G.AntiTurrentData then
            _G.AntiTurrentData = {connection = nil, target = nil, charAddedConnection = nil, active = false}
        end
        local data = _G.AntiTurrentData
        
        local function getChar() return player.Character end
        local function getWeapon()
            local char = getChar()
            if not char then return nil end
            return player.Backpack:FindFirstChild("Bat") or char:FindFirstChild("Bat")
        end
        local function findTarget()
            local char = getChar()
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local rootPos = char.HumanoidRootPart.Position
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:find("Sentry") and not obj.Name:lower():find("bullet") then
                    local ownerId = obj.Name:match("Sentry_(%d+)")
                    if ownerId and tonumber(ownerId) == player.UserId then continue end
                    local part = obj:IsA("BasePart") and obj or obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart"))
                    if part and (rootPos - part.Position).Magnitude <= 60 then return obj end
                end
            end
        end
        local function moveTarget(obj)
            local char = getChar()
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            for _, part in pairs(obj:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
            local root = char.HumanoidRootPart
            local cf = root.CFrame * CFrame.new(0, 0, -5)
            if obj:IsA("BasePart") then obj.CFrame = cf
            elseif obj:IsA("Model") then
                local main = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if main then main.CFrame = cf end
            end
        end
        local function attack()
            local char = getChar()
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local weapon = getWeapon()
            if not weapon then return end
            if weapon.Parent == player.Backpack then hum:EquipTool(weapon) task.wait(0.1) end
            local handle = weapon:FindFirstChild("Handle")
            if handle then handle.CanCollide = false end
            pcall(function() weapon:Activate() end)
            for _, r in pairs(weapon:GetDescendants()) do
                if r:IsA("RemoteEvent") then pcall(function() r:FireServer() end) end
            end
        end
        local function start()
            if data.connection then return end
            data.connection = RunService.Heartbeat:Connect(function()
                if not data.active then return end
                if data.target and data.target.Parent == workspace then
                    moveTarget(data.target)
                    attack()
                else
                    data.target = findTarget()
                end
            end)
        end
        local function stop()
            if data.connection then data.connection:Disconnect() data.connection = nil end
            data.target = nil
        end
        
        if enabled then
            if data.active then return end
            data.active = true
            start()
            if data.charAddedConnection then data.charAddedConnection:Disconnect() end
            data.charAddedConnection = player.CharacterAdded:Connect(function()
                task.wait(0.5)
                if data.active then start() else stop() end
            end)
            print("Anti Turrent Enabled ✅")
        else
            if not data.active then return end
            data.active = false
            stop()
            if data.charAddedConnection then data.charAddedConnection:Disconnect() data.charAddedConnection = nil end
            print("Anti Turrent Disabled ❌")
        end
    end)
    
    -- AUTO LEAVE
    createToggle("Auto Leave", function(enabled)
        if not _G.AutoLeaveData then
            _G.AutoLeaveData = {connections = {}, scanLoop = nil, active = false}
        end
        local data = _G.AutoLeaveData
        
        local function check(obj)
            if not data.active then return end
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                local function detect()
                    if not data.active then return end
                    if obj.Text and string.find(string.lower(obj.Text), "you stole") then
                        player:Kick("Chlip On Top")
                    end
                end
                detect()
                local conn = obj:GetPropertyChangedSignal("Text"):Connect(detect)
                table.insert(data.connections, conn)
            end
        end
        
        if enabled then
            if data.active then return end
            data.active = true
            for _, v in pairs(player.PlayerGui:GetDescendants()) do check(v) end
            local descConn = player.PlayerGui.DescendantAdded:Connect(check)
            table.insert(data.connections, descConn)
            data.scanLoop = task.spawn(function()
                while data.active do
                    for _, v in pairs(player.PlayerGui:GetDescendants()) do
                        if (v:IsA("TextLabel") or v:IsA("TextButton")) and v.Text then
                            if string.find(string.lower(v.Text), "you stole") then player:Kick("Chlip On Top") end
                        end
                    end
                    task.wait(0.3)
                end
            end)
            print("Auto Leave Enabled ✅")
        else
            if not data.active then return end
            data.active = false
            for _, conn in ipairs(data.connections) do if typeof(conn) == "RBXScriptConnection" then conn:Disconnect() end end
            table.clear(data.connections)
            data.scanLoop = nil
            print("Auto Leave Disabled ❌")
        end
    end)
    
    -- ANTI LAG
    createToggle("Anti Lag", function(enabled)
        local Lighting = game:GetService("Lighting")
        if not _G.AntiLagData then _G.AntiLagData = {connection = nil, active = false} end
        local data = _G.AntiLagData
        
        local function optimize(v)
            if not data.active then return end
            if v:IsA("BasePart") then v.Material = Enum.Material.Plastic v.Reflectance = 0 end
            if v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1 end
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then v.Enabled = false end
        end
        
        if enabled then
            if data.active then return end
            data.active = true
            pcall(function()
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 9e9
                Lighting.Brightness = 1
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            end)
            for _, v in pairs(workspace:GetDescendants()) do optimize(v) end
            data.connection = workspace.DescendantAdded:Connect(optimize)
            print("Anti Lag Enabled ✅")
        else
            if not data.active then return end
            data.active = false
            if data.connection then data.connection:Disconnect() data.connection = nil end
            print("Anti Lag Disabled ❌")
        end
    end)
    
    -- Auto-update canvas size
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
    end)
    
    -- Draggable
    local dragging = false
    local dragInput, dragStart, startPos
    mainFrame2.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame2.Position
        end
    end)
    mainFrame2.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            mainFrame2.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    print("Left Scroll Toggles 6-9 + Draggable Loaded")
    return services
end
