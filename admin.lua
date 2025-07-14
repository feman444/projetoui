local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local allowedUsers = {
    ["3811306935"] = "TETRA_ADM", -- ID e Key autorizada
    -- Você pode adicionar mais usuários aqui
}

local Player = game.Players.LocalPlayer
local userId = tostring(Player.UserId)

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
    print("✅ Acesso autorizado para o usuário:", Player.Name, "ID:", userId)
else
    print("❌ Acesso negado! ID:", userId)
end

local Tab = Window:CreateTab("👑 Admin", 4483362458)
Tab:CreateSection("🎁 Comandos do Admin")

Tab:CreateParagraph({
    Title = "✅ Acesso Liberado",
    Content = "Olá " .. Player.Name .. "! Seu ID (".. userId .. ") foi autorizado!"
})

-- Botão de mensagem padrão
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

-- ✅ Botão para detectar players usando o script principal
Tab:CreateButton({
    Name = "👁️ Detectar Usuários do Script",
    Callback = function()
        local players = game:GetService("Players"):GetPlayers()
        local encontrados = 0

        for _, player in ipairs(players) do
            if player:FindFirstChild("TETRA_SCRIPT_USER") then
                encontrados = 1
                Rayfield:Notify({
                    Title = "📌 Detectado",
                    Content = "Usuário: "..player.Name.." | ID: "..player.UserId,
                    Duration = 6
                })
            end
        end

        if encontrados == 0 then
            Rayfield:Notify({
                Title = "🚫 Nenhum Encontrado",
                Content = "Nenhum player usando o script foi detectado.",
                Duration = 6
            })
        end
    end
})