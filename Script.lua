local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "MATHEUS X HUB",
	LoadingTitle = "Carregando Script...",
	LoadingSubtitle = "CARREGADO.",
	ConfigurationSaving = {
		Enabled = false
	},
	Discord = {
		Enabled = false
	},
	KeySystem = false,
	Theme = "Default",
	ToggleUIKeybind = Enum.KeyCode.K
})

-- 🧩 Aba Principal
local Tab = Window:CreateTab("Principal", 4483362458)
local Section = Tab:CreateSection("Funções")

-- 🔘 Botão de Teste
Tab:CreateButton({
	Name = "Testar Botão",
	Callback = function()
		Rayfield:Notify({
			Title = "Funcionando!",
			Content = "Você clicou no botão.",
			Duration = 4
		})
	end
})

-- ✅ Toggle de troca de cor automática
local trocandoCor = false
local trocador

Tab:CreateToggle({
	Name = "Trocar Cor do Personagem",
	CurrentValue = false,
	Callback = function(Value)
		trocandoCor = Value
		if trocandoCor then
			trocador = task.spawn(function()
				local plr = game.Players.LocalPlayer
				while trocandoCor and plr and plr.Character do
					for _, part in pairs(plr.Character:GetDescendants()) do
						if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
							part.Color = Color3.new(math.random(), math.random(), math.random())
						end
					end
					wait(0.3) -- Intervalo entre as trocas
				end
			end)
		else
			if trocador then
				task.cancel(trocador)
			end
		end
	end
})

print("hello world");