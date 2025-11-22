--[[
    NAIT HUB - PC VERSION
    Ícone que abre e fecha o menu com animação
    Desenvolvido para você não ter que mexer em nada :)
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer

-- Criar GUI principal
local NaitHub = Instance.new("ScreenGui")
NaitHub.Name = "NaitHub"
NaitHub.Parent = Player:WaitForChild("PlayerGui")
NaitHub.ResetOnSpawn = false

---------------------------------------------------------------------
-- BOTÃO QUE ABRE/FECHA O MENU
---------------------------------------------------------------------

local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = NaitHub
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
ToggleButton.BackgroundTransparency = 1
ToggleButton.Image = "rbxassetid://3926305904"
ToggleButton.ImageRectOffset = Vector2.new(4, 364)
ToggleButton.ImageRectSize = Vector2.new(36, 36)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = ToggleButton

---------------------------------------------------------------------
-- MAIN MENU (seu layout principal adaptado)
---------------------------------------------------------------------

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = NaitHub
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0, 100, 0.5, -200)
MainFrame.Visible = false

local mf_corner = Instance.new("UICorner")
mf_corner.CornerRadius = UDim.new(0, 15)
mf_corner.Parent = MainFrame

-- Título dentro do menu
local Titulo = Instance.new("TextLabel")
Titulo.Parent = MainFrame
Titulo.Size = UDim2.new(1, 0, 0, 50)
Titulo.Text = "🌐 NAIT HUB"
Titulo.Font = Enum.Font.GothamBold
Titulo.TextScaled = true
Titulo.BackgroundTransparency = 1
Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)

---------------------------------------------------------------------
-- ANIMAÇÕES DE ABRIR E FECHAR
---------------------------------------------------------------------

local aberto = false

local function AbrirMenu()
    aberto = true
    MainFrame.Visible = true

    TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 520, 0, 350)
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

-- Clicar no botão alterna entre abrir/fechar
ToggleButton.MouseButton1Click:Connect(function()
    if aberto then
        FecharMenu()
    else
        AbrirMenu()
    end
end)

print("🔥 NAIT HUB PC carregado com sucesso!")
