--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GhostStroke
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets.GhostStroke
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local Parent = require(script.Parent.Parent);

return function(p1, p2, p3) -- Line: 3
    -- upvalues: Parent (copy)
    local v4 = Parent.Gradient.new(p1, Parent.Templates.Ghost.Color, Parent.Templates.Ghost.Transparency);
    v4:SetOffsetSpeed(p2, 1);
    v4:SetTransparencyOffsetSpeed(p2 * 0.9, 1);
    local v5 = Parent.Stroke.new(p1, p3);
    local v6 = Parent.Gradient.new(v5.Instance, Parent.Templates.Ghost.Color, Parent.Templates.Ghost.Transparency);
    v6:SetOffsetSpeed(-p2 * 0.9, 1);
    v6:SetTransparencyOffsetSpeed(-p2 * 0.9, 1);

    return {
        Effects = { v4, v6, v5 }
    };
end;