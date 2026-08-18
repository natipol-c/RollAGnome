--[[
  Type:     LocalScript
  Method:   decompile
  Name:     LocalScript
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Upgrade Tree.TutorialPointer.LocalScript
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:08 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local u1 = require(ReplicatedStorage.Library).get("SimpleTween");
local u2 = nil;
script.Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 26
    -- upvalues: u2 (ref), u1 (copy)
    if script.Parent.Visible then
        u2 = u1:Tween(script.Parent, 0.15, "Quad", "InOut", {
            Size = UDim2.fromScale(0.55, 0.55)
        }, true, nil, -1);

        return;
    end;

    if u2 then
        u2:Cancel();
        u2:Destroy();
    end;
end);