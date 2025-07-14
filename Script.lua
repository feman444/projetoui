local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()

local Window = redzlib:MakeWindow({
    Title = "Tetra4 🛠️",
    SubTitle = "by Renan",
    SaveFolder = "Tetra4_Settings"
})

-- Aba Player
local TabPlayer = Window:MakeTab({"Player", "4483362458"}) -- ícone pode ser ID ou string

local velocidadeAtiva = false
local velocidadeValor = 16

TabPlayer:AddToggle({
    Name = "🏃‍♂️ Ativar Velocidade",
    Default = false,
    Callback = function(v)
        velocidadeAtiva = v
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = v and velocidadeValor or 16
        end
    end
})

TabPlayer:AddSlider({
    Name = "⚡ Velocidade",
    Min = 0,
    Max = 100,
    Default = 16,
    Callback = function(v)
        velocidadeValor = v
        if velocidadeAtiva then
            local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = velocidadeValor
            end
        end
    end
})

local puloAtivo = false
local puloValor = 50

TabPlayer:AddToggle({
    Name = "🦘 Ativar Pulo",
    Default = false,
    Callback = function(v)
        puloAtivo = v
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = v and puloValor or 50
        end
    end
})

TabPlayer:AddSlider({
    Name = "🦘 Pulo",
    Min = 0,
    Max = 250,
    Default = 50,
    Callback = function(v)
        puloValor = v
        if puloAtivo then
            local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = puloValor
            end
        end
    end
})

local noclipAtivo = false
TabPlayer:AddToggle({
    Name = "🚫 Ativar Noclip",
    Default = false,
    Callback = function(v)
        noclipAtivo = v
        if v then
            task.spawn(function()
                while noclipAtivo do
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

TabPlayer:AddButton({
    Name = "🔄 Rejoin Server",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

-- Aba Avatar
local TabAvatar = Window:MakeTab({"Avatar", "4483362458"})

TabAvatar:AddSection({"🎨 Funções"})

local remoteCorpo = game:GetService("ReplicatedStorage").Remotes.ChangeBodyColor
local remoteNome = game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r")

local coresCorpo = {
    "Really red", "Lime green", "Bright blue", "New Yeller",
    "Royal purple", "Deep orange", "Medium stone grey",
    "Hot pink", "Earth green"
}

local loopCorpoAtivo = false
TabAvatar:AddToggle({
    Name = "🌈 Trocar Cor do Corpo",
    Default = false,
    Callback = function(v)
        loopCorpoAtivo = v
        if v then
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
    end
})

local loopNomeAtivo = false
TabAvatar:AddToggle({
    Name = "🌈 Trocar Cor do Nome RP (RGB)",
    Default = false,
    Callback = function(v)
        loopNomeAtivo = v
        if v then
            task.spawn(function()
                while loopNomeAtivo do
                    local cor = Color3.fromHSV((tick() % 5) / 5, 1, 1)
                    remoteNome:FireServer("PickingRPNameColor", cor)
                    task.wait(0.1)
                end
            end)
        end
    end
})