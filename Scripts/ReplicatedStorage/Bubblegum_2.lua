--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Bubblegum
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.GradientTemplates.Bubblegum
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:33 2026
]]

-- Decompiled with Potassium's decompiler.

return function() -- Line: 1
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.9529411792755127, 0.3960784375667572, 0.6941176652908325)), ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.6549019813537598, 0.8901960849761963)), ColorSequenceKeypoint.new(1, Color3.new(0.9529411792755127, 0.3960784375667572, 0.6941176652908325)) });
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.09894459694623947, 0),
        NumberSequenceKeypoint.new(0.5, 1),
        NumberSequenceKeypoint.new(0.8997361660003662, 0),
        NumberSequenceKeypoint.new(1, 0)
    });

    return UIGradient;
end;