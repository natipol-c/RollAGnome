--[[
  Type:     LocalScript
  Method:   decompile
  Name:     Handler
  Path:     game.StarterGui.Display.Boosts.Frame.VIP.Handler
  Service:  StarterGui
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:07 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Network");
Library.get("Numbers");
local u2 = Library.get("Products");
local _ = Players.LocalPlayer;
task.wait(5);

if u2.check("VIP") then
    script.Parent.Visible = true;
end;

v1:BindEvents({
    BoughtVIP = function() -- Line: 33, Name: BoughtVIP
        -- upvalues: u2 (copy)
        if u2.check("VIP") then
            script.Parent.Visible = true;
        end;
    end
});