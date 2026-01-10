-- 🌊 NaitHub Loader v3.0
-- Auto-update system for NaitHub
-- GitHub: https://github.com/cristiann3010/NaitHub

print("========================================")
print("🌊 NaitHub Loader v3.0")
print("========================================")

-- Configurações
local CONFIG = {
    REPO_OWNER = "cristiann3010",
    REPO_NAME = "NaitHub",
    BRANCH = "main",
    MAIN_SCRIPT = "naihub.lua",
    BACKUP_SCRIPTS = {"main.lua", "script.lua"},
    VERSION = "3.0.0"
}

-- Função para log
local function log(msg, type)
    local colors = {
        INFO = Color3.fromRGB(0, 200, 255),
        SUCCESS = Color3.fromRGB(0, 255, 100),
        WARNING = Color3.fromRGB(255, 200, 0),
        ERROR = Color3.fromRGB(255, 50, 50)
    }
    
    local prefix = {
        INFO = "[INFO]",
        SUCCESS = "[SUCCESS]",
        WARNING = "[WARNING]", 
        ERROR = "[ERROR]"
    }
    
    local color = colors[type] or Color3.fromRGB(255, 255, 255)
    local finalMsg = string.format("%s %s", prefix[type] or "[LOG]", msg)
    
    print(finalMsg)
    return finalMsg
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
        local content = game:HttpGet(url, true)
        return content and #content > 100
    end)
    return success
end

-- Buscar script
local function fetchScript()
    log("Buscando script mais recente...", "INFO")
    
    -- Tentar script principal
    local mainURL = buildURL(CONFIG.MAIN_SCRIPT)
    log("Tentando: " .. CONFIG.MAIN_SCRIPT, "INFO")
    
    if checkURL(mainURL) then
        log("Script principal encontrado!", "SUCCESS")
        return mainURL, CONFIG.MAIN_SCRIPT
    end
    
    -- Tentar backups
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

-- Carregar script
local function loadScriptSafely(url, scriptName)
    log("Baixando: " .. scriptName, "INFO")
    
    local success, content = pcall(function()
        return game:HttpGet(url, true)
    end)
    
    if not success or not content then
        log("Falha ao baixar", "ERROR")
        return false
    end
    
    if #content < 50 then
        log("Script inválido", "WARNING")
        return false
    end
    
    log("Executando script...", "INFO")
    
    -- Adicionar timestamp
    content = "-- 🕒 Carregado em: " .. os.date("%d/%m/%Y %H:%M:%S") .. "\n" .. content
    
    local execSuccess, execError = pcall(function()
        loadstring(content)()
    end)
    
    if execSuccess then
        log("Script executado com sucesso!", "SUCCESS")
        return true
    else
        log("Erro: " .. tostring(execError), "ERROR")
        return false
    end
end

-- Modo offline
local function loadOfflineMode()
    log("Ativando modo offline...", "WARNING")
    
    local offlineScript = [[
        print("🌊 NaitHub - Modo Offline")
        
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "NaitHub_Offline"
        ScreenGui.Parent = Player:WaitForChild("PlayerGui")
        
        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 350, 0, 200)
        MainFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
        MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        MainFrame.Parent = ScreenGui
        
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 40)
        Title.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        Title.Text = "🌊 NaitHub - Offline"
        Title.TextColor3 = Color3.new(1, 1, 1)
        Title.Font = Enum.Font.GothamBold
        Title.Parent = MainFrame
        
        local Message = Instance.new("TextLabel")
        Message.Size = UDim2.new(1, -20, 0, 100)
        Message.Position = UDim2.new(0, 10, 0, 50)
        Message.BackgroundTransparency = 1
        Message.Text = "Verifique sua conexão\nou tente novamente."
        Message.TextColor3 = Color3.new(1, 1, 1)
        Message.TextSize = 14
        Message.Font = Enum.Font.Gotham
        Message.TextWrapped = true
        Message.Parent = MainFrame
        
        local RetryBtn = Instance.new("TextButton")
        RetryBtn.Size = UDim2.new(0, 120, 0, 35)
        RetryBtn.Position = UDim2.new(0.5, -60, 1, -50)
        RetryBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        RetryBtn.Text = "🔄 Tentar"
        RetryBtn.TextColor3 = Color3.new(1, 1, 1)
        RetryBtn.Font = Enum.Font.Gotham
        RetryBtn.Parent = MainFrame
        
        RetryBtn.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/cristiann3010/NaitHub/main/loader.lua"))()
        end)
    ]]
    
    local success, err = pcall(function()
        loadstring(offlineScript)()
    end)
    
    if success then
        log("Modo offline ativado", "SUCCESS")
    end
end

-- Principal
log("Inicializando NaitHub Loader v" .. CONFIG.VERSION, "INFO")

local url, scriptName = fetchScript()

if url then
    local loaded = loadScriptSafely(url, scriptName)
    if not loaded then
        loadOfflineMode()
    end
else
    loadOfflineMode()
end

print("========================================")
