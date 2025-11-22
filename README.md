--[[
    🌟 NAIT HUB - Ícone + Menu Abre/Fecha
--]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- 🖥️ ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "NaitHubGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- 🎯 Ícone de abertura (pequeno e redondo)
local iconButton = Instance.new("ImageButton")
iconButton.Name = "NaitHubIcon"
iconButton.Size = UDim2.new(0, 50, 0, 50)
iconButton.Position = UDim2.new(0, 15, 0, 15)
iconButton.BackgroundTransparency = 1
iconButton.Image = "rbxassetid://3926305904" -- Ícone simples padrão Roblox (pode trocar)
iconButton.ImageRectOffset = Vector2.new(4, 4)
iconButton.ImageRectSize = Vector2.new(36, 36)
iconButton.Parent = gui

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = iconButton

-- 📦 Menu principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 120)
frame.Position = UDim2.new(0, 75, 0, 15)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = frame

-- ✨ Texto
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.Text = "🌐 NAIT HUB"
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Parent = frame

-- 🔽 Sombra
local shadow = Instance.new("ImageLabel")
shadow.Parent = frame
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0.5, -15, 0.5, -15)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.55
shadow.ZIndex = -1

-- 🟢 Abrir / Fechar ao clicar no ícone
local aberto = false

iconButton.MouseButton1Click:Connect(function()
    aberto = not aberto
    frame.Visible = aberto
end)

print("🔥 NAIT HUB carregado com ícone clicável.")
