local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "MATHEUS X HUB",
	LoadingTitle = "Carregando Script...",
	LoadingSubtitle = "CARREGADO.",
	ConfigurationSaving = { Enabled = false },
	Discord = { Enabled = false },
	KeySystem = false,
	Theme = "Default",
	ToggleUIKeybind = Enum.KeyCode.K
})

local Tab = Window:CreateTab("Principal", 4483362458)
Tab:CreateSection("Funções")

local ativo = false
local loop

Tab:CreateToggle({
	Name = "RGB COLOR",
	CurrentValue = false,
	Callback = function(v)
		ativo = v
		if ativo then
			loop = task.spawn(function()
				local p = game.Players.LocalPlayer
				while ativo and p.Character do
					local corUnica = Color3.new(math.random(), math.random(), math.random())
					for _, parte in pairs(p.Character:GetDescendants()) do
						if parte:IsA("BasePart") and parte.Name ~= "HumanoidRootPart" then
							parte.Color = corUnica
						end
					end
					wait(0.3)
				end
			end)
		elseif loop then
			task.cancel(loop)
		end
	end
})