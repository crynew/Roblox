local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Config = {
    isEnabled = false,
    maxDistance = 20,
    removeDistance = 500,
    toggleKey = Enum.KeyCode.E,
    excludedPlayers = {},
    isMinimized = false,
    currentTab = "Settings"
}

local DiscordConfig = {
    inviteLink = "https://discord.gg/erro"
}

local function createNotification(message, type)
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "Notification"
    NotificationGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Size = UDim2.new(0, 250, 0, 60)
    NotificationFrame.Position = UDim2.new(1, 20, 0.8, 0)
    NotificationFrame.BackgroundColor3 = type == "success" and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
    NotificationFrame.BackgroundTransparency = 0.1
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.Parent = NotificationGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = NotificationFrame
    
    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Size = UDim2.new(1, -20, 1, 0)
    MessageLabel.Position = UDim2.new(0, 10, 0, 0)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Font = Enum.Font.GothamBold
    MessageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MessageLabel.TextSize = 14
    MessageLabel.Text = message
    MessageLabel.TextWrapped = true
    MessageLabel.Parent = NotificationFrame
    
    local slideIn = TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
        Position = UDim2.new(1, -270, 0.8, 0)
    })
    
    local fadeOut = TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
        Position = UDim2.new(1, 20, 0.8, 0),
        BackgroundTransparency = 1
    })
    
    slideIn:Play()
    wait(2.5)
    fadeOut:Play()
    fadeOut.Completed:Connect(function()
        NotificationGui:Destroy()
    end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "CameraConfig"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(1, 20, 0.2, 0)
MainFrame.Size = UDim2.new(0, 800, 0, 500)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BorderSizePixel = 0

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Camera Config"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Parent = TopBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
MinimizeButton.Position = UDim2.new(1, -80, 0, 5)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 8)
MinimizeCorner.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 200, 1, -40)

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local UserProfile = Instance.new("Frame")
UserProfile.Name = "UserProfile"
UserProfile.Parent = Sidebar
UserProfile.BackgroundTransparency = 1
UserProfile.Position = UDim2.new(0, 20, 0, 20)
UserProfile.Size = UDim2.new(1, -40, 0, 100)

local UserAvatar = Instance.new("ImageLabel")
UserAvatar.Name = "UserAvatar"
UserAvatar.Parent = UserProfile
UserAvatar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
UserAvatar.Size = UDim2.new(0, 60, 0, 60)
UserAvatar.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = UserAvatar

local UserName = Instance.new("TextLabel")
UserName.Name = "UserName"
UserName.Parent = UserProfile
UserName.BackgroundTransparency = 1
UserName.Position = UDim2.new(0, 20, 0, 20)
UserName.Size = UDim2.new(1, 0, 0, 20)
UserName.Font = Enum.Font.GothamBold
UserName.Text = LocalPlayer.DisplayName
UserName.TextColor3 = Color3.fromRGB(255, 255, 255)
UserName.TextSize = 16

local function createNavButton(name, position)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Parent = Sidebar
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    button.Position = UDim2.new(0, 20, 0, position)
    button.Size = UDim2.new(1, -40, 0, 40)
    button.Font = Enum.Font.GothamSemibold
    button.Text = "  " .. name
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.TextSize = 14
    button.TextXAlignment = Enum.TextXAlignment.Left
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    local hoverTween = TweenService:Create(button, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    })
    
    button.MouseEnter:Connect(function()
        if Config.currentTab ~= name then
            hoverTween:Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if Config.currentTab ~= name then
            button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        end
    end)
    
    return button
end

local settingsButton = createNavButton("Settings", 100)
local playersButton = createNavButton("Players", 150)
local discordButton = createNavButton("Discord", 200)

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ContentArea.BorderSizePixel = 0
ContentArea.Position = UDim2.new(0, 220, 0, 60)
ContentArea.Size = UDim2.new(1, -240, 1, -80)

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 12)
ContentCorner.Parent = ContentArea

local SettingsContent = Instance.new("Frame")
SettingsContent.Name = "SettingsContent"
SettingsContent.Parent = ContentArea
SettingsContent.BackgroundTransparency = 1
SettingsContent.Size = UDim2.new(1, 0, 1, 0)
SettingsContent.Visible = true

