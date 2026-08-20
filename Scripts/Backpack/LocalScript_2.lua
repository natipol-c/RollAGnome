--[[
  Type:     LocalScript
  Method:   cached
  Name:     LocalScript
  Path:     game.Players.Palukalima37806.Backpack.Rainbow Mango.LocalScript
  Service:  Backpack
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:12 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local u1 = require(ReplicatedStorage.Library).get("Signal");
script.Parent.Equipped:Connect(function() -- Line: 24
    -- upvalues: u1 (copy)
    u1.Fire("GiveItem", true, "Fruit");
end);
script.Parent.Unequipped:Connect(function() -- Line: 28
    -- upvalues: u1 (copy)
    u1.Fire("GiveItem", false);
end);