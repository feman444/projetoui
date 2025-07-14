local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local keys = {
    ["KALEBKEY12345"] = 1037122909853986917,
    ["YumekaAdm"] = 5593313487
}

local player = game.Players.LocalPlayer

local WindowKey = Rayfield:CreateWindow({
    Name = "Autenticação",
    LoadingTitle = "Digite sua Key",
    LoadingSubtitle = "Insira a chave de acesso",
    ConfigurationSaving = { Enabled = false },
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.RightShift
})

local keyInput
local keyValid = false

WindowKey:CreateSection("Autenticação")

WindowKey:CreateInput({
    Name = "Digite a Key",
    PlaceholderText = "Sua key aqui...",
    RemoveTextAfterFocusLost = false,
    OnFocusLost = function(text)
        keyInput = text
        if keys[keyInput] == player.UserId then
            keyValid = true
            WindowKey:Destroy()
            task.wait(0.2)
            -- Abrir painel admin
            local WindowAdmin = Rayfield:CreateWindow({
                Name = "Painel Admin",
                LoadingTitle = "Autenticado",
                LoadingSubtitle = "Bem-vindo, "..player.Name,
                ConfigurationSaving = { Enabled = false },
                Theme = "Default",
                ToggleUIKeybind = Enum.KeyCode.RightShift
            })

            local Tab = WindowAdmin:CreateTab("Admin", 4483362458)
            Tab:CreateSection("Comandos")

            Tab:CreateButton({
                Name = "Carregar Script Principal",
                Callback = function()
                    loadstring(game:HttpGet('https://raw.githubusercontent.com/feman444/projetoui/main/Script.lua'))()
                end
            })
        else
            warn("Chave inválida ou não autorizada!")
        end
    end
})