--[[
  Type:     LocalScript
  Method:   cached
  Name:     Handler
  Path:     game.Players.Palukalima37806.Backpack.Kiwi Gnome.Handler
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
local Library = require(ReplicatedStorage.Library);
Library.get("Network");
local u1 = Library.get("Signal");
script.Parent.Equipped:Connect(function() -- Line: 25
    -- upvalues: u1 (copy)
    u1.Fire("Place", true, script.Parent.Name, "Farmer");
    u1.Fire("GiveItem", true, "Farmer");
end);
script.Parent.Unequipped:Connect(function() -- Line: 30
    -- upvalues: u1 (copy)
    u1.Fire("Place");
    u1.Fire("GiveItem", false);
end);