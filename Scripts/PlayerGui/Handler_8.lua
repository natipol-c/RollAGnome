--[[
  Type:     LocalScript
  Method:   cached
  Name:     Handler
  Path:     game.Players.Palukalima37806.PlayerGui.Display.Boosts.Friends.Friends.Handler
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:31 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
Library.get("Numbers");
Library.get("Rebirths");
local LocalPlayer = Players.LocalPlayer;

local function changed() -- Line: 26
    -- upvalues: LocalPlayer (copy)
    local v1 = LocalPlayer:GetAttribute("FriendCount");

    if not v1 then
        return;
    end;

    script.Parent.Text = `Friend Boost: +{5 * v1}%`;
end;

local v2 = LocalPlayer:GetAttribute("FriendCount");

if v2 then
    script.Parent.Text = `Friend Boost: +{5 * v2}%`;
end;

LocalPlayer:GetAttributeChangedSignal("FriendCount"):Connect(changed);