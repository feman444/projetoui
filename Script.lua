local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getHumanoid()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

local Window = Rayfield:CreateWindow({
    Name = "Tetra4 🛠️",
    LoadingTitle = "🔄 Carregando Menu Tetra4...",
    LoadingSubtitle = "💻 Script otimizado",
    ConfigurationSaving = { Enabled = false },
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.K
})

-- 👤 Aba Player
local TabPlayer = Window:CreateTab("👤 Player", 4483362458)
TabPlayer:CreateSection("🎮 Funções de Movimento")

-- Velocidade
local velocidadeAtiva, velocidadeValor = false, 16
TabPlayer:CreateToggle({
    Name = "🏃‍♂️ Velocidade",
    CurrentValue = false,
    Callback = function(v)
        velocidadeAtiva = v
        local humanoid = getHumanoid()
        humanoid.WalkSpeed = v and velocidadeValor or 16
    end
})
TabPlayer:CreateSlider({
    Name = "⚡ Definir Velocidade",
    Range = {0, 100},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        velocidadeValor = v
        if velocidadeAtiva then
            getHumanoid().WalkSpeed = velocidadeValor
        end
    end
})

-- Pulo
local puloAtivo, puloValor = false, 50
TabPlayer:CreateToggle({
    Name = "🦘 Pulo",
    CurrentValue = false,
    Callback = function(v)
        puloAtivo = v
        getHumanoid().JumpPower = v and puloValor or 50
    end
})
TabPlayer:CreateSlider({
    Name = "🎚️ Definir Pulo",
    Range = {0, 250},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(v)
        puloValor = v
        if puloAtivo then
            getHumanoid().JumpPower = puloValor
        end
    end
})

-- Noclip
local noclipAtivo = false
TabPlayer:CreateToggle({
    Name = "🚫 Noclip",
    CurrentValue = false,
    Callback = function(v)
        noclipAtivo = v
        if v then
            task.spawn(function()
                while noclipAtivo do
                    for _, part in ipairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

TabPlayer:CreateButton({
    Name = "🔄 Reentrar no Server",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end
})

-- 🧍 Aba Avatar
local TabAvatar = Window:CreateTab("🧍 Avatar", 4483362458)
TabAvatar:CreateSection("🎨 Edição Visual")

local remoteCorpo = game:GetService("ReplicatedStorage").Remotes.ChangeBodyColor
local remoteNome = game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r")
local coresCorpo = {"Really red", "Lime green", "Bright blue", "New Yeller", "Royal purple", "Deep orange", "Medium stone grey", "Hot pink", "Earth green"}

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
    Name = "🌈 Nome RGB",
    CurrentValue = false,
    Callback = function(v)
        loopNomeAtivo = v
        if v then
            task.spawn(function()
                while loopNomeAtivo do
                    remoteNome:FireServer("PickingRPNameColor", Color3.fromHSV((tick() % 5) / 5, 1, 1))
                    task.wait(0.1)
                end
            end)
        end
    end
})