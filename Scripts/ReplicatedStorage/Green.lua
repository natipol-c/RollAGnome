--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Green
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.GradientTemplates.Green
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:01 2026
]]

-- Decompiled with Potassium's decompiler.

return function() -- Line: 1
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0)) });
    UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 1), NumberSequenceKeypoint.new(1, 1) });

    return UIGradient;
end;