local function createSettingSection(title, position)
    local section = Instance.new("Frame")
    section.BackgroundTransparency = 1
    section.Position = UDim2.new(0, 20, 0, position)
    section.Size = UDim2.new(1, -40, 0, 70)
    section.Parent = SettingsContent
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = section
    
    return section
end

local distanceSection = createSettingSection("Distance Settings", 20)
local keybindSection = createSettingSection("Keybind", 110)
local toggleSection = createSettingSection("Toggle Camera Focus", 200)

local function createInputField(parent, label, defaultValue, yPos)
    local container = Instance.new("Frame")
    container.BackgroundTransparency = 1
    container.Position = UDim2.new(0, 0, 0, yPos)
    container.Size = UDim2.new(1, 0, 0, 30)
    container.Parent = parent
    
    local inputLabel = Instance.new("TextLabel")
    inputLabel.BackgroundTransparency = 1
    inputLabel.Size = UDim2.new(0.7, 0, 1, 0)
    inputLabel.Font = Enum.Font.GothamSemibold
    inputLabel.Text = label
    inputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    inputLabel.TextSize = 14
    inputLabel.TextXAlignment = Enum.TextXAlignment.Left
    inputLabel.Parent = container
    
    local input = Instance.new("TextBox")
    input.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    input.Position = UDim2.new(0.7, 0, 0, 0)
    input.Size = UDim2.new(0.3, -20, 1, 0)
    input.Font = Enum.Font.GothamSemibold
    input.Text = tostring(defaultValue)
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.TextSize = 14
    input.Parent = container
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = input
    
    return input
end

local maxDistanceInput = createInputField(distanceSection, "Max Focus Distance", Config.maxDistance, 30)
local removeDistanceInput = createInputField(distanceSection, "Remove Distance", Config.removeDistance, 70)

local keybindButton = Instance.new("TextButton")
keybindButton.Position = UDim2.new(0, 0, 0, 30)
keybindButton.Size = UDim2.new(0.3, 0, 0, 40)
keybindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
keybindButton.Font = Enum.Font.GothamSemibold
keybindButton.Text = Config.toggleKey.Name
keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
keybindButton.TextSize = 14
keybindButton.Parent = keybindSection

local keybindCorner = Instance.new("UICorner")
keybindCorner.CornerRadius = UDim.new(0, 8)
keybindCorner.Parent = keybindButton

local toggleButton = Instance.new("TextButton")
toggleButton.Position = UDim2.new(0, 0, 0, 30)
toggleButton.Size = UDim2.new(0.3, 0, 0, 40)
toggleButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "DISABLED"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 14
toggleButton.Parent = toggleSection

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

local PlayersContent = Instance.new("Frame")
PlayersContent.Name = "PlayersContent"
PlayersContent.Parent = ContentArea
PlayersContent.BackgroundTransparency = 1
PlayersContent.Size = UDim2.new(1, 0, 1, 0)
PlayersContent.Visible = false

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Name = "PlayerList"
PlayerList.Parent = PlayersContent
PlayerList.BackgroundTransparency = 1
PlayerList.Position = UDim2.new(0, 20, 0, 20)
PlayerList.Size = UDim2.new(1, -40, 1, -40)
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.ScrollBarThickness = 4
PlayerList.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = PlayerList
UIListLayout.SortOrder = Enum.SortOrder.Name
UIListLayout.Padding = UDim.new(0, 10)

