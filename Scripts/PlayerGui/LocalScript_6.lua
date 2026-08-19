--[[
  Type:     LocalScript
  Method:   cached
  Name:     LocalScript
  Path:     game.Players.Palukalima37806.PlayerGui.UpgradeTree.Close.ClosePointer.LocalScript
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
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Signal");
local u2 = Library.get("SimpleTween");
local u3 = nil;
v1.new("CloseUpgradesPointer"):Connect(function(p4) -- Line: 27
    -- upvalues: u3 (ref), u2 (copy)
    if p4 then
        script.Parent.Visible = true;
        u3 = u2:Tween(script.Parent, 0.15, "Quad", "InOut", {
            Size = UDim2.fromScale(0.95, 0.95)
        }, true, nil, -1);

        return;
    end;

    script.Parent.Visible = false;

    if u3 then
        u3:Cancel();
        u3:Destroy();
    end;
end);