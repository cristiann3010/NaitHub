-- 🌊 NaitHub - Blox Fruits Script
-- Versão: 2.0.0
-- Autor: cristiann3010
-- GitHub: https://github.com/cristiann3010/NaitHub

-- ========================================
-- CONFIGURAÇÕES GLOBAIS
-- ========================================
local NAITHUB_CONFIG = {
    VERSION = "2.0.0",
    NAME = "NaitHub",
    AUTHOR = "cristiann3010",
    DISCORD = "discord.gg/exemplo",
    
    -- Cores do tema
    COLORS = {
        PRIMARY = Color3.fromRGB(0, 120, 215),
        SECONDARY = Color3.fromRGB(40, 40, 50),
        BACKGROUND = Color3.fromRGB(25, 25, 35),
        TEXT = Color3.fromRGB(255, 255, 255),
        SUCCESS = Color3.fromRGB(0, 200, 100),
        WARNING = Color3.fromRGB(255, 170, 0),
        DANGER = Color3.fromRGB(220, 60, 60)
    },
    
    -- Configurações da GUI
    GUI = {
        WIDTH = 450,
        HEIGHT = 550,
        MINIMIZED_SIZE = 50,
        ACCENT_COLOR = Color3.fromRGB(0, 170, 255)
    }
}

-- ========================================
-- SERVIÇOS NECESSÁRIOS
-- ========================================
local Services = {
    Players = game:GetService("Players"),
    TweenService = game:GetService("TweenService"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    TeleportService = game:GetService("TeleportService"),
    HttpService = game:GetService("HttpService")
}

local Player = Services.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- ========================================
-- SISTEMA DE LOG
-- ========================================
local LogSystem = {
    logs = {},
    
    add = function(self, type, message)
        local timestamp = os.date("%H:%M:%S")
        local logEntry = string.format("[%s] [%s] %s", timestamp, type:upper(), message)
        
        table.insert(self.logs, logEntry)
        
        -- Imprimir no console
        local colorMap = {
            INFO = Color3.fromRGB(0, 200, 255),
            SUCCESS = Color3.fromRGB(0, 255, 100),
            WARNING = Color3.fromRGB(255, 200, 0),
            ERROR = Color3.fromRGB(255, 50, 50)
        }
        
        local color = colorMap[type] or Color3.fromRGB(255, 255, 255)
        print("🌊 " .. logEntry)
        
        return logEntry
    end,
    
    info = function(self, message) return self:add("INFO", message) end,
    success = function(self, message) return self:add("SUCCESS", message) end,
    warning = function(self, message) return self:add("WARNING", message) end,
    error = function(self, message) return self:add("ERROR", message) end
}

LogSystem:info(string.format("Inicializando %s v%s", NAITHUB_CONFIG.NAME, NAITHUB_CONFIG.VERSION))

-- ========================================
-- FUNÇÕES UTILITÁRIAS
-- ========================================
local Utilities = {
    -- Criar elemento UI com propriedades comuns
    create = function(self, className, properties)
        local element = Instance.new(className)
        
        for prop, value in pairs(properties) do
            if prop ~= "Parent" then
                element[prop] = value
            end
        end
        
        if properties.Parent then
            element.Parent = properties.Parent
        end
        
        return element
    end,
    
    -- Arredondar cantos
    roundCorners = function(self, element, radius)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius)
        corner.Parent = element
        return corner
    end,
    
    -- Adicionar gradiente
    addGradient = function(self, element, colors)
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new(colors)
        gradient.Rotation = 90
        gradient.Parent = element
        return gradient
    end,
    
    -- Tween suave
    tween = function(self, object, properties, duration, easingStyle, easingDirection)
        local tweenInfo = TweenInfo.new(
            duration or 0.3,
            easingStyle or Enum.EasingStyle.Quad,
            easingDirection or Enum.EasingDirection.Out
        )
        
        local tween = Services.TweenService:Create(object, tweenInfo, properties)
        tween:Play()
        return tween
    end,
    
    -- Notificação na tela
    notify = function(self, title, message, type)
        LogSystem:info(string.format("%s: %s", title, message))
    end
}

