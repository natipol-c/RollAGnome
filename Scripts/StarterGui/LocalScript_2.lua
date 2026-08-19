--[[
  Type:     LocalScript
  Method:   decompile
  Name:     LocalScript
  Path:     game.StarterGui.Tabs.Shop.Menu.Frame.List.Server Luck.ImageLabel.LocalScript
  Service:  StarterGui
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:27 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
script.Parent.Position = UDim2.fromScale(0.011, 0.55);
TweenService:Create(script.Parent, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, 0), {
    Position = UDim2.fromScale(0.011, 0.45)
}):Play();