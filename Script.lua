local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "MATHEUS X HUB",
	LoadingTitle = "Carregando Script...",
	LoadingSubtitle = "CARREGADO.",
	ConfigurationSaving = { Enabled = false },
	Theme = "Default",
	ToggleUIKeybind = Enum.KeyCode.K
})

local TabPlayer = Window:CreateTab("Player", 4483362458)
TabPlayer:CreateSection("Funções")

local velocidadeAtiva = false
local velocidadeValor = 16

TabPlayer:CreateToggle({
	Name = "Ativar Velocidade",
	CurrentValue = false,
	Callback = function(v)
		velocidadeAtiva = v
		local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = v and velocidadeValor or 16
		end
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
			local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = velocidadeValor
			end
		end
	end
})

local TabAvatar = Window:CreateTab("Avatar", 4483362458)
TabAvatar:CreateSection("Funções")

local remoteCorpo = game:GetService("ReplicatedStorage").Remotes.ChangeBodyColor
local remoteNome = game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r")

local loopCorpo, loopNome

local coresCorpo = {
	"Really red", "Lime green", "Bright blue", "New Yeller",
	"Royal purple", "Deep orange", "Medium stone grey",
	"Hot pink", "Earth green"
}

local coresNome = {
	Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(128, 0, 128), Color3.fromRGB(255, 165, 0)
}

TabAvatar:CreateToggle({
	Name = "Trocar Cor do Corpo",
	CurrentValue = false,
	Callback = function(v)
		if v then
			loopCorpo = task.spawn(function()
				while true do
					for _, cor in ipairs(coresCorpo) do
						if not loopCorpo or not v then return end
						remoteCorpo:FireServer(cor)
						task.wait(0.3)
					end
				end
			end)
		else
			if loopCorpo then task.cancel(loopCorpo) end
		end
	end
})

TabAvatar:CreateToggle({
	Name = "Trocar Cor do Nome RP",
	CurrentValue = false,
	Callback = function(v)
		if v then
			loopNome = task.spawn(function()
				while true do
					for _, cor in ipairs(coresNome) do
						if not loopNome or not v then return end
						remoteNome:FireServer("PickingRPNameColor", cor)
						task.wait(0.3)
					end
				end
			end)
		else
			if loopNome then task.cancel(loopNome) end
		end
	end
})