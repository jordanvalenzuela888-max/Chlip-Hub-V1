-- CHLIP HUB V1 - CHUNK 3: Header UI
return function(services)
    local TweenService = services.TweenService
    local RunService = services.RunService
    local Stats = services.Stats
    local playerGui = services.playerGui
    
    if playerGui:FindFirstChild("ChlipHeader") then
        playerGui.ChlipHeader:Destroy()
    end
    
    local headerGui = Instance.new("ScreenGui")
    headerGui.Name = "ChlipHeader"
    headerGui.ResetOnSpawn = false
    headerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    headerGui.Parent = playerGui
    
    local headerFrame = Instance.new("Frame")
    headerFrame.Name = "HeaderFrame"
    headerFrame.Size = UDim2.new(0, 552, 0, 45)
    headerFrame.Position = UDim2.new(0.5, -276, 1, -119)
    headerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    headerFrame.BorderSizePixel = 0
    headerFrame.Parent = headerGui
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Name = "Outline"
    uiStroke.Color = Color3.fromRGB(255, 255, 255)
    uiStroke.Thickness = 2
    uiStroke.Parent = headerFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = headerFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(0, 160, 0, 20)
    titleLabel.Position = UDim2.new(0, 15, 0, 3)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "Chlip Hub V1"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = headerFrame
    
    local creditsLabel = Instance.new("TextLabel")
    creditsLabel.Name = "Credits"
    creditsLabel.Size = UDim2.new(0, 160, 0, 16)
    creditsLabel.Position = UDim2.new(0, 15, 0, 24)
    creditsLabel.BackgroundTransparency = 1
    creditsLabel.Text = "Credits @Batchinga2"
    creditsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    creditsLabel.TextSize = 12
    creditsLabel.Font = Enum.Font.GothamBold
    creditsLabel.TextXAlignment = Enum.TextXAlignment.Left
    creditsLabel.Parent = headerFrame
    
    local divider1 = Instance.new("Frame")
    divider1.Name = "Divider1"
    divider1.Size = UDim2.new(0, 2, 0, 32)
    divider1.Position = UDim2.new(0, 185, 0, 6)
    divider1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    divider1.BorderSizePixel = 0
    divider1.Parent = headerFrame
    
    local discordLabel = Instance.new("TextLabel")
    discordLabel.Name = "Discord"
    discordLabel.Size = UDim2.new(0, 160, 0, 32)
    discordLabel.Position = UDim2.new(0.5, -80, 0, 6)
    discordLabel.BackgroundTransparency = 1
    discordLabel.Text = ".gg/KSfMtGz9Fc"
    discordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    discordLabel.TextSize = 16
    discordLabel.Font = Enum.Font.GothamBold
    discordLabel.TextXAlignment = Enum.TextXAlignment.Center
    discordLabel.Parent = headerFrame
    
    local divider2 = Instance.new("Frame")
    divider2.Name = "Divider2"
    divider2.Size = UDim2.new(0, 2, 0, 32)
    divider2.Position = UDim2.new(0, 405, 0, 6)
    divider2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    divider2.BorderSizePixel = 0
    divider2.Parent = headerFrame
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Name = "FPS"
    fpsLabel.Size = UDim2.new(0, 120, 0, 18)
    fpsLabel.Position = UDim2.new(0, 420, 0, 4)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "FPS: --"
    fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    fpsLabel.TextSize = 14
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
    fpsLabel.Parent = headerFrame
    
    local pingLabel = Instance.new("TextLabel")
    pingLabel.Name = "Ping"
    pingLabel.Size = UDim2.new(0, 120, 0, 18)
    pingLabel.Position = UDim2.new(0, 420, 0, 22)
    pingLabel.BackgroundTransparency = 1
    pingLabel.Text = "PING: --"
    pingLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    pingLabel.TextSize = 14
    pingLabel.Font = Enum.Font.GothamBold
    pingLabel.TextXAlignment = Enum.TextXAlignment.Left
    pingLabel.Parent = headerFrame
    
    local lastUpdate = 0
    RunService.RenderStepped:Connect(function()
        if tick() - lastUpdate >= 0.5 then
            lastUpdate = tick()
            local fps = math.floor(1 / RunService.RenderStepped:Wait())
            fpsLabel.Text = string.format("FPS: %d", fps)
            local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            pingLabel.Text = string.format("PING: %dms", ping)
        end
    end)
    
    print("Header UI Loaded")
    return services
end
