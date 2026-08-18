--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Oceanic
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.GradientTemplates.Oceanic
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

return function() -- Line: 1
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(0, 0.45098039507865906, 1)),
        ColorSequenceKeypoint.new(0.125, Color3.new(1, 0, 0)),
        ColorSequenceKeypoint.new(0.2552083432674408, Color3.new(0, 0.45098039507865906, 1)),
        ColorSequenceKeypoint.new(0.3767361044883728, Color3.new(1, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.new(0, 0.45098039507865906, 1)),
        ColorSequenceKeypoint.new(0.6197916865348816, Color3.new(1, 0, 0)),
        ColorSequenceKeypoint.new(0.7374784350395203, Color3.new(0, 0.45098039507865906, 1)),
        ColorSequenceKeypoint.new(0.8680555820465088, Color3.new(1, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0.45098039507865906, 1))
    });

    return UIGradient;
end;