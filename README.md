-- NAIT HUB - PC VERSION FINAL
-- Ícone abre/fecha + Menu central + Sistema arrastável

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer

---------------------------------------------------------------------
-- GUI PRINCIPAL
---------------------------------------------------------------------

local NaitHub = Instance.new("ScreenGui")
NaitHub.Name = "NaitHub"
NaitHub.Parent = Player:WaitForChild("PlayerGui")
NaitHub.ResetOnSpawn = false

---------------------------------------------------------------------
-- BOTÃO DE ABRIR/FECHAR
---------------------------------------------------------------------

local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = NaitHub
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundTransparency = 1
ToggleButton.Image = "rbxassetid://3926305904"
ToggleButton.ImageRectOffset = Vector2.new(4, 364)
ToggleButton.ImageRectSize = Vector2.new(36, 36)

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = ToggleButton

---------------------------------------------------------------------
-- MENU PRINCIPAL
---------------------------------------------------------------------

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = NaitHub
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 18)
frameCorner.Parent = MainFrame

-- TÍTULO
local Header = Instance.new("TextLabel")
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 60)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundTransparency = 1
Header.Font = Enum.Font.GothamBold
Header.TextScaled = true
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.Text = "🌐  NAIT HUB"

---------------------------------------------------------------------
-- SISTEMA DE ABRIR E FECHAR
---------------------------------------------------------------------

local aberto = false

local function AbrirMenu()
	aberto = true
	MainFrame.Visible = true

	TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
		Size = UDim2.new(0, 520, 0, 360)
	}):Play()
end

local function FecharMenu()
	aberto = false

	local tween = TweenService:Create(MainFrame, TweenInfo.new(0.25), {
		Size = UDim2.new(0, 0, 0, 0)
	})
	tween:Play()

	tween.Completed:Connect(function()
		MainFrame.Visible = false
	end)
end

ToggleButton.MouseButton1Click:Connect(function()
	if aberto then
		FecharMenu()
	else
		AbrirMenu()
	end
end)

---------------------------------------------------------------------
-- SISTEMA DE ARRASTAR O MENU (pegar com mouse)
---------------------------------------------------------------------

local dragging = false
local dragStart
local startPos

Header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

Header.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

print("🔥 NAIT HUB PC carregado 100% ajustado!")
