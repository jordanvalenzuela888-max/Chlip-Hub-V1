-- CHLIP HUB V1 - CHUNK 9: Main Features UI Functionality
return function(services)
    local mf = services.MainFeaturesUI
    local TweenService = mf.TweenService
    local UserInputService = mf.UserInputService
    local TeleportService = mf.TeleportService
    local player = mf.player
    local mainFeaturesFrame = mf.frame
    local contentContainer = mf.content
    local minimizeBtn = mf.minimizeBtn
    
    local toggle1MF = mf.toggles[1]
    local toggle2MF = mf.toggles[2]
    local toggle3MF = mf.toggles[3]
    local toggle4MF = mf.toggles[4]
    local btn1MF = mf.buttons[1]
    local btn2MF = mf.buttons[2]
    local btn3MF = mf.buttons[3]
    local btn4MF = mf.buttons[4]
    local animateToggleMF = mf.animateToggle
    
    toggle1MF.clickArea.MouseButton1Click:Connect(function()
        animateToggleMF(toggle1MF, not toggle1MF.enabled)
        print(toggle1MF.enabled and "Auto Grab Enabled ✅" or "Auto Grab Disabled ❌")
    end)
    
    toggle2MF.clickArea.MouseButton1Click:Connect(function()
        animateToggleMF(toggle2MF, not toggle2MF.enabled)
        print(toggle2MF.enabled and "ESP Best Enabled ✅" or "ESP Best Disabled ❌")
    end)
    
    toggle3MF.clickArea.MouseButton1Click:Connect(function()
        animateToggleMF(toggle3MF, not toggle3MF.enabled)
        print(toggle3MF.enabled and "ESP Timer Enabled ✅" or "ESP Timer Disabled ❌")
    end)
    
    toggle4MF.clickArea.MouseButton1Click:Connect(function()
        animateToggleMF(toggle4MF, not toggle4MF.enabled)
        local function setupAnim(char)
            local humanoid = char:WaitForChild("Humanoid")
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do track:Stop() end
            humanoid.AnimationPlayed:Connect(function(track)
                if toggle4MF.enabled then track:Stop() end
            end)
        end
        if toggle4MF.enabled then
            if player.Character then setupAnim(player.Character) end
            player.CharacterAdded:Connect(setupAnim)
            print("Disable Animation Enabled ✅")
        else
            print("Disable Animation Disabled ❌")
        end
    end)
    
    btn1MF.MouseButton1Click:Connect(function()
        local function ApplyAntiRagdoll()
            local char = player.Character
            if not char then return end
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
            humanoid.StateChanged:Connect(function(oldState, newState)
                if newState == Enum.HumanoidStateType.Ragdoll or newState == Enum.HumanoidStateType.FallingDown then
                    humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    task.wait(0.1)
                    humanoid:ChangeState(Enum.HumanoidStateType.Running)
                end
            end)
        end
        ApplyAntiRagdoll()
        player.CharacterAdded:Connect(ApplyAntiRagdoll)
        print("Anti Ragdoll V1 Activated ✅")
    end)
    
    btn2MF.MouseButton1Click:Connect(function()
        local tool = player.Backpack:FindFirstChild("Quantum Cloner") or (player.Character and player.Character:FindFirstChild("Quantum Cloner"))
        if tool then
            local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:EquipTool(tool)
                tool:Activate()
                print("Instant Cloner Fired ✅ (10s cooldown)")
            end
        else
            warn("Quantum Cloner not found!")
        end
    end)
    
    btn3MF.MouseButton1Click:Connect(function()
        player:Kick("Manual Kick Triggered")
    end)
    
    btn4MF.MouseButton1Click:Connect(function()
        TeleportService:Teleport(game.PlaceId, player)
    end)
    
    local minimizedMF = false
    minimizeBtn.MouseButton1Click:Connect(function()
        minimizedMF = not minimizedMF
        if minimizedMF then
            TweenService:Create(mainFeaturesFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 340, 0, 50)}):Play()
            contentContainer.Visible = false
            minimizeBtn.Text = "+"
        else
            TweenService:Create(mainFeaturesFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 340, 0, 280)}):Play()
            task.wait(0.15)
            contentContainer.Visible = true
            minimizeBtn.Text = "−"
        end
    end)
    
    local draggingMF = false
    local dragInputMF, dragStartMF, startPosMF
    mainFeaturesFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMF = true
            dragStartMF = input.Position
            startPosMF = mainFeaturesFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then draggingMF = false end
            end)
        end
    end)
    mainFeaturesFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInputMF = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInputMF and draggingMF then
            local delta = input.Position - dragStartMF
            mainFeaturesFrame.Position = UDim2.new(startPosMF.X.Scale, startPosMF.X.Offset + delta.X, startPosMF.Y.Scale, startPosMF.Y.Offset + delta.Y)
        end
    end)
    
    -- Mobile Toggle Button
    local toggleBtnGui = Instance.new("ScreenGui")
    toggleBtnGui.Name = "ChlipHubToggle"
    toggleBtnGui.Parent = player.PlayerGui
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 60, 0, 40)
    toggleBtn.Position = UDim2.new(1, -70, 0, 10)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.BorderSizePixel = 2
    toggleBtn.Text = "CH"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 20
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = toggleBtnGui
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleBtn
    
    toggleBtn.MouseButton1Click:Connect(function()
        mf.gui.Enabled = not mf.gui.Enabled
    end)
    
    print("Chlip Hub V1 Fully Loaded ✅ - Press 'CH' button to toggle Main Features")
    return services
end
