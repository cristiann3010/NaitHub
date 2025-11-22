--[[
    🌟 NAIT HUB - Interface Simples e Estilizada
    Criado automaticamente pelo ChatGPT
--]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- 🖥️ ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "NaitHubGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- 📦 Container Principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 90)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.25
frame.BorderSizePixel = 0
frame.Parent = gui

-- 🔵 Bordas Arredondadas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- ✨ Texto
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.Text = "🌐 NAIT HUB\nPressione F"
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
shadow.ImageTransparency = 0.5
shadow.ZIndex = -1

print("🎮 NAIT HUB - Interface criada com sucesso!")
