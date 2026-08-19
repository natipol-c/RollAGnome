--[[
  Type:     LocalScript
  Method:   cached
  Name:     Handler
  Path:     game.Players.Palukalima37806.PlayerGui.Display.Right.Frame.Upgrade.Frame.OUTLINE.Handler
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:31 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Signal");
local u2 = Library.get("SimpleTween");
local Button = script.Parent.Parent.Parent.Button;
local UIStroke = script.Parent.UIStroke;
UIStroke.Transparency = 1;
v1.new("UpgradeButtonOutline"):Connect(function(p3) -- Line: 31
    -- upvalues: u2 (copy), UIStroke (copy), Button (copy), Players (copy)
    script.Parent.Visible = p3;

    if p3 then
        script.Parent.Size = UDim2.fromScale(10, 10);
        u2:Tween(UIStroke, 0.4, "Quad", "Out", {
            Transparency = 0.2
        });
        u2:Tween(script.Parent, 0.4, "Quad", "Out", {
            Size = UDim2.fromScale(1.25, 1.25)
        });
        Button.MouseButton1Click:Once(function() -- Line: 42
            -- upvalues: Players (ref)
            script.Parent.Visible = false;
            Players.LocalPlayer:SetAttribute("OpenedUpgrades", true);
        end);
    end;
end);