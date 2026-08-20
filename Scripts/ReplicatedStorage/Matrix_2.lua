--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Matrix
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.GradientTemplates.Matrix
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:01 2026
]]

-- Decompiled with Potassium's decompiler.

return function() -- Line: 1
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(0.243137, 0.937254, 0.007843)),
        ColorSequenceKeypoint.new(0.015625, Color3.new(0.243137, 0.937254, 0.007843)),
        ColorSequenceKeypoint.new(0.1458333283662796, Color3.new(0.243137, 0.937254, 0.007843)),
        ColorSequenceKeypoint.new(0.2482638955116272, Color3.new(0.243137, 0.937254, 0.007843)),
        ColorSequenceKeypoint.new(0.3559027910232544, Color3.new(0.243137, 0.937254, 0.007843)),
        ColorSequenceKeypoint.new(0.4970000088214874, Color3.new(0.243137, 0.937254, 0.007843)),
        ColorSequenceKeypoint.new(0.503000020980835, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.647569477558136, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.7829861044883728, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.890625, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(0.9774305820465088, Color3.new(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
    });

    return UIGradient;
end;