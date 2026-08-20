--[[
  Type:     LocalScript
  Method:   cached
  Name:     LocalScript
  Path:     game.StarterGui.Display.Right.Products.WeeklyDeal.Frame.LightRay.LocalScript
  Service:  StarterGui
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:07 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0), {
    Rotation = 360
}):Play();