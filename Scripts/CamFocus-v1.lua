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
    excludedPlayers = {}
}

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(1, -420, 0.2, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local ToggleButton = Instance.new("TextButton", MainFrame)
ToggleButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Size = UDim2.new(0, 100, 0, 30)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "DISABLED"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 8)

local MaxDistanceInput = Instance.new("TextBox", MainFrame)
MaxDistanceInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
MaxDistanceInput.Position = UDim2.new(0, 10, 0, 50)
MaxDistanceInput.Size = UDim2.new(0, 100, 0, 30)
MaxDistanceInput.Font = Enum.Font.GothamSemibold
MaxDistanceInput.Text = tostring(Config.maxDistance)
MaxDistanceInput.TextColor3 = Color3.fromRGB(255, 255, 255)
MaxDistanceInput.TextSize = 14
Instance.new("UICorner", MaxDistanceInput).CornerRadius = UDim.new(0, 6)

local RemoveDistanceInput = Instance.new("TextBox", MainFrame)
RemoveDistanceInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
RemoveDistanceInput.Position = UDim2.new(0, 10, 0, 90)
RemoveDistanceInput.Size = UDim2.new(0, 100, 0, 30)
RemoveDistanceInput.Font = Enum.Font.GothamSemibold
RemoveDistanceInput.Text = tostring(Config.removeDistance)
RemoveDistanceInput.TextColor3 = Color3.fromRGB(255, 255, 255)
RemoveDistanceInput.TextSize = 14
Instance.new("UICorner", RemoveDistanceInput).CornerRadius = UDim.new(0, 6)

local KeybindButton = Instance.new("TextButton", MainFrame)
KeybindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
KeybindButton.Position = UDim2.new(0, 10, 0, 130)
KeybindButton.Size = UDim2.new(0, 100, 0, 30)
KeybindButton.Font = Enum.Font.GothamSemibold
KeybindButton.Text = Config.toggleKey.Name
KeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KeybindButton.TextSize = 14
Instance.new("UICorner", KeybindButton).CornerRadius = UDim.new(0, 8)

local PlayerList = Instance.new("ScrollingFrame", MainFrame)
PlayerList.BackgroundTransparency = 1
PlayerList.Position = UDim2.new(0, 120, 0, 10)
PlayerList.Size = UDim2.new(0, 270, 0, 280)
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout", PlayerList)
UIListLayout.SortOrder = Enum.SortOrder.Name
UIListLayout.Padding = UDim.new(0, 5)

local function getNearestPlayer()
    local nearestPlayer, shortestDistance = nil, math.huge
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

local function focusCamera()
    if Config.isEnabled then
        local nearestPlayer = getNearestPlayer()
        if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, nearestPlayer.Character.HumanoidRootPart.Position)
        end
    end
end

local function updatePlayerList()
    for _, child in pairs(PlayerList:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local playerFrame = Instance.new("Frame", PlayerList)
            playerFrame.Size = UDim2.new(1, 0, 0, 40)
            playerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            Instance.new("UICorner", playerFrame).CornerRadius = UDim.new(0, 6)

            local playerName = Instance.new("TextLabel", playerFrame)
            playerName.Position = UDim2.new(0, 10, 0, 0)
            playerName.Size = UDim2.new(0, 150, 1, 0)
            playerName.BackgroundTransparency = 1
            playerName.Font = Enum.Font.GothamSemibold
            playerName.Text = player.Name
            playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerName.TextSize = 14
            playerName.TextXAlignment = Enum.TextXAlignment.Left

            local excludeButton = Instance.new("TextButton", playerFrame)
            excludeButton.Position = UDim2.new(1, -100, 0, 5)
            excludeButton.Size = UDim2.new(0, 90, 0, 30)
            excludeButton.BackgroundColor3 = Config.excludedPlayers[player.Name] and Color3.fromRGB(231, 76, 60) or Color3.fromRGB(46, 204, 113)
            excludeButton.Font = Enum.Font.GothamBold
            excludeButton.Text = Config.excludedPlayers[player.Name] and "EXCLUDED" or "INCLUDED"
            excludeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            excludeButton.TextSize = 12
            Instance.new("UICorner", excludeButton).CornerRadius = UDim.new(0, 6)

            excludeButton.MouseButton1Click:Connect(function()
                Config.excludedPlayers[player.Name] = not Config.excludedPlayers[player.Name]
                excludeButton.BackgroundColor3 = Config.excludedPlayers[player.Name] and Color3.fromRGB(231, 76, 60) or Color3.fromRGB(46, 204, 113)
                excludeButton.Text = Config.excludedPlayers[player.Name] and "EXCLUDED" or "INCLUDED"
            end)
        end
    end
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end

ToggleButton.MouseButton1Click:Connect(function()
    Config.isEnabled = not Config.isEnabled
    ToggleButton.BackgroundColor3 = Config.isEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
    ToggleButton.Text = Config.isEnabled and "ENABLED" or "DISABLED"
end)

MaxDistanceInput.FocusLost:Connect(function()
    local newValue = tonumber(MaxDistanceInput.Text)
    if newValue then Config.maxDistance = newValue end
    MaxDistanceInput.Text = tostring(Config.maxDistance)
end)

RemoveDistanceInput.FocusLost:Connect(function()
    local newValue = tonumber(RemoveDistanceInput.Text)
    if newValue then Config.removeDistance = newValue end
    RemoveDistanceInput.Text = tostring(Config.removeDistance)
end)

local isChangingKeybind = false
KeybindButton.MouseButton1Click:Connect(function()
    if not isChangingKeybind then
        isChangingKeybind = true
        KeybindButton.Text = "PRESS ANY KEY"
        KeybindButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        local connection
        connection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                Config.toggleKey = input.KeyCode
                KeybindButton.Text = input.KeyCode.Name
                KeybindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                isChangingKeybind = false
                connection:Disconnect()
            end
        end)
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Config.toggleKey then
        Config.isEnabled = not Config.isEnabled
        ToggleButton.BackgroundColor3 = Config.isEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
        ToggleButton.Text = Config.isEnabled and "ENABLED" or "DISABLED"
    end
end)

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
RunService.RenderStepped:Connect(focusCamera)
updatePlayerList()