local function updatePlayerList()
    for _, child in pairs(PlayerList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local playerFrame = Instance.new("Frame")
            playerFrame.Size = UDim2.new(1, 0, 0, 60)
            playerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            
            local playerCorner = Instance.new("UICorner")
            playerCorner.CornerRadius = UDim.new(0, 8)
            playerCorner.Parent = playerFrame
            
            local playerAvatar = Instance.new("ImageLabel")
            playerAvatar.Position = UDim2.new(0, 10, 0.5, -20)
            playerAvatar.Size = UDim2.new(0, 40, 0, 40)
            playerAvatar.BackgroundTransparency = 1
            playerAvatar.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
            playerAvatar.Parent = playerFrame
            
            local avatarCorner = Instance.new("UICorner")
            avatarCorner.CornerRadius = UDim.new(1, 0)
            avatarCorner.Parent = playerAvatar
            
            local playerName = Instance.new("TextLabel")
            playerName.Position = UDim2.new(0, 60, 0, 0)
            playerName.Size = UDim2.new(1, -180, 1, 0)
            playerName.BackgroundTransparency = 1
            playerName.Font = Enum.Font.GothamSemibold
            playerName.Text = player.Name
            playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerName.TextSize = 14
            playerName.TextXAlignment = Enum.TextXAlignment.Left
            playerName.Parent = playerFrame
            
            local toggleButton = Instance.new("TextButton")
            toggleButton.Position = UDim2.new(1, -110, 0.5, -15)
            toggleButton.Size = UDim2.new(0, 100, 0, 30)
            toggleButton.BackgroundColor3 = Config.excludedPlayers[player.Name] and Color3.fromRGB(231, 76, 60) or Color3.fromRGB(46, 204, 113)
            toggleButton.Font = Enum.Font.GothamBold
            toggleButton.Text = Config.excludedPlayers[player.Name] and "EXCLUDED" or "INCLUDED"
            toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleButton.TextSize = 12
            toggleButton.Parent = playerFrame
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 6)
            toggleCorner.Parent = toggleButton
            
            toggleButton.MouseButton1Click:Connect(function()
                Config.excludedPlayers[player.Name] = not Config.excludedPlayers[player.Name]
                local targetColor = Config.excludedPlayers[player.Name] and Color3.fromRGB(231, 76, 60) or Color3.fromRGB(46, 204, 113)
                local targetText = Config.excludedPlayers[player.Name] and "EXCLUDED" or "INCLUDED"
                
                local colorTween = TweenService:Create(toggleButton, TweenInfo.new(0.3), {
                    BackgroundColor3 = targetColor
                })
                colorTween:Play()
                toggleButton.Text = targetText
                
                createNotification(string.format("Player %s %s", player.Name, 
                    Config.excludedPlayers[player.Name] and "excluded from camera focus" or "included in camera focus"),
                    Config.excludedPlayers[player.Name] and "error" or "success")
            end)
            
            playerFrame.Parent = PlayerList
        end
    end
    
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end

local function getNearestPlayer()
    local nearestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not Config.excludedPlayers[player.Name] and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance and distance <= Config.maxDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end
    
    return nearestPlayer
end

local function removeFarObjects(player)
    local character = player.Character
    if character then
        for _, part in pairs(workspace:GetChildren()) do
            if part:IsA("BasePart") then
                local distance = (part.Position - character.HumanoidRootPart.Position).Magnitude
                if distance > Config.removeDistance then
                    part:Destroy()
                end
            end
        end
    end
end

local function focusCameraOnNearestPlayer()
    if Config.isEnabled then
        local nearestPlayer = getNearestPlayer()
        if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, nearestPlayer.Character.HumanoidRootPart.Position)
        end
    end
end

local function switchTab(tabName)
    Config.currentTab = tabName
    SettingsContent.Visible = tabName == "Settings"
    PlayersContent.Visible = tabName == "Players"
    
    local buttons = {settingsButton, playersButton}
    for _, button in pairs(buttons) do
        button.BackgroundColor3 = button.Name:sub(1, -7) == tabName and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(30, 30, 35)
        button.TextColor3 = button.Name:sub(1, -7) == tabName and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
    end
end

local function toggleMinimize()
    Config.isMinimized = not Config.isMinimized
    local targetSize = Config.isMinimized and UDim2.new(0, 800, 0, 40) or UDim2.new(0, 800, 0, 500)
    local targetText = Config.isMinimized and "+" or "-"
    
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
        Size = targetSize
    })
    tween:Play()
    
    MinimizeButton.Text = targetText
    Sidebar.Visible = not Config.isMinimized
    ContentArea.Visible = not Config.isMinimized
end

local function closeGui()
    local slideOut = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
        Position = UDim2.new(1, 20, 0.2, 0)
    })
    slideOut:Play()
    slideOut.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end

