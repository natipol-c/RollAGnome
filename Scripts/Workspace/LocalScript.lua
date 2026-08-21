--[[
  Type:     LocalScript
  Method:   decompile
  Name:     LocalScript
  Path:     game.Players.NotHub024.Backpack.Pepper.LocalScript
  Service:  Workspace
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:29 2026
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