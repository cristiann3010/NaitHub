-- 🌊 NaitHub Loader v2.0
-- Auto-update system for NaitHub
-- GitHub: https://github.com/cristiann3010/NaitHub

print("========================================")
print("🌊 NaitHub Loader v2.0")
print("========================================")

-- Configurações
local CONFIG = {
    REPO_OWNER = "cristiann3010",
    REPO_NAME = "NaitHub",
    BRANCH = "main",
    MAIN_SCRIPT = "naihub.lua",
    BACKUP_SCRIPTS = {"menu.lua", "main.lua", "script.lua"},
    VERSION = "2.0.0",
    DEBUG = true
}

-- Função para log colorido
local function log(message, type)
    local colors = {
        INFO = Color3.fromRGB(0, 200, 255),
        SUCCESS = Color3.fromRGB(0, 255, 100),
        WARNING = Color3.fromRGB(255, 200, 0),
        ERROR = Color3.fromRGB(255, 50, 50)
    }
    
    local prefix = {
        INFO = "ℹ️",
        SUCCESS = "✅",
        WARNING = "⚠️",
        ERROR = "❌"
    }
    
    local color = colors[type] or Color3.fromRGB(255, 255, 255)
    local msg = string.format("[%s] %s", prefix[type] or "🔷", message)
    
    print(msg)
    
    -- Notificação no jogo
    if type == "ERROR" or type == "SUCCESS" then
        task.spawn(function()
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "NaitHub Loader",
                    Text = message,
                    Duration = 5,
                    Icon = type == "SUCCESS" and "rbxassetid://4483345998" or "rbxassetid://4483345998"
                })
            end)
        end)
    end
    
    return msg
end

-- Função para construir URL
local function buildURL(filename)
    return string.format(
        "https://raw.githubusercontent.com/%s/%s/%s/%s",
        CONFIG.REPO_OWNER,
        CONFIG.REPO_NAME,
        CONFIG.BRANCH,
        filename
    )
end

-- Verificar se URL existe
local function checkURL(url)
    local success, response = pcall(function()
        return game:HttpGet(url, true)
    end)
    return success and response and #response > 100
end

-- Buscar script do GitHub
local function fetchScript()
    log("Procurando script mais recente...", "INFO")
    
    -- Tentar script principal primeiro
    local mainURL = buildURL(CONFIG.MAIN_SCRIPT)
    log("Tentando: " .. CONFIG.MAIN_SCRIPT, "INFO")
    
    if checkURL(mainURL) then
        log("Script principal encontrado!", "SUCCESS")
        return mainURL, CONFIG.MAIN_SCRIPT
    end
    
    -- Tentar scripts de backup
    for _, scriptName in ipairs(CONFIG.BACKUP_SCRIPTS) do
        local url = buildURL(scriptName)
        log("Tentando backup: " .. scriptName, "INFO")
        
        if checkURL(url) then
            log("Backup encontrado: " .. scriptName, "SUCCESS")
            return url, scriptName
        end
    end
    
    return nil, nil
end

