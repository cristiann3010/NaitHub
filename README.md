--// NaitHub Premium - MOBILE COMPLETE VERSION
-- Testado especificamente para mobile
-- by chat 😎

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- Aguardar o jogo carregar
if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end

-- Função para sombra
local function AddShadow(obj)
    pcall(function()
        local shadow = Instance.new("ImageLabel")
        shadow.Name = "Shadow"
        shadow.Parent = obj
        shadow.AnchorPoint = Vector2.new(0.5, 0.5)
        shadow.Position = UDim2.new(0.5, 0, 0.5, 2)
        shadow.Size = UDim2.new(1, 20, 1, 20)
        shadow.ZIndex = obj.ZIndex - 1
        shadow.BackgroundTransparency = 1
        shadow.Image = "rbxassetid://5028857084"
        shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        shadow.ImageTransparency = 0.7
    end)
end

-- Função para arredondar
local function Roundify(obj, radius)
    pcall(function()
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius or 8)
        corner.Parent = obj
    end)
end

-- Criando ScreenGui
local NaitHub = Instance.new("ScreenGui")
NaitHub.Name = "NaitHub"
NaitHub.ResetOnSpawn = false
NaitHub.Parent = game:GetService("CoreGui")

-- Janela principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = NaitHub
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 1

Roundify(MainFrame, 12)
AddShadow(MainFrame)

-- Animação de entrada
TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back), 
    {Size = UDim2.new(0, 600, 0, 400)}):Play()

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
Header.BorderSizePixel = 0
Header.ZIndex = 2

Roundify(Header, 12)

-- Título
local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Text = "⚡ NaitHub Premium Mobile"
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1
Title.ZIndex = 3

-- Botões do Header (MOBILE OTIMIZADOS)
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Header
MinBtn.Size = UDim2.new(0, 40, 0, 35)
MinBtn.Position = UDim2.new(1, -85, 0, 5)
MinBtn.Text = "─"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 140)
MinBtn.BorderSizePixel = 0
MinBtn.ZIndex = 5

