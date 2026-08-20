--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Interface
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:07 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
require(ReplicatedStorage.Replication);
require(ReplicatedStorage.Library);
local Display = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Display");

return {
    Initialize = function(p1) -- Line: 20, Name: Initialize
        -- upvalues: ReplicatedStorage (copy), Display (copy)
        repeat
            task.wait(0.1);
        until ReplicatedStorage:GetAttribute("DataLoaded", true);

        repeat
            task.wait(0.1);
        until ReplicatedStorage:GetAttribute("ClientLoaded", true);

        local v2 = next;
        local v3, v4 = script:GetChildren();

        for _, v in v2, v3, v4 do
            if v:IsA("ModuleScript") then
                task.spawn(function() -- Line: 28
                    -- upvalues: v (ref), Display (ref)
                    local v5 = Display:FindFirstChild(v.Name) or Display;
                    v = require(v);
                    v:Start(v5);
                end);
            end;
        end;
    end
};