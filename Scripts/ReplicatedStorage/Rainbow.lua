--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rainbow
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets.Rainbow
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local Parent = require(script.Parent.Parent);

return function(p1, p2) -- Line: 3
    -- upvalues: Parent (copy)
    local v3 = Parent.Gradient.new(p1, Parent.Templates.Rainbow.Color, 0);
    v3:SetOffsetSpeed(p2, 1);

    return {
        Effects = { v3 }
    };
end;