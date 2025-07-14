local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "✨ Tetra4 | HUB Principal ✨",
    LoadingTitle = "🔵 Tetra4 Carregando...",
    LoadingSubtitle = "🌟 By Renan 🌟",
    ConfigurationSaving = { Enabled = false },
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.K
})

local function getHumanoid()
    local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

-- 🟦 Aba Player
local TabPlayer = Window:CreateTab("🎮 Player", 4483362458)
TabPlayer:CreateSection("⚙️ Funções do Player")

local velocidadeAtiva, velocidadeValor = false, 16
TabPlayer:CreateToggle({
    Name = "🚀 Ativar Velocidade",
    CurrentValue = false,
    Callback = function(v)
        velocidadeAtiva = v
        local humanoid = getHumanoid()
        humanoid.WalkSpeed = v and velocidadeValor or 16
    end
})
TabPlayer:CreateSlider({
    Name = "⚡ Velocidade",
    Range = {0, 100},
    Increment = 1,
    Suffix = " WalkSpeed",
    CurrentValue = 16,
    Callback = function(v)
        velocidadeValor = v
        if velocidadeAtiva then
            local humanoid = getHumanoid()
            humanoid.WalkSpeed = velocidadeValor
        end
    end
})

local puloAtivo, puloValor = false, 50
TabPlayer:CreateToggle({
    Name = "🦘 Ativar Pulo",
    CurrentValue = false,
    Callback = function(v)
        puloAtivo = v
        local humanoid = getHumanoid()
        humanoid.JumpPower = v and puloValor or 50
    end
})
TabPlayer:CreateSlider({
    Name = "🏀 Força do Pulo",
    Range = {0, 250},
    Increment = 1,
    Suffix = " JumpPower",
    CurrentValue = 50,
    Callback = function(v)
        puloValor = v
        if puloAtivo then
            local humanoid = getHumanoid()
            humanoid.JumpPower = puloValor
        end
    end
})

local noclipAtivo = false
TabPlayer:CreateToggle({
    Name = "🚫 Noclip (Atravessar Paredes)",
    CurrentValue = false,
    Callback = function(v)
        noclipAtivo = v
        if v then
            task.spawn(function()
                while noclipAtivo do
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        for _, part in ipairs(character:GetDescendants()) do
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

TabPlayer:CreateButton({
    Name = "🔁 Rejoin Server",
    Suffix = "By Renan",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end
})

-- 🟨 Aba Avatar
local TabAvatar = Window:CreateTab("🧍 Avatar", 4483362458)
TabAvatar:CreateSection("🎨 Personalização de Avatar")

local remoteCorpo = game:GetService("ReplicatedStorage").Remotes.ChangeBodyColor
local remoteNome = game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r")

local coresCorpo = {
    "Really red", "Lime green", "Bright blue", "New Yeller",
    "Royal purple", "Deep orange", "Medium stone grey",
    "Hot pink", "Earth green"
}

local loopCorpoAtivo = false
TabAvatar:CreateToggle({
    Name = "🌈 Trocar Cor do Corpo",
    CurrentValue = false,
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
TabAvatar:CreateToggle({
    Name = "💫 Cor do Nome RP (RGB)",
    CurrentValue = false,
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