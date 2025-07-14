--[[ 🔔 TETRA4 HUB UI COMPLETO - REDZHUB STYLE Desenvolvido por TETRA4 ]]

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

local Players = game:GetService("Players") local player = Players.LocalPlayer

local function getHumanoid() local character = player.Character or player.CharacterAdded:Wait() return character:WaitForChild("Humanoid") end

local Window = redzlib:MakeWindow({ Title = "TETRA4 HUB 💎", SubTitle = "🌐 Interface Completa - Redz UI", SaveFolder = "TETRA4_Hub_Config.lua" })

-- Aba Utilidades local TabUtil = Window:MakeTab({"⚙️ Utilidades", "🧰"})

TabUtil:AddButton({"🌑 Tema Escuro", function() redzlib:SetTheme("Dark") end})

TabUtil:AddButton({"🌌 Tema Muito Escuro", function() redzlib:SetTheme("Darker") end})

TabUtil:AddButton({"💜 Tema Roxo", function() redzlib:SetTheme("Purple") end})

-- Aba Player local TabPlayer = Window:MakeTab({"🏃 Player", "🎮"})

TabPlayer:AddParagraph({"📃 Aviso", "Use com responsabilidade!"})

local velocidadeAtiva, velocidadeValor = false, 16 TabPlayer:AddToggle({ Name = "🏃‍♂️ Ativar Velocidade", Default = false, Callback = function(v) velocidadeAtiva = v getHumanoid().WalkSpeed = v and velocidadeValor or 16 end })

TabPlayer:AddSlider({ Name = "⚡ Velocidade", Min = 0, Max = 100, Default = 16, Callback = function(v) velocidadeValor = v if velocidadeAtiva then getHumanoid().WalkSpeed = v end end })

local puloAtivo, puloValor = false, 50 TabPlayer:AddToggle({ Name = "🦘 Ativar Pulo", Default = false, Callback = function(v) puloAtivo = v getHumanoid().JumpPower = v and puloValor or 50 end })

TabPlayer:AddSlider({ Name = "🦘 Altura do Pulo", Min = 0, Max = 250, Default = 50, Callback = function(v) puloValor = v if puloAtivo then getHumanoid().JumpPower = v end end })

local noclipAtivo = false TabPlayer:AddToggle({ Name = "🚫 Ativar Noclip", Default = false, Callback = function(v) noclipAtivo = v if v then task.spawn(function() while noclipAtivo do local character = player.Character if character then for _, part in ipairs(character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end task.wait(0.1) end end) end end })

TabPlayer:AddButton({"🔄 Rejoin", function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, player) end})

-- Aba Avatar local TabAvatar = Window:MakeTab({"🧍 Avatar", "🎨"})

local remoteCorpo = game:GetService("ReplicatedStorage").Remotes.ChangeBodyColor local remoteNome = game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r")

local coresCorpo = { "Really red", "Lime green", "Bright blue", "New Yeller", "Royal purple", "Deep orange", "Medium stone grey", "Hot pink", "Earth green" }

local loopCorpoAtivo = false TabAvatar:AddToggle({ Name = "🌈 Trocar Cor do Corpo", Default = false, Callback = function(v) loopCorpoAtivo = v if v then task.spawn(function() while loopCorpoAtivo do for _, cor in ipairs(coresCorpo) do if not loopCorpoAtivo then break end remoteCorpo:FireServer(cor) task.wait(0.3) end end end) end end })

local loopNomeAtivo = false TabAvatar:AddToggle({ Name = "🌈 Trocar Cor do Nome RP (RGB)", Default = false, Callback = function(v) loopNomeAtivo = v if v then task.spawn(function() while loopNomeAtivo do local cor = Color3.fromHSV((tick() % 5) / 5, 1, 1) remoteNome:FireServer("PickingRPNameColor", cor) task.wait(0.1) end end) end end })

Window:SelectTab(TabUtil)

