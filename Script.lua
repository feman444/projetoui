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
        Image = redzlib:GetIcon("rbxassetid://16814451728"),
        Size = UDim2.fromOffset(60, 60),
        BackgroundTransparency = 0
    },
    Corner = { CornerRadius = UDim.new(0, 6) }
})

-- 🎮 Player
local TabPlayer = Window:MakeTab({"🚶 Player", "rbxassetid://4483362458"})
TabPlayer:AddSection({"🕹️ Movimentação e Agilidade"})

TabPlayer:AddToggle({
    Name = "💨 Super Velocidade",
    Flag = "SuperVelocidade",
    Callback = function(value)
        getgenv().activeSpeed = value
        if not value then
            Character:WaitForChild("Humanoid").WalkSpeed = 16
        end
        while getgenv().activeSpeed do
            if getgenv().valueSpeed then
                Character:WaitForChild("Humanoid").WalkSpeed = getgenv().valueSpeed
            end
            task.wait()
        end
    end
})

TabPlayer:AddSlider({
    Name = "⚡ Definir Velocidade",
    Min = 0,
    Max = 100,
    Default = 16,
    Callback = function(valor)
        getgenv().valueSpeed = valor
    end
})

TabPlayer:AddToggle({
    Name = "🚀 Pulo Super Alto",
    Flag = "PuloSuper",
    Callback = function(value)
        getgenv().activeJumpPower = value
        if not value then
            Character:WaitForChild("Humanoid").JumpPower = 50
        end
        while getgenv().activeJumpPower do
            if getgenv().valueJumpPower then
                Character:WaitForChild("Humanoid").JumpPower = getgenv().valueJumpPower
            end
            task.wait()
        end
    end
})

TabPlayer:AddSlider({
    Name = "📏 Ajustar Altura do Pulo",
    Min = 0,
    Max = 250,
    Default = 50,
    Callback = function(valor)
        getgenv().valueJumpPower = valor
    end
})

local noclipAtivo = false
TabPlayer:AddToggle({
    Name = "🛸 Noclip (Fantasma)",
    Callback = function(v)
        noclipAtivo = v
        if v then
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
        if state then
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
        if state then
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

-- Nova função Bio Colorida
TabAvatar:AddToggle({
    Name = "🧬 Bio Colorida",
    Callback = function(state)
        if state then
            task.spawn(function()
                while state do
                    local args = {
                        [1] = "PickingRPBioColor",
                        [2] = Color3.fromHSV((tick() % 5) / 5, 1, 1)
                    }
                    if game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r") then
                        game:GetService("ReplicatedStorage").RE["1RPNam1eColo1r"]:FireServer(unpack(args))
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
        if state then
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

-- 👓 Chams (ESPs)
local TabChams = Window:MakeTab({"👓 Chams (ESPs)", "rbxassetid://4483362458"})
TabChams:AddSection({"✨ Personalização de ESP"})

local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local Highlights = {}
local Tracers = {}
local Boxes = {}
local NameTags = {}

local espPlayersActive = false
local espTracersActive = false
local espBoxesActive = false

local function ClearESP()
    for _, hl in pairs(Highlights) do
        hl:Destroy()
    end
    Highlights = {}

    for _, line in pairs(Tracers) do
        line:Remove()
    end
    Tracers = {}

    for _, box in pairs(Boxes) do
        box:Remove()
    end
    Boxes = {}

    for _, nameTag in pairs(NameTags) do
        nameTag:Destroy()
    end
    NameTags = {}
end

local function CreateBox()
    local box = Drawing.new("Square")
    box.Color = Color3.new(1, 0.5, 0) -- laranja Arsenal style
    box.Thickness = 1.5
    box.Filled = false
    box.Transparency = 1
    return box
end

local function CreateTracer()
    local line = Drawing.new("Line")
    line.Color = Color3.new(0, 1, 0)
    line.Thickness = 1.5
    line.Transparency = 1
    return line
end

local function CreateNameTag(player)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPNameTag"
    billboard.Adornee = player.Character and player.Character:FindFirstChild("Head")
    billboard.Size = UDim2.new(0, 100, 0, 25)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = player.Name
    textLabel.TextColor3 = Color3.new(1, 0.5, 0) -- laranja Arsenal style
    textLabel.TextStrokeTransparency = 0
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextScaled = true

    billboard.Parent = player.Character

    return billboard
end

RunService.RenderStepped:Connect(function()
    if not (espPlayersActive or espTracersActive or espBoxesActive) then
        ClearESP()
        return
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local rootPart = player.Character.HumanoidRootPart
            local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

            if espPlayersActive then
                -- Highlight
                if not Highlights[player] then
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = player.Character
                    highlight.FillColor = Color3.fromRGB(255, 165, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 165, 0)
                    highlight.Parent = workspace
                    Highlights[player] = highlight
                end
                -- NameTag
                if not NameTags[player] then
                    local nameTag = CreateNameTag(player)
                    NameTags[player] = nameTag
                end
            else
                if Highlights[player] then
                    Highlights[player]:Destroy()
                    Highlights[player] = nil
                end
                if NameTags[player] then
                    NameTags[player]:Destroy()
                    NameTags[player] = nil
                end
            end

            -- Tracers
            if espTracersActive and onScreen then
                if not Tracers[player] then
                    Tracers[player] = CreateTracer()
                end
                local screenSize = Camera.ViewportSize
                Tracers[player].From = Vector2.new(screenSize.X / 2, screenSize.Y)
                Tracers[player].To = Vector2.new(pos.X, pos.Y)
                Tracers[player].Visible = true
            else
                if Tracers[player] then
                    Tracers[player].Visible = false
                    Tracers[player]:Remove()
                    Tracers[player] = nil
                end
            end

            -- Boxes estilo Arsenal (retângulo simples)
            if espBoxesActive and onScreen then
                local head = player.Character:FindFirstChild("Head")
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                if head and root then
                    local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local rootPos, rootOnScreen = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
                    if headOnScreen and rootOnScreen then
                        if not Boxes[player] then
                            Boxes[player] = CreateBox()
                        end
                        local box = Boxes[player]
                        local height = math.abs(headPos.Y - rootPos.Y)
                        local width = height / 2 -- proporção de box estilo Arsenal
                        box.Position = Vector2.new(headPos.X - width/2, headPos.Y)
                        box.Size = Vector2.new(width, height)
                        box.Visible = true
                    else
                        if Boxes[player] then
                            Boxes[player].Visible = false
                        end
                    end
                end
            else
                if Boxes[player] then
                    Boxes[player].Visible = false
                    Boxes[player]:Remove()
                    Boxes[player] = nil
                end
            end
        else
            if Highlights[player] then
                Highlights[player]:Destroy()
                Highlights[player] = nil
            end
            if Tracers[player] then
                Tracers[player]:Remove()
                Tracers[player] = nil
            end
            if Boxes[player] then
                Boxes[player]:Remove()
                Boxes[player] = nil
            end
            if NameTags[player] then
                NameTags[player]:Destroy()
                NameTags[player] = nil
            end
        end
    end
end)

TabChams:AddToggle({
    Name = "🟠 ESP Players",
    Callback = function(state)
        espPlayersActive = state
        if not state then ClearESP() end
    end
})

TabChams:AddToggle({
    Name = "🔵 ESP Tracers",
    Callback = function(state)
        espTracersActive = state
        if not state then ClearESP() end
    end
})

TabChams:AddToggle({
    Name = "🟡 ESP Box (Estilo Arsenal)",
    Callback = function(state)
        espBoxesActive = state
        if not state then ClearESP() end
    end
})