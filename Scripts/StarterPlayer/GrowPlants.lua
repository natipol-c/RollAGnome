--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GrowPlants
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.GrowPlants
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:08 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require(ReplicatedStorage.Library).get("GrowPlants");

return {
    Initialize = function(p2) -- Line: 10, Name: Initialize
        -- upvalues: u1 (copy)
        u1:InitializeClient();
    end
};