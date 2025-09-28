--// NaitHub Premium - Mobile Version
-- by chat 😎

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- Função para sombra
local function AddShadow(obj)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Parent = obj
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 2)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.ZIndex = math.max(obj.ZIndex - 1, 0)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5028857084"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.7
    return shadow
end

-- Função para arredondar
local function Roundify(obj, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = obj
    return corner
end

-- Função para gradiente
local function AddGradient(obj, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    }
    gradient.Rotation = rotation or 0
    gradient.Parent = obj
    return gradient
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
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 5

Roundify(MainFrame, 15)
AddShadow(MainFrame)
AddGradient(MainFrame, Color3.fromRGB(20, 20, 30), Color3.fromRGB(30, 15, 45), 45)

-- Animação de entrada
local openTween = TweenService:Create(MainFrame, 
    TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
    {Size = UDim2.new(0, 700, 0, 400)}
)
openTween:Play()

-- Header (não draggable para não interferir nos botões)
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 50)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(60, 30, 90)
Header.BorderSizePixel = 0
Header.ZIndex = 6
Header.Active = false

Roundify(Header, 15)
AddShadow(Header)
AddGradient(Header, Color3.fromRGB(80, 40, 120), Color3.fromRGB(60, 30, 90), 90)

-- Área draggable separada
local DragArea = Instance.new("Frame")
DragArea.Name = "DragArea"
DragArea.Parent = Header
DragArea.Size = UDim2.new(1, -150, 1, 0)
DragArea.Position = UDim2.new(0, 0, 0, 0)
DragArea.BackgroundTransparency = 1
DragArea.ZIndex = 6

-- Conectar drag manualmente
local dragStart = nil
local startPos = nil
local dragging = false

DragArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

DragArea.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Header
Title.Text = "⚡ NaitHub Premium"
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.ZIndex = 7

-- Botão minimizar
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Parent = Header
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -80, 0.5, -17.5)
MinBtn.Text = "─"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 140)
MinBtn.BorderSizePixel = 0
MinBtn.ZIndex = 10
MinBtn.Active = true

Roundify(MinBtn, 8)
AddShadow(MinBtn)

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = Header
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 10
CloseBtn.Active = true

Roundify(CloseBtn, 8)
AddShadow(CloseBtn)

-- Menu lateral
local SideMenu = Instance.new("Frame")
SideMenu.Name = "SideMenu"
SideMenu.Parent = MainFrame
SideMenu.Size = UDim2.new(0, 150, 1, -50)
SideMenu.Position = UDim2.new(0, 0, 0, 50)
SideMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
SideMenu.BorderSizePixel = 0
SideMenu.ZIndex = 6

Roundify(SideMenu, 12)
AddShadow(SideMenu)
AddGradient(SideMenu, Color3.fromRGB(25, 25, 40), Color3.fromRGB(35, 20, 50), 180)

-- Função para criar botões do menu (mobile-friendly)
local function CreateMenuButton(name, icon, y)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Parent = SideMenu
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(50, 30, 70)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Text = "  " .. icon .. "  " .. name
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 8
    btn.BorderSizePixel = 0
    btn.Active = true

    Roundify(btn, 8)
    AddShadow(btn)
    AddGradient(btn, Color3.fromRGB(60, 40, 80), Color3.fromRGB(40, 25, 60), 45)

    -- Efeito de toque para mobile
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(btn, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(80, 50, 120),
                Size = UDim2.new(1, -15, 0, 38)
            }):Play()
        end
    end)

    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(btn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(50, 30, 70),
                Size = UDim2.new(1, -20, 0, 40)
            }):Play()
        end
    end)

    return btn
end

-- Criando botões do menu
local InicioBtn = CreateMenuButton("Início", "🏠", 15)
local FarmBtn = CreateMenuButton("Farm", "⚡", 70)
local TeleportBtn = CreateMenuButton("Teleport", "🌐", 125)
local ESPBtn = CreateMenuButton("ESP", "👁️", 180)
local ConfigBtn = CreateMenuButton("Config", "⚙️", 235)

-- Área central para páginas
local Pages = Instance.new("Frame")
Pages.Name = "Pages"
Pages.Parent = MainFrame
Pages.Size = UDim2.new(1, -150, 1, -50)
Pages.Position = UDim2.new(0, 150, 0, 50)
Pages.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Pages.BorderSizePixel = 0
Pages.ZIndex = 6

Roundify(Pages, 12)
AddShadow(Pages)
AddGradient(Pages, Color3.fromRGB(30, 30, 45), Color3.fromRGB(25, 25, 40), 0)

-- Função para criar páginas
local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Parent = Pages
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Position = UDim2.new(0, 0, 0, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 8
    page.ScrollBarImageColor3 = Color3.fromRGB(100, 60, 140)
    page.CanvasSize = UDim2.new(0, 0, 0, 500)
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.Visible = false
    page.ZIndex = 7

    local pageTitle = Instance.new("TextLabel")
    pageTitle.Name = "PageTitle"
    pageTitle.Parent = page
    pageTitle.Text = name
    pageTitle.Size = UDim2.new(1, -40, 0, 40)
    pageTitle.Position = UDim2.new(0, 20, 0, 10)
    pageTitle.TextColor3 = Color3.fromRGB(200, 150, 255)
    pageTitle.BackgroundTransparency = 1
    pageTitle.Font = Enum.Font.GothamBold
    pageTitle.TextSize = 24
    pageTitle.TextXAlignment = Enum.TextXAlignment.Left
    pageTitle.ZIndex = 8

    return page
end

-- Criando páginas
local InicioPage = CreatePage("Início")
local FarmPage = CreatePage("Farm")
local TeleportPage = CreatePage("Teleport")
local ESPPage = CreatePage("ESP")
local ConfigPage = CreatePage("Config")

-- Função para criar slider (mobile-friendly)
local function CreateSlider(parent, labelText, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = labelText .. "Slider"
    sliderFrame.Parent = parent
    sliderFrame.Size = UDim2.new(1, -40, 0, 80)
    sliderFrame.Position = UDim2.new(0, 20, 0, (#parent:GetChildren() - 1) * 90 + 60)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.ZIndex = 8
    
    Roundify(sliderFrame, 12)
    AddShadow(sliderFrame)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Parent = sliderFrame
    label.Text = labelText .. ": " .. default
    label.Size = UDim2.new(1, -20, 0, 25)
    label.Position = UDim2.new(0, 10, 0, 8)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 9

    local sliderBar = Instance.new("Frame")
    sliderBar.Name = "SliderBar"
    sliderBar.Parent = sliderFrame
    sliderBar.Size = UDim2.new(1, -40, 0, 8)
    sliderBar.Position = UDim2.new(0, 20, 0, 45)
    sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    sliderBar.BorderSizePixel = 0
    sliderBar.ZIndex = 9
    sliderBar.Active = true
    
    Roundify(sliderBar, 4)

    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "SliderFill"
    sliderFill.Parent = sliderBar
    sliderFill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(120, 80, 200)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 10
    
    Roundify(sliderFill, 4)

    local sliderButton = Instance.new("Frame")
    sliderButton.Name = "SliderButton"
    sliderButton.Parent = sliderBar
    sliderButton.Size = UDim2.new(0, 24, 0, 24)
    sliderButton.Position = UDim2.new((default-min)/(max-min), -12, 0.5, -12)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.BorderSizePixel = 0
    sliderButton.ZIndex = 11
    sliderButton.Active = true
    
    Roundify(sliderButton, 12)
    AddShadow(sliderButton)

    local currentValue = default
    local dragging = false

    local function updateSlider(inputPos)
        local relativeX = math.clamp((inputPos - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * relativeX)
        
        if value ~= currentValue then
            currentValue = value
            label.Text = labelText .. ": " .. value
            
            sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            sliderButton.Position = UDim2.new(relativeX, -12, 0.5, -12)
            
            callback(value)
        end
    end

    -- Eventos mobile-friendly para o slider
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input.Position.X)
            sliderButton.Size = UDim2.new(0, 28, 0, 28)
            sliderButton.Position = UDim2.new(sliderButton.Position.X.Scale, -14, 0.5, -14)
        end
    end)

    sliderBar.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input.Position.X)
        end
    end)

    sliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            sliderButton.Size = UDim2.new(0, 24, 0, 24)
            sliderButton.Position = UDim2.new(sliderButton.Position.X.Scale, -12, 0.5, -12)
        end
    end)
end

-- Conteúdo das páginas
local welcomeText = Instance.new("TextLabel")
welcomeText.Parent = InicioPage
welcomeText.Text = "Bem-vindo ao NaitHub Premium!\n\nEste é um hub mobile completo com várias funcionalidades.\n\n📱 Otimizado para dispositivos móveis\n⚡ Use os sliders na aba Farm\n🌐 Explore as outras funcionalidades\n\n👆 Toque nos botões para navegar!"
welcomeText.Size = UDim2.new(1, -40, 0, 200)
welcomeText.Position = UDim2.new(0, 20, 0, 60)
welcomeText.TextColor3 = Color3.fromRGB(200, 200, 200)
welcomeText.BackgroundTransparency = 1
welcomeText.Font = Enum.Font.Gotham
welcomeText.TextSize = 16
welcomeText.TextXAlignment = Enum.TextXAlignment.Left
welcomeText.TextYAlignment = Enum.TextYAlignment.Top
welcomeText.TextWrapped = true
welcomeText.ZIndex = 8

-- Sliders na Farm Page
CreateSlider(FarmPage, "Speed", 16, 300, 16, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

CreateSlider(FarmPage, "Jump Power", 50, 300, 50, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

-- Sistema de páginas
local currentPage = nil
local function ShowPage(page)
    if currentPage then
        currentPage.Visible = false
    end
    currentPage = page
    page.Visible = true
end

-- Conectar botões (mobile events)
InicioBtn.Activated:Connect(function() ShowPage(InicioPage) end)
FarmBtn.Activated:Connect(function() ShowPage(FarmPage) end)
TeleportBtn.Activated:Connect(function() ShowPage(TeleportPage) end)
ESPBtn.Activated:Connect(function() ShowPage(ESPPage) end)
ConfigBtn.Activated:Connect(function() ShowPage(ConfigPage) end)

-- Página inicial
ShowPage(InicioPage)

-- Funcionalidade minimizar (mobile)
local minimized = false
MinBtn.Activated:Connect(function()
    minimized = not minimized
    
    if minimized then
        MinBtn.Text = "☐"
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 350, 0, 50)
        }):Play()
        SideMenu.Visible = false
        Pages.Visible = false
    else
        MinBtn.Text = "─"
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 700, 0, 400)
        }):Play()
        task.wait(0.2)
        SideMenu.Visible = true
        Pages.Visible = true
    end
end)

-- Funcionalidade fechar (mobile)
CloseBtn.Activated:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    task.wait(0.5)
    NaitHub:Destroy()
end)

print("✨ NaitHub Premium Mobile v2.0 carregado!")
print("📱 Otimizado para dispositivos móveis!")
