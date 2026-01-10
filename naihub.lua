-- 🌊 NaitHub PC Edition - Blox Fruits Script
-- Versão: 2.1.0-PC
-- Otimizado para Xeno Executor
-- Autor: cristiann3010

-- ========================================
-- CONFIGURAÇÕES PC
-- ========================================
local NAITHUB_CONFIG = {
    VERSION = "2.1.0-PC",
    NAME = "NaitHub PC",
    AUTHOR = "cristiann3010",
    
    -- Cores mais vibrantes para PC
    COLORS = {
        PRIMARY = Color3.fromRGB(0, 150, 255),     -- Azul mais forte
        SECONDARY = Color3.fromRGB(45, 45, 60),    -- Fundo escuro
        BACKGROUND = Color3.fromRGB(20, 20, 30),   -- Fundo principal
        TEXT = Color3.fromRGB(240, 240, 240),      -- Texto mais claro
        SUCCESS = Color3.fromRGB(0, 220, 120),     -- Verde brilhante
        WARNING = Color3.fromRGB(255, 180, 0),     -- Amarelo ouro
        DANGER = Color3.fromRGB(255, 70, 70)       -- Vermelho forte
    },
    
    -- Tamanho maior para PC
    GUI = {
        WIDTH = 500,      -- Mais largo para PC
        HEIGHT = 600,     -- Mais alto
        MINIMIZED_SIZE = 60
    }
}

-- ========================================
-- INICIALIZAÇÃO PC
-- ========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Sistema de Log PC
local function log(message, type)
    local colors = {
        INFO = Color3.fromRGB(0, 200, 255),
        SUCCESS = Color3.fromRGB(0, 255, 100),
        WARNING = Color3.fromRGB(255, 200, 0),
        ERROR = Color3.fromRGB(255, 50, 50)
    }
    
    local color = colors[type] or Color3.fromRGB(255, 255, 255)
    print("🌊 [PC] " .. message)
    return message
end

log("Inicializando NaitHub PC Edition v" .. NAITHUB_CONFIG.VERSION, "INFO")

-- ========================================
-- FUNÇÕES UTILITÁRIAS PC
-- ========================================
local PC_Utils = {
    create = function(className, props)
        local obj = Instance.new(className)
        for prop, val in pairs(props) do
            if prop ~= "Parent" then
                obj[prop] = val
            end
        end
        if props.Parent then
            obj.Parent = props.Parent
        end
        return obj
    end,
    
    round = function(obj, radius)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius)
        corner.Parent = obj
        return corner
    end,
    
    gradient = function(obj, color1, color2)
        local grad = Instance.new("UIGradient")
        grad.Color = ColorSequence.new({color1, color2})
        grad.Rotation = 90
        grad.Parent = obj
        return grad
    end,
    
    tween = function(obj, props, duration)
        local tween = TweenService:Create(obj, TweenInfo.new(duration or 0.3), props)
        tween:Play()
        return tween
    end
}

-- ========================================
-- GUI PRINCIPAL PC
-- ========================================
local PC_GUI = {
    screenGui = nil,
    mainFrame = nil,
    isMinimized = false,
    isDragging = false,
    
    config = {
        minimizedSize = UDim2.new(0, 60, 0, 60),
        maximizedSize = UDim2.new(0, 500, 0, 600),
        minimizedPosition = UDim2.new(0.5, -30, 0, 10),
        maximizedPosition = UDim2.new(0.5, -250, 0.5, -300)
    }
}

-- Criar GUI PC
function PC_GUI:init()
    -- ScreenGui com proteção Xeno
    self.screenGui = PC_Utils.create("ScreenGui", {
        Name = "NaitHubPC",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999
    })
    
    -- Proteção para Xeno
    if syn and syn.protect_gui then
        syn.protect_gui(self.screenGui)
    elseif getgenv().protect_gui then
        getgenv().protect_gui(self.screenGui)
    end
    
    self.screenGui.Parent = Player:WaitForChild("PlayerGui")
    
    -- Frame principal
    self.mainFrame = PC_Utils.create("Frame", {
        Name = "MainFrame",
        Size = self.config.maximizedSize,
        Position = self.config.maximizedPosition,
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.BACKGROUND,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.screenGui
    })
    
    PC_Utils.round(self.mainFrame, 15)
    
    -- Sombra
    local shadow = PC_Utils.create("ImageLabel", {
        Name = "Shadow",
        Size = UDim2.new(1, 20, 1, 20),
        Position = UDim2.new(0, -10, 0, -10),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.7,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        ZIndex = -1,
        Parent = self.mainFrame
    })
    
    self:createTitleBar()
    self:createContent()
    
    log("GUI PC criada com sucesso", "SUCCESS")
