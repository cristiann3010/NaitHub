-- Nait Hub - Sistema de Speed e Jump com Interface
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
    BoostedWalkSpeed = 50,
    BoostedJumpPower = 100,
    SpeedEnabled = false,
    JumpEnabled = false
}

-- Variáveis globais
local character, humanoid
local mainGui, menuGui
local speedButton, jumpButton

-- Função para criar o botão principal
local function CreateMainButton()
    -- Remover GUIs existentes
    if playerGui:FindFirstChild("NaitHubMain") then
        playerGui.NaitHubMain:Destroy()
    end
    if playerGui:FindFirstChild("NaitHubMenu") then
        playerGui.NaitHubMenu:Destroy()
    end
    
    -- Botão principal
    mainGui = Instance.new("ScreenGui")
    mainGui.Name = "NaitHubMain"
    mainGui.ResetOnSpawn = false
    mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    mainGui.Parent = playerGui

    local mainButton = Instance.new("TextButton")
    mainButton.Size = UDim2.new(0, 60, 0, 60)
    mainButton.Position = UDim2.new(0, 20, 0, 20)
    mainButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainButton.Text = "🎮\nNAIT"
    mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    mainButton.TextScaled = true
    mainButton.Font = Enum.Font.GothamBold
    mainButton.Parent = mainGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainButton

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 100, 255)
    stroke.Thickness = 3
    stroke.Parent = mainButton

    -- Clique do botão principal
    mainButton.MouseButton1Click:Connect(function()
        ToggleMenu()
    end)

    return mainButton
end

-- Função para criar o menu
local function CreateMenu()
    menuGui = Instance.new("ScreenGui")
    menuGui.Name = "NaitHubMenu"
    menuGui.ResetOnSpawn = false
    menuGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    menuGui.Enabled = false
    menuGui.Parent = playerGui

    local menuFrame = Instance.new("Frame")
    menuFrame.Size = UDim2.new(0, 200, 0, 180)
    menuFrame.Position = UDim2.new(0, 90, 0, 20)
    menuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    menuFrame.BackgroundTransparency = 0.1
    menuFrame.BorderSizePixel = 0
    menuFrame.Parent = menuGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = menuFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 100, 255)
    stroke.Thickness = 2
    stroke.Parent = menuFrame

    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    title.Text = "🎮 NAIT HUB"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = menuFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = title

    -- Botão de Speed
    speedButton = Instance.new("TextButton")
    speedButton.Size = UDim2.new(0.8, 0, 0, 40)
    speedButton.Position = UDim2.new(0.1, 0, 0, 50)
    speedButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    speedButton.Text = "⚡ SPEED: OFF"
    speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedButton.TextScaled = true
    speedButton.Font = Enum.Font.GothamBold
    speedButton.Parent = menuFrame

    local speedCorner = Instance.new("UICorner")
    speedCorner.CornerRadius = UDim.new(0, 8)
    speedCorner.Parent = speedButton

    -- Botão de Jump
    jumpButton = Instance.new("TextButton")
    jumpButton.Size = UDim2.new(0.8, 0, 0, 40)
    jumpButton.Position = UDim2.new(0.1, 0, 0, 100)
    jumpButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    jumpButton.Text = "🦘 JUMP: OFF"
    jumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    jumpButton.TextScaled = true
    jumpButton.Font = Enum.Font.GothamBold
    jumpButton.Parent = menuFrame

    local jumpCorner = Instance.new("UICorner")
    jumpCorner.CornerRadius = UDim.new(0, 8)
    jumpCorner.Parent = jumpButton

    -- Botão Fechar
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0.8, 0, 0, 30)
    closeButton.Position = UDim2.new(0.1, 0, 0, 150)
    closeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    closeButton.Text = "❌ FECHAR"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.Gotham
    closeButton.Parent = menuFrame

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeButton

    -- Eventos dos botões
    speedButton.MouseButton1Click:Connect(function()
        ToggleSpeed()
    end)

    jumpButton.MouseButton1Click:Connect(function()
        ToggleJump()
    end)

    closeButton.MouseButton1Click:Connect(function()
        ToggleMenu()
    end)

    return menuFrame
end

-- Função para alternar o menu
local function ToggleMenu()
    menuGui.Enabled = not menuGui.Enabled
end

-- Função para alternar Speed
local function ToggleSpeed()
    NaitHub.SpeedEnabled = not NaitHub.SpeedEnabled
    
    if humanoid then
        if NaitHub.SpeedEnabled then
            humanoid.WalkSpeed = NaitHub.BoostedWalkSpeed
            speedButton.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
            speedButton.Text = "⚡ SPEED: ON"
            print("🎮 Speed Boost ATIVADO: " .. NaitHub.BoostedWalkSpeed)
        else
            humanoid.WalkSpeed = NaitHub.OriginalWalkSpeed
            speedButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            speedButton.Text = "⚡ SPEED: OFF"
            print("🎮 Speed Boost DESATIVADO")
        end
    end
end

-- Função para alternar Jump
local function ToggleJump()
    NaitHub.JumpEnabled = not NaitHub.JumpEnabled
    
    if humanoid then
        if NaitHub.JumpEnabled then
            humanoid.JumpPower = NaitHub.BoostedJumpPower
            jumpButton.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
            jumpButton.Text = "🦘 JUMP: ON"
            print("🎮 Jump Boost ATIVADO: " .. NaitHub.BoostedJumpPower)
        else
            humanoid.JumpPower = NaitHub.OriginalJumpPower
            jumpButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            jumpButton.Text = "🦘 JUMP: OFF"
            print("🎮 Jump Boost DESATIVADO")
        end
    end
end

-- Função para inicializar o personagem
local function InitializeCharacter()
    character = player.Character
    if character then
        humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            NaitHub.OriginalWalkSpeed = humanoid.WalkSpeed
            NaitHub.OriginalJumpPower = humanoid.JumpPower
            
            -- Restaurar estados se estavam ativados
            if NaitHub.SpeedEnabled then
                humanoid.WalkSpeed = NaitHub.BoostedWalkSpeed
            end
            if NaitHub.JumpEnabled then
                humanoid.JumpPower = NaitHub.BoostedJumpPower
            end
            
            print("✅ Personagem inicializado!")
        end
    end
end

-- Inicializar
wait(1)

-- Criar interfaces
CreateMainButton()
CreateMenu()

-- Inicializar quando o personagem spawnar
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    wait(1)
    InitializeCharacter()
end)

-- Inicializar personagem atual
InitializeCharacter()

-- Atualizar interface periodicamente
RunService.Heartbeat:Connect(function()
    if speedButton and jumpButton then
        -- Atualizar cores baseadas no estado
        if NaitHub.SpeedEnabled then
            speedButton.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
            speedButton.Text = "⚡ SPEED: ON"
        else
            speedButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            speedButton.Text = "⚡ SPEED: OFF"
        end
        
        if NaitHub.JumpEnabled then
            jumpButton.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
            jumpButton.Text = "🦘 JUMP: ON"
        else
            jumpButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            jumpButton.Text = "🦘 JUMP: OFF"
        end
    end
end)

-- Mensagem de inicialização
print("======================================")
print("🎮 NAIT HUB INTERFACE CARREGADA!")
print("📌 Clique no botão 🎮 para abrir o menu")
print("⚡ Speed Boost: " .. NaitHub.BoostedWalkSpeed)
print("🦘 Jump Boost: " .. NaitHub.BoostedJumpPower)
print("======================================")
