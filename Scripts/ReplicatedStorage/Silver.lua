--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Silver
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets.Silver
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:32 2026
]]

-- Decompiled with Potassium's decompiler.

local Parent = require(script.Parent.Parent);

return function(p1, p2) -- Line: 3
    -- upvalues: Parent (copy)
    local v3 = Parent.Gradient.new(p1, Parent.Templates.Silver.Color, 0);
    v3:SetRotation(-75, 1);
    v3:SetOffsetSpeed(p2, 1);

    return {
        Effects = { v3 }
    };
end;