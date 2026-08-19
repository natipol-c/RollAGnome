--[[
  Type:     LocalScript
  Method:   cached
  Name:     Handler
  Path:     game.Players.Palukalima37806.PlayerGui.TutorialMessages.Messages.Handler
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:31 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Library).get("Signal").new("TutorialMessage"):Connect(function(p1, p2) -- Line: 24
    if not p1 then
        script.Parent.Visible = false;

        return;
    end;

    script.Parent.Text = p1;
    script.Parent.Visible = true;

    if p1 ~= nil and not p2 then
        _G.Play("Noti");
    end;
end);