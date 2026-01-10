-- 🌊 NaitHub - Blox Fruits
-- Versão: 1.0-Stable
-- Para PC/Executor

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer

print("🌊 NaitHub inicializando...")

-- Configurações
local Config = {
    VERSION = "1.0",
    Colors = {
        Main = Color3.fromRGB(0, 120, 215),
        Dark = Color3.fromRGB(30, 30, 40),
        Light = Color3.fromRGB(50, 50, 60),
        Text = Color3.fromRGB(255, 255, 255),
        Green = Color3.fromRGB(0, 200, 100),
        Red = Color3.fromRGB(220, 60, 60)
    }
}

-- Criar interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NaitHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 500)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
MainFrame.BackgroundColor3 = Config.Colors.Dark
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Config.Colors.Main
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌊 NaitHub v" .. Config.VERSION
Title.TextColor3 = Config.Colors.Text
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Botão minimizar
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -80, 0.5, -17.5)
MinBtn.BackgroundColor3 = Config.Colors.Light
MinBtn.Text = "-"
MinBtn.TextColor3 = Config.Colors.Text
MinBtn.TextSize = 20
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Parent = TitleBar

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = MinBtn

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseBtn.BackgroundColor3 = Config.Colors.Red
CloseBtn.Text = "X"
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

-- Tabs
local Tabs = {"Início", "Farm", "TP", "Frutas", "Config"}
local CurrentTab = "Início"

-- Criar barra de tabs
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 40)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Content

-- Conteúdo das tabs
local TabContent = Instance.new("Frame")
TabContent.Size = UDim2.new(1, 0, 1, -50)
TabContent.Position = UDim2.new(0, 0, 0, 50)
TabContent.BackgroundTransparency = 1
TabContent.Parent = Content

-- Função para criar botões de tab
local function createTabButtons()
    for i, tabName in ipairs(Tabs) do
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0.2, -4, 1, 0)
        TabBtn.Position = UDim2.new((i-1) * 0.2, 2, 0, 0)
        TabBtn.BackgroundColor3 = tabName == CurrentTab and Config.Colors.Main or Config.Colors.Light
        TabBtn.Text = tabName
        TabBtn.TextColor3 = Config.Colors.Text
        TabBtn.TextSize = 14
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.Parent = TabBar
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabBtn
        
        TabBtn.MouseButton1Click:Connect(function()
            CurrentTab = tabName
            loadTabContent()
            
            -- Atualizar cores
            for _, child in ipairs(TabBar:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = child.Text == CurrentTab and Config.Colors.Main or Config.Colors.Light
                end
            end
        end)
    end
end

-- Função para criar seção
local function createSection(title, parent)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, 0, 0, 0)
    Section.BackgroundColor3 = Config.Colors.Light
    Section.Parent = parent
    
    local SectionCorner = Instance.new("UICorner")
    SectionCorner.CornerRadius = UDim.new(0, 8)
    SectionCorner.Parent = Section
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 0, 30)
    TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "📌 " .. title
    TitleLabel.TextColor3 = Config.Colors.Main
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

-- Função para carregar conteúdo da tab
local function loadTabContent()
    for _, child in ipairs(TabContent:GetChildren()) do
        child:Destroy()
    end
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.Parent = TabContent
    
    if CurrentTab == "Início" then
        local welcomeSection = createSection("Bem-vindo", TabContent)
        welcomeSection.Size = UDim2.new(1, 0, 0, 120)
        
        local WelcomeText = Instance.new("TextLabel")
        WelcomeText.Size = UDim2.new(1, 0, 1, 0)
        WelcomeText.BackgroundTransparency = 1
        WelcomeText.Text = "🌊 NaitHub v" .. Config.VERSION .. "\n\nPara Blox Fruits\nUse as tabs para navegar"
        WelcomeText.TextColor3 = Config.Colors.Text
        WelcomeText.TextSize = 16
        WelcomeText.Font = Enum.Font.Gotham
        WelcomeText.TextYAlignment = Enum.TextYAlignment.Top
        WelcomeText.TextWrapped = true
        WelcomeText.Parent = welcomeSection
        
    elseif CurrentTab == "Farm" then
        local farmSection = createSection("Auto Farm", TabContent)
        farmSection.Size = UDim2.new(1, 0, 0, 150)
        
        local Status = Instance.new("TextLabel")
        Status.Size = UDim2.new(1, 0, 0, 30)
        Status.BackgroundTransparency = 1
        Status.Text = "🛑 Farm Desativado"
        Status.TextColor3 = Config.Colors.Text
        Status.TextSize = 16
        Status.Font = Enum.Font.GothamBold
        Status.Parent = farmSection
        
        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(1, 0, 0, 40)
        ToggleBtn.Position = UDim2.new(0, 0, 0, 40)
        ToggleBtn.BackgroundColor3 = Config.Colors.Green
        ToggleBtn.Text = "▶️ INICIAR FARM"
        ToggleBtn.TextColor3 = Config.Colors.Text
        ToggleBtn.TextSize = 14
        ToggleBtn.Font = Enum.Font.GothamBold
        ToggleBtn.Parent = farmSection
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 8)
        ToggleCorner.Parent = ToggleBtn
        
        local farming = false
        ToggleBtn.MouseButton1Click:Connect(function()
            farming = not farming
            if farming then
                Status.Text = "✅ Farm Ativo"
                ToggleBtn.Text = "⏸️ PARAR FARM"
                ToggleBtn.BackgroundColor3 = Config.Colors.Red
                print("Farm iniciado")
            else
                Status.Text = "🛑 Farm Desativado"
                ToggleBtn.Text = "▶️ INICIAR FARM"
                ToggleBtn.BackgroundColor3 = Config.Colors.Green
                print("Farm parado")
            end
        end)
        
    elseif CurrentTab == "TP" then
        local tpSection = createSection("Teleportes", TabContent)
        
        local Scroll = Instance.new("ScrollingFrame")
        Scroll.Size = UDim2.new(1, 0, 0, 250)
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
            "Magma Village"
        }
        
        for i, loc in ipairs(Locations) do
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 40)
            Btn.Position = UDim2.new(0, 0, 0, (i-1) * 45)
            Btn.BackgroundColor3 = i % 2 == 0 and Config.Colors.Light or Color3.fromRGB(40, 40, 50)
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
                print("TP para: " .. loc)
            end)
        end
        
    elseif CurrentTab == "Frutas" then
        local fruitSection = createSection("Frutas", TabContent)
        
        local Btn1 = Instance.new("TextButton")
        Btn1.Size = UDim2.new(1, 0, 0, 40)
        Btn1.BackgroundColor3 = Config.Colors.Main
        Btn1.Text = "🍎 Comprar Fruta Aleatória"
        Btn1.TextColor3 = Config.Colors.Text
        Btn1.TextSize = 14
        Btn1.Font = Enum.Font.Gotham
        Btn1.Parent = fruitSection
        
        local Btn1Corner = Instance.new("UICorner")
        Btn1Corner.CornerRadius = UDim.new(0, 8)
        Btn1Corner.Parent = Btn1
        
        local Btn2 = Instance.new("TextButton")
        Btn2.Size = UDim2.new(1, 0, 0, 40)
        Btn2.Position = UDim2.new(0, 0, 0, 50)
        Btn2.BackgroundColor3 = Config.Colors.Main
        Btn2.Text = "📦 Armazenar Fruta"
        Btn2.TextColor3 = Config.Colors.Text
        Btn2.TextSize = 14
        Btn2.Font = Enum.Font.Gotham
        Btn2.Parent = fruitSection
        
        local Btn2Corner = Instance.new("UICorner")
        Btn2Corner.CornerRadius = UDim.new(0, 8)
        Btn2Corner.Parent = Btn2
        
        Btn1.MouseButton1Click:Connect(function()
            print("Comprando fruta aleatória...")
        end)
        
        Btn2.MouseButton1Click:Connect(function()
            print("Armazenando fruta...")
        end)
        
    elseif CurrentTab == "Config" then
        local configSection = createSection("Configurações", TabContent)
        
        local HideBtn = Instance.new("TextButton")
        HideBtn.Size = UDim2.new(1, 0, 0, 40)
        HideBtn.BackgroundColor3 = Config.Colors.Main
        HideBtn.Text = "👁️ Mostrar/Ocultar Interface"
        HideBtn.TextColor3 = Config.Colors.Text
        HideBtn.TextSize = 14
        HideBtn.Font = Enum.Font.Gotham
        HideBtn.Parent = configSection
        
        local HideCorner = Instance.new("UICorner")
        HideCorner.CornerRadius = UDim.new(0, 8)
        HideCorner.Parent = HideBtn
        
        HideBtn.MouseButton1Click:Connect(function()
            ScreenGui.Enabled = not ScreenGui.Enabled
            print("Interface: " .. (ScreenGui.Enabled and "Visível" or "Oculta"))
        end)
    end
end

-- Inicializar tabs
createTabButtons()
loadTabContent()

-- Minimizar/Maximizar
local Minimized = false
MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    
    if Minimized then
        MainFrame.Size = UDim2.new(0, 50, 0, 50)
        MainFrame.Position = UDim2.new(0.5, -25, 0, 20)
        MinBtn.Text = "+"
        Content.Visible = false
        Title.Text = "🌊"
    else
        MainFrame.Size = UDim2.new(0, 450, 0, 500)
        MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
        MinBtn.Text = "-"
        Content.Visible = true
        Title.Text = "🌊 NaitHub v" .. Config.VERSION
    end
end)

-- Fechar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    print("NaitHub fechado")
end)

-- Arrastar
local Dragging, DragStart, FrameStart
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
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.F9 then
            Minimized = not Minimized
            if Minimized then
                MainFrame.Size = UDim2.new(0, 50, 0, 50)
                MainFrame.Position = UDim2.new(0.5, -25, 0, 20)
                MinBtn.Text = "+"
                Content.Visible = false
                Title.Text = "🌊"
            else
                MainFrame.Size = UDim2.new(0, 450, 0, 500)
                MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
                MinBtn.Text = "-"
                Content.Visible = true
                Title.Text = "🌊 NaitHub v" .. Config.VERSION
            end
        elseif input.KeyCode == Enum.KeyCode.Insert then
            ScreenGui.Enabled = not ScreenGui.Enabled
            print("Interface: " .. (ScreenGui.Enabled and "Visível" or "Oculta"))
        end
    end
end)

-- Notificação inicial
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "NaitHub v" .. Config.VERSION,
    Text = "Carregado com sucesso!\nF9: Minimizar\nInsert: Ocultar",
    Duration = 5
})

print("✅ NaitHub v" .. Config.VERSION .. " carregado!")
print("📌 F9: Minimizar/Maximizar")
print("📌 Insert: Mostrar/Ocultar")
print("📌 Arraste pela barra azul para mover")
