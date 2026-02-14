-- CHLIP HUB V1 - CHUNK 8: Main Features UI Elements
return function(services)
    local mf = services.MainFeaturesUI
    local TweenService = mf.TweenService
    local leftColumnMF = mf.leftColumn
    local rightColumnMF = mf.rightColumn
    local player = mf.player
    
    local function createToggleSwitchMF(name, parent, position)
        local toggleContainer = Instance.new("Frame")
        toggleContainer.Name = name .. "Container"
        toggleContainer.Size = UDim2.new(1, -8, 0, 40)
        toggleContainer.Position = position
        toggleContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        toggleContainer.BorderSizePixel = 0
        toggleContainer.Parent = parent
        
        local containerCorner = Instance.new("UICorner")
        containerCorner.CornerRadius = UDim.new(0, 8)
        containerCorner.Parent = toggleContainer
        
        local containerStroke = Instance.new("UIStroke")
        containerStroke.Color = Color3.fromRGB(255, 255, 255)
        containerStroke.Thickness = 1
        containerStroke.Parent = toggleContainer
        
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Size = UDim2.new(0.5, 0, 1, 0)
        label.Position = UDim2.new(0, 8, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 11
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = toggleContainer
        
        local switchBg = Instance.new("Frame")
        switchBg.Name = "SwitchBg"
        switchBg.Size = UDim2.new(0, 40, 0, 20)
        switchBg.Position = UDim2.new(1, -48, 0.5, -10)
        switchBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        switchBg.BorderSizePixel = 0
        switchBg.Parent = toggleContainer
        
        local switchBgCorner = Instance.new("UICorner")
        switchBgCorner.CornerRadius = UDim.new(1, 0)
        switchBgCorner.Parent = switchBg
        
        local switchCircle = Instance.new("Frame")
        switchCircle.Name = "Circle"
        switchCircle.Size = UDim2.new(0, 16, 0, 16)
        switchCircle.Position = UDim2.new(0, 2, 0.5, -8)
        switchCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        switchCircle.BorderSizePixel = 0
        switchCircle.Parent = switchBg
        
        local switchCircleCorner = Instance.new("UICorner")
        switchCircleCorner.CornerRadius = UDim.new(1, 0)
        switchCircleCorner.Parent = switchCircle
        
        local clickArea = Instance.new("TextButton")
        clickArea.Name = "ClickArea"
        clickArea.Size = UDim2.new(1, 0, 1, 0)
        clickArea.BackgroundTransparency = 1
        clickArea.Text = ""
        clickArea.Parent = toggleContainer
        
        return {
            container = toggleContainer,
            switchBg = switchBg,
            switchCircle = switchCircle,
            clickArea = clickArea,
            enabled = false
        }
    end
    
    local function createFeatureButtonMF(name, parent, position)
        local btn = Instance.new("TextButton")
        btn.Name = name .. "Btn"
        btn.Size = UDim2.new(1, -8, 0, 40)
        btn.Position = position
        btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamBold
        btn.Parent = parent
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
        
        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = Color3.fromRGB(255, 255, 255)
        btnStroke.Thickness = 1
        btnStroke.Parent = btn
        
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(15, 15, 15)}):Play()
        end)
        return btn
    end
    
    local toggle1MF = createToggleSwitchMF("Auto Grab", leftColumnMF, UDim2.new(0, 4, 0, 8))
    local toggle2MF = createToggleSwitchMF("Esp Best", leftColumnMF, UDim2.new(0, 4, 0, 54))
    local toggle3MF = createToggleSwitchMF("Esp Timer", leftColumnMF, UDim2.new(0, 4, 0, 100))
    local toggle4MF = createToggleSwitchMF("Disable Anim", leftColumnMF, UDim2.new(0, 4, 0, 146))
    
    local btn1MF = createFeatureButtonMF("Anti Ragdoll", rightColumnMF, UDim2.new(0, 4, 0, 8))
    local btn2MF = createFeatureButtonMF("Cloner", rightColumnMF, UDim2.new(0, 4, 0, 54))
    local btn3MF = createFeatureButtonMF("Kick", rightColumnMF, UDim2.new(0, 4, 0, 100))
    local btn4MF = createFeatureButtonMF("Rejoin", rightColumnMF, UDim2.new(0, 4, 0, 146))
    
    local function animateToggleMF(toggleData, enabled)
        toggleData.enabled = enabled
        if enabled then
            TweenService:Create(toggleData.switchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 0)}):Play()
            TweenService:Create(toggleData.switchCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 22, 0.5, -8)}):Play()
        else
            TweenService:Create(toggleData.switchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            TweenService:Create(toggleData.switchCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        end
    end
    
    mf.toggles = {toggle1MF, toggle2MF, toggle3MF, toggle4MF}
    mf.buttons = {btn1MF, btn2MF, btn3MF, btn4MF}
    mf.animateToggle = animateToggleMF
    
    print("Main Features UI Elements Loaded")
    return services
end