-- ========================================
-- SISTEMA DE GUI PRINCIPAL
-- ========================================
local NaitHubGUI = {
    screenGui = nil,
    mainFrame = nil,
    isMinimized = false,
    isDragging = false,
    dragStart = nil,
    frameStart = nil,
    
    -- Configurações de tamanho e posição
    config = {
        minimizedSize = UDim2.new(0, NAITHUB_CONFIG.GUI.MINIMIZED_SIZE, 0, NAITHUB_CONFIG.GUI.MINIMIZED_SIZE),
        maximizedSize = UDim2.new(0, NAITHUB_CONFIG.GUI.WIDTH, 0, NAITHUB_CONFIG.GUI.HEIGHT),
        minimizedPosition = UDim2.new(0.5, -NAITHUB_CONFIG.GUI.MINIMIZED_SIZE/2, 0, 20),
        maximizedPosition = UDim2.new(0.5, -NAITHUB_CONFIG.GUI.WIDTH/2, 0.5, -NAITHUB_CONFIG.GUI.HEIGHT/2)
    }
}

-- Criar GUI principal
function NaitHubGUI:create()
    LogSystem:info("Criando interface gráfica...")
    
    -- ScreenGui principal
    self.screenGui = Utilities:create("ScreenGui", {
        Name = NAITHUB_CONFIG.NAME .. "GUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    -- Proteger GUI
    if syn and syn.protect_gui then
        syn.protect_gui(self.screenGui)
    end
    
    self.screenGui.Parent = Player:WaitForChild("PlayerGui")
    
    -- Frame principal
    self.mainFrame = Utilities:create("Frame", {
        Name = "MainFrame",
        Size = self.config.maximizedSize,
        Position = self.config.maximizedPosition,
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.BACKGROUND,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.screenGui
    })
    
    Utilities:roundCorners(self.mainFrame, 12)
    
    -- Sombra
    local shadow = Utilities:create("ImageLabel", {
        Name = "Shadow",
        Size = UDim2.new(1, 10, 1, 10),
        Position = UDim2.new(0, -5, 0, -5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.8,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        ZIndex = -1,
        Parent = self.mainFrame
    })
    
    self:createTitleBar()
    self:createContent()
    
    LogSystem:success("Interface gráfica criada com sucesso")
end

-- Criar barra de título
function NaitHubGUI:createTitleBar()
    LogSystem:info("Criando barra de título...")
    
    -- Barra de título
    local titleBar = Utilities:create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
        BorderSizePixel = 0,
        Parent = self.mainFrame
    })
    
    Utilities:roundCorners(titleBar, 12)
    Utilities:addGradient(titleBar, {
        NAITHUB_CONFIG.COLORS.PRIMARY,
        Color3.fromRGB(0, 100, 180)
    })
    
    -- Título
    local title = Utilities:create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = string.format("🌊 %s v%s", NAITHUB_CONFIG.NAME, NAITHUB_CONFIG.VERSION),
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = titleBar
    })
    
    -- Botão minimizar/maximizar
    self.minimizeBtn = Utilities:create("TextButton", {
        Name = "MinimizeBtn",
        Size = UDim2.new(0, 35, 0, 35),
        Position = UDim2.new(1, -85, 0.5, -17.5),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.PRIMARY,
        Text = "-",
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        Parent = titleBar
    })
    
    Utilities:roundCorners(self.minimizeBtn, 8)
    
    -- Botão fechar
    local closeBtn = Utilities:create("TextButton", {
        Name = "CloseBtn",
        Size = UDim2.new(0, 35, 0, 35),
        Position = UDim2.new(1, -40, 0.5, -17.5),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.DANGER,
        Text = "✕",
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        Parent = titleBar
    })
    
    Utilities:roundCorners(closeBtn, 8)
    
    -- Conectar eventos
    self.minimizeBtn.MouseButton1Click:Connect(function()
        self:toggleMinimize()
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        self:close()
    end)
    
    -- Eventos de arrastar
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.isDragging = true
            self.dragStart = input.Position
            self.frameStart = self.mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    self.isDragging = false
                end
            end)
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and self.isDragging then
            local delta = input.Position - self.dragStart
            self.mainFrame.Position = UDim2.new(
                self.frameStart.X.Scale,
                self.frameStart.X.Offset + delta.X,
                self.frameStart.Y.Scale,
                self.frameStart.Y.Offset + delta.Y
            )
        end
    end)
