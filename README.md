--// NaitHub Premium Corrigido
-- Hub bonito, com blur, minimizar, fechar e toggle na tecla Insert

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- Blur de fundo
local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting
TweenService:Create(Blur, TweenInfo.new(0.5), {Size = 12}):Play()

-- Criando ScreenGui
local NaitHub = Instance.new("ScreenGui")
NaitHub.Name = "NaitHub"
NaitHub.ResetOnSpawn = false
NaitHub.Parent = game:GetService("CoreGui")

-- Funções auxiliares
local function AddShadow(obj)
    local shadow = Instance.new("ImageLabel", obj)
    shadow.Name = "Shadow"
    shadow.AnchorPoint = Vector2.new(0.5,0.5)
    shadow.Position = UDim2.new(0.5,0,0.5,0)
    shadow.Size = UDim2.new(1,30,1,30)
    shadow.ZIndex = obj.ZIndex - 1
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5028857084"
    shadow.ImageColor3 = Color3.fromRGB(0,0,0)
    shadow.ImageTransparency = 0.5
end

local function Roundify(obj, rad)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, rad or 6)
    corner.Parent = obj
end

-- Janela principal
local MainFrame = Instance.new("Frame", NaitHub)
MainFrame.Size = UDim2.new(0, 600, 0, 350)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Roundify(MainFrame, 12)
AddShadow(MainFrame)

-- Header
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(90, 0, 150)
Roundify(Header, 12)
AddShadow(Header)

local Title = Instance.new("TextLabel", Header)
Title.Text = "NaitHub"
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- Botão minimizar
local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 40, 0, 40)
MinBtn.Position = UDim2.new(1, -45, 0, 0)
MinBtn.Text = "–"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 22
MinBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
MinBtn.BorderSizePixel = 0
Roundify(MinBtn, 8)
AddShadow(MinBtn)

-- Botão fechar
local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -90, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 22
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 80)
CloseBtn.BorderSizePixel = 0
Roundify(CloseBtn, 8)
AddShadow(CloseBtn)

-- Menu lateral
local SideMenu = Instance.new("Frame", MainFrame)
SideMenu.Size = UDim2.new(0, 120, 1, -40)
SideMenu.Position = UDim2.new(0, 0, 0, 40)
SideMenu.BackgroundColor3 = Color3.fromRGB(60, 0, 90)
Roundify(SideMenu, 8)
AddShadow(SideMenu)

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
    Roundify(btn, 6)
    AddShadow(btn)
    return btn
end

-- Botões
local InicioBtn = CreateButton("Início", 10)
local FarmBtn = CreateButton("Farm", 55)
local TeleportBtn = CreateButton("Teleport", 100)
local ESPBtn = CreateButton("ESP", 145)
local ConfigBtn = CreateButton("Config", 190)

-- Área central
local Pages = Instance.new("Frame", MainFrame)
Pages.Size = UDim2.new(1, -120, 1, -40)
Pages.Position = UDim2.new(0, 120, 0, 40)
Pages.BackgroundColor3 = Color3.fromRGB(30, 0, 50)
Roundify(Pages, 8)
AddShadow(Pages)

-- Criar páginas
local function CreatePage(name)
    local page = Instance.new("Frame", Pages)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 0
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

-- Alternar páginas
local function ShowPage(page)
    for _, p in pairs(Pages:GetChildren()) do
        if p:IsA("Frame") then
            p.Visible = false
        end
    end
    page.Visible = true
end

InicioBtn.MouseButton1Click:Connect(function() ShowPage(InicioPage) end)
FarmBtn.MouseButton1Click:Connect(function() ShowPage(FarmPage) end)
TeleportBtn.MouseButton1Click:Connect(function() ShowPage(TeleportPage) end)
ESPBtn.MouseButton1Click:Connect(function() ShowPage(ESPPage) end)
ConfigBtn.MouseButton1Click:Connect(function() ShowPage(ConfigPage) end)

ShowPage(InicioPage)

-- Minimizar
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MinBtn.Text = "+"
        SideMenu.Visible = false
        Pages.Visible = false
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 200, 0, 40)}):Play()
    else
        MinBtn.Text = "–"
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 350)}):Play()
        task.wait(0.3)
        SideMenu.Visible = true
        Pages.Visible = true
    end
end)

-- Fechar
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Blur, TweenInfo.new(0.3), {Size = 0}):Play()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.3)
    Blur:Destroy()
    NaitHub:Destroy()
end)

-- Toggle por Insert
local hubVisible = true
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        hubVisible = not hubVisible
        MainFrame.Visible = hubVisible
        if hubVisible then
            TweenService:Create(Blur, TweenInfo.new(0.3), {Size = 12}):Play()
        else
            TweenService:Create(Blur, TweenInfo.new(0.3), {Size = 0}):Play()
        end
    end
end)

print("✅ NaitHub Premium Corrigido carregado!")
