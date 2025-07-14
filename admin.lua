local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local allowedUsers = {
    ["3811306935"] = "TETRA_ADM", -- Substitua pelo seu ID
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

if not allowedUsers[userId] then
    warn("❌ Acesso negado! ID:", userId)
    return -- não permite abrir menu se não autorizado
end

local Tab = Window:CreateTab("👑 Admin", 4483362458)
Tab:CreateSection("🎁 Comandos do Admin")

Tab:CreateParagraph({
    Title = "✅ Acesso Liberado",
    Content = "Olá " .. player.Name .. "! Seu ID (".. userId .. ") foi autorizado!"
})

Tab:CreateButton({
    Name = "📢 Mensagem Teste",
    Callback = function()
        Rayfield:Notify({
            Title = "✅ Sucesso",
            Content = "Você tem acesso ao painel admin!",
            Duration = 5
        })
    end
})