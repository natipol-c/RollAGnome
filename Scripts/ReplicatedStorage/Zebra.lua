--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Zebra
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets.Zebra
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local Parent = require(script.Parent.Parent);

return function(p1, u2, p3) -- Line: 3
    -- upvalues: Parent (copy)
    local v4 = Parent.Gradient.new(p1, Parent.Templates.Zebra.Color, 0);
    v4:SetOffsetSpeed(u2, 1);
    v4:SetRotation(90, 1);
    local v5 = Parent.Stroke.new(p1, p3);
    local u6 = Parent.Gradient.new(v5.Instance, Parent.Templates.Zebra.Color, 0);
    u6:SetOffset(0.5, 1);
    u6:SetRotation(90, 1);
    task.delay(0.1, function() -- Line: 14
        -- upvalues: u6 (copy), u2 (copy)
        u6:SetOffsetSpeed(u2, 1);
    end);

    return {
        Effects = { v4, u6, v5 }
    };
end;