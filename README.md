-- Nait Hub - Sistema de Speed e Jump
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Configurações do Nait Hub
local NaitHub = {
    Enabled = false,
    OriginalWalkSpeed = humanoid.WalkSpeed,
    OriginalJumpPower = humanoid.JumpPower,
    BoostedWalkSpeed = 50,  -- Velocidade aumentada
    BoostedJumpPower = 100, -- Pulo aumentado
    Hotkey = Enum.KeyCode.F  -- Tecla para ativar/desativar
}

-- Função para criar a interface
local function CreateGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NaitHubGUI"
    screenGui.Parent = player.PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    title.Text = "🎮 Nait Hub"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0, 30)
    statusLabel.Position = UDim2.new(0, 0, 0, 35)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Status: Desativado"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = frame

    local hintLabel = Instance.new("TextLabel")
    hintLabel.Size = UDim2.new(1, 0, 0, 30)
    hintLabel.Position = UDim2.new(0, 0, 0, 65)
    hintLabel.BackgroundTransparency = 1
    hintLabel.Text = "Pressione F para ativar"
    hintLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    hintLabel.TextScaled = true
    hintLabel.TextSize = 14
    hintLabel.Font = Enum.Font.Gotham
    hintLabel.Parent = frame

    return screenGui, statusLabel
end

-- Função para aplicar os boosts
local function ApplyBoosts()
    if NaitHub.Enabled then
        -- Animação suave
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        local walkTween = TweenService:Create(humanoid, tweenInfo, {WalkSpeed = NaitHub.BoostedWalkSpeed})
        local jumpTween = TweenService:Create(humanoid, tweenInfo, {JumpPower = NaitHub.BoostedJumpPower})
        
        walkTween:Play()
        jumpTween:Play()
    else
        -- Voltar aos valores originais
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        local walkTween = TweenService:Create(humanoid, tweenInfo, {WalkSpeed = NaitHub.OriginalWalkSpeed})
        local jumpTween = TweenService:Create(humanoid, tweenInfo, {JumpPower = NaitHub.OriginalJumpPower})
        
        walkTween:Play()
        jumpTween:Play()
    end
end

-- Função para alternar o Nait Hub
local function ToggleNaitHub()
    NaitHub.Enabled = not NaitHub.Enabled
    
    if NaitHub.Enabled then
        statusLabel.Text = "Status: ATIVADO"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        print("🎮 Nait Hub - Modo Turbo ATIVADO!")
        print("⚡ Speed: " .. NaitHub.BoostedWalkSpeed)
        print("🦘 Jump: " .. NaitHub.BoostedJumpPower)
    else
        statusLabel.Text = "Status: Desativado"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        print("🎮 Nait Hub - Modo Turbo DESATIVADO!")
    end
    
    ApplyBoosts()
end

-- Criar a interface
local gui, statusLabel = CreateGUI()

-- Configurar o hotkey
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == NaitHub.Hotkey then
        ToggleNaitHub()
    end
end)

-- Lidar com respawn do personagem
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    
    -- Atualizar valores originais
    NaitHub.OriginalWalkSpeed = humanoid.WalkSpeed
    NaitHub.OriginalJumpPower = humanoid.JumpPower
    
    -- Reaplicar boosts se estiver ativado
    if NaitHub.Enabled then
        wait(1) -- Esperar o personagem carregar completamente
        ApplyBoosts()
    end
end)

-- Mensagem de inicialização
print("🎮 Nait Hub Carregado!")
print("📌 Pressione F para ativar/desativar")
print("⚡ Speed Boost: " .. NaitHub.BoostedWalkSpeed)
print("🦘 Jump Boost: " .. NaitHub.BoostedJumpPower)

-- Proteção contra errors
pcall(function()
    -- Código principal já executado
end)
