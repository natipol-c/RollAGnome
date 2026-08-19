--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ChatTags
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.ChatTags
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TextChatService = game:GetService("TextChatService");
local Library = require(ReplicatedStorage.Library);
Library.get("Network");
Library.get("Find");
local u1 = Library.get("Products");
local u2 = Library.get("Signal");
local _ = Players.LocalPlayer;
local v3 = {};

local function updateInGame(p4) -- Line: 30
    -- upvalues: TextChatService (copy)
    TextChatService.BubbleChatConfiguration.Enabled = not p4;
end;

function v3.Initialize(p5) -- Line: 34
    -- upvalues: u2 (copy), TextChatService (copy), Players (copy), u1 (copy)
    u2.new("Chat"):Connect(function(p6) -- Line: 36
        -- upvalues: TextChatService (ref)
        TextChatService.BubbleChatConfiguration.Enabled = not p6;
    end);

    function TextChatService.OnIncomingMessage(p7) -- Line: 40
        -- upvalues: Players (ref), u1 (ref)
        local TextChatMessageProperties = Instance.new("TextChatMessageProperties");

        if p7.TextSource then
            local v8 = Players:GetPlayerByUserId(p7.TextSource.UserId);

            if v8 and u1.check("VIP", v8) then
                TextChatMessageProperties.PrefixText = "<font color= \'#ffd900\'>VIP </font>" .. p7.PrefixText;
            end;
        end;

        return TextChatMessageProperties;
    end;
end;

return v3;