end

-- Criar conteúdo principal
function NaitHubGUI:createContent()
    LogSystem:info("Criando conteúdo principal...")
    
    -- Frame de conteúdo
    self.contentFrame = Utilities:create("Frame", {
        Name = "ContentFrame",
        Size = UDim2.new(1, 0, 1, -45),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundTransparency = 1,
        Parent = self.mainFrame
    })
    
    -- Sistema de tabs
    self:createTabSystem()
end

-- Criar sistema de tabs
function NaitHubGUI:createTabSystem()
    LogSystem:info("Criando sistema de tabs...")
    
    -- Barra de tabs
    local tabBar = Utilities:create("Frame", {
        Name = "TabBar",
        Size = UDim2.new(1, -20, 0, 40),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
        Parent = self.contentFrame
    })
    
    Utilities:roundCorners(tabBar, 8)
    
    -- Conteúdo das tabs
    self.tabContent = Utilities:create("Frame", {
        Name = "TabContent",
        Size = UDim2.new(1, -20, 1, -70),
        Position = UDim2.new(0, 10, 0, 60),
        BackgroundTransparency = 1,
        Parent = self.contentFrame
    })
    
    -- Tabs disponíveis
    self.tabs = {
        {name = "Início", icon = "🏠"},
        {name = "Frutas", icon = "🍎"},
        {name = "Farm", icon = "⚔️"},
        {name = "Teleport", icon = "📍"},
        {name = "Misc", icon = "⚙️"}
    }
    
    self.currentTab = "Início"
    
    -- Criar botões das tabs
    for i, tab in ipairs(self.tabs) do
        self:createTabButton(tab, i, tabBar)
    end
    
    -- Carregar conteúdo inicial
    self:loadTabContent()
end

-- Criar botão de tab
function NaitHubGUI:createTabButton(tabData, index, parent)
    local tabWidth = 1 / #self.tabs
    
    local tabBtn = Utilities:create("TextButton", {
        Name = tabData.name .. "Tab",
        Size = UDim2.new(tabWidth, -5, 1, -10),
        Position = UDim2.new((index-1) * tabWidth, 2.5, 0, 5),
        BackgroundColor3 = (tabData.name == "Início") and NAITHUB_CONFIG.COLORS.PRIMARY or NAITHUB_CONFIG.COLORS.SECONDARY,
        Text = string.format("%s %s", tabData.icon, tabData.name),
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        Parent = parent
    })
    
    Utilities:roundCorners(tabBtn, 6)
    
    tabBtn.MouseButton1Click:Connect(function()
        self.currentTab = tabData.name
        self:loadTabContent()
        
        -- Atualizar aparência das tabs
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("TextButton") then
                if child.Name == tabData.name .. "Tab" then
                    Utilities:tween(child, {BackgroundColor3 = NAITHUB_CONFIG.COLORS.PRIMARY}, 0.2)
                else
                    Utilities:tween(child, {BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY}, 0.2)
                end
            end
        end
    end)
end

-- Carregar conteúdo da tab
function NaitHubGUI:loadTabContent()
    -- Limpar conteúdo anterior
    for _, child in ipairs(self.tabContent:GetChildren()) do
        child:Destroy()
    end
    
    -- Layout
    local layout = Utilities:create("UIListLayout", {
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = self.tabContent
    })
    
    if self.currentTab == "Início" then
        self:createHomeTab()
    elseif self.currentTab == "Frutas" then
        self:createFruitsTab()
    elseif self.currentTab == "Farm" then
        self:createFarmTab()
    elseif self.currentTab == "Teleport" then
        self:createTeleportTab()
    elseif self.currentTab == "Misc" then
        self:createMiscTab()
    end
