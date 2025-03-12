local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local V1Button = Instance.new("TextButton")
local V2Button = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local Loading = Instance.new("Frame")
local LoadingCircle = Instance.new("Frame")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "CamFocusHub"

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.5, -150, 0.5, -110)
Frame.Size = UDim2.new(0, 0, 0, 0)
Frame.Active = true
Frame.Draggable = true

UICorner.Parent = Frame
UICorner.CornerRadius = UDim.new(0, 25)

Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "CAM FOCUS HUB"
Title.TextColor3 = Color3.fromRGB(200, 200, 200)
Title.TextSize = 28
Title.Font = Enum.Font.GothamBold
Title.TextStrokeTransparency = 0.8
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

V1Button.Parent = Frame
V1Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
V1Button.Position = UDim2.new(0.5, -110, 0, 60)
V1Button.Size = UDim2.new(0, 220, 0, 50)
V1Button.Text = "V1"
V1Button.TextColor3 = Color3.fromRGB(200, 200, 200)
V1Button.TextSize = 22
V1Button.Font = Enum.Font.Gotham
V1Button.BorderSizePixel = 0
local V1Corner = Instance.new("UICorner")
V1Corner.Parent = V1Button
V1Corner.CornerRadius = UDim.new(0, 15)

V2Button.Parent = Frame
V2Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
V2Button.Position = UDim2.new(0.5, -110, 0, 120)
V2Button.Size = UDim2.new(0, 220, 0, 50)
V2Button.Text = "V2"
V2Button.TextColor3 = Color3.fromRGB(200, 200, 200)
V2Button.TextSize = 22
V2Button.Font = Enum.Font.Gotham
V2Button.BorderSizePixel = 0
local V2Corner = Instance.new("UICorner")
V2Corner.Parent = V2Button
V2Corner.CornerRadius = UDim.new(0, 15)

CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
local CloseCorner = Instance.new("UICorner")
CloseCorner.Parent = CloseButton
CloseCorner.CornerRadius = UDim.new(1, 0)

Loading.Parent = ScreenGui
Loading.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Loading.BackgroundTransparency = 0.7
Loading.Size = UDim2.new(1, 0, 1, 0)
Loading.Visible = false

LoadingCircle.Parent = Loading
LoadingCircle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
LoadingCircle.Position = UDim2.new(0.5, -30, 0.5, -30)
LoadingCircle.Size = UDim2.new(0, 60, 0, 60)
local LoadingCorner = Instance.new("UICorner")
LoadingCorner.Parent = LoadingCircle
LoadingCorner.CornerRadius = UDim.new(1, 0)

local function animateLoading()
    Loading.Visible = true
    for i = 1, 720, 20 do
        LoadingCircle.Rotation = i
        LoadingCircle.Size = UDim2.new(0, 60 + math.sin(i/50)*5, 0, 60 + math.sin(i/50)*5)
        wait(0.01)
    end
    Loading.Visible = false
end

Frame:TweenSize(UDim2.new(0, 300, 0, 220), "Out", "Back", 0.4, true)

V1Button.MouseButton1Click:Connect(function()
    V1Button:TweenSize(UDim2.new(0, 200, 0, 45), "Out", "Quad", 0.1, true)
    wait(0.1)
    V1Button:TweenSize(UDim2.new(0, 220, 0, 50), "Out", "Quad", 0.1, true)
    spawn(animateLoading)
    wait(0.5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/crynew/Roblox/refs/heads/main/Scripts/CamFocus-v1.lua"))()
    ScreenGui:Destroy()
end)

V2Button.MouseButton1Click:Connect(function()
    V2Button:TweenSize(UDim2.new(0, 200, 0, 45), "Out", "Quad", 0.1, true)
    wait(0.1)
    V2Button:TweenSize(UDim2.new(0, 220, 0, 50), "Out", "Quad", 0.1, true)
    spawn(animateLoading)
    wait(0.5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/crynew/Roblox/refs/heads/main/Scripts/CamFocus-v2.lua"))()
    ScreenGui:Destroy()
end)

CloseButton.MouseButton1Click:Connect(function()
    Frame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.3, true)
    wait(0.3)
    ScreenGui:Destroy()
end)
