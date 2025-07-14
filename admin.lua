local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local allowedUsers = {
    ["3811306935"] = "TETRA_ADM", -- IDs autorizados (adicione mais aqui)
}

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local userId = tostring(player.UserId)

local Window = Rayfield:CreateWindow({
    Name = "🔒 Painel Admin - TETRA4",
    LoadingTitle = "🔐 Verificando acesso...",
    LoadingSubtitle = "🔎 Aguarde...",
    ConfigurationSaving = { Enabled = false },
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.K,
    KeySystem = true,
    KeySettings = {
        Title = "🔑 Verificação de Acesso",
        Subtitle = "🔐 Apenas usuários autorizados",
        Note = "Entre em contato para adquirir acesso.",
        FileName = "PainelAdmin_TETRA4",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {allowedUsers[userId] or "chave_incorreta"}
    }
})

if allowedUsers[userId] then
    print("✅ Acesso autorizado para o usuário:", player.Name, "ID:", userId)
else
    print("❌ Acesso negado! ID:", userId)
end

local Tab = Window:CreateTab("👑 Admin", 4483362458)
Tab:CreateSection("🎁 Comandos do Admin")

Tab:CreateParagraph({
    Title = "✅ Acesso Liberado",
    Content = "Olá " .. player.Name .. "! Seu ID (".. userId .. ") foi autorizado!"
})

local function checarUsuarios()
    for _, p in pairs(Players:GetPlayers()) do
        local character = p.Character
        if character then
            local flag = character:FindFirstChild("UsandoScriptTetra4")
            if flag and flag.Value == true then
                Rayfield:Notify({
                    Title = "🔔 Usuário Detectado",
                    Content = "Usuário usando o script: "..p.Name.." (ID: "..p.UserId..")",
                    Duration = 5
                })
            end
        end
    end
end

Tab:CreateButton({
    Name = "🔍 Verificar usuários usando script",
    Callback = function()
        checarUsuarios()
    end
})