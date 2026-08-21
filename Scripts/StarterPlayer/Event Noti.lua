--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Event Noti
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Event Noti
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:40 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local SocialService = game:GetService("SocialService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Replication = require(ReplicatedStorage.Replication);
local v1 = {};

local function prompt() -- Line: 26
    -- upvalues: SocialService (copy)
    local success, result = pcall(function() -- Line: 29
        -- upvalues: SocialService (ref)
        return SocialService:GetEventRsvpStatusAsync("6904936723306906172");
    end);

    if not success then
        return;
    end;

    if result ~= Enum.RsvpStatus.Going then
        pcall(function() -- Line: 38
            -- upvalues: SocialService (ref)
            SocialService:PromptRsvpToEventAsync("6904936723306906172");
        end);
    end;
end;

function v1.Initialize(p2) -- Line: 44
    -- upvalues: Replication (copy), prompt (copy)
    if Replication.Data.tutorial then
        task.wait(90);
    else
        task.wait(180);
    end;

    prompt();
end;

return v1;