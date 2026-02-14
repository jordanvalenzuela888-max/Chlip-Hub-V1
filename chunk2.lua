-- CHLIP HUB V1 - CHUNK 2: Lockpick UI (Mobile)
return function(services)
    local TweenService = services.TweenService
    local playerGui = services.playerGui
    local smartUnlock = services.smartUnlock
    
    if playerGui:FindFirstChild("LockpickUI") then
        playerGui.LockpickUI:Destroy()
    end
    
    local lockpickGui = Instance.new("ScreenGui")
    lockpickGui.Name = "LockpickUI"
    lockpickGui.ResetOnSpawn = false
    lockpickGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    lockpickGui.Parent = playerGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 200, 0, 50)
    mainFrame.Position = UDim2.new(0.5, -100, 0, 10)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    mainFrame.Parent = lockpickGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainFrame
    
    local paddingFrame = Instance.new("Frame")
    paddingFrame.Name = "Padding"
    paddingFrame.Size = UDim2.new(1, -6, 1, -6)
    paddingFrame.Position = UDim2.new(0, 3, 0, 3)
    paddingFrame.BackgroundTransparency = 1
    paddingFrame.Parent = mainFrame
    
    local function createButtonSlot(name, position, text, index, parent)
        local slot = Instance.new("Frame")
        slot.Name = name
        slot.Size = UDim2.new(0, 44, 1, 0)
        slot.Position = position
        slot.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        slot.BorderSizePixel = 0
        slot.Parent = parent
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = slot
        
        local label = Instance.new("TextLabel")
        label.Name = "Text"
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextSize = 24
        label.Font = Enum.Font.GothamBold
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Parent = slot
        
        local clickBtn = Instance.new("TextButton")
        clickBtn.Name = "Click"
        clickBtn.Size = UDim2.new(1, 0, 1, 0)
        clickBtn.BackgroundTransparency = 1
        clickBtn.Text = ""
        clickBtn.Parent = slot
        
        clickBtn.MouseEnter:Connect(function()
            TweenService:Create(slot, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
        end)
        clickBtn.MouseLeave:Connect(function()
            TweenService:Create(slot, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(10, 10, 10)}):Play()
        end)
        clickBtn.MouseButton1Click:Connect(function()
            TweenService:Create(slot, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            task.wait(0.1)
            TweenService:Create(slot, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(10, 10, 10)}):Play()
            smartUnlock(index)
        end)
        return slot
    end
    
    local lockSlot = Instance.new("Frame")
    lockSlot.Name = "LockLogo"
    lockSlot.Size = UDim2.new(0, 44, 1, 0)
    lockSlot.Position = UDim2.new(0, 0, 0, 0)
    lockSlot.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    lockSlot.BorderSizePixel = 0
    lockSlot.Parent = paddingFrame
    
    local lockCorner = Instance.new("UICorner")
    lockCorner.CornerRadius = UDim.new(0, 6)
    lockCorner.Parent = lockSlot
    
    local lockIcon = Instance.new("TextLabel")
    lockIcon.Name = "Icon"
    lockIcon.Size = UDim2.new(1, 0, 1, 0)
    lockIcon.BackgroundTransparency = 1
    lockIcon.Text = "🔓"
    lockIcon.TextSize = 22
    lockIcon.Font = Enum.Font.GothamBold
    lockIcon.Parent = lockSlot
    
    for i = 1, 3 do
        createButtonSlot("Btn" .. i, UDim2.new(0, 48 + ((i-1) * 48), 0, 0), tostring(i), i, paddingFrame)
    end
    
    print("Lockpick UI Loaded")
    return services
end
