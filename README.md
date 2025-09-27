--// NaitHub Premium - com blur de fundo
-- by chat 😎

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- Função para sombra (DropShadow)
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

-- Função pra arredondar
local function Roundify(obj, rad)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, rad or 6)
    corner.Parent = obj
end

-- Criando ScreenGui
local NaitHub = Instance.new("ScreenGui")
NaitHub.Name = "NaitHub"
NaitHub.ResetOnSpawn = false
NaitHub.Parent = game:GetService("CoreGui")

-- Criando efeito de blur
local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting
TweenService:Create(Blur, TweenInfo.new(0.5), {Size = 12}):Play()

-- Janela principal
local MainFrame = Instance.new("Frame", NaitHub)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 0, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 5
Roundify(MainFrame, 12)
AddShadow(MainFrame)

-- Animação de entrada
TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 600, 0, 350)}):Play()

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
SideMenu.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
Roundify(SideMenu, 8)
AddShadow(SideMenu)

-- Função para criar botões com animação
local function CreateButton(name, y)
    local btn = Instance.new("TextButton", SideMenu)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, y)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(100, 0, 160)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    btn.AutoButtonColor = false
    btn.ZIndex = 6
    Roundify(btn, 6)
    AddShadow(btn)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(140, 0, 200)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 0, 160)}):Play()
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
Roundify(Pages, 8)
AddShadow(Pages)

-- Criar páginas
local function CreatePage(name)
    local page = Instance.new("Frame", Pages)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false

    local label = Instance.new("TextLabel", page)
    label.Text = name .. " Page"
    label.Size = UDim2.new(1, 0, 0, 30)
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

-- Fade ao trocar página
local function ShowPage(page)
    for _, p in pairs(Pages:GetChildren()) do
        if p:IsA("Frame") then
            TweenService:Create(p, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            p.Visible = false
        end
    end
    page.Visible = true
    TweenService:Create(page, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
end

-- Conectar botões às páginas
InicioBtn.MouseButton1Click:Connect(function() ShowPage(InicioPage) end)
FarmBtn.MouseButton1Click:Connect(function() ShowPage(FarmPage) end)
TeleportBtn.MouseButton1Click:Connect(function() ShowPage(TeleportPage) end)
ESPBtn.MouseButton1Click:Connect(function() ShowPage(ESPPage) end)
ConfigBtn.MouseButton1Click:Connect(function() ShowPage(ConfigPage) end)

ShowPage(InicioPage)

-- Minimizar animado
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MinBtn.Text = "+"
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 200, 0, 40)}):Play()
        SideMenu.Visible = false
        Pages.Visible = false
    else
        MinBtn.Text = "–"
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 350)}):Play()
        task.wait(0.3)
        SideMenu.Visible = true
        Pages.Visible = true
    end
end)

-- Fechar com efeito + remover blur
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    TweenService:Create(Blur, TweenInfo.new(0.3), {Size = 0}):Play()
    task.wait(0.3)
    Blur:Destroy()
    NaitHub:Destroy()
end)

-- Sliders (iguais antes, só com blur ativo)
local function CreateSlider(parent, labelText, min, max, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0, 300, 0, 60)
    frame.Position = UDim2.new(0, 20, 0, (#parent:GetChildren() - 1) * 70 + 40)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Text = labelText .. ": " .. default
    label.Size = UDim2.new(1, 0, 0, 20)
    label.TextColor3 = Color3.fromRGB(200, 150, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(1, -20, 0, 8)
    bar.Position = UDim2.new(0, 10, 0, 35)
    bar.BackgroundColor3 = Color3.fromRGB(100, 0, 160)
    Roundify(bar, 4)
    AddShadow(bar)

    local knob = Instance.new("Frame", bar)
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new((default-min)/(max-min), -10, 0.5, -10)
    knob.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
    Roundify(knob, 10)
    AddShadow(knob)

    local dragging = false

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - bar.AbsolutePosition.X)/bar.AbsoluteSize.X, 0, 1)
            knob.Position = UDim2.new(rel, -10, 0.5, -10)
            local value = math.floor(min + (max-min)*rel)
            label.Text = labelText .. ": " .. value
            callback(value)
        end
    end)
end

-- Slider Speed
CreateSlider(FarmPage, "Speed", 16, 200, 16, function(val)
    local plr = game.Players.LocalPlayer
    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.WalkSpeed = val
    end
end)

-- Slider Jump
CreateSlider(FarmPage, "Jump", 50, 200, 50, function(val)
    local plr = game.Players.LocalPlayer
    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.JumpPower = val
    end
end)

print("✨ NaitHub Premium carregado com blur de fundo!")
