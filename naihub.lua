-- 🌊 NaitHub v3.0
-- Blox Fruits Script
-- Autor: cristiann3010

print("🌊 NaitHub v3.0 carregando...")

-- Serviços
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local Player = Players.LocalPlayer

-- Configurações
local Config = {
    Name = "NaitHub",
    Version = "3.0",
    Colors = {
        Primary = Color3.fromRGB(0, 120, 215),
        Secondary = Color3.fromRGB(40, 40, 50),
        Background = Color3.fromRGB(25, 25, 35),
        Text = Color3.fromRGB(255, 255, 255),
        Success = Color3.fromRGB(0, 200, 100),
        Danger = Color3.fromRGB(220, 60, 60)
    }
}

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NaitHub_Main"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 500)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
MainFrame.BackgroundColor3 = Config.Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Arredondar cantos
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Sombra
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.8
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

-- Barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Config.Colors.Primary
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌊 NaitHub v" .. Config.Version
Title.TextColor3 = Config.Colors.Text
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Botão minimizar (com ícone)
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -80, 0.5, -17.5)
MinBtn.BackgroundColor3 = Config.Colors.Secondary
MinBtn.Text = "🗕"  -- Ícone de minimizar
MinBtn.TextColor3 = Config.Colors.Text
MinBtn.TextSize = 18
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Parent = TitleBar

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = MinBtn

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseBtn.BackgroundColor3 = Config.Colors.Danger
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Config.Colors.Text
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Conteúdo
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -65)
Content.Position = UDim2.new(0, 10, 0, 55)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Variáveis de estado
local Minimized = false
local Dragging = false
local DragStart, FrameStart

-- Sistema de tabs
local Tabs = {"Início", "Farm", "TP", "Frutas", "Config"}
local CurrentTab = "Início"

-- Criar barra de tabs
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 40)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Content

-- Área de conteúdo das tabs
local TabContent = Instance.new("Frame")
TabContent.Size = UDim2.new(1, 0, 1, -50)
TabContent.Position = UDim2.new(0, 0, 0, 50)
TabContent.BackgroundTransparency = 1
TabContent.Parent = Content

-- Função para criar botão de tab
local function createTabButton(tabName, index)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tabName .. "Tab"
    TabBtn.Size = UDim2.new(0.2, -4, 1, 0)
    TabBtn.Position = UDim2.new((index-1) * 0.2, 2, 0, 0)
    TabBtn.BackgroundColor3 = tabName == CurrentTab and Config.Colors.Primary or Config.Colors.Secondary
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Config.Colors.Text
    TabBtn.TextSize = 14
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.Parent = TabBar
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabBtn
    
    -- Conectar clique
    TabBtn.MouseButton1Click:Connect(function()
        CurrentTab = tabName
        loadTabContent()
        
        -- Atualizar aparência de todas as tabs
        for _, child in ipairs(TabBar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = child.Text == CurrentTab and Config.Colors.Primary or Config.Colors.Secondary
            end
        end
    end)
    
    return TabBtn
end

-- Função para criar seção
local function createSection(title, parent, height)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, 0, 0, height or 0)
    Section.BackgroundColor3 = Config.Colors.Secondary
    Section.BackgroundTransparency = 0.2
    Section.Parent = parent
    
    local SectionCorner = Instance.new("UICorner")
    SectionCorner.CornerRadius = UDim.new(0, 8)
    SectionCorner.Parent = Section
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 0, 30)
    TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "📌 " .. title
    TitleLabel.TextColor3 = Config.Colors.Primary
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Section
    
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "Content"
    ContentFrame.Size = UDim2.new(1, -20, 1, -40)
    ContentFrame.Position = UDim2.new(0, 10, 0, 40)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = Section
    
    return ContentFrame
end

