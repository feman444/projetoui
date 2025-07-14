local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Painel Admin",
    LoadingTitle = "Validando Key...",
    LoadingSubtitle = "Aguarde...",
    ConfigurationSaving = { Enabled = false },
    Theme = "Default",
    KeySystem = true,
    KeySettings = {
        Title = "Acesso Painel Admin",
        Subtitle = "Insira sua Key",
        Note = "Peça sua Key ao dono",
        FileName = "Painel_Key",
        SaveKey = true,
        Keys = {"KALEBKEY12345", "RENANKEY54321"}
    },
    ToggleUIKeybind = Enum.KeyCode.RightShift
})

local Tab = Window:CreateTab("Admin", 4483362458)
Tab:CreateSection("Comandos")

Tab:CreateButton({
    Name = "Carregar Script Principal",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/seurepositorio/Principal.lua'))()
    end
})