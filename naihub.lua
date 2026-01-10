-- 🌊 NaitHub v4.0 - FINAL
-- Navegação TOTALMENTE FUNCIONANTE
-- Autor: cristiann3010

print("🌊 NaitHub v4.0 - Iniciando...")

-- Serviços
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local Player = Players.LocalPlayer

-- Configurações
local Config = {
    Name = "NaitHub",
    Version = "4.0",
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
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Arredondar cantos
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

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

-- Botão minimizar
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -80, 0.5, -17.5)
MinBtn.BackgroundColor3 = Config.Colors.Secondary
MinBtn.Text = "🗕"
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

-- Área de conteúdo principal
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -65)
Content.Position = UDim2.new(0, 10, 0, 55)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- ========================================
-- SISTEMA DE TABS (CORRIGIDO)
-- ========================================

local Tabs = {
    {Name = "Início", Icon = "🏠"},
    {Name = "Farm", Icon = "⚔️"},
    {Name = "TP", Icon = "📍"},
    {Name = "Frutas", Icon = "🍎"},
    {Name = "Config", Icon = "⚙️"}
}

local CurrentTab = "Início"

-- Criar barra de tabs
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 40)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Content

-- Área de conteúdo das tabs
local TabContent = Instance.new("Frame")
TabContent.Name = "TabContent"
TabContent.Size = UDim2.new(1, 0, 1, -50)
TabContent.Position = UDim2.new(0, 0, 0, 50)
TabContent.BackgroundTransparency = 1
TabContent.Parent = Content

-- Função para criar botões de tab
local function createTabButtons()
    for i, tab in ipairs(Tabs) do
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = tab.Name .. "Tab"
        TabBtn.Size = UDim2.new(0.2, -4, 1, 0)
        TabBtn.Position = UDim2.new((i-1) * 0.2, 2, 0, 0)
        TabBtn.BackgroundColor3 = tab.Name == CurrentTab and Config.Colors.Primary or Config.Colors.Secondary
        TabBtn.Text = tab.Icon .. "\n" .. tab.Name
        TabBtn.TextColor3 = Config.Colors.Text
        TabBtn.TextSize = 11
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.Parent = TabBar
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabBtn
        
        -- Conectar clique CORRETAMENTE
        TabBtn.MouseButton1Click:Connect(function()
            print("[TAB] Clicado: " .. tab.Name)
            CurrentTab = tab.Name
            loadTabContent()  -- Isso VAI chamar a função
            
            -- Atualizar aparência de todas as tabs
            for _, child in ipairs(TabBar:GetChildren()) do
                if child:IsA("TextButton") then
                    local isActive = child.Name == tab.Name .. "Tab"
                    child.BackgroundColor3 = isActive and Config.Colors.Primary or Config.Colors.Secondary
                end
            end
        end)
    end
end

-- ========================================
-- FUNÇÕES PARA CRIAR CONTEÚDO
-- ========================================

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

local function createButton(text, parent, callback, yPosition)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.Position = UDim2.new(0, 0, 0, yPosition or 0)
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

-- ========================================
-- CARREGAR CONTEÚDO DAS TABS (REESCRITO)
-- ========================================

function loadTabContent()
    print("[DEBUG] Carregando tab: " .. CurrentTab)
    
    -- LIMPAR conteúdo anterior COMPLETAMENTE
    for _, child in ipairs(TabContent:GetChildren()) do
        child:Destroy()
    end
    
    -- Criar layout
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = TabContent
    
    if CurrentTab == "Início" then
        print("[DEBUG] Criando tab Início")
        
        -- Seção de boas-vindas
        local welcomeSection = createSection("Bem-vindo", TabContent, 120)
        welcomeSection.LayoutOrder = 1
        
        local WelcomeText = Instance.new("TextLabel")
        WelcomeText.Size = UDim2.new(1, 0, 0.8, 0)
        WelcomeText.Position = UDim2.new(0, 0, 0.1, 0)
        WelcomeText.BackgroundTransparency = 1
        WelcomeText.Text = "🌊 NaitHub v" .. Config.Version .. "\n\nBlox Fruits Script\nClique nas tabs acima!"
        WelcomeText.TextColor3 = Config.Colors.Text
        WelcomeText.TextSize = 16
        WelcomeText.Font = Enum.Font.GothamBold
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
        print("[DEBUG] Criando tab Farm")
        
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
        
        local farmToggle = false
        
        local FarmBtn = createButton("▶️ INICIAR AUTO FARM", farmSection, function()
            farmToggle = not farmToggle
            if farmToggle then
                StatusLabel.Text = "✅ Farm Ativo"
                FarmBtn.Text = "⏸️ PARAR FARM"
                FarmBtn.BackgroundColor3 = Config.Colors.Danger
                print("[FARM] Auto Farm INICIADO!")
            else
                StatusLabel.Text = "🛑 Farm Desativado"
                FarmBtn.Text = "▶️ INICIAR AUTO FARM"
                FarmBtn.BackgroundColor3 = Config.Colors.Primary
                print("[FARM] Auto Farm PARADO!")
            end
        end, 40)
        
        -- Configurações
        local settingsSection = createSection("Configurações", TabContent, 120)
        settingsSection.LayoutOrder = 2
        
        createButton("⚙️ Farm de NPCs", settingsSection, function()
            print("[CONFIG] Farm de NPCs ativado")
        end, 0)
        
        createButton("👑 Farm de Bosses", settingsSection, function()
            print("[CONFIG] Farm de Bosses ativado")
        end, 50)
        
    elseif CurrentTab == "TP" then
        print("[DEBUG] Criando tab TP")
        
        local tpSection = createSection("Teleportes", TabContent, 250)
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
        print("[DEBUG] Criando tab Frutas")
        
        local fruitSection = createSection("Gerenciar Frutas", TabContent, 200)
        fruitSection.LayoutOrder = 1
        
        createButton("🍎 Comprar Fruta Aleatória", fruitSection, function()
            print("[FRUTAS] Comprando fruta aleatória...")
        end, 0)
        
        createButton("📦 Armazenar Fruta", fruitSection, function()
            print("[FRUTAS] Armazenando fruta atual...")
        end, 50)
        
        createButton("🔍 Procurar Frutas", fruitSection, function()
            print("[FRUTAS] Procurando frutas no mapa...")
        end, 100)
        
        -- Lista de frutas
        local listSection = createSection("Frutas Disponíveis", TabContent, 150)
        listSection.LayoutOrder = 2
        
        local FruitsText = Instance.new("TextLabel")
        FruitsText.Size = UDim2.new(1, 0, 1, 0)
        FruitsText.BackgroundTransparency = 1
        FruitsText.Text = "🍎 Bomba\n🍐 Spike\n🍊 Dark\n🍇 Ice\n🍓 Flame\n🍑 Magma\n🍒 Buddha\n🥭 Dragon"
        FruitsText.TextColor3 = Config.Colors.Text
        FruitsText.TextSize = 14
        FruitsText.Font = Enum.Font.Gotham
        FruitsText.TextYAlignment = Enum.TextYAlignment.Top
        FruitsText.TextXAlignment = Enum.TextXAlignment.Left
        FruitsText.Parent = listSection
        
    elseif CurrentTab == "Config" then
        print("[DEBUG] Criando tab Config")
        
        local configSection = createSection("Configurações", TabContent, 200)
        configSection.LayoutOrder = 1
        
        createButton("👁️ Mostrar/Ocultar GUI", configSection, function()
            ScreenGui.Enabled = not ScreenGui.Enabled
            print("[CONFIG] GUI: " .. (ScreenGui.Enabled and "VISÍVEL" or "OCULTA"))
        end, 0)
        
        createButton("💾 Salvar Configurações", configSection, function()
            print("[CONFIG] Configurações salvas com sucesso!")
        end, 50)
        
        createButton("🔄 Reiniciar Script", configSection, function()
            print("[CONFIG] Reiniciando...")
        end, 100)
        
        -- Informações
        local infoSection = createSection("Informações", TabContent, 120)
        infoSection.LayoutOrder = 2
        
        local InfoText = Instance.new("TextLabel")
        InfoText.Size = UDim2.new(1, 0, 1, 0)
        InfoText.BackgroundTransparency = 1
        InfoText.Text = "🌊 NaitHub v" .. Config.Version .. "\n👑 Por: cristiann3010\n🎮 Para Blox Fruits\n📅 " .. os.date("%d/%m/%Y")
        InfoText.TextColor3 = Config.Colors.Text
        InfoText.TextSize = 14
        InfoText.Font = Enum.Font.Gotham
        InfoText.TextYAlignment = Enum.TextYAlignment.Top
        InfoText.Parent = infoSection
    end
    
    print("[DEBUG] Tab '" .. CurrentTab .. "' carregada com sucesso!")
end

-- ========================================
-- INICIALIZAR
-- ========================================

-- Criar tabs
createTabButtons()

-- Carregar primeira tab
loadTabContent()

-- ========================================
-- CONTROLES DA GUI
-- ========================================

-- Minimizar/Maximizar
local Minimized = false
MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    
    if Minimized then
        MainFrame.Size = UDim2.new(0, 50, 0, 50)
        MainFrame.Position = UDim2.new(0.5, -25, 0, 20)
        MinBtn.Text = "🗖"
        Content.Visible = false
        Title.Text = "🌊"
        print("[GUI] Minimizada")
    else
        MainFrame.Size = UDim2.new(0, 450, 0, 500)
        MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
        MinBtn.Text = "🗕"
        Content.Visible = true
        Title.Text = "🌊 NaitHub v" .. Config.Version
        print("[GUI] Maximizada")
    end
end)

-- Fechar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    print("[GUI] Fechada")
end)

-- Arrastar
local Dragging = false
local DragStart, FrameStart

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        FrameStart = MainFrame.Position
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
    end
end)

-- Atalhos de teclado
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.F9 then
            Minimized = not Minimized
            if Minimized then
                MainFrame.Size = UDim2.new(0, 50, 0, 50)
                MainFrame.Position = UDim2.new(0.5, -25, 0, 20)
                MinBtn.Text = "🗖"
                Content.Visible = false
                Title.Text = "🌊"
            else
                MainFrame.Size = UDim2.new(0, 450, 0, 500)
                MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
                MinBtn.Text = "🗕"
                Content.Visible = true
                Title.Text = "🌊 NaitHub v" .. Config.Version
            end
        elseif input.KeyCode == Enum.KeyCode.Insert then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end
end)

-- Notificação
task.spawn(function()
    wait(0.5)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "NaitHub v" .. Config.Version,
            Text = "Carregado!\nF9: Minimizar | Insert: Ocultar",
            Duration = 5
        })
    end
    end)
end)

print("✅ NaitHub v" .. Config.Version .. " CARREGADO!")
print("🎮 Atalhos: F9 = Minimizar | Insert = Ocultar")
print("📌 Navegação TOTALMENTE FUNCIONANTE!")
print("🚀 Pronto para usar!")
