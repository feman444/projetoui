local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/feman444/projetoui/main/Script.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "MATHEUS X HUB",
    LoadingTitle = "MATHEUS X HUB",
    LoadingSubtitle = "Carregando...",
    ConfigurationSaving = { Enabled = false },
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.K
})

local function getHumanoid()
    local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

local TabPlayer = Window:CreateTab("Player", 4483362458)
TabPlayer:CreateSection("Funções")

local velocidadeAtiva, velocidadeValor = false, 16
TabPlayer:CreateToggle({
    Name = "Ativar Velocidade",
    CurrentValue = false,
    Callback = function(v)
        velocidadeAtiva = v
        local humanoid = getHumanoid()
        humanoid.WalkSpeed = v and velocidadeValor or 16
    end
})
TabPlayer:CreateSlider({
    Name = "Velocidade",
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
    Name = "Ativar Pulo",
    CurrentValue = false,
    Callback = function(v)
        puloAtivo = v
        local humanoid = getHumanoid()
        humanoid.JumpPower = v and puloValor or 50
    end
})
TabPlayer:CreateSlider({
    Name = "Pulo",
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
    Name = "Ativar Noclip",
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

local TabAvatar = Window:CreateTab("Avatar", 4483362458)
TabAvatar:CreateSection("Funções")

local remoteCorpo = game:GetService("ReplicatedStorage").Remotes.ChangeBodyColor
local remoteNome = game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r")

local coresCorpo = {
    "Really red", "Lime green", "Bright blue", "New Yeller",
    "Royal purple", "Deep orange", "Medium stone grey",
    "Hot pink", "Earth green"
}

local loopCorpoAtivo, loopNomeAtivo = false, false

TabAvatar:CreateToggle({
    Name = "Trocar Cor do Corpo",
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

TabAvatar:CreateToggle({
    Name = "Trocar Cor do Nome RP (RGB)",
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

-- ESP na parte do Toggle(Esp)
local espAtivo = false
local billboards = {}

TabAvatar:CreateToggle({
    Name = "Ativar ESP",
    CurrentValue = false,
    Callback = function(v)
        espAtivo = v
        if espAtivo then
            task.spawn(function()
                while espAtivo do
                    for _, b in pairs(billboards) do
                        if b and b.Parent then b:Destroy() end
                    end
                    billboards = {}

                    for _, player in ipairs(game.Players:GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local billboard = Instance.new("BillboardGui")
                            billboard.Size = UDim2.new(0, 100, 0, 30)
                            billboard.AlwaysOnTop = true
                            billboard.Adornee = player.Character.HumanoidRootPart
                            billboard.Parent = player.Character

                            local text = Instance.new("TextLabel")
                            text.Size = UDim2.new(1, 0, 1, 0)
                            text.BackgroundTransparency = 1
                            text.Text = player.Name
                            text.TextColor3 = Color3.fromRGB(0, 150, 255)
                            text.TextScaled = true
                            text.Parent = billboard

                            table.insert(billboards, billboard)
                        end
                    end
                    task.wait(0.5)
                end

                for _, b in pairs(billboards) do
                    if b and b.Parent then b:Destroy() end
                end
                billboards = {}
            end)
        else
            for _, b in pairs(billboards) do
                if b and b.Parent then b:Destroy() end
            end
            billboards = {}
        end
    end
})