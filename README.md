--[[
    Menu GUI para Blox Fruits
    Compatível com PC
    Features: Minimizar/Maximizar, Arrastar, Seções organizadas
]]

-- Serviços necessários
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Player local
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Configurações do menu
local config = {
    MinimizedSize = UDim2.new(0, 50, 0, 50), -- Tamanho minimizado
    MaximizedSize = UDim2.new(0, 450, 0, 500), -- Tamanho maximizado
    MinimizedPosition = UDim2.new(0.5, -25, 0, 20), -- Posição minimizada
    MaximizedPosition = UDim2.new(0.5, -225, 0.5, -250), -- Posição maximizada
    BackgroundColor = Color3.fromRGB(30, 30, 40),
    AccentColor = Color3.fromRGB(0, 170, 255),
    TextColor = Color3.fromRGB(255, 255, 255)
}

-- Estado do menu
local isMinimized = false
local isDragging = false
local dragStart, frameStart

-- Criar a GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BloxFruitsMenu"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn and syn.protect_gui then
    syn.protect_gui(screenGui)
end

screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = config.MaximizedSize
mainFrame.Position = config.MaximizedPosition
mainFrame.BackgroundColor3 = config.BackgroundColor
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Arredondar bordas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Sombra
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame
shadow.ZIndex = -1

-- Barra de título
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

-- Título
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌊 Blox Fruits Menu"
title.TextColor3 = config.TextColor
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Botão de minimizar/maximizar
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0.5, -15)
minimizeBtn.BackgroundColor3 = config.AccentColor
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = config.TextColor
minimizeBtn.TextSize = 20
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = titleBar

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 5)
btnCorner.Parent = minimizeBtn

-- Botão de fechar (opcional)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeBtn.Text = "X"
closeBtn.TextColor3 = config.TextColor
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeBtn

-- Conteúdo principal
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Tab bar
local tabBar = Instance.new("Frame")
tabBar.Name = "TabBar"
tabBar.Size = UDim2.new(1, 0, 0, 50)
tabBar.BackgroundTransparency = 1
tabBar.Parent = contentFrame

-- Conteúdo das tabs
local tabContent = Instance.new("Frame")
tabContent.Name = "TabContent"
tabContent.Size = UDim2.new(1, -20, 1, -70)
tabContent.Position = UDim2.new(0, 10, 0, 60)
tabContent.BackgroundTransparency = 1
tabContent.Parent = contentFrame

-- Tabs disponíveis
local tabs = {
    "Início",
    "Frutas",
    "Farms",
    "Teleportes",
    "Misc"
}

local currentTab = "Início"

-- Função para criar botão de tab
local function createTabButton(tabName)
    local btn = Instance.new("TextButton")
    btn.Name = tabName .. "Tab"
    btn.Size = UDim2.new(0.2, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = tabName
    btn.TextColor3 = config.TextColor
    btn.TextSize = 14
    btn.Font = Enum.Font.Gotham
    btn.Parent = tabBar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = btn
    
    -- Posicionar tabs
    local tabCount = #tabs
    for i, tab in ipairs(tabs) do
        if tab == tabName then
            btn.Position = UDim2.new((i-1) * 0.2, 5, 0, 5)
        end
    end
    
    btn.MouseButton1Click:Connect(function()
        currentTab = tabName
        updateTabContent()
        
        -- Atualizar aparência das tabs
        for _, child in ipairs(tabBar:GetChildren()) do
            if child:IsA("TextButton") then
                if child.Name == tabName .. "Tab" then
                    child.BackgroundColor3 = config.AccentColor
                else
                    child.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                end
            end
        end
    end)
    
    return btn
end

-- Função para criar seção
local function createSection(titleText, parent)
    local section = Instance.new("Frame")
    section.Name = titleText .. "Section"
    section.Size = UDim2.new(1, 0, 0, 150)
    section.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    section.BackgroundTransparency = 0.2
    section.Parent = parent
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 8)
    sectionCorner.Parent = section
    
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Name = "Title"
    sectionTitle.Size = UDim2.new(1, -20, 0, 30)
    sectionTitle.Position = UDim2.new(0, 10, 0, 5)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = titleText
    sectionTitle.TextColor3 = config.AccentColor
    sectionTitle.TextSize = 16
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.Parent = section
    
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -20, 1, -40)
    content.Position = UDim2.new(0, 10, 0, 40)
    content.BackgroundTransparency = 1
    content.Parent = section
    
    return content
end

-- Função para criar botão de ação
local function createActionButton(text, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Name = text .. "Btn"
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = config.AccentColor
    btn.Text = text
    btn.TextColor3 = config.TextColor
    btn.TextSize = 14
    btn.Font = Enum.Font.Gotham
    btn.Parent = parent
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    
    return btn
end

-- Função para atualizar conteúdo da tab
local function updateTabContent()
    -- Limpar conteúdo anterior
    for _, child in ipairs(tabContent:GetChildren()) do
        child:Destroy()
    end
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = tabContent
    
    if currentTab == "Início" then
        local welcomeSection = createSection("Bem-vindo", tabContent)
        
        local welcomeText = Instance.new("TextLabel")
        welcomeText.Size = UDim2.new(1, 0, 0, 80)
        welcomeText.BackgroundTransparency = 1
        welcomeText.Text = "Menu Blox Fruits\n\nUse as tabs para navegar\nentre as funcionalidades"
        welcomeText.TextColor3 = config.TextColor
        welcomeText.TextSize = 14
        welcomeText.Font = Enum.Font.Gotham
        welcomeText.TextYAlignment = Enum.TextYAlignment.Top
        welcomeText.Parent = welcomeSection
        
    elseif currentTab == "Frutas" then
        local fruitsSection = createSection("Gerenciar Frutas", tabContent)
        
        createActionButton("Comprar Fruta Aleatória", fruitsSection, function()
            print("Comprar fruta aleatória")
        end)
        
        createActionButton("Armazenar Fruta Atual", fruitsSection, function()
            print("Armazenar fruta")
        end)
        
    elseif currentTab == "Farms" then
        local farmSection = createSection("Auto Farm", tabContent)
        
        local toggleFarm = Instance.new("TextButton")
        toggleFarm.Name = "ToggleFarm"
        toggleFarm.Size = UDim2.new(1, 0, 0, 35)
        toggleFarm.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
        toggleFarm.Text = "Iniciar Auto Farm"
        toggleFarm.TextColor3 = config.TextColor
        toggleFarm.TextSize = 14
        toggleFarm.Font = Enum.Font.Gotham
        toggleFarm.Parent = farmSection
        
        local farmCorner = Instance.new("UICorner")
        farmCorner.CornerRadius = UDim.new(0, 5)
        farmCorner.Parent = toggleFarm
        
        local farming = false
        toggleFarm.MouseButton1Click:Connect(function()
            farming = not farming
            if farming then
                toggleFarm.Text = "Parar Auto Farm"
                toggleFarm.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
                print("Auto Farm iniciado")
            else
                toggleFarm.Text = "Iniciar Auto Farm"
                toggleFarm.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
                print("Auto Farm parado")
            end
        end)
        
    elseif currentTab == "Teleportes" then
        local teleportSection = createSection("Teleportes", tabContent)
        
        local locations = {
            "Praça inicial",
            "Ilha do Coliseu",
            "Vila dos Piratas",
            "Cidade dos Marines"
        }
        
        for i, location in ipairs(locations) do
            createActionButton("TP: " .. location, teleportSection, function()
                print("Teleportando para: " .. location)
            end)
        end
        
    elseif currentTab == "Misc" then
        local miscSection = createSection("Configurações", tabContent)
        
        createActionButton("Mostrar/Ocultar Interface", miscSection, function()
            screenGui.Enabled = not screenGui.Enabled
        end)
        
        createActionButton("Salvar Configurações", miscSection, function()
            print("Configurações salvas")
        end)
    end
end

-- Função para minimizar/maximizar
local function toggleMinimize()
    isMinimized = not isMinimized
    
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    if isMinimized then
        -- Minimizar
        local tweenSize = TweenService:Create(mainFrame, tweenInfo, {Size = config.MinimizedSize})
        local tweenPos = TweenService:Create(mainFrame, tweenInfo, {Position = config.MinimizedPosition})
        
        tweenSize:Play()
        tweenPos:Play()
        
        minimizeBtn.Text = "+"
        contentFrame.Visible = false
        
        -- Apenas mostrar título minimizado
        title.Text = "🌊"
    else
        -- Maximizar
        local tweenSize = TweenService:Create(mainFrame, tweenInfo, {Size = config.MaximizedSize})
        local tweenPos = TweenService:Create(mainFrame, tweenInfo, {Position = config.MaximizedPosition})
        
        tweenSize:Play()
        tweenPos:Play()
        
        minimizeBtn.Text = "-"
        contentFrame.Visible = true
        
        -- Restaurar título
        title.Text = "🌊 Blox Fruits Menu"
    end
end

-- Funções para arrastar
local function startDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        dragStart = input.Position
        frameStart = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
            end
        end)
    end
end

local function updateDrag(input)
    if isDragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X,
                                      frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
    end
end

-- Criar todas as tabs
for _, tabName in ipairs(tabs) do
    createTabButton(tabName)
end

-- Inicializar primeira tab
updateTabContent()

-- Conectar eventos
minimizeBtn.MouseButton1Click:Connect(toggleMinimize)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    print("Menu fechado")
end)

-- Arrastar
titleBar.InputBegan:Connect(startDrag)
titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        updateDrag(input)
    end
end)

-- Atalho de teclado (F9 para minimizar/maximizar)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.F9 then
            toggleMinimize()
        elseif input.KeyCode == Enum.KeyCode.Insert then
            screenGui.Enabled = not screenGui.Enabled
        end
    end
end)

-- Notificação inicial
print("📜 Menu Blox Fruits carregado!")
print("📌 F9: Minimizar/Maximizar")
print("📌 Insert: Mostrar/Ocultar")
print("📌 Arraste pela barra de título")

-- Manter interface responsiva
RunService.RenderStepped:Connect(function()
    -- Atualizar posição se estiver minimizado
    if isMinimized then
        mainFrame.Position = config.MinimizedPosition
    end
end)

return screenGui
