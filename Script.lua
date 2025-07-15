local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/V5/Source.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

if shared.connectCharacter then shared.connectCharacter:Disconnect() end
shared.connectCharacter = LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
end)

local Window = redzlib:MakeWindow({
    Title = "🌌 Tetra4 | Hub Completo",
    SubTitle = "✨ Melhor experiência mobile",
    SaveFolder = ""
})

Window:AddMinimizeButton({
    Button = {
        Image = redzlib:GetIcon("rbxassetid://88328937608580"),
        Size = UDim2.fromOffset(60, 60),
        BackgroundTransparency = 0
    },
    Corner = { CornerRadius = UDim.new(0, 6) }
})

-- 🎮 Player
local TabPlayer = Window:MakeTab({"🚶 Player", "rbxassetid://4483362458"})
TabPlayer:AddSection({"🕹️ Movimentação e Agilidade"})

local velocidadeAtiva = false
TabPlayer:AddToggle({
    Name = "💨 Super Velocidade",
    Callback = function(v)
        velocidadeAtiva = v
    end
})

TabPlayer:AddSlider({
    Name = "⚡ Definir Velocidade",
    Min = 0,
    Max = 100,
    Default = 16,
    Callback = function(valor)
        if velocidadeAtiva then
            Character:WaitForChild("Humanoid").WalkSpeed = valor
        end
    end
})

local puloAtivo = false
TabPlayer:AddToggle({
    Name = "🚀 Pulo Super Alto",
    Callback = function(v)
        puloAtivo = v
    end
})

TabPlayer:AddSlider({
    Name = "📏 Ajustar Altura do Pulo",
    Min = 0,
    Max = 250,
    Default = 50,
    Callback = function(valor)
        if puloAtivo then
            Character:WaitForChild("Humanoid").JumpPower = valor
        end
    end
})

local noclipAtivo = false
TabPlayer:AddToggle({
    Name = "🛸 Noclip (Fantasma)",
    Callback = function(v)
        noclipAtivo = v
        if noclipAtivo then
            task.spawn(function()
                while noclipAtivo do
                    for _, part in ipairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
            for _, part in ipairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
})

TabPlayer:AddButton({"🔄 Reentrar no Servidor", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end})

-- 🎨 Avatar
local TabAvatar = Window:MakeTab({"🎨 Avatar", "rbxassetid://4483362458"})
TabAvatar:AddSection({"🎭 Personalização Visual"})

local cores = {"Really red", "Lime green", "Bright blue", "New Yeller", "Royal purple", "Deep orange", "Medium stone grey", "Hot pink", "Earth green"}
local loopCorpo = false

TabAvatar:AddToggle({
    Name = "🌈 Loop Cor do Corpo",
    Callback = function(state)
        loopCorpo = state
        if loopCorpo then
            task.spawn(function()
                while loopCorpo do
                    for _, cor in ipairs(cores) do
                        if not loopCorpo then break end
                        if game:GetService("ReplicatedStorage").Remotes:FindFirstChild("ChangeBodyColor") then
                            game:GetService("ReplicatedStorage").Remotes.ChangeBodyColor:FireServer(cor)
                        end
                        task.wait(0.3)
                    end
                end
            end)
        end
    end
})

local loopNome = false
TabAvatar:AddToggle({
    Name = "💡 Nome RGB Animado",
    Callback = function(state)
        loopNome = state
        if loopNome then
            task.spawn(function()
                while loopNome do
                    if game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r") then
                        game:GetService("ReplicatedStorage").RE["1RPNam1eColo1r"]:FireServer("PickingRPNameColor", Color3.fromHSV((tick() % 5)/5,1,1))
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

-- 🃏 Troll
local TabTroll = Window:MakeTab({"🃏 Troll", "rbxassetid://4483362458"})
TabTroll:AddSection({"😈 Trollar Players Facilmente"})

local playerSelecionado = ""
local DropdownPlayers = TabTroll:AddDropdown({
    Name = "🎯 Escolher Jogador-Alvo",
    Options = {},
    Callback = function(nome)
        playerSelecionado = nome
        redzlib:Notify("🎯 Jogador Alvo", "Alvo selecionado: " .. nome, 5)
    end
})

local function AtualizarPlayers()
    local lista = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(lista, p.Name)
        end
    end
    DropdownPlayers:Set(lista)
end

AtualizarPlayers()

TabTroll:AddButton({"🔃 Atualizar Lista de Players", function()
    AtualizarPlayers()
end})

TabTroll:AddButton({"📌 Teleportar para Alvo", function()
    local alvo = Players:FindFirstChild(playerSelecionado)
    if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = alvo.Character.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
        redzlib:Notify("✅ Teleportado", "Você foi até "..playerSelecionado, 5)
    end
end})

local viewAlvo = false
TabTroll:AddToggle({
    Name = "👁️ View Jogador",
    Callback = function(v)
        viewAlvo = v
        local cam = workspace.CurrentCamera
        task.spawn(function()
            while viewAlvo do
                local alvo = Players:FindFirstChild(playerSelecionado)
                if alvo and alvo.Character and alvo.Character:FindFirstChild("Humanoid") then
                    cam.CameraSubject = alvo.Character.Humanoid
                end
                task.wait()
            end
            cam.CameraSubject = LocalPlayer.Character:WaitForChild("Humanoid")
        end)
    end
})

-- 🏠 Casas
local TabCasas = Window:MakeTab({"🏠 Casas", "rbxassetid://4483362458"})
TabCasas:AddSection({"🏡 Utilitários para Casas"})

local antBanAtivo = false
TabCasas:AddToggle({
    Name = "🚫 Auto AntBan (BannedBlock)",
    Callback = function(state)
        antBanAtivo = state
        if antBanAtivo then
            task.spawn(function()
                while antBanAtivo do
                    for _, v in ipairs(workspace:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name == "BannedBlock" then
                            v:Destroy()
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

-- 🚗 Carros
local TabCarros = Window:MakeTab({"🚗 Carros", "rbxassetid://4483362458"})
TabCarros:AddSection({"🚘 Personalização e Hacks de Carros"})