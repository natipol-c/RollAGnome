--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Zebra
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.GradientTemplates.Zebra
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

return function() -- Line: 1
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.015625, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.1458333283662796, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.2482638955116272, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.3559027910232544, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.4970000088214874, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.503000020980835, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.647569477558136, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.7829861044883728, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.890625, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.9774305820465088, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
    });

    return UIGradient;
end;