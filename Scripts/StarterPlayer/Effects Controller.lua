--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Effects Controller
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Effects Controller
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local Spin = require(script.Spin);
local Bounce = require(script.Bounce);

return {
    Initialize = function(p1) -- Line: 20, Name: Initialize
        -- upvalues: Spin (copy), Bounce (copy)
        Spin:Initialize();
        Bounce:Initialize();
    end
};