end

-- ========================================
-- FUNÇÕES DAS TABS
-- ========================================

-- Tab: Início
function NaitHubGUI:createHomeTab()
    LogSystem:info("Carregando tab: Início")
    
    -- Seção de boas-vindas
    local welcomeSection = self:createSection("Boas-vindas", self.tabContent)
    
    local welcomeText = Utilities:create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 120),
        BackgroundTransparency = 1,
        Text = string.format([[🌊 Bem-vindo ao %s v%s!

Um script completo para Blox Fruits
com diversas funcionalidades.

👑 Desenvolvedor: %s
🎮 Modo: %s
👥 Jogadores: %d]],
            NAITHUB_CONFIG.NAME,
            NAITHUB_CONFIG.VERSION,
            NAITHUB_CONFIG.AUTHOR,
            Services.RunService:IsStudio() and "Studio" or "Live",
            #Services.Players:GetPlayers()),
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        Parent = welcomeSection
    })
    
    -- Seção de status
    local statusSection = self:createSection("Status do Sistema", self.tabContent)
    
    local statusGrid = Utilities:create("Frame", {
        Size = UDim2.new(1, 0, 0, 100),
        BackgroundTransparency = 1,
        Parent = statusSection
    })
    
    local statusItems = {
        {"✅", "Script Carregado", NAITHUB_CONFIG.COLORS.SUCCESS},
        {"📊", "FPS: " .. math.floor(1/Services.RunService.RenderStepped:Wait()), NAITHUB_CONFIG.COLORS.PRIMARY},
        {"🎯", "Latência: --ms", NAITHUB_CONFIG.COLORS.WARNING},
        {"🛡️", "Anti-Kick: Ativo", NAITHUB_CONFIG.COLORS.SUCCESS}
    }
    
    for i, item in ipairs(statusItems) do
        local row = math.floor((i-1)/2)
        local col = (i-1) % 2
        
        local statusFrame = Utilities:create("Frame", {
            Size = UDim2.new(0.5, -5, 0, 40),
            Position = UDim2.new(col * 0.5, col == 0 and 0 or 5, 0, row * 45),
            BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
            Parent = statusGrid
        })
        
        Utilities:roundCorners(statusFrame, 6)
        
        local icon = Utilities:create("TextLabel", {
            Size = UDim2.new(0, 30, 1, 0),
            BackgroundTransparency = 1,
            Text = item[1],
            TextColor3 = item[3],
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            Parent = statusFrame
        })
        
        local text = Utilities:create("TextLabel", {
            Size = UDim2.new(1, -35, 1, 0),
            Position = UDim2.new(0, 35, 0, 0),
            BackgroundTransparency = 1,
            Text = item[2],
            TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
            TextSize = 12,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = statusFrame
        })
    end
end

