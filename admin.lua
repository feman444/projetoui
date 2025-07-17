local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "🟣 Painel Administrativo 🌐",
    LoadingTitle = "🔐 Verificando Acesso...",
    LoadingSubtitle = "Sistema Protegido por Key 🔑",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = true, -- ATIVA O SISTEMA DE KEY DO RAYFIELD
    KeySettings = {
        Title = "🟣 Sistema de Key - Admin",
        Subtitle = "Painel Exclusivo 🔑",
        Note = "Entre no Discord: discord.gg/seuservidor",
        FileName = "PainelAdmin_KEY",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"ADMINKEY123"}, -- SUA KEY AQUI
        Whitelist = {
            Enabled = true,
            List = {
                12345678, -- SEU USERID
                98765432, -- OUTRO USERID
                11223344  -- ADICIONE AQUI
            }
        }
    }
})

local Tab = Window:CreateTab("📢 Moderação")

local TextChatService = game:GetService("TextChatService")
local Channel = TextChatService.TextChannels.RBXGeneral

function EnviarChat(comando, player)
    local mensagem = ";"..comando.." "..player
    Channel:SendAsync(mensagem)
end

local playerAlvo = ""

Tab:CreateInput({
    Name = "🎯 Jogador Alvo",
    PlaceholderText = "Exemplo: Renan44",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        playerAlvo = Text
    end
})

Tab:CreateButton({
    Name = "🚫 Expulsar Jogador",
    Callback = function()
        if playerAlvo ~= "" then
            EnviarChat("kick", playerAlvo)
        else
            Rayfield:Notify({ Title = "⚠️ Aviso", Content = "Digite um nome válido!", Duration = 4 })
        end
    end
})

Tab:CreateButton({
    Name = "🔨 Banir Jogador",
    Callback = function()
        if playerAlvo ~= "" then
            EnviarChat("ban", playerAlvo)
        else
            Rayfield:Notify({ Title = "⚠️ Aviso", Content = "Digite um nome válido!", Duration = 4 })
        end
    end
})

Tab:CreateButton({
    Name = "🕊️ Conceder Voo",
    Callback = function()
        if playerAlvo ~= "" then
            EnviarChat("fly", playerAlvo)
        else
            Rayfield:Notify({ Title = "⚠️ Aviso", Content = "Digite um nome válido!", Duration = 4 })
        end
    end
})