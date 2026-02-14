-- CHLIP HUB V1 - CHUNK 7: Main Features UI Framework (Mobile)
return function(services)
    local TweenService = services.TweenService
    local UserInputService = services.UserInputService
    local TeleportService = services.TeleportService
    local player = services.player
    local playerGui = services.playerGui
    
    if playerGui:FindFirstChild("MainFeaturesUI") then
        playerGui.MainFeaturesUI:Destroy()
    end
    
    local mainFeaturesGui = Instance.new("ScreenGui")
    mainFeaturesGui.Name = "MainFeaturesUI"
    mainFeaturesGui.ResetOnSpawn = false
    mainFeaturesGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    mainFeaturesGui.Parent = playerGui
    
    local mainFeaturesFrame = Instance.new("Frame")
    mainFeaturesFrame.Name = "MainFrame"
    mainFeaturesFrame.Size = UDim2.new(0, 340, 0, 280)
    mainFeaturesFrame.Position = UDim2.new(0.5, -170, 0.5, -140)
    mainFeaturesFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFeaturesFrame.BorderSizePixel = 2
    mainFeaturesFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    mainFeaturesFrame.Active = true
    mainFeaturesFrame.Visible = true
    mainFeaturesFrame.Parent = mainFeaturesGui
    
    local mainFeaturesCorner = Instance.new("UICorner")
    mainFeaturesCorner.CornerRadius = UDim.new(0, 12)
    mainFeaturesCorner.Parent = mainFeaturesFrame
    
    -- Header
    local featuresHeader = Instance.new("Frame")
    featuresHeader.Name = "Header"
    featuresHeader.Size = UDim2.new(1, 0, 0, 50)
    featuresHeader.BackgroundTransparency = 1
    featuresHeader.Active = true
    featuresHeader.Parent = mainFeaturesFrame
    
    local logoImage = Instance.new("ImageLabel")
    logoImage.Name = "Logo"
    logoImage.Size = UDim2.new(0, 40, 0, 40)
    logoImage.Position = UDim2.new(0, 10, 0, 5)
    logoImage.BackgroundTransparency = 1
    logoImage.Image = "rbxassetid://83770860531903"
    logoImage.Parent = featuresHeader
    
    local featuresTitle = Instance.new("TextLabel")
    featuresTitle.Name = "Title"
    featuresTitle.Size = UDim2.new(0, 200, 0, 30)
    featuresTitle.Position = UDim2.new(0, 55, 0, 10)
    featuresTitle.BackgroundTransparency = 1
    featuresTitle.Text = "Main Features"
    featuresTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    featuresTitle.TextSize = 22
    featuresTitle.Font = Enum.Font.GothamBold
    featuresTitle.TextXAlignment = Enum.TextXAlignment.Left
    featuresTitle.Parent = featuresHeader
    
    local statusDot = Instance.new("Frame")
    statusDot.Name = "StatusDot"
    statusDot.Size = UDim2.new(0, 10, 0, 10)
    statusDot.Position = UDim2.new(1, -60, 0, 20)
    statusDot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    statusDot.BorderSizePixel = 0
    statusDot.Parent = featuresHeader
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = statusDot
    
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "Minimize"
    minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
    minimizeBtn.Position = UDim2.new(1, -45, 0, 7)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    minimizeBtn.Text = "−"
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.TextSize = 24
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Parent = featuresHeader
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 6)
    minimizeCorner.Parent = minimizeBtn
    
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "Content"
    contentContainer.Size = UDim2.new(1, -20, 1, -60)
    contentContainer.Position = UDim2.new(0, 10, 0, 55)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = mainFeaturesFrame
    
    -- Left Column
    local leftColumnMF = Instance.new("Frame")
    leftColumnMF.Name = "LeftColumn"
    leftColumnMF.Size = UDim2.new(0.48, 0, 1, 0)
    leftColumnMF.BackgroundTransparency = 1
    leftColumnMF.Parent = contentContainer
    
    local leftStrokeMF = Instance.new("UIStroke")
    leftStrokeMF.Color = Color3.fromRGB(255, 255, 255)
    leftStrokeMF.Thickness = 1
    leftStrokeMF.Parent = leftColumnMF
    
    local leftCornerMF = Instance.new("UICorner")
    leftCornerMF.CornerRadius = UDim.new(0, 8)
    leftCornerMF.Parent = leftColumnMF
    
    -- Right Column
    local rightColumnMF = Instance.new("Frame")
    rightColumnMF.Name = "RightColumn"
    rightColumnMF.Size = UDim2.new(0.48, 0, 1, 0)
    rightColumnMF.Position = UDim2.new(0.52, 0, 0, 0)
    rightColumnMF.BackgroundTransparency = 1
    rightColumnMF.Parent = contentContainer
    
    local rightStrokeMF = Instance.new("UIStroke")
    rightStrokeMF.Color = Color3.fromRGB(255, 255, 255)
    rightStrokeMF.Thickness = 1
    rightStrokeMF.Parent = rightColumnMF
    
    local rightCornerMF = Instance.new("UICorner")
    rightCornerMF.CornerRadius = UDim.new(0, 8)
    rightCornerMF.Parent = rightColumnMF
    
    services.MainFeaturesUI = {
        gui = mainFeaturesGui,
        frame = mainFeaturesFrame,
        content = contentContainer,
        leftColumn = leftColumnMF,
        rightColumn = rightColumnMF,
        minimizeBtn = minimizeBtn,
        player = player,
        TweenService = TweenService,
        UserInputService = UserInputService,
        TeleportService = TeleportService
    }
    
    print("Main Features UI Framework Loaded")
    return services
end
