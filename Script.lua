local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getHumanoid()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

local Window = Rayfield:CreateWindow({
    Name = "🌌 Tetra4 | Hub Completo",
    LoadingTitle = "🚀 Carregando Tetra4 Hub...",
    LoadingSubtitle = "✨ Melhor experiência mobile",
    ConfigurationSaving = { Enabled = false },
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.K
})

-- 🎮 Player
local TabPlayer = Window:CreateTab("🚶 Player", 4483362458)
TabPlayer:CreateSection("🕹️ Movimentação e Agilidade")

local velocidadeAtiva, velocidadeValor = false, 16
TabPlayer:CreateToggle({
    Name = "💨 Super Velocidade",
    CurrentValue = false,
    Callback = function(v)
        velocidadeAtiva = v
        getHumanoid().WalkSpeed = v and velocidadeValor or 16
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

local puloAtivo, puloValor = false, 50
TabPlayer:CreateToggle({
    Name = "🚀 Pulo Super Alto",
    CurrentValue = false,
    Callback = function(v)
        puloAtivo = v
        getHumanoid().JumpPower = v and puloValor or 50
    end
})
TabPlayer:CreateSlider({
    Name = "📏 Ajustar Altura do Pulo",
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

local noclipAtivo = false
TabPlayer:CreateToggle({
    Name = "🛸 Noclip (Fantasma)",
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
    Name = "🔄 Reentrar no Servidor",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end
})

-- 🎨 Avatar
local TabAvatar = Window:CreateTab("🎨 Avatar", 4483362458)
TabAvatar:CreateSection("🎭 Personalização Visual")

local remoteCorpo = game:GetService("ReplicatedStorage").Remotes.ChangeBodyColor
local remoteNome = game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r")
local coresCorpo = {"Really red", "Lime green", "Bright blue", "New Yeller", "Royal purple", "Deep orange", "Medium stone grey", "Hot pink", "Earth green"}

local loopCorpoAtivo = false
TabAvatar:CreateToggle({
    Name = "🌈 Loop Cor do Corpo",
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
    Name = "💡 Nome RGB Animado",
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

-- 🃏 Troll
local TabTroll = Window:CreateTab("🃏 Troll", 4483362458)
TabTroll:CreateSection("😈 Trollar Players Facilmente")

local target = nil
TabTroll:CreateDropdown({
    Name = "🎯 Escolher Jogador-Alvo",
    Options = (function()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player then
                table.insert(list, p.Name)
            end
        end
        return list
    end)(),
    CurrentOption = nil,
    Callback = function(option)
        target = Players:FindFirstChild(option)
        Rayfield:Notify({
            Title = "🎯 Alvo Selecionado",
            Content = "Agora mirando em: "..option,
            Duration = 5
        })
    end
})

TabTroll:CreateButton({
    Name = "📌 Teleportar para Alvo",
    Callback = function()
        if target and target.Character then
            player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
            Rayfield:Notify({
                Title = "✅ Teleportado com Sucesso",
                Content = "Você foi até "..target.Name,
                Duration = 5
            })
        end
    end
})

local viewAtivo = false
TabTroll:CreateToggle({
    Name = "👁️‍🗨️ View Jogador Alvo",
    CurrentValue = false,
    Callback = function(v)
        viewAtivo = v
        local cam = workspace.CurrentCamera
        if v and target and target.Character then
            task.spawn(function()
                while viewAtivo and target and target.Character do
                    cam.CameraSubject = target.Character.Humanoid
                    task.wait()
                end
                cam.CameraSubject = player.Character.Humanoid
            end)
        else
            cam.CameraSubject = player.Character.Humanoid
        end
    end
})