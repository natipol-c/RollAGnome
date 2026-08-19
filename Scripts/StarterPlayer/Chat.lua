--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Chat
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Chat
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TextChatService = game:GetService("TextChatService");
local u1 = require(ReplicatedStorage.Library).get("Network");
local RBXGeneral = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral");

return {
    Initialize = function(p2) -- Line: 27, Name: Initialize
        -- upvalues: u1 (copy), RBXGeneral (copy)
        u1:BindEvents({
            DisplayChat = function(p3) -- Line: 30, Name: DisplayChat
                -- upvalues: RBXGeneral (ref)
                RBXGeneral:DisplaySystemMessage(p3);
            end
        });
    end
};