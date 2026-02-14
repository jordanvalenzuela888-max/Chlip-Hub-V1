-- CHLIP HUB V1 - CHUNK 4: Left Scroll UI Framework (Mobile)
return function(services)
    local player = services.player
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LeftScrollUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = game:GetService("CoreGui")
    
    local mainFrame2 = Instance.new("Frame")
    mainFrame2.Name = "MainContainer"
    mainFrame2.Size = UDim2.new(0, 160, 0, 200)
    mainFrame2.Position = UDim2.new(0, 10, 0, 120)
    mainFrame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame2.BorderColor3 = Color3.fromRGB(255, 255, 255)
    mainFrame2.BorderSizePixel = 2
    mainFrame2.Parent = screenGui
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 8)
    corner2.Parent = mainFrame2
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ScrollContent"
    scrollFrame.Size = UDim2.new(1, -10, 1, -10)
    scrollFrame.Position = UDim2.new(0, 5, 0, 5)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
    scrollFrame.Parent = mainFrame2
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 5)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = scrollFrame
    
    local headerLabel = Instance.new("TextLabel")
    headerLabel.Name = "MiscHeader"
    headerLabel.Size = UDim2.new(1, -10, 0, 25)
    headerLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    headerLabel.BorderColor3 = Color3.fromRGB(255, 255, 255)
    headerLabel.BorderSizePixel = 1
    headerLabel.Text = "Misc"
    headerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    headerLabel.TextSize = 16
    headerLabel.Font = Enum.Font.GothamBold
    headerLabel.LayoutOrder = 0
    headerLabel.Parent = scrollFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 4)
    headerCorner.Parent = headerLabel
    
    services.LeftScrollUI = {
        screenGui = screenGui,
        mainFrame = mainFrame2,
        scrollFrame = scrollFrame,
        listLayout = listLayout,
        player = player
    }
    
    print("Left Scroll UI Framework Loaded")
    return services
end
