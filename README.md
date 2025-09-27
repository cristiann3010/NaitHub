--// NaitHub - Script Base com botão de minimizar
-- Feito para ser simples, bonito e expansível 😎

-- Criando ScreenGui
local NaitHub = Instance.new("ScreenGui")
NaitHub.Name = "NaitHub"
NaitHub.ResetOnSpawn = false
NaitHub.Parent = game:GetService("CoreGui")

-- Janela principal
local MainFrame = Instance.new("Frame", NaitHub)
MainFrame.Size = UDim2.new(0, 600, 0, 350)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 0, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- arrastar hub

-- Header
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(90, 0, 150)

local Title = Instance.new("TextLabel", Header)
Title.Text = "NaitHub"
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- Botão de minimizar
local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 40, 0, 40)
MinBtn.Position = UDim2.new(1, -45, 0, 0)
MinBtn.Text = "–"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 22
MinBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
MinBtn.BorderSizePixel = 0

-- Menu lateral
local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, -40)
SideMenu.Position = UDim2.new(0, 0, 0, 40)
SideMenu.BackgroundColor3 = Color3.fromRGB(50, 0, 80)

-- Função para criar botões
local function CreateButton(name, y)
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, y)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(100, 0, 160)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    btn.AutoButtonColor = true
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(140, 0, 200)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(100, 0, 160)
    end)
    return btn
end

-- Botões do menu
local InicioBtn = CreateButton("Início", 10)
local FarmBtn = CreateButton("Farm", 55)
local TeleportBtn = CreateButton("Teleport", 100)
local ESPBtn = CreateButton("ESP", 145)
local ConfigBtn = CreateButton("Config", 190)

-- Área central para páginas
local Pages = Instance.new("Frame", MainFrame)
Pages.Size = UDim2.new(1, -120, 1, -40)
Pages.Position = UDim2.new(0, 120, 0, 40)
Pages.BackgroundColor3 = Color3.fromRGB(35, 0, 60)

-- Criar páginas
local function CreatePage(name)
    local page = Instance.new("Frame", Pages)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false

    local label = Instance.new("TextLabel", page)
    label.Text = name .. " Page"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.TextColor3 = Color3.fromRGB(200, 150, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 22
    return page
end

local InicioPage = CreatePage("Início")
local FarmPage = CreatePage("Farm")
local TeleportPage = CreatePage("Teleport")
local ESPPage = CreatePage("ESP")
local ConfigPage = CreatePage("Config")

-- Função para mudar de página
local function ShowPage(page)
    for _, p in pairs(Pages:GetChildren()) do
        p.Visible = false
    end
    page.Visible = true
end

-- Conectar botões às páginas
InicioBtn.MouseButton1Click:Connect(function() ShowPage(InicioPage) end)
FarmBtn.MouseButton1Click:Connect(function() ShowPage(FarmPage) end)
TeleportBtn.MouseButton1Click:Connect(function() ShowPage(TeleportPage) end)
ESPBtn.MouseButton1Click:Connect(function() ShowPage(ESPPage) end)
ConfigBtn.MouseButton1Click:Connect(function() ShowPage(ConfigPage) end)

-- Mostrar página inicial
ShowPage(InicioPage)

-- Função do botão minimizar
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        SideMenu.Visible = false
        Pages.Visible = false
        MainFrame.Size = UDim2.new(0, 200, 0, 40)
    else
        SideMenu.Visible = true
        Pages.Visible = true
        MainFrame.Size = UDim2.new(0, 600, 0, 350)
    end
end)

print("✅ NaitHub carregado com sucesso!")
