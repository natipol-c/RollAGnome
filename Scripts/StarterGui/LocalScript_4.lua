--[[
  Type:     LocalScript
  Method:   cached
  Name:     LocalScript
  Path:     game.StarterGui.Display.Right.Frame.Shop.Frame.LightRay.LocalScript
  Service:  StarterGui
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:07 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0), {
    Rotation = 360
}):Play();