-- Função para criar botão
local function createButton(text, parent, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.BackgroundColor3 = Config.Colors.Primary
    Btn.Text = text
    Btn.TextColor3 = Config.Colors.Text
    Btn.TextSize = 14
    Btn.Font = Enum.Font.Gotham
    Btn.Parent = parent
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(callback)
    
    return Btn
end

-- Função para carregar conteúdo da tab (CORRIGIDA)
local function loadTabContent()
    -- Limpar conteúdo anterior
    for _, child in ipairs(TabContent:GetChildren()) do
        child:Destroy()
    end
    
    -- Layout
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = TabContent
    
    print("Carregando tab: " .. CurrentTab)
    
    if CurrentTab == "Início" then
        -- Seção de boas-vindas
        local welcomeSection = createSection("Bem-vindo", TabContent, 120)
        welcomeSection.LayoutOrder = 1
        
        local WelcomeText = Instance.new("TextLabel")
        WelcomeText.Size = UDim2.new(1, 0, 1, 0)
        WelcomeText.BackgroundTransparency = 1
        WelcomeText.Text = "🌊 NaitHub v" .. Config.Version .. "\n\nPara Blox Fruits\nUse as tabs acima para navegar"
        WelcomeText.TextColor3 = Config.Colors.Text
        WelcomeText.TextSize = 16
        WelcomeText.Font = Enum.Font.Gotham
        WelcomeText.TextYAlignment = Enum.TextYAlignment.Top
        WelcomeText.TextWrapped = true
        WelcomeText.Parent = welcomeSection
        
        -- Seção de status
        local statusSection = createSection("Status", TabContent, 100)
        statusSection.LayoutOrder = 2
        
        local StatusText = Instance.new("TextLabel")
        StatusText.Size = UDim2.new(1, 0, 1, 0)
        StatusText.BackgroundTransparency = 1
        StatusText.Text = "✅ Script carregado\n🎮 Modo: PC\n👤 Jogador: " .. Player.Name
        StatusText.TextColor3 = Config.Colors.Text
        StatusText.TextSize = 14
        StatusText.Font = Enum.Font.Gotham
        StatusText.TextYAlignment = Enum.TextYAlignment.Top
        StatusText.Parent = statusSection
        
    elseif CurrentTab == "Farm" then
        local farmSection = createSection("Auto Farm", TabContent, 150)
        farmSection.LayoutOrder = 1
        
        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Size = UDim2.new(1, 0, 0, 30)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "🛑 Farm Desativado"
        StatusLabel.TextColor3 = Config.Colors.Text
        StatusLabel.TextSize = 16
        StatusLabel.Font = Enum.Font.GothamBold
        StatusLabel.Parent = farmSection
        
        local FarmBtn = createButton("▶️ INICIAR AUTO FARM", farmSection, function()
            if StatusLabel.Text == "🛑 Farm Desativado" then
                StatusLabel.Text = "✅ Farm Ativo"
                FarmBtn.Text = "⏸️ PARAR FARM"
                FarmBtn.BackgroundColor3 = Config.Colors.Danger
                print("[FARM] Auto Farm iniciado!")
            else
                StatusLabel.Text = "🛑 Farm Desativado"
                FarmBtn.Text = "▶️ INICIAR AUTO FARM"
                FarmBtn.BackgroundColor3 = Config.Colors.Primary
                print("[FARM] Auto Farm parado!")
            end
        end)
        FarmBtn.Position = UDim2.new(0, 0, 0, 40)
        
        -- Configurações
        local settingsSection = createSection("Configurações", TabContent, 120)
        settingsSection.LayoutOrder = 2
        
        createButton("⚙️ Farm de NPCs", settingsSection, function()
            print("[CONFIG] Farm de NPCs ativado")
        end)
        
        local btn2 = createButton("👑 Farm de Bosses", settingsSection, function()
            print("[CONFIG] Farm de Bosses ativado")
        end)
        btn2.Position = UDim2.new(0, 0, 0, 50)
        
    elseif CurrentTab == "TP" then
        local tpSection = createSection("Teleportes", TabContent)
        tpSection.Size = UDim2.new(1, 0, 0, 250)
        tpSection.LayoutOrder = 1
        
        local Scroll = Instance.new("ScrollingFrame")
        Scroll.Size = UDim2.new(1, 0, 1, 0)
        Scroll.BackgroundTransparency = 1
        Scroll.ScrollBarThickness = 6
        Scroll.CanvasSize = UDim2.new(0, 0, 0, 400)
        Scroll.Parent = tpSection
        
        local Locations = {
            "Praça Inicial",
            "Vila Pirata", 
            "Base Marines",
            "Coliseu",
            "Deserto",
            "Vila Inverno",
            "Magma Village",
            "Cemetery",
            "Sky Island"
        }
        
        for i, loc in ipairs(Locations) do
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 40)
            Btn.Position = UDim2.new(0, 0, 0, (i-1) * 45)
            Btn.BackgroundColor3 = i % 2 == 0 and Config.Colors.Secondary or Color3.fromRGB(50, 50, 60)
            Btn.Text = "📍 " .. loc
            Btn.TextColor3 = Config.Colors.Text
            Btn.TextSize = 14
            Btn.Font = Enum.Font.Gotham
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            Btn.Parent = Scroll
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = Btn
            
            Btn.MouseButton1Click:Connect(function()
                print("[TELEPORT] Indo para: " .. loc)
            end)
        end
        
    elseif CurrentTab == "Frutas" then
        local fruitSection = createSection("Frutas", TabContent, 200)
        fruitSection.LayoutOrder = 1
        
        createButton("🍎 Comprar Fruta Aleatória", fruitSection, function()
            print("[FRUTAS] Comprando fruta aleatória...")
        end)
        
        local btn2 = createButton("📦 Armazenar Fruta", fruitSection, function()
            print("[FRUTAS] Armazenando fruta...")
        end)
        btn2.Position = UDim2.new(0, 0, 0, 50)
        
        local btn3 = createButton("🔍 Procurar Frutas", fruitSection, function()
            print("[FRUTAS] Procurando frutas no mapa...")
        end)
        btn3.Position = UDim2.new(0, 0, 0, 100)
        
        -- Lista de frutas
        local listSection = createSection("Lista de Frutas", TabContent, 150)
        listSection.LayoutOrder = 2
        
        local FruitsList = Instance.new("TextLabel")
        FruitsList.Size = UDim2.new(1, 0, 1, 0)
        FruitsList.BackgroundTransparency = 1
        FruitsList.Text = "🍎 Bomba\n🍐 Spike\n🍊 Dark\n🍇 Ice\n🍓 Flame\n🍑 Magma"
        FruitsList.TextColor3 = Config.Colors.Text
        FruitsList.TextSize = 14
        FruitsList.Font = Enum.Font.Gotham
        FruitsList.TextYAlignment = Enum.TextYAlignment.Top
        FruitsList.TextXAlignment = Enum.TextXAlignment.Left
        FruitsList.Parent = listSection
        
    elseif CurrentTab == "Config" then
        local configSection = createSection("Configurações", TabContent, 200)
        configSection.LayoutOrder = 1
        
        createButton("👁️ Mostrar/Ocultar GUI", configSection, function()
            ScreenGui.Enabled = not ScreenGui.Enabled
            print("[CONFIG] GUI: " .. (ScreenGui.Enabled and "Visível" or "Oculta"))
        end)
        
        local btn2 = createButton("💾 Salvar Configurações", configSection, function()
            print("[CONFIG] Configurações salvas!")
        end)
        btn2.Position = UDim2.new(0, 0, 0, 50)
        
        local btn3 = createButton("🔄 Atualizar Script", configSection, function()
            print("[CONFIG] Verificando atualizações...")
        end)
        btn3.Position = UDim2.new(0, 0, 0, 100)
        
        -- Informações
        local infoSection = createSection("Informações", TabContent, 120)
        infoSection.LayoutOrder = 2
        
        local InfoText = Instance.new("TextLabel")
        InfoText.Size = UDim2.new(1, 0, 1, 0)
        InfoText.BackgroundTransparency = 1
        InfoText.Text = "🌊 NaitHub v" .. Config.Version .. "\n👑 Por: cristiann3010\n🎮 Para Blox Fruits"
        InfoText.TextColor3 = Config.Colors.Text
        InfoText.TextSize = 14
        InfoText.Font = Enum.Font.Gotham
        InfoText.TextYAlignment = Enum.TextYAlignment.Top
        InfoText.Parent = infoSection
    end
