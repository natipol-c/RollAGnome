--[[
  Type:     LocalScript
  Method:   cached
  Name:     Handler
  Path:     game.Players.Palukalima37806.PlayerGui.Notifications.Frame.InstabilityEvent.Handler
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
local _ = Players.LocalPlayer;
local Timer = script.Parent.Timer;

local function update() -- Line: 24
    -- upvalues: ReplicatedStorage (copy), Timer (copy)
    local v1 = ReplicatedStorage:GetAttribute("Instability");
    local v2 = ReplicatedStorage:GetAttribute("Instability_Timer");

    if not v1 then
        script.Parent.Visible = false;

        return;
    end;

    Timer.Text = `BACKROOMS COLLAPSE IN: {v2}s`;
    script.Parent.Visible = true;
end;

ReplicatedStorage:GetAttributeChangedSignal("Instability"):Connect(update);
ReplicatedStorage:GetAttributeChangedSignal("Instability_Timer"):Connect(update);