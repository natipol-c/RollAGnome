--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     stroke
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.components.stroke
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:05 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../theme");
local create = require("../../roblox_packages/vide").create;

return function(p2) -- Line: 13
    -- upvalues: create (copy), u1 (copy)
    return create("UIStroke")({
        Thickness = p2.thickness,
        Color = u1.stroke,
        unpack(p2)
    });
end;