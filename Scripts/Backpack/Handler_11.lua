--[[
  Type:     LocalScript
  Method:   cached
  Name:     Handler
  Path:     game.Players.Palukalima37806.Backpack.Turtle.Handler
  Service:  Backpack
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:44 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
Library.get("Network");
local u1 = Library.get("Signal");
script.Parent.Activated:Connect(function() -- Line: 25
    -- upvalues: u1 (copy)
    u1.Fire("PlacePet", script.Parent);
end);