end

-- Barra de título PC
function PC_GUI:createTitleBar()
    local titleBar = PC_Utils.create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
        BorderSizePixel = 0,
        Parent = self.mainFrame
    })
    
    PC_Utils.round(titleBar, 15)
    PC_Utils.gradient(titleBar, NAITHUB_CONFIG.COLORS.PRIMARY, Color3.fromRGB(0, 100, 200))
    
    -- Título
    local title = PC_Utils.create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -140, 1, 0),
        Position = UDim2.new(0, 20, 0, 0),
        BackgroundTransparency = 1,
        Text = string.format("🚀 %s v%s", NAITHUB_CONFIG.NAME, NAITHUB_CONFIG.VERSION),
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = titleBar
    })
    
    -- Botões
    self.minimizeBtn = PC_Utils.create("TextButton", {
        Name = "MinimizeBtn",
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(1, -95, 0.5, -20),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.PRIMARY,
        Text = "-",
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 24,
        Font = Enum.Font.GothamBold,
        Parent = titleBar
    })
    
    PC_Utils.round(self.minimizeBtn, 10)
    
    local closeBtn = PC_Utils.create("TextButton", {
        Name = "CloseBtn",
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(1, -45, 0.5, -20),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.DANGER,
        Text = "✕",
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        Parent = titleBar
    })
    
    PC_Utils.round(closeBtn, 10)
    
    -- Eventos
    self.minimizeBtn.MouseButton1Click:Connect(function()
        self:toggleMinimize()
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        self:close()
    end)
    
    -- Arrastar PC
    local dragStart, frameStart
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.isDragging = true
            dragStart = input.Position
            frameStart = self.mainFrame.Position
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and self.isDragging then
            local delta = input.Position - dragStart
            self.mainFrame.Position = UDim2.new(
                frameStart.X.Scale,
                frameStart.X.Offset + delta.X,
                frameStart.Y.Scale,
                frameStart.Y.Offset + delta.Y
            )
        end
    end)
    
    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.isDragging = false
        end
    end)
end

-- Conteúdo PC
function PC_GUI:createContent()
    self.contentFrame = PC_Utils.create("Frame", {
        Name = "ContentFrame",
        Size = UDim2.new(1, 0, 1, -50),
        Position = UDim2.new(0, 0, 0, 50),
        BackgroundTransparency = 1,
        Parent = self.mainFrame
    })
    
    self:createTabSystem()
end