end

-- Criar todas as tabs
for i, tabName in ipairs(Tabs) do
    createTabButton(tabName, i)
end

-- Carregar conteúdo inicial
loadTabContent()

-- Função para minimizar/maximizar (com ícones diferentes)
local function toggleMinimize()
    Minimized = not Minimized
    
    if Minimized then
        -- Minimizar
        MainFrame.Size = UDim2.new(0, 50, 0, 50)
        MainFrame.Position = UDim2.new(0.5, -25, 0, 20)
        MinBtn.Text = "🗖"  -- Ícone de maximizar
        Content.Visible = false
        Title.Text = "🌊"
        print("[GUI] Minimizada")
    else
        -- Maximizar
        MainFrame.Size = UDim2.new(0, 450, 0, 500)
        MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
        MinBtn.Text = "🗕"  -- Ícone de minimizar
        Content.Visible = true
        Title.Text = "🌊 NaitHub v" .. Config.Version
        print("[GUI] Maximizada")
    end
end

-- Conectar eventos dos botões
MinBtn.MouseButton1Click:Connect(toggleMinimize)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    print("[GUI] Fechada")
end)

-- Sistema de arrastar (agora funciona em toda a barra)
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        FrameStart = MainFrame.Position
        
        print("[DRAG] Iniciando arraste...")
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(
            FrameStart.X.Scale,
            FrameStart.X.Offset + Delta.X,
            FrameStart.Y.Scale,
            FrameStart.Y.Offset + Delta.Y
        )
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
        print("[DRAG] Arraste finalizado")
    end
end)

-- Atalhos de teclado
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.F9 then
            toggleMinimize()
            print("[HOTKEY] F9 pressionado")
        elseif input.KeyCode == Enum.KeyCode.Insert then
            ScreenGui.Enabled = not ScreenGui.Enabled
            print("[HOTKEY] Insert pressionado - GUI: " .. (ScreenGui.Enabled and "ON" or "OFF"))
        end
    end
end)

-- Notificação inicial
task.spawn(function()
    wait(1)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "NaitHub v" .. Config.Version,
            Text = "Carregado com sucesso!\nF9: Minimizar | Insert: Ocultar",
            Duration = 5
        })
    end)
end)

print("✅ NaitHub v" .. Config.Version .. " carregado!")
print("🎮 Atalhos: F9 = Minimizar | Insert = Ocultar")
print("📌 Arraste pela barra azul para mover")
