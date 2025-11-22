-- NAIT HUB - Ícone abre/fecha

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "NaitHubGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Ícone (ImageButton)
local iconButton = Instance.new("ImageButton")
iconButton.Name = "NaitHubIcon"
iconButton.Size = UDim2.new(0, 50, 0, 50)
iconButton.Position = UDim2.new(0, 15, 0, 15)
iconButton.BackgroundTransparency = 1
iconButton.Parent = gui

-- Ícone padrão
iconButton.Image = "rbxassetid://3926307971"
iconButton.ImageRectOffset = Vector2.new(84, 84)
iconButton.ImageRectSize = Vector2.new(36, 36)

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = iconButton

-- Menu
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 120)
frame.Position = UDim2.new(0, 75, 0, 15)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.Text = "🌐 NAIT HUB"
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Parent = frame

-- Toggle abrir/fechar
local aberto = false

iconButton.MouseButton1Click:Connect(function()
    aberto = not aberto
    frame.Visible = aberto
end)

print("NAIT HUB carregado com sucesso!")