-- Sistema de Tabs PC
function PC_GUI:createTabSystem()
    -- Container de tabs
    local tabContainer = PC_Utils.create("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(1, -30, 0, 50),
        Position = UDim2.new(0, 15, 0, 10),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
        Parent = self.contentFrame
    })
    
    PC_Utils.round(tabContainer, 10)
    
    -- Conteúdo das tabs
    self.tabContent = PC_Utils.create("Frame", {
        Name = "TabContent",
        Size = UDim2.new(1, -30, 1, -80),
        Position = UDim2.new(0, 15, 0, 70),
        BackgroundTransparency = 1,
        Parent = self.contentFrame
    })
    
    -- Tabs para PC
    local tabs = {
        {name = "Home", icon = "🏠"},
        {name = "Farm", icon = "⚔️"},
        {name = "TP", icon = "📍"},
        {name = "Fruits", icon = "🍎"},
        {name = "Player", icon = "👤"}
    }
    
    -- Criar tabs
    for i, tab in ipairs(tabs) do
        local tabBtn = PC_Utils.create("TextButton", {
            Name = tab.name .. "Tab",
            Size = UDim2.new(0.2, -6, 0.8, 0),
            Position = UDim2.new((i-1) * 0.2, 3, 0.1, 0),
            BackgroundColor3 = i == 1 and NAITHUB_CONFIG.COLORS.PRIMARY or NAITHUB_CONFIG.COLORS.SECONDARY,
            Text = tab.icon,
            TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
            TextSize = 18,
            Font = Enum.Font.GothamBold,
            Parent = tabContainer
        })
        
        PC_Utils.round(tabBtn, 8)
        
        local tabLabel = PC_Utils.create("TextLabel", {
            Size = UDim2.new(1, 0, 0, 15),
            Position = UDim2.new(0, 0, 1, 2),
            BackgroundTransparency = 1,
            Text = tab.name,
            TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            Parent = tabBtn
        })
        
        tabBtn.MouseButton1Click:Connect(function()
            self:loadTabContent(tab.name)
            -- Atualizar cores
            for _, child in ipairs(tabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = child.Name == tab.name .. "Tab" and 
                        NAITHUB_CONFIG.COLORS.PRIMARY or NAITHUB_CONFIG.COLORS.SECONDARY
                end
            end
        end)
    end
    
    -- Carregar primeira tab
    self:loadTabContent("Home")
end

-- Carregar conteúdo da tab
function PC_GUI:loadTabContent(tabName)
    -- Limpar
    for _, child in ipairs(self.tabContent:GetChildren()) do
        child:Destroy()
    end
    
    if tabName == "Home" then
        self:createHomeTab()
    elseif tabName == "Farm" then
        self:createFarmTab()
    elseif tabName == "TP" then
        self:createTeleportTab()
    elseif tabName == "Fruits" then
        self:createFruitsTab()
    elseif tabName == "Player" then
        self:createPlayerTab()
    end
end

-- Tab: Home
function PC_GUI:createHomeTab()
    local scroll = PC_Utils.create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 8,
        CanvasSize = UDim2.new(0, 0, 0, 400),
        Parent = self.tabContent
    })
    
    -- Welcome
    local welcome = PC_Utils.create("Frame", {
        Size = UDim2.new(1, 0, 0, 120),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
        Parent = scroll
    })
    
    PC_Utils.round(welcome, 12)
    
    local welcomeText = PC_Utils.create("TextLabel", {
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        Text = string.format("🎮 NaitHub PC Edition\nv%s\n\nOtimizado para Xeno Executor\nClique F9 para minimizar",
            NAITHUB_CONFIG.VERSION),
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        Parent = welcome
    })
    
    -- Quick Actions
    local actions = PC_Utils.create("Frame", {
        Size = UDim2.new(1, 0, 0, 150),
        Position = UDim2.new(0, 0, 0, 130),
        BackgroundTransparency = 1,
        Parent = scroll
    })
    
    local actionsTitle = PC_Utils.create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        Text = "⚡ Ações Rápidas",
        TextColor3 = NAITHUB_CONFIG.COLORS.PRIMARY,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = actions
    })
    
    local quickActions = {
        {"Auto Farm", "⚔️", function() log("Iniciando Auto Farm", "INFO") end},
        {"TP Boss", "👑", function() log("Teleportando para boss", "INFO") end},
        {"Buy Fruit", "🍎", function() log("Comprando fruta", "INFO") end},
        {"Player ESP", "👁️", function() log("ESP ativado", "INFO") end}
    }
    
    for i, action in ipairs(quickActions) do
        local col = (i-1) % 2
        local row = math.floor((i-1)/2)
        
        local btn = PC_Utils.create("TextButton", {
            Size = UDim2.new(0.5, -5, 0, 50),
            Position = UDim2.new(col * 0.5, col == 0 and 0 or 5, 0, 35 + row * 55),
            BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
            Text = string.format("%s\n%s", action[2], action[1]),
            TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
            TextSize = 14,
            Font = Enum.Font.Gotham,
            Parent = actions
        })
        
        PC_Utils.round(btn, 10)
        
        btn.MouseButton1Click:Connect(action[3])
    end
end

-- Tab: Farm
function PC_GUI:createFarmTab()
    local scroll = PC_Utils.create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 8,
        CanvasSize = UDim2.new(0, 0, 0, 300),
        Parent = self.tabContent
    })
    
    -- Toggle Farm
    local toggleFrame = PC_Utils.create("Frame", {
        Size = UDim2.new(1, 0, 0, 80),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.SECONDARY,
        Parent = scroll
    })
    
    PC_Utils.round(toggleFrame, 12)
    
    local farmStatus = PC_Utils.create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        Text = "🛑 Farm Desativado",
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toggleFrame
    })
    
    local toggleBtn = PC_Utils.create("TextButton", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 40),
        BackgroundColor3 = NAITHUB_CONFIG.COLORS.SUCCESS,
        Text = "▶️ INICIAR FARM",
        TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = toggleFrame
    })
    
    PC_Utils.round(toggleBtn, 8)
    
    local farming = false
    toggleBtn.MouseButton1Click:Connect(function()
        farming = not farming
        if farming then
            farmStatus.Text = "✅ Farm Ativo"
            toggleBtn.Text = "⏸️ PARAR FARM"
            toggleBtn.BackgroundColor3 = NAITHUB_CONFIG.COLORS.DANGER
            log("Auto Farm iniciado", "SUCCESS")
        else
            farmStatus.Text = "🛑 Farm Desativado"
            toggleBtn.Text = "▶️ INICIAR FARM"
            toggleBtn.BackgroundColor3 = NAITHUB_CONFIG.COLORS.SUCCESS
            log("Auto Farm parado", "WARNING")
        end
    end)
end

-- Tab: TP
function PC_GUI:createTeleportTab()
    local scroll = PC_Utils.create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 8,
        CanvasSize = UDim2.new(0, 0, 0, 400),
        Parent = self.tabContent
    })
    
    local locations = {
        {"🏠", "Spawn"},
        {"⚓", "Pirate Village"},
        {"⚖️", "Marine Base"},
        {"🏟️", "Colosseum"},
        {"❄️", "Snow Village"},
        {"🌋", "Magma Village"},
        {"🐉", "Dragon Island"},
        {"👻", "Graveyard"}
    }
    
    for i, loc in ipairs(locations) do
        local btn = PC_Utils.create("TextButton", {
            Size = UDim2.new(1, 0, 0, 45),
            Position = UDim2.new(0, 0, 0, (i-1) * 50),
            BackgroundColor3 = i % 2 == 0 and NAITHUB_CONFIG.COLORS.SECONDARY or Color3.fromRGB(50, 50, 65),
            Text = string.format("  %s  %s", loc[1], loc[2]),
            TextColor3 = NAITHUB_CONFIG.COLORS.TEXT,
            TextSize = 16,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = scroll
        })
        
        PC_Utils.round(btn, 8)
        
        btn.MouseButton1Click:Connect(function()
            log("Teleportando para: " .. loc[2], "INFO")
            PC_Utils.tween(btn, {BackgroundColor3 = NAITHUB_CONFIG.COLORS.PRIMARY}, 0.1)
            task.wait(0.1)
            PC_Utils.tween(btn, {BackgroundColor3 = i % 2 == 0 and NAITHUB_CONFIG.COLORS.SECONDARY or Color3.fromRGB(50, 50, 65)}, 0.1)
        end)
    end
end

-- Minimizar/Maximizar
function PC_GUI:toggleMinimize()
    self.isMinimized = not self.isMinimized
    
    if self.isMinimized then
        PC_Utils.tween(self.mainFrame, {Size = self.config.minimizedSize}, 0.3)
        PC_Utils.tween(self.mainFrame, {Position = self.config.minimizedPosition}, 0.3)
        self.minimizeBtn.Text = "+"
        self.contentFrame.Visible = false
        log("Minimizado", "INFO")
    else
        PC_Utils.tween(self.mainFrame, {Size = self.config.maximizedSize}, 0.3)
        PC_Utils.tween(self.mainFrame, {Position = self.config.maximizedPosition}, 0.3)
        self.minimizeBtn.Text = "-"
        self.contentFrame.Visible = true
        log("Maximizado", "INFO")
    end
end

-- Fechar
function PC_GUI:close()
    PC_Utils.tween(self.mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
    task.wait(0.3)
    self.screenGui:Destroy()
    log("Fechado", "INFO")
end

-- ========================================
-- INICIAR
-- ========================================
PC_GUI:init()

-- Atalhos PC
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.F9 then
            PC_GUI:toggleMinimize()
        elseif input.KeyCode == Enum.KeyCode.RightControl then
            PC_GUI.screenGui.Enabled = not PC_GUI.screenGui.Enabled
            log("GUI " .. (PC_GUI.screenGui.Enabled and "visível" or "oculta"), "INFO")
        end
    end
end)

-- Mensagem final
log(string.format("✅ %s v%s carregado!", NAITHUB_CONFIG.NAME, NAITHUB_CONFIG.VERSION), "SUCCESS")
log("F9: Minimizar/Maximizar | RightCtrl: Mostrar/Ocultar", "INFO")
log("Arraste pela barra de título para mover", "INFO")

-- Notificação inicial
game.StarterGui:SetCore("SendNotification", {
    Title = "NaitHub PC",
    Text = "Script carregado com sucesso!\nPressione F9 para abrir.",
    Duration = 5,
    Icon = "rbxassetid://4483345998"
})
