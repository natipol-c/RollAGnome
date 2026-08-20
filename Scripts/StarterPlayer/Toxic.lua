--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Toxic
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.GlobalEvents.Events.Toxic
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:09 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
game:GetService("ReplicatedStorage");
game:GetService("RunService");
local LightingController = require(script.Parent.Parent.Parent.LightingController);

return {
    OnStart = function(p1, p2) -- Line: 23, Name: OnStart
        -- upvalues: LightingController (copy)
        task.spawn(function() -- Line: 24
            if _G.FadeIn then
                _G.FadeIn("Toxic", "BG Music", 5);
            end;
        end);
        LightingController:Apply("Toxic");
        p1:Add(function() -- Line: 31
            -- upvalues: LightingController (ref)
            LightingController:Remove("Toxic");
            task.spawn(function() -- Line: 33
                if _G.FadeIn then
                    _G.FadeIn("BG Music", "Toxic", 5);
                end;
            end);
        end);
    end,

    OnEnd = function() -- Line: 41, Name: OnEnd
    end
};