-- Carregar script com segurança
local function loadScriptSafely(url, scriptName)
    log("Baixando: " .. scriptName, "INFO")
    
    local success, content = pcall(function()
        return game:HttpGet(url, true)
    end)
    
    if not success or not content then
        log("Falha ao baixar script", "ERROR")
        return false
    end
    
    if #content < 50 then
        log("Script muito pequeno, possivelmente inválido", "WARNING")
        return false
    end
    
    log("Script baixado (" .. #content .. " bytes)", "SUCCESS")
    
    -- Adicionar header
    local header = string.format([[
-- ========================================
-- 🌊 NaitHub v%s
-- Carregado via Loader v%s
-- Data: %s
-- Arquivo: %s
-- ========================================

]],
        "1.0",
        CONFIG.VERSION,
        os.date("%d/%m/%Y %H:%M:%S"),
        scriptName
    )
    
    content = header .. content
    
    -- Executar script
    log("Executando script...", "INFO")
    
    local execSuccess, execError = pcall(function()
        local func, err = loadstring(content)
        if func then
            func()
        else
            error(err)
        end
    end)
    
    if execSuccess then
        log("Script executado com sucesso!", "SUCCESS")
        return true
    else
        log("Erro na execução: " .. tostring(execError), "ERROR")
        return false
    end
end

-- Modo offline (fallback)
local function loadOfflineMode()
    log("Entrando em modo offline...", "WARNING")
    
    local offlineScript = [[
        -- 🌊 NaitHub - Modo Offline
        
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        
        -- Criar GUI simples
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "NaitHub_Offline"
        ScreenGui.Parent = Player:WaitForChild("PlayerGui")
        
        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 400, 0, 300)
        MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
        MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        MainFrame.Parent = ScreenGui
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = MainFrame
        
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 50)
        Title.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        Title.Text = "🌊 NaitHub - Modo Offline"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamBold
        Title.Parent = MainFrame
        
        local TitleCorner = Instance.new("UICorner")
        TitleCorner.CornerRadius = UDim.new(0, 12)
        TitleCorner.Parent = Title
        
        local Message = Instance.new("TextLabel")
        Message.Size = UDim2.new(1, -20, 0, 150)
        Message.Position = UDim2.new(0, 10, 0, 60)
        Message.BackgroundTransparency = 1
        Message.Text = "⚠️ Modo Offline Ativado\n\n• Conecte-se à internet\n• Verifique o repositório\n• Tente novamente mais tarde\n\nGitHub: cristiann3010/NaitHub"
        Message.TextColor3 = Color3.fromRGB(255, 255, 255)
        Message.TextSize = 14
        Message.Font = Enum.Font.Gotham
        Message.TextWrapped = true
        Message.Parent = MainFrame
        
        local RetryBtn = Instance.new("TextButton")
        RetryBtn.Size = UDim2.new(0, 150, 0, 40)
        RetryBtn.Position = UDim2.new(0.5, -75, 1, -60)
        RetryBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        RetryBtn.Text = "🔄 Tentar Novamente"
        RetryBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        RetryBtn.Font = Enum.Font.Gotham
        RetryBtn.TextSize = 14
        RetryBtn.Parent = MainFrame
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 8)
        BtnCorner.Parent = RetryBtn
        
        RetryBtn.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/cristiann3010/NaitHub/main/loader.lua"))()
        end)
        
        print("🌊 NaitHub Offline Mode ativado")
        print("🔗 GitHub: github.com/cristiann3010/NaitHub")
    ]]
    
    local success, err = pcall(function()
        loadstring(offlineScript)()
    end)
    
    if success then
        log("Modo offline carregado", "SUCCESS")
    else
        log("Erro no modo offline: " .. tostring(err), "ERROR")
    end
end

-- Função principal
local function main()
    log("Inicializando NaitHub Loader...", "INFO")
    log("Repositório: " .. CONFIG.REPO_OWNER .. "/" .. CONFIG.REPO_NAME, "INFO")
    log("Branch: " .. CONFIG.BRANCH, "INFO")
    
    -- Verificar conexão
    log("Verificando conexão...", "INFO")
    
    local url, scriptName = fetchScript()
    
    if url and scriptName then
        log("Conexão estabelecida com sucesso!", "SUCCESS")
        
        -- Carregar script
        local loaded = loadScriptSafely(url, scriptName)
        
        if loaded then
            log("🎉 NaitHub carregado com sucesso!", "SUCCESS")
            
            -- Notificação final
            task.spawn(function()
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "NaitHub",
                        Text = "Carregado com sucesso! Pressione F9",
                        Duration = 5,
                        Icon = "rbxassetid://4483345998"
                    })
                end)
            end)
            
            return true
        else
            log("Falha ao carregar script, ativando modo offline...", "ERROR")
            loadOfflineMode()
            return false
        end
    else
        log("Não foi possível conectar ao GitHub", "ERROR")
        log("Ativando modo offline...", "WARNING")
        loadOfflineMode()
        return false
    end
end

-- Iniciar com tratamento de erros
local success, err = pcall(main)

if not success then
    log("ERRO CRÍTICO: " .. tostring(err), "ERROR")
    
    -- Tentar carregamento de emergência
    local emergency = [[
        print("🚨 NaitHub - Modo Emergência")
        
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        
        -- GUI de emergência mínima
        local gui = Instance.new("ScreenGui")
        gui.Name = "NaitHub_Emergency"
        gui.Parent = Player:WaitForChild("PlayerGui")
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 200)
        frame.Position = UDim2.new(0.5, -150, 0.5, -100)
        frame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        frame.Parent = gui
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 1, -20)
        label.Position = UDim2.new(0, 10, 0, 10)
        label.BackgroundTransparency = 1
        label.Text = "🚨 NaitHub - Erro\n\nPor favor, reinicie o script.\n\nDiscord: cristiann3010"
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextWrapped = true
        label.Parent = frame
        
        print("🚨 Entre em contato para suporte")
    ]]
    
    pcall(function()
        loadstring(emergency)()
    end)
end

print("========================================")
print("🌊 Loader finalizado")
print("========================================")

-- Retornar status
return success