-- Tab: Frutas
function NaitHubGUI:createFruitsTab()
    LogSystem:info("Carregando tab: Frutas")
    
    local fruitsSection = self:createSection("Gerenciador de Frutas", self.tabContent)
    
    -- Lista de frutas (exemplo)
    local fruits = {
        "Bomba", "Spike", "Chop", "Spring", "Rocket",
        "Spin", "Flame", "Falcon", "Ice", "Sand",
        "Dark", "Diamond", "Light", "Rubber", "Barrier",
        "Ghost", "Magma", "Quake", "Buddha", "Love",
        "String", "Bird: Phoenix", "Rumble", "Paw", "Gravity",
        "Dough", "Shadow", "Venom", "Control", "Spirit",
        "Dragon", "Leopard", "Kitsune"
    }
    
    local scrollFrame = Utilities:create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        CanvasSize = UDim2.new(0, 0, 0, #fruits * 35),
        Parent = fruitsSection
    })
    
    local layout = Utilities:create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = scrollFrame
    })
    
    for i, fruit in ipairs(fruits) do
        local fruitBtn = Utilities:create("TextButton", {
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundColor3 = i % 2 == 0 and NAITHUB_CONFIG.COLORS.SECONDARY or Color3.fromRGB(50, 50, 60),
            Text = "🍎 " .. fruit,
            TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
            TextSize = 13,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = i,
            Parent = scrollFrame
        })
        
        Utilities:roundCorners(fruitBtn, 4)
        
        fruitBtn.MouseButton1Click:Connect(function()
            Utilities:notify("Frutas", "Selecionada: " .. fruit, "info")
            LogSystem:info("Fruta selecionada: " .. fruit)
        end)
    end
    
    -- Botões de ação
    local actionsSection = self:createSection("Ações Rápidas", self.tabContent)
    
    local actionsGrid = Utilities:create("Frame", {
        Size = UDim2.new(1, 0, 0, 80),
        BackgroundTransparency = 1,
        Parent = actionsSection
    })
    
    local actionButtons = {
        {"Comprar Aleatória", function()
            Utilities:notify("Frutas", "Comprando fruta aleatória...", "info")
        end},
        {"Armazenar Fruta", function()
            Utilities:notify("Frutas", "Armazenando fruta atual...", "info")
        end},
        {"Drop de Fruta", function()
            Utilities:notify("Frutas", "Dropando fruta...", "warning")
        end},
        {"Buscar Frutas", function()
            Utilities:notify("Frutas", "Buscando frutas no servidor...", "info")
        end}
    }
    
    for i, action in ipairs(actionButtons) do
        local col = (i-1) % 2
        local row = math.floor((i-1)/2)
        
        local btn = Utilities:create("TextButton", {
            Size = UDim2.new(0.5, -5, 0, 35),
            Position = UDim2.new(col * 0.5, col == 0 and 0 or 5, 0, row * 40),
            BackgroundColor3 = NAITHUB_CONFIG.COLORS.PRIMARY,
            Text = action[1],
            TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
            TextSize = 12,
            Font = Enum.Font.Gotham,
            Parent = actionsGrid
        })
        
        Utilities:roundCorners(btn, 6)
        
        btn.MouseButton1Click:Connect(action[2])
    end
end

