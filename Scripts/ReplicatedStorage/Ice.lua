--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ice
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.GradientTemplates.Ice
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
        ColorSequenceKeypoint.new(0, Color3.fromRGB(109, 210, 212)),
        ColorSequenceKeypoint.new(0.171875, Color3.new(0.8784313797950745, 0.9411764740943909, 1)),
        ColorSequenceKeypoint.new(0.3177083432674408, Color3.fromRGB(140, 208, 209)),
        ColorSequenceKeypoint.new(0.4670138955116272, Color3.fromRGB(109, 210, 212)),
        ColorSequenceKeypoint.new(0.4982638955116272, Color3.fromRGB(109, 210, 212)),
        ColorSequenceKeypoint.new(0.5034722089767456, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.71875, Color3.new(0.7058823704719543, 1, 0.9529411792755127)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(109, 210, 212))
    });

    return UIGradient;
end;