local isChangingKeybind = false

keybindButton.MouseButton1Click:Connect(function()
    if not isChangingKeybind then
        isChangingKeybind = true
        keybindButton.Text = "PRESS ANY KEY"
        keybindButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        
        local connection
        connection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                Config.toggleKey = input.KeyCode
                keybindButton.Text = input.KeyCode.Name
                keybindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                isChangingKeybind = false
                connection:Disconnect()
                createNotification("Keybind updated to " .. input.KeyCode.Name, "success")
            end
        end)
    end
end)

toggleButton.MouseButton1Click:Connect(function()
    Config.isEnabled = not Config.isEnabled
    local targetColor = Config.isEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
    local targetText = Config.isEnabled and "ENABLED" or "DISABLED"
    
    local colorTween = TweenService:Create(toggleButton, TweenInfo.new(0.3), {
        BackgroundColor3 = targetColor
    })
    colorTween:Play()
    toggleButton.Text = targetText
    
    createNotification(Config.isEnabled and "Camera focus enabled" or "Camera focus disabled",
        Config.isEnabled and "success" or "error")
end)

maxDistanceInput.FocusLost:Connect(function()
    local newValue = tonumber(maxDistanceInput.Text)
    if newValue then
        Config.maxDistance = newValue
        createNotification("Max focus distance updated to " .. newValue, "success")
    else
        maxDistanceInput.Text = tostring(Config.maxDistance)
        createNotification("Invalid distance value", "error")
    end
end)

removeDistanceInput.FocusLost:Connect(function()
    local newValue = tonumber(removeDistanceInput.Text)
    if newValue then
        Config.removeDistance = newValue
        createNotification("Remove distance updated to " .. newValue, "success")
    else
        removeDistanceInput.Text = tostring(Config.removeDistance)
        createNotification("Invalid distance value", "error")
    end
end)

settingsButton.MouseButton1Click:Connect(function()
    switchTab("Settings")
end)

playersButton.MouseButton1Click:Connect(function()
    switchTab("Players")
end)

discordButton.MouseButton1Click:Connect(function()
    setclipboard(DiscordConfig.inviteLink)
    createNotification("Discord invite copied to clipboard!", "success")
end)

MinimizeButton.MouseButton1Click:Connect(toggleMinimize)
CloseButton.MouseButton1Click:Connect(closeGui)

local function addButtonHover(button)
    local originalColor = button.BackgroundColor3
    local hoverTween = TweenService:Create(button, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(
            originalColor.R * 255 * 1.1,
            originalColor.G * 255 * 1.1,
            originalColor.B * 255 * 1.1
        )
    })
    local normalTween = TweenService:Create(button, TweenInfo.new(0.2), {
        BackgroundColor3 = originalColor
    })
    
    button.MouseEnter:Connect(function() hoverTween:Play() end)
    button.MouseLeave:Connect(function() normalTween:Play() end)
end

addButtonHover(MinimizeButton)
addButtonHover(CloseButton)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Config.toggleKey then
        Config.isEnabled = not Config.isEnabled
        local targetColor = Config.isEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
        local targetText = Config.isEnabled and "ENABLED" or "DISABLED"
        
        local colorTween = TweenService:Create(toggleButton, TweenInfo.new(0.3), {
            BackgroundColor3 = targetColor
        })
        colorTween:Play()
        toggleButton.Text = targetText
        
        createNotification(Config.isEnabled and "Camera focus enabled" or "Camera focus disabled",
            Config.isEnabled and "success" or "error")
    end
end)

Players.PlayerAdded:Connect(function(player)
    updatePlayerList()
    player.CharacterAdded:Connect(function()
        removeFarObjects(player)
    end)
end)

Players.PlayerRemoving:Connect(updatePlayerList)

RunService.RenderStepped:Connect(function()
    focusCameraOnNearestPlayer()
    removeFarObjects(LocalPlayer)
end)

updatePlayerList()
switchTab("Settings")

local slideIn = TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Quart), {
    Position = UDim2.new(1, -820, 0.2, 0)
})
slideIn:Play()