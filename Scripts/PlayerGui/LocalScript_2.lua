--[[
  Type:     LocalScript
  Method:   cached
  Name:     LocalScript
  Path:     game.Players.Palukalima37806.PlayerGui.Tabs.Shop.Menu.Frame.List.Server Luck.ImageLabel.LocalScript
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:10 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
script.Parent.Position = UDim2.fromScale(0.011, 0.55);
TweenService:Create(script.Parent, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, 0), {
    Position = UDim2.fromScale(0.011, 0.45)
}):Play();