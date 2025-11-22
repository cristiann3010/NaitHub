-- Nait Hub - Sistema de Speed e Jump
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configurações do Nait Hub
local NaitHub = {
    Enabled = false,
    OriginalWalkSpeed = 16,
    OriginalJumpPower = 50,
    BoostedWalkSpeed = 50,  -- Velocidade aumentada
    BoostedJumpPower = 100, -- Pulo aumentado
    Hotkey = Enum.KeyCode.F  -- Tecla para ativar/desativar
}

-- Variáveis globais
local character, humanoid
local screenGui, statusLabel

-- Função para criar a interface
local function CreateGUI()
    -- Verificar se já existe e remover
    if playerGui:FindFirstChild("NaitHubGUI") then
        playerGui.NaitHubGUI:Destroy()
    end
    
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NaitHubGUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 120)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 100, 255)
    stroke.Thickness = 2
    stroke.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    title.Text = "🎮 NAIT HUB"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = title

    statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -20, 0, 30)
    statusLabel.Position = UDim2.new(0, 10, 0, 40)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "STATUS: DESATIVADO"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.Parent = frame

    local speedLabel = Instance.new("TextLabel")
    speedLabel.Size = UDim2.new(1, -20, 0, 20)
    speedLabel.Position = UDim2.new(0, 10, 0, 70)
    speedLabel.BackgroundTransparency = 1
    speedLabel.Text = "SPEED: " .. NaitHub.OriginalWalkSpeed
    speedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    speedLabel.TextScaled = true
    speedLabel.Font = Enum.Font.Gotham
    speedLabel.Parent = frame

    local jumpLabel = Instance.new("TextLabel")
    jumpLabel.Size = UDim2.new(1, -20, 0, 20)
    jumpLabel.Position = UDim2.new(0, 10, 0, 90)
    jumpLabel.BackgroundTransparency = 1
    jumpLabel.Text = "JUMP: " .. NaitHub.OriginalJumpPower
    jumpLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    jumpLabel.TextScaled = true
    jumpLabel.Font = Enum.Font.Gotham
    jumpLabel.Parent = frame

    return screenGui, statusLabel, speedLabel, jumpLabel
end

-- Função para inicializar o personagem
local function InitializeCharacter()
    character = player.Character
    if character then
        humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            NaitHub.OriginalWalkSpeed = humanoid.WalkSpeed
            NaitHub.OriginalJumpPower = humanoid.JumpPower
            print("✅ Personagem inicializado - Speed: " .. NaitHub.OriginalWalkSpeed .. " | Jump: " .. NaitHub.OriginalJumpPower)
        end
    end
end

-- Função para aplicar os boosts
local function ApplyBoosts()
    if not humanoid then return end
    
    if NaitHub.Enabled then
        -- Ativar boosts
        humanoid.WalkSpeed = NaitHub.BoostedWalkSpeed
        humanoid.JumpPower = NaitHub.BoostedJumpPower
        statusLabel.Text = "STATUS: ATIVADO 🚀"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        -- Desativar boosts
        humanoid.WalkSpeed = NaitHub.OriginalWalkSpeed
        humanoid.JumpPower = NaitHub.OriginalJumpPower
        statusLabel.Text = "STATUS: DESATIVADO"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end

-- Função para alternar o Nait Hub
local function ToggleNaitHub()
    NaitHub.Enabled = not NaitHub.Enabled
    
    if NaitHub.Enabled then
        print("🎮 Nait Hub - MODE: TURBO 🚀")
        print("⚡ Speed: " .. NaitHub.BoostedWalkSpeed)
        print("🦘 Jump: " .. NaitHub.BoostedJumpPower)
    else
        print("🎮 Nait Hub - MODE: NORMAL")
        print("⚡ Speed: " .. NaitHub.OriginalWalkSpeed)
        print("🦘 Jump: " .. NaitHub.OriginalJumpPower)
    end
    
    ApplyBoosts()
end

-- Inicializar
wait(2) -- Esperar o jogo carregar

-- Criar a interface
CreateGUI()

-- Configurar o hotkey
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == NaitHub.Hotkey then
        ToggleNaitHub()
    end
end)

-- Inicializar quando o personagem spawnar
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    wait(1) -- Esperar o personagem carregar completamente
    InitializeCharacter()
    
    -- Reaplicar boosts se estiver ativado
    if NaitHub.Enabled then
        wait(0.5)
        ApplyBoosts()
    end
end)

-- Inicializar personagem atual
InitializeCharacter()

-- Mensagem de inicialização
print("======================================")
print("🎮 NAIT HUB CARREGADO COM SUCESSO!")
print("📌 HOTKEY: F")
print("⚡ SPEED BOOST: " .. NaitHub.BoostedWalkSpeed)
print("🦘 JUMP BOOST: " .. NaitHub.BoostedJumpPower)
print("======================================")

-- Loop para atualizar interface
local connection
connection = RunService.Heartbeat:Connect(function()
    if humanoid and statusLabel then
        if NaitHub.Enabled then
            statusLabel.Text = "STATUS: ATIVADO 🚀"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            statusLabel.Text = "STATUS: DESATIVADO"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end
end)
