local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "🟣 Painel Chat Global",
    LoadingTitle = "Chat via SendAsync",
    ConfigurationSaving = { Enabled = false }
})

local Tab = Window:CreateTab("💬 Comandos Chat")

local TextChatService = game:GetService("TextChatService")
local Channel = TextChatService.TextChannels.RBXGeneral

-- Função para enviar mensagem no chat via SendAsync
function EnviarChat(comando, player)
    local mensagem = ";" .. comando .. " " .. player
    Channel:SendAsync(mensagem)
end

local playerAlvo = ""

Tab:CreateInput({
    Name = "🎯 Nome do Player",
    PlaceholderText = "Ex: Renan",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        playerAlvo = Text
    end
})

Tab:CreateButton({
    Name = "🦶 Kick Player",
    Callback = function()
        if playerAlvo ~= "" then
            EnviarChat("kick", playerAlvo)
        else
            Rayfield:Notify({ Title = "❗ Aviso", Content = "Digite um player!", Duration = 4 })
        end
    end
})

Tab:CreateButton({
    Name = "🛡️ Ban Player",
    Callback = function()
        if playerAlvo ~= "" then
            EnviarChat("ban", playerAlvo)
        else
            Rayfield:Notify({ Title = "❗ Aviso", Content = "Digite um player!", Duration = 4 })
        end
    end
})

Tab:CreateButton({
    Name = "💨 Fly Player",
    Callback = function()
        if playerAlvo ~= "" then
            EnviarChat("fly", playerAlvo)
        else
            Rayfield:Notify({ Title = "❗ Aviso", Content = "Digite um player!", Duration = 4 })
        end
    end
})

Rayfield:Notify({
    Title = "✅ Pronto",
    Content = "Sistema Chat via TextChatService pronto para uso!",
    Duration = 5
})