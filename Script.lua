-- Load Kavo UI mais recente (adaptado para mobile e executores comuns)
local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/kavopoint/Kavo-UI-Library/main/source.lua"))()

-- Criar a janela principal
local Window = KavoUI.CreateLib("Tetra4 Hub 🛠️", "DarkTheme")

-- Aba Player
local PlayerTab = Window:NewTab("👤 Player")
local PlayerSection = PlayerTab:NewSection("🎮 Funções")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getHumanoid()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end

-- Velocidade
local velocidadeAtiva = false
local velocidadeValor = 16

PlayerSection:NewToggle("🏃‍♂️ Ativar Velocidade", "Ativa velocidade customizada", function(state)
    velocidadeAtiva = state
    local humanoid = getHumanoid()
    humanoid.WalkSpeed = state and velocidadeValor or 16
end)

PlayerSection:NewSlider("⚡ Velocidade", "Define a velocidade do personagem", 100, 0, function(value)
    velocidadeValor = value
    if velocidadeAtiva then
        local humanoid = getHumanoid()
        humanoid.WalkSpeed = value
    end
end)

-- Pulo
local puloAtivo = false
local puloValor = 50

PlayerSection:NewToggle("🦘 Ativar Pulo", "Ativa pulo customizado", function(state)
    puloAtivo = state
    local humanoid = getHumanoid()
    humanoid.JumpPower = state and puloValor or 50
end)

PlayerSection:NewSlider("🦘 Pulo", "Define o poder do pulo", 250, 0, function(value)
    puloValor = value
    if puloAtivo then
        local humanoid = getHumanoid()
        humanoid.JumpPower = value
    end
end)

-- Noclip
local noclipAtivo = false

PlayerSection:NewToggle("🚫 Ativar Noclip", "Desativa colisão do personagem", function(state)
    noclipAtivo = state
    if state then
        task.spawn(function()
            while noclipAtivo do
                local char = player.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)

-- Rejoin Button
PlayerSection:NewButton("🔄 Rejoin Server", "Reentra no servidor atual", function()
    local TeleportService = game:GetService("TeleportService")
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)

-- Aba Avatar
local AvatarTab = Window:NewTab("🧍 Avatar")
local AvatarSection = AvatarTab:NewSection("🎨 Funções")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteCorpo = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ChangeBodyColor")
local remoteNome = ReplicatedStorage:WaitForChild("RE"):FindFirstChild("1RPNam1eColo1r")

local coresCorpo = {
    "Really red", "Lime green", "Bright blue", "New Yeller",
    "Royal purple", "Deep orange", "Medium stone grey",
    "Hot pink", "Earth green"
}

local loopCorpoAtivo = false
AvatarSection:NewToggle("🌈 Trocar Cor do Corpo", "Alterna cores do corpo automaticamente", function(state)
    loopCorpoAtivo = state
    if state then
        task.spawn(function()
            while loopCorpoAtivo do
                for _, cor in ipairs(coresCorpo) do
                    if not loopCorpoAtivo then break end
                    remoteCorpo:FireServer(cor)
                    task.wait(0.3)
                end
            end
        end)
    end
end)

local loopNomeAtivo = false
AvatarSection:NewToggle("🌈 Trocar Cor do Nome RP (RGB)", "Altera cor do nome RP dinamicamente", function(state)
    loopNomeAtivo = state
    if state then
        task.spawn(function()
            while loopNomeAtivo do
                local cor = Color3.fromHSV((tick() % 5) / 5, 1, 1)
                remoteNome:FireServer("PickingRPNameColor", cor)
                task.wait(0.1)
            end
        end)
    end
end)