--[[
  Type:     LocalScript
  Method:   decompile
  Name:     Handler
  Path:     game.StarterGui.Notifications.Frame.SanityDroppingMessage.Handler
  Service:  StarterGui
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:38 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local u1 = 0;

local function update() -- Line: 23
    -- upvalues: u1 (ref), LocalPlayer (copy)
    u1 = u1 + 1;

    if LocalPlayer:GetAttribute("LowSanity") then
        script.Parent.Visible = true;

        return;
    end;

    script.Parent.Visible = false;
end;

u1 = u1 + 1;

if LocalPlayer:GetAttribute("LowSanity") then
    script.Parent.Visible = true;
else
    script.Parent.Visible = false;
end;

LocalPlayer:GetAttributeChangedSignal("LowSanity"):Connect(update);