--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GoldStroke
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets.GoldStroke
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:32 2026
]]

-- Decompiled with Potassium's decompiler.

local Parent = require(script.Parent.Parent);

return function(p1, p2, p3) -- Line: 3
    -- upvalues: Parent (copy)
    local v4 = Parent.Gradient.new(p1, Parent.Templates.Gold.Color, 0);
    v4:SetRotation(-75, 1);
    v4:SetOffsetSpeed(p2, 1);
    local v5 = Parent.Stroke.new(p1, p3);
    local v6 = Parent.Gradient.new(v5.Instance, Parent.Templates.Gold.Color, 0);
    v6:SetRotation(75, 1);
    v6:SetOffsetSpeed(-p2, 1);

    return {
        Effects = { v4, v6, v5 }
    };
end;