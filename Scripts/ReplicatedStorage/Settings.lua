--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Settings
  Path:     game.ReplicatedStorage.Library.Settings
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:42:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
Library.get("Signal");
Library.get("Network");
local Sounds = SoundService.Sounds;
local Music = SoundService.Music;
local u5 = {
    Music = {
        func = function(p1) -- Line: 24, Name: func
            -- upvalues: Music (copy)
            Music.Volume = p1 / 100;
        end
    },
    Sounds = {
        func = function(p2) -- Line: 31, Name: func
            -- upvalues: Sounds (copy)
            Sounds.Volume = p2 / 100;
        end
    },
    Vibrations = {
        Enabled = true,

        func = function(p3) -- Line: 40, Name: func
            _G.Vibrations = p3;
        end
    },
    CameraShake = {
        Enabled = true,

        func = function(p4) -- Line: 47, Name: func
            _G.CameraShake = p4;
        end
    }
};

function u5.change(p6, p7) -- Line: 55
    -- upvalues: u5 (copy)
    u5[p6].Enabled = p7;

    if u5[p6].func then
        u5[p6].func(p7);
    end;
end;

function u5.check(p8) -- Line: 65
    -- upvalues: u5 (copy)
    return u5[p8] and u5[p8].Enabled;
end;

function u5.Start(p9, p10) -- Line: 69
    -- upvalues: u5 (copy)
    u5.Music.func(p10.Music or 100);
    u5.Sounds.func(p10.Sounds or 100);
    u5.Vibrations.Enabled = p10.Vibrations or true;
    u5.Vibrations.func(u5.Vibrations.Enabled);
    u5.CameraShake.Enabled = p10.CameraShake or true;
    u5.CameraShake.func(u5.CameraShake.Enabled);
end;

return u5;