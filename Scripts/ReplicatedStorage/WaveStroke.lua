--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     WaveStroke
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets.WaveStroke
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local Parent = require(script.Parent.Parent);

return function(p1, p2, p3, p4) -- Line: 3
    -- upvalues: Parent (copy)
    local v5 = ColorSequence.new({ ColorSequenceKeypoint.new(0, p4), ColorSequenceKeypoint.new(0.5, p4), ColorSequenceKeypoint.new(1, p4) });
    local v6 = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.25, 1),
        NumberSequenceKeypoint.new(0.5, 1),
        NumberSequenceKeypoint.new(0.75, 1),
        NumberSequenceKeypoint.new(1, 0)
    });
    local v7 = Parent.Stroke.new(p1, p3);
    local v8 = Parent.Gradient.new(v7.Instance, v5, v6);
    v8:SetOffsetSpeed(p2, 1);
    v8:SetTransparencyOffsetSpeed(p2 * 0.9, 1);

    return {
        Effects = { v8, v7 }
    };
end;