-- Tab: Farm
function NaitHubGUI:createFarmTab()
    LogSystem:info("Carregando tab: Farm")
    
    local farmSection = self:createSection("Auto Farm", self.tabContent)
    
    -- Status do farm
    local farmStatus = Utilities:create("Frame", {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
        Parent = farmSection
    })
    
    Utilities:roundCorners(farmStatus, 8)
    
    local statusIndicator = Utilities:create("Frame", {
        Size = UDim2.new(0, 10, 0, 10),
        Position = UDim2.new(0, 15, 0.5, -5),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.DANGER,
        Parent = farmStatus
    })
    
    Utilities:roundCorners(statusIndicator, 10)
    
    local statusText = Utilities:create("TextLabel", {
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 35, 0, 0),
        BackgroundTransparency = 1,
        Text = "🛑 Auto Farm Desativado",
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = farmStatus
    })
    
    -- Botão toggle farm
    local toggleBtn = Utilities:create("TextButton", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.SUCCESS,
        Text = "▶️ INICIAR AUTO FARM",
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = farmSection
    })
    
    Utilities:roundCorners(toggleBtn, 8)
    
    local isFarming = false
    
    toggleBtn.MouseButton1Click:Connect(function()
        isFarming = not isFarming
        
        if isFarming then
            statusIndicator.BackgroundColor3 = NAITHUB_CONFIG.COLORS.SUCCESS
            statusText.Text = "✅ Auto Farm Ativo"
            toggleBtn.Text = "⏸️ PARAR AUTO FARM"
            toggleBtn.BackgroundColor3 = NAITHUB_CONFIG.COLORS.DANGER
            
            LogSystem:success("Auto Farm iniciado")
            Utilities:notify("Farm", "Auto Farm iniciado com sucesso!", "success")
        else
            statusIndicator.BackgroundColor3 = NAITHUB_CONFIG.COLORS.DANGER
            statusText.Text = "🛑 Auto Farm Desativado"
            toggleBtn.Text = "▶️ INICIAR AUTO FARM"
            toggleBtn.BackgroundColor3 = NAITHUB_CONFIG.COLORS.SUCCESS
            
            LogSystem:warning("Auto Farm parado")
            Utilities:notify("Farm", "Auto Farm parado.", "warning")
        end
    end)
    
    -- Configurações de farm
    local settingsSection = self:createSection("Configurações", self.tabContent)
    
    local settings = {
        {"Farm de NPCs", true},
        {"Farm de Bosses", false},
        {"Farm de Frutas", true},
        {"Auto Coletar", true},
        {"Ignorar Players", false}
    }
    
    for i, setting in ipairs(settings) do
        local settingFrame = Utilities:create("Frame", {
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundTransparency = 1,
            Parent = settingsSection
        })
        
        local label = Utilities:create("TextLabel", {
            Size = UDim2.new(0.7, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = "⚙️ " .. setting[1],
            TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
            TextSize = 13,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = settingFrame
        })
        
        local toggle = Utilities:create("TextButton", {
            Size = UDim2.new(0, 50, 0, 25),
            Position = UDim2.new(1, -55, 0.5, -12.5),
            BackgroundColor3 = setting[2] and NAITHUB_CONFIG.COLORS.SUCCESS or NAITHUB_CONFIG.COLORS.SECONDARY,
            Text = setting[2] and "ON" or "OFF",
            TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            Parent = settingFrame
        })
        
        Utilities:roundCorners(toggle, 15)
        
        toggle.MouseButton1Click:Connect(function()
            setting[2] = not setting[2]
            toggle.BackgroundColor3 = setting[2] and NAITHUB_CONFIG.COLORS.SUCCESS or NAITHUB_CONFIG.COLORS.SECONDARY
            toggle.Text = setting[2] and "ON" or "OFF"
            
            LogSystem:info(string.format("%s: %s", setting[1], setting[2] and "Ativado" or "Desativado"))
        end)
    end
end

-- Tab: Teleport
function NaitHubGUI:createTeleportTab()
    LogSystem:info("Carregando tab: Teleport")
    
    local teleportSection = self:createSection("Teleportes Rápidos", self.tabContent)
    
    -- Pesquisa
    local searchBox = Utilities:create("TextBox", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
        PlaceholderText = "🔍 Pesquisar localização...",
        PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
        Text = "",
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        Parent = teleportSection
    })
    
    Utilities:roundCorners(searchBox, 8)
    
    Utilities:create("UIPadding", {
        PaddingLeft = UDim.new(0, 15),
        Parent = searchBox
    })
    
    -- Lista de localizações
    local locations = {
        {"🌊", "Praça Inicial (Primeiro Mar)"},
        {"⚓", "Vila dos Piratas"},
        {"⚖️", "Cidade dos Marines"},
        {"🏟️", "Coliseu"},
        {"🏝️", "Deserto"},
        {"❄️", "Vila do Inverno"},
        {"🌋", "Magma Village"},
        {"🏔️", "Ice Castle"},
        {"🐉", "Dragon Island"},
        {"👻", "Cemetery"},
        {"🌌", "Sky Island"},
        {"🏛️", "Fountain City"},
        {"⚫", "Dark Arena"},
        {"🎯", "Training Island"}
    }
    
    local scrollFrame = Utilities:create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 0, 200),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        CanvasSize = UDim2.new(0, 0, 0, #locations * 40),
        Parent = teleportSection
    })
    
    local layout = Utilities:create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5),
        Parent = scrollFrame
    })
    
    local function createLocationButtons()
        for _, child in ipairs(scrollFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        local searchText = string.lower(searchBox.Text)
        
        for i, location in ipairs(locations) do
            if searchText == "" or string.find(string.lower(location[2]), searchText) then
                local locationBtn = Utilities:create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
                    Text = string.format("%s %s", location[1], location[2]),
                    TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
                    TextSize = 13,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = i,
                    Parent = scrollFrame
                })
                
                Utilities:roundCorners(locationBtn, 6)
                
                Utilities:create("UIPadding", {
                    PaddingLeft = UDim.new(0, 15),
                    Parent = locationBtn
                })
                
                locationBtn.MouseButton1Click:Connect(function()
                    Utilities:notify("Teleport", "Teleportando para: " .. location[2], "info")
                    LogSystem:info("Teleport para: " .. location[2])
                    
                    -- Efeito visual ao clicar
                    Utilities:tween(locationBtn, {BackgroundColor3 = NAITHUB_CONFIG.COLORS.PRIMARY}, 0.1)
                    task.wait(0.1)
                    Utilities:tween(locationBtn, {BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY}, 0.1)
                end)
            end
        end
    end
    
    createLocationButtons()
    
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        createLocationButtons()
    end)
end

-- Tab: Misc
function NaitHubGUI:createMiscTab()
    LogSystem:info("Carregando tab: Misc")
    
    -- Configurações
    local settingsSection = self:createSection("Configurações", self.tabContent)
    
    local miscButtons = {
        {"🌙", "Modo Noturno", function()
            Utilities:notify("Misc", "Alternando modo noturno...", "info")
        end},
        {"🎨", "Mudar Tema", function()
            Utilities:notify("Misc", "Mudando tema...", "info")
        end},
        {"💾", "Salvar Config", function()
            Utilities:notify("Misc", "Configurações salvas!", "success")
            LogSystem:success("Configurações salvas")
        end},
        {"🔄", "Atualizar Script", function()
            Utilities:notify("Misc", "Verificando atualizações...", "info")
        end}
    }
    
    for i, button in ipairs(miscButtons) do
        local col = (i-1) % 2
        local row = math.floor((i-1)/2)
        
        local btn = Utilities:create("TextButton", {
            Size = UDim2.new(0.5, -5, 0, 40),
            Position = UDim2.new(col * 0.5, col == 0 and 0 or 5, 0, row * 45),
            BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
            Text = string.format("%s %s", button[1], button[2]),
            TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
            TextSize = 13,
            Font = Enum.Font.Gotham,
            Parent = settingsSection
        })
        
        Utilities:roundCorners(btn, 8)
        
        btn.MouseButton1Click:Connect(button[3])
    end
    
    -- Ferramentas
    local toolsSection = self:createSection("Ferramentas", self.tabContent)
    
    local tools = {
        {"📏", "Medidor de Distância", function()
            Utilities:notify("Ferramentas", "Medidor ativado", "info")
        end},
        {"💰", "Calculadora de Beli", function()
            Utilities:notify("Ferramentas", "Calculadora aberta", "info")
        end},
        {"📊", "Estatísticas", function()
            Utilities:notify("Ferramentas", "Exibindo estatísticas", "info")
        end},
        {"🎯", "Aim Assist", function()
            Utilities:notify("Ferramentas", "Aim Assist ajustado", "info")
        end}
    }
    
    for i, tool in ipairs(tools) do
        local col = (i-1) % 2
        local row = math.floor((i-1)/2)
        
        local btn = Utilities:create("TextButton", {
            Size = UDim2.new(0.5, -5, 0, 40),
            Position = UDim2.new(col * 0.5, col == 0 and 0 or 5, 0, row * 45),
            BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
            Text = string.format("%s %s", tool[1], tool[2]),
            TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
            TextSize = 13,
            Font = Enum.Font.Gotham,
            Parent = toolsSection
        })
        
        Utilities:roundCorners(btn, 8)
        
        btn.MouseButton1Click:Connect(tool[3])
    end
    
    -- Informações
    local infoSection = self:createSection("Informações", self.tabContent)
    
    local infoText = Utilities:create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 100),
        BackgroundTransparency = 1,
        Text = string.format([[🌊 %s v%s
👑 Desenvolvedor: %s
📅 Última atualização: %s
🎮 Para Blox Fruits
⚠️ Use com responsabilidade]],
            NAITHUB_CONFIG.NAME,
            NAITHUB_CONFIG.VERSION,
            NAITHUB_CONFIG.AUTHOR,
            os.date("%d/%m/%Y")),
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        Parent = infoSection
    })
end

-- ========================================
-- FUNÇÕES AUXILIARES DA GUI
-- ========================================

-- Criar seção
function NaitHubGUI:createSection(title, parent)
    local section = Utilities:create("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
        BackgroundTransparency = 0.2,
        Parent = parent
    })
    
    Utilities:roundCorners(section, 10)
    
    local sectionTitle = Utilities:create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = "📌 " .. title,
        TextColor3 = NAITHUB_CONFIG.COLORS.PRIMARY,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = section
    })
    
    local content = Utilities:create("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -20, 1, -40),
        Position = UDim2.new(0, 10, 0, 40),
        BackgroundTransparency = 1,
        Parent = section
    })
    
    return content
end

-- Alternar minimizar/maximizar
function NaitHubGUI:toggleMinimize()
    self.isMinimized = not self.isMinimized
    
    if self.isMinimized then
        -- Minimizar
        Utilities:tween(self.mainFrame, {Size = self.config.minimizedSize}, 0.3)
        Utilities:tween(self.mainFrame, {Position = self.config.minimizedPosition}, 0.3)
        
        self.minimizeBtn.Text = "+"
        self.contentFrame.Visible = false
        
        LogSystem:info("GUI minimizada")
    else
        -- Maximizar
        Utilities:tween(self.mainFrame, {Size = self.config.maximizedSize}, 0.3)
        Utilities:tween(self.mainFrame, {Position = self.config.maximizedPosition}, 0.3)
        
        self.minimizeBtn.Text = "-"
        self.contentFrame.Visible = true
        
        LogSystem:info("GUI maximizada")
    end
end

-- Fechar GUI
function NaitHubGUI:close()
    Utilities:tween(self.mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
    Utilities:tween(self.mainFrame, {BackgroundTransparency = 1}, 0.3)
    
    task.wait(0.3)
    self.screenGui:Destroy()
    
    LogSystem:success("GUI fechada")
    Utilities:notify("NaitHub", "Script finalizado", "info")
end

-- ========================================
-- INICIALIZAÇÃO
-- ========================================

-- Inicializar GUI
NaitHubGUI:create()

-- Atalhos de teclado
Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.F9 then
            NaitHubGUI:toggleMinimize()
        elseif input.KeyCode == Enum.KeyCode.Insert then
            NaitHubGUI.screenGui.Enabled = not NaitHubGUI.screenGui.Enabled
            LogSystem:info("GUI " .. (NaitHubGUI.screenGui.Enabled and "habilitada" or "desabilitada"))
        end
    end
end)

-- Log inicial
LogSystem:success(string.format("%s v%s inicializado com sucesso!", NAITHUB_CONFIG.NAME, NAITHUB_CONFIG.VERSION))
LogSystem:info("Atalhos: F9 = Minimizar/Maximizar | Insert = Mostrar/Ocultar")

-- Mensagem final
Utilities:notify("NaitHub", 
    string.format("%s v%s carregado com sucesso!\nPressione F9 para abrir o menu.", 
        NAITHUB_CONFIG.NAME, 
        NAITHUB_CONFIG.VERSION
    ), 
    "success"
)

print("\n" .. string.rep("=", 50))
print("🌊 NAITHUB v" .. NAITHUB_CONFIG.VERSION .. " CARREGADO!")
print(string.rep("=", 50))