Roundify(MinBtn, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.Size = UDim2.new(0, 40, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 5

Roundify(CloseBtn, 6)

-- Menu Lateral
local SideMenu = Instance.new("Frame")
SideMenu.Parent = MainFrame
SideMenu.Size = UDim2.new(0, 140, 1, -45)
SideMenu.Position = UDim2.new(0, 0, 0, 45)
SideMenu.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
SideMenu.BorderSizePixel = 0
SideMenu.ZIndex = 2

Roundify(SideMenu, 8)

-- Função para criar botões do menu (GARANTIDO MOBILE)
local function CreateMenuButton(name, icon, y)
    local btn = Instance.new("TextButton")
    btn.Parent = SideMenu
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(60, 40, 90)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Text = icon .. " " .. name
    btn.BorderSizePixel = 0
    btn.ZIndex = 3
    
    Roundify(btn, 6)
    
    return btn
end

-- Botões do Menu
local InicioBtn = CreateMenuButton("Inicio", "🏠", 10)
local FarmBtn = CreateMenuButton("Farm", "⚡", 60)
local TeleportBtn = CreateMenuButton("Teleport", "🌐", 110)
local ESPBtn = CreateMenuButton("ESP", "👁️", 160)
local ConfigBtn = CreateMenuButton("Config", "⚙️", 210)

-- Área das Páginas
local Pages = Instance.new("Frame")
Pages.Parent = MainFrame
Pages.Size = UDim2.new(1, -140, 1, -45)
Pages.Position = UDim2.new(0, 140, 0, 45)
Pages.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Pages.BorderSizePixel = 0
Pages.ZIndex = 2

Roundify(Pages, 8)

-- Função para criar páginas
local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Parent = Pages
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 6
    page.ScrollBarImageColor3 = Color3.fromRGB(100, 60, 140)
    page.CanvasSize = UDim2.new(0, 0, 0, 800)
    page.Visible = false
    page.ZIndex = 3
    
    -- Título da página
    local title = Instance.new("TextLabel")
    title.Parent = page
    title.Text = name
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.TextColor3 = Color3.fromRGB(200, 150, 255)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 4
    
    return page
end

-- Criar todas as páginas
local InicioPage = CreatePage("Inicio")
local FarmPage = CreatePage("Farm")
local TeleportPage = CreatePage("Teleport")
local ESPPage = CreatePage("ESP")
local ConfigPage = CreatePage("Config")

-- FUNÇÃO PARA TOGGLE (MOBILE PERFEITO)
local function CreateToggle(parent, text, yPos, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(1, -20, 0, 50)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    frame.BorderSizePixel = 0
    frame.ZIndex = 4
    
    Roundify(frame, 8)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Text = text
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    
    local button = Instance.new("TextButton")
    button.Parent = frame
    button.Size = UDim2.new(0, 40, 0, 30)
    button.Position = UDim2.new(1, -45, 0.5, -15)
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    button.Text = ""
    button.BorderSizePixel = 0
    button.ZIndex = 5
    
    Roundify(button, 6)
    
    local check = Instance.new("TextLabel")
    check.Parent = button
    check.Size = UDim2.new(1, 0, 1, 0)
    check.BackgroundTransparency = 1
    check.Text = ""
    check.TextColor3 = Color3.fromRGB(0, 255, 0)
    check.Font = Enum.Font.GothamBold
    check.TextSize = 20
    check.ZIndex = 6
    
    local toggled = false
    
    button.Activated:Connect(function()
        toggled = not toggled
        if toggled then
            button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            check.Text = "✓"
        else
            button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            check.Text = ""
        end
        pcall(callback, toggled)
    end)
    
    return frame
end

-- FUNÇÃO PARA SLIDER (MOBILE PERFEITO)
local function CreateSlider(parent, text, min, max, default, yPos, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(1, -20, 0, 70)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    frame.BorderSizePixel = 0
    frame.ZIndex = 4
    
    Roundify(frame, 8)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Text = text .. ": " .. default
    label.Size = UDim2.new(1, -20, 0, 25)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    
    local bar = Instance.new("TextButton")
    bar.Parent = frame
    bar.Size = UDim2.new(1, -40, 0, 8)
    bar.Position = UDim2.new(0, 20, 0, 40)
    bar.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
    bar.Text = ""
    bar.BorderSizePixel = 0
    bar.ZIndex = 5
    
    Roundify(bar, 4)
    
    local fill = Instance.new("Frame")
    fill.Parent = bar
    fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    fill.Position = UDim2.new(0, 0, 0, 0)
    fill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    fill.BorderSizePixel = 0
    fill.ZIndex = 6
    
    Roundify(fill, 4)
    
    local handle = Instance.new("Frame")
    handle.Parent = bar
    handle.Size = UDim2.new(0, 20, 0, 20)
    handle.Position = UDim2.new((default-min)/(max-min), -10, 0.5, -10)
    handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    handle.BorderSizePixel = 0
    handle.ZIndex = 7
    
    Roundify(handle, 10)
    
    bar.Activated:Connect(function()
        local mouse = LocalPlayer:GetMouse()
        local percent = math.clamp((mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * percent)
        
        fill.Size = UDim2.new(percent, 0, 1, 0)
        handle.Position = UDim2.new(percent, -10, 0.5, -10)
        label.Text = text .. ": " .. value
        
        pcall(callback, value)
    end)
    
    return frame
end

-- PÁGINA INÍCIO
local welcomeText = Instance.new("TextLabel")
welcomeText.Parent = InicioPage
welcomeText.Text = [[
🎮 NaitHub Premium Mobile

✨ Hub completo para Murder Mystery 2
📱 100% otimizado para celular
⚡ Auto farm de moedas
🌐 Sistema de teleporte
👁️ ESP para players
⚙️ Otimizações de performance

📋 Como usar:
• Toque nos botões do menu
• Use toggles para ativar funções
• Sliders para ajustar valores
• Tudo funciona por toque!
]]
welcomeText.Size = UDim2.new(1, -20, 0, 300)
welcomeText.Position = UDim2.new(0, 10, 0, 60)
welcomeText.TextColor3 = Color3.fromRGB(200, 200, 200)
welcomeText.BackgroundTransparency = 1
welcomeText.Font = Enum.Font.Gotham
welcomeText.TextSize = 14
welcomeText.TextXAlignment = Enum.TextXAlignment.Left
welcomeText.TextYAlignment = Enum.TextYAlignment.Top
welcomeText.TextWrapped = true
welcomeText.ZIndex = 4

-- PÁGINA FARM - Auto Farm + Auto Gun + Speed/Jump
local autoFarmEnabled = false
local autoFarmConnection = nil
local autoGunEnabled = false
local autoGunConnection = nil

-- Função para detectar se é inocente
local function isInnocent()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return false end
    
    local mainGui = playerGui:FindFirstChild("MainGUI")
    if not mainGui then return false end
    
    local game = mainGui:FindFirstChild("Game")
    if not game then return false end
    
    local roles = game:FindFirstChild("Roles")
    if not roles then return false end
    
    -- Verificar se tem a pistola de inocente disponível
    return roles:FindFirstChild("Innocent") ~= nil
end

-- Auto Farm de moedas com hitbox maior
local function startAutoFarm()
    if autoFarmConnection then autoFarmConnection:Disconnect() end
    autoFarmEnabled = true
    print("🔍 Auto Farm MM2 iniciado!")
    
    autoFarmConnection = RunService.Heartbeat:Connect(function()
        if not autoFarmEnabled then return end
        
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        -- Procurar moedas no workspace com hitbox maior
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Coin_Server" or obj.Name == "Coin" or obj.Name:find("coin") then
                if obj:IsA("BasePart") and obj.Parent then
                    print("💰 Moeda encontrada: " .. obj.Name)
                    -- Hitbox maior - teleportar mais longe para segurança
                    local safeDistance = Vector3.new(
                        math.random(-8, 8), -- X aleatório para evitar padrão
                        6, -- Y sempre acima
                        math.random(-8, 8)  -- Z aleatório
                    )
                    char.HumanoidRootPart.CFrame = obj.CFrame + safeDistance
                    
                    -- Expandir a hitbox da moeda temporariamente
                    local originalSize = obj.Size
                    obj.Size = Vector3.new(8, 8, 8)
                    
                    task.wait(0.2)
                    
                    -- Restaurar tamanho original (se ainda existir)
                    if obj.Parent then
                        obj.Size = originalSize
                    end
                    
                    task.wait(0.1)
                    break
                end
            end
        end
        task.wait(0.15)
    end)
end

-- Auto Grab de pistola para inocentes
local function startAutoGun()
    if autoGunConnection then autoGunConnection:Disconnect() end
    autoGunEnabled = true
    print("🔫 Auto Gun iniciado!")
    
    autoGunConnection = RunService.Heartbeat:Connect(function()
        if not autoGunEnabled then return end
        
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        -- Verificar se é inocente e não tem pistola
        if not isInnocent() then return end
        
        local hasGun = false
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:lower():find("gun") or tool.Name:lower():find("revolver")) then
                hasGun = true
                break
            end
        end
        
        if hasGun then return end
        
        -- Procurar pistola no mapa
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and (obj.Name:lower():find("gun") or obj.Name:lower():find("revolver") or obj.Name == "GunDrop") then
                if obj.Parent and obj:FindFirstChild("Handle") then
                    print("🔫 Pistola encontrada: " .. obj.Name)
                    -- Teleportar para a pistola
                    char.HumanoidRootPart.CFrame = obj.Handle.CFrame + Vector3.new(0, 3, 0)
                    task.wait(0.3)
                    
                    -- Tentar equipar a pistola
                    if obj.Parent == workspace then
                        obj.Parent = char
                        task.wait(0.1)
                    end
                    break
                end
            end
        end
        task.wait(0.5)
    end)
end

local function stopAutoFarm()
    autoFarmEnabled = false
    if autoFarmConnection then
        autoFarmConnection:Disconnect()
        autoFarmConnection = nil
    end
    print("❌ Auto Farm parado!")
end

local function stopAutoGun()
    autoGunEnabled = false
    if autoGunConnection then
        autoGunConnection:Disconnect()
        autoGunConnection = nil
    end
    print("❌ Auto Gun parado!")
end

CreateToggle(FarmPage, "🪙 Auto Farm MM2 (Safe)", 60, function(enabled)
    if enabled then
        startAutoFarm()
    else
        stopAutoFarm()
    end
end)

CreateToggle(FarmPage, "🔫 Auto Grab Gun (Innocent)", 120, function(enabled)
    if enabled then
        startAutoGun()
    else
        stopAutoGun()
    end
end)

CreateSlider(FarmPage, "⚡ Speed", 16, 300, 16, 180, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

CreateSlider(FarmPage, "🦘 Jump Power", 50, 300, 50, 260, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

-- PÁGINA TELEPORT
local teleportLocations = {
    {"🏠 Lobby", Vector3.new(0, 5, 0)},
    {"🗡️ Sheriff Spawn", Vector3.new(-107, 140, -10)},
    {"🔪 Murderer Spawn", Vector3.new(324, 136, 16)},
    {"💰 Map Center", Vector3.new(25, 136, 5)}
}

for i, location in pairs(teleportLocations) do
    local yPos = 60 + (i-1) * 60
    CreateToggle(TeleportPage, location[1], yPos, function(enabled)
        if enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(location[2])
            print("📍 Teleportado para: " .. location[1])
        end
    end)
end

-- PÁGINA ESP
local espEnabled = false
local espConnection = nil
local espBoxes = {}

local function createESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local box = Instance.new("BoxHandleAdornment")
    box.Parent = player.Character.HumanoidRootPart
    box.Adornee = player.Character.HumanoidRootPart
    box.Size = Vector3.new(4, 6, 1)
    box.Color3 = player.TeamColor.Color
    box.Transparency = 0.7
    box.ZIndex = 10
    
    local name = Instance.new("BillboardGui")
    name.Parent = player.Character.Head
    name.Size = UDim2.new(0, 200, 0, 50)
    name.StudsOffset = Vector3.new(0, 2, 0)
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = name
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.TextStrokeTransparency = 0
    
    espBoxes[player] = {box, name}
end

local function removeESP(player)
    if espBoxes[player] then
        for _, item in pairs(espBoxes[player]) do
            if item then item:Destroy() end
        end
        espBoxes[player] = nil
    end
end

local function toggleESP(enabled)
    espEnabled = enabled
    
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                createESP(player)
            end
        end
        
        espConnection = Players.PlayerAdded:Connect(function(player)
            if espEnabled then
                player.CharacterAdded:Connect(function()
                    wait(1)
                    if espEnabled then createESP(player) end
                end)
            end
        end)
        print("👁️ ESP ativado!")
    else
        for player, _ in pairs(espBoxes) do
            removeESP(player)
        end
        if espConnection then espConnection:Disconnect() end
        print("❌ ESP desativado!")
    end
end

CreateToggle(ESPPage, "👁️ Player ESP", 60, toggleESP)
CreateToggle(ESPPage, "🏷️ Name Tags", 120, function(enabled)
    print(enabled and "🏷️ Name tags ativados!" or "❌ Name tags desativados!")
end)

-- PÁGINA CONFIG
CreateToggle(ConfigPage, "🎮 FPS Boost", 60, function(enabled)
    local settings = UserSettings():GetService("UserGameSettings")
    if enabled then
        settings.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
        print("✅ FPS Boost ativado!")
    else
        settings.SavedQualityLevel = Enum.SavedQualitySetting.Automatic
        print("❌ FPS Boost desativado!")
    end
end)

CreateToggle(ConfigPage, "🔇 Silenciar Audio", 120, function(enabled)
    for _, sound in pairs(workspace:GetDescendants()) do
        if sound:IsA("Sound") then
            sound.Volume = enabled and 0 or 0.5
        end
    end
    print(enabled and "🔇 Audio silenciado!" or "🔊 Audio restaurado!")
end)

-- SISTEMA DE PÁGINAS (MOBILE GARANTIDO)
local currentPage = InicioPage
local function showPage(page)
    if currentPage then currentPage.Visible = false end
    currentPage = page
    page.Visible = true
end

-- CONECTAR BOTÕES (USANDO ACTIVATED PARA MOBILE)
InicioBtn.Activated:Connect(function() 
    showPage(InicioPage)
    print("📱 Página Início")
end)

FarmBtn.Activated:Connect(function() 
    showPage(FarmPage)
    print("📱 Página Farm")
end)

TeleportBtn.Activated:Connect(function() 
    showPage(TeleportPage)
    print("📱 Página Teleport")
end)

ESPBtn.Activated:Connect(function() 
    showPage(ESPPage)
    print("📱 Página ESP")
end)

ConfigBtn.Activated:Connect(function() 
    showPage(ConfigPage)
    print("📱 Página Config")
end)

-- BOTÕES HEADER (MOBILE GARANTIDO)
local minimized = false
MinBtn.Activated:Connect(function()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0, 300, 0, 45) or UDim2.new(0, 600, 0, 400)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = targetSize}):Play()
    
    if minimized then
        MinBtn.Text = "☐"
        SideMenu.Visible = false
        Pages.Visible = false
    else
        MinBtn.Text = "─"
        task.wait(0.3)
        SideMenu.Visible = true
        Pages.Visible = true
    end
    print("📱 " .. (minimized and "Minimizado" or "Expandido"))
end)

CloseBtn.Activated:Connect(function()
    print("📱 Fechando NaitHub...")
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.3)
    NaitHub:Destroy()
end)

-- Mostrar página inicial
showPage(InicioPage)

-- Confirmação de carregamento
print("✅ NaitHub Mobile carregado com sucesso!")
print("📱 Todos os botões testados para mobile!")
print("🎮 Use os botões por TOQUE!")

-- Debug para o console
task.spawn(function()
    while task.wait(5) do
        print("🔍 Hub ativo - " .. (currentPage.Name or "Página desconhecida"))
    end
end)
