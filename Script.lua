local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getHumanoid()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

local Window = redzlib:MakeWindow({
    Title = "Tetra4 🛠️",
    SubTitle = "Interface do Script",
    SaveFolder = "Tetra4Config"
})

local TabPlayer = Window:MakeTab({"👤 Player", "user"})

TabPlayer:AddSection({"🎮 Funções"})

local velocidadeAtiva, velocidadeValor = false, 16
TabPlayer:AddToggle({
    Name = "🏃‍♂️ Ativar Velocidade",
    Default = false,
    Callback = function(v)
        velocidadeAtiva = v
        local humanoid = getHumanoid()
        humanoid.WalkSpeed = v and velocidadeValor or 16
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
            local humanoid = getHumanoid()
            humanoid.WalkSpeed = velocidadeValor
        end
    end
})

local puloAtivo, puloValor = false, 50
TabPlayer:AddToggle({
    Name = "🦘 Ativar Pulo",
    Default = false,
    Callback = function(v)
        puloAtivo = v
        local humanoid = getHumanoid()
        humanoid.JumpPower = v and puloValor or 50
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
            local humanoid = getHumanoid()
            humanoid.JumpPower = puloValor
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
                    local character = player.Character
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

TabPlayer:AddButton({
    Name = "🔄 Rejoin Server",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end
})

local TabAvatar = Window:MakeTab({"🧍 Avatar", "user"})

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

-- BOTÃO EXTERNO PARA ABRIR/FECHAR O MENU --
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local UIS = UserInputService
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Tetra4ToggleGui"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0, 10, 0.5, -50) -- Lado esquerdo, meio vertical
ToggleButton.Size = UDim2.new(0, 60, 0, 60) -- Quadrado médio
ToggleButton.Image = "https://i.imgur.com/rlc8OiB.png" -- Substitua pelo seu link da imagem

ToggleButton.MouseButton1Click:Connect(function()
    Window:Toggle() -- Abre ou fecha o menu
end)

-- Opcional: mudar opacidade no hover
ToggleButton.MouseEnter:Connect(function()
    ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)
ToggleButton.MouseLeave:Connect(function()
    ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)