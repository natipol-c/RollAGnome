--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Event Noti
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Event Noti
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
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
        return SocialService:GetEventRsvpStatusAsync("4979711253774729848");
    end);

    if not success then
        return;
    end;

    if result ~= Enum.RsvpStatus.Going then
        pcall(function() -- Line: 38
            -- upvalues: SocialService (ref)
            SocialService:PromptRsvpToEventAsync("4979711253774729848");
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