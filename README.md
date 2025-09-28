--// NaitHub Premium - Design Melhorado
-- by chat 😎

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Função para sombra melhorada
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
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
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
MainFrame.ClipsDescendants = true

Roundify(MainFrame, 15)
AddShadow(MainFrame)
AddGradient(MainFrame, Color3.fromRGB(20, 20, 30), Color3.fromRGB(30, 15, 45), 45)

-- Animação de entrada suave
local openTween = TweenService:Create(MainFrame, 
    TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
    {Size = UDim2.new(0, 700, 0, 400)}
)
openTween:Play()

-- Header moderno
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 50)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(60, 30, 90)
Header.BorderSizePixel = 0
Header.ZIndex = 6

Roundify(Header, 15)
AddShadow(Header)
AddGradient(Header, Color3.fromRGB(80, 40, 120), Color3.fromRGB(60, 30, 90), 90)

-- Título com ícone
local TitleIcon = Instance.new("TextLabel")
TitleIcon.Name = "TitleIcon"
TitleIcon.Parent = Header
TitleIcon.Size = UDim2.new(0, 30, 0, 30)
TitleIcon.Position = UDim2.new(0, 15, 0.5, -15)
TitleIcon.Text = "⚡"
TitleIcon.TextColor3 = Color3.fromRGB(255, 200, 255)
TitleIcon.TextSize = 24
TitleIcon.Font = Enum.Font.GothamBold
TitleIcon.BackgroundTransparency = 1
TitleIcon.ZIndex = 7

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Header
Title.Text = "NaitHub Premium"
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 55, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.ZIndex = 7

-- Botão minimizar melhorado
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
MinBtn.AutoButtonColor = false
MinBtn.ZIndex = 7

Roundify(MinBtn, 8)
AddShadow(MinBtn)

-- Botão fechar melhorado
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
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 7

Roundify(CloseBtn, 8)
AddShadow(CloseBtn)

-- Menu lateral moderno
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

-- Função para criar botões com animação melhorada
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
    btn.AutoButtonColor = false
    btn.ZIndex = 7
    btn.BorderSizePixel = 0

    Roundify(btn, 8)
    AddShadow(btn)
    AddGradient(btn, Color3.fromRGB(60, 40, 80), Color3.fromRGB(40, 25, 60), 45)

    -- Animações de hover
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Color3.fromRGB(80, 50, 120),
            Size = UDim2.new(1, -15, 0, 40)
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Color3.fromRGB(50, 30, 70),
            Size = UDim2.new(1, -20, 0, 40)
        }):Play()
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
    page.ScrollBarThickness = 6
    page.ScrollBarImageColor3 = Color3.fromRGB(100, 60, 140)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.Visible = false
    page.ZIndex = 7

    -- Título da página
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
local ConfigPage = CreatePage("Configurações")

-- Função melhorada para trocar páginas
local currentPage = nil
local function ShowPage(page)
    if currentPage == page then return end
    
    if currentPage then
        TweenService:Create(currentPage, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Position = UDim2.new(-1, 0, 0, 0)
        }):Play()
        
        task.wait(0.1)
        currentPage.Visible = false
        currentPage.Position = UDim2.new(1, 0, 0, 0)
    end
    
    currentPage = page
    page.Visible = true
    page.Position = UDim2.new(1, 0, 0, 0)
    
    TweenService:Create(page, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
end

-- Função para criar slider moderno e funcional
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
    AddGradient(sliderFrame, Color3.fromRGB(45, 45, 65), Color3.fromRGB(35, 35, 55), 90)

    -- Label do slider
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

    -- Barra do slider
    local sliderBar = Instance.new("Frame")
    sliderBar.Name = "SliderBar"
    sliderBar.Parent = sliderFrame
    sliderBar.Size = UDim2.new(1, -40, 0, 6)
    sliderBar.Position = UDim2.new(0, 20, 0, 45)
    sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    sliderBar.BorderSizePixel = 0
    sliderBar.ZIndex = 9
    
    Roundify(sliderBar, 3)

    -- Preenchimento do slider
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "SliderFill"
    sliderFill.Parent = sliderBar
    sliderFill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(120, 80, 200)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 10
    
    Roundify(sliderFill, 3)
    AddGradient(sliderFill, Color3.fromRGB(140, 100, 220), Color3.fromRGB(100, 60, 180), 0)

    -- Botão do slider
    local sliderButton = Instance.new("TextButton")
    sliderButton.Name = "SliderButton"
    sliderButton.Parent = sliderBar
    sliderButton.Size = UDim2.new(0, 20, 0, 20)
    sliderButton.Position = UDim2.new((default-min)/(max-min), -10, 0.5, -10)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.BorderSizePixel = 0
    sliderButton.Text = ""
    sliderButton.AutoButtonColor = false
    sliderButton.ZIndex = 11
    
    Roundify(sliderButton, 10)
    AddShadow(sliderButton)
    AddGradient(sliderButton, Color3.fromRGB(255, 255, 255), Color3.fromRGB(200, 200, 200), 45)

    -- Lógica do slider
    local dragging = false
    local currentValue = default

    local function updateSlider(input)
        local relativeX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * relativeX)
        
        if value ~= currentValue then
            currentValue = value
            label.Text = labelText .. ": " .. value
            
            -- Animações suaves
            TweenService:Create(sliderFill, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                Size = UDim2.new(relativeX, 0, 1, 0)
            }):Play()
            
            TweenService:Create(sliderButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                Position = UDim2.new(relativeX, -10, 0.5, -10)
            }):Play()
            
            callback(value)
        end
    end

    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
        TweenService:Create(sliderButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 24, 0, 24)}):Play()
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
            dragging = false
            TweenService:Create(sliderButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 20, 0, 20)}):Play()
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)

    sliderBar.MouseButton1Down:Connect(function()
        updateSlider(UserInputService:GetMouseLocation())
    end)

    -- Efeito hover
    sliderButton.MouseEnter:Connect(function()
        if not dragging then
            TweenService:Create(sliderButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 22, 0, 22)}):Play()
        end
    end)

    sliderButton.MouseLeave:Connect(function()
        if not dragging then
            TweenService:Create(sliderButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 20, 0, 20)}):Play()
        end
    end)
end

-- Adicionando sliders na Farm Page
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

-- Conectar botões às páginas
InicioBtn.MouseButton1Click:Connect(function() ShowPage(InicioPage) end)
FarmBtn.MouseButton1Click:Connect(function() ShowPage(FarmPage) end)
TeleportBtn.MouseButton1Click:Connect(function() ShowPage(TeleportPage) end)
ESPBtn.MouseButton1Click:Connect(function() ShowPage(ESPPage) end)
ConfigBtn.MouseButton1Click:Connect(function() ShowPage(ConfigPage) end)

-- Mostrar página inicial
ShowPage(InicioPage)

-- Funcionalidade de minimizar melhorada
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    if minimized then
        MinBtn.Text = "☐"
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 350, 0, 50)}):Play()
        SideMenu.Visible = false
        Pages.Visible = false
    else
        MinBtn.Text = "─"
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 700, 0, 400)}):Play()
        task.wait(0.4)
        SideMenu.Visible = true
        Pages.Visible = true
    end
end)

-- Fechar com animação suave
CloseBtn.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(MainFrame, 
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), 
        {Size = UDim2.new(0, 0, 0, 0)}
    )
    closeTween:Play()
    
    closeTween.Completed:Connect(function()
        NaitHub:Destroy()
    end)
end)

-- Efeitos hover nos botões do header
MinBtn.MouseEnter:Connect(function()
    TweenService:Create(MinBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120, 80, 160)}):Play()
end)
MinBtn.MouseLeave:Connect(function()
    TweenService:Create(MinBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 60, 140)}):Play()
end)

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 80, 80)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 60, 60)}):Play()
end)

print("✨ NaitHub Premium v2.0 carregado com sucesso!")
print("🎨 Design melhorado e sliders funcionais implementados!")
