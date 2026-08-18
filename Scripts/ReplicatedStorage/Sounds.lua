--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Sounds
  Path:     game.ReplicatedStorage.Library.Sounds
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local ContentProvider = game:GetService("ContentProvider");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Network");
Library.get("Settings");
local Sounds = ReplicatedStorage.Assets.Sounds;
local u2 = {};

function _G.SetGameMusic(p3) -- Line: 22
    -- upvalues: Sounds (copy)
    Sounds.GAMEMUSIC.SoundId = p3;
end;

function _G.Play(u4, u5, p6) -- Line: 26
    -- upvalues: Sounds (copy)
    local u7 = u4;

    if p6 then
        local v8 = Sounds:FindFirstChild(u4);

        if v8 then
            if u7 == "Tap" then
                _G.Haptic();
            end;

            if v8:GetAttribute("Disabled") then
                return;
            end;

            local v9 = v8:Clone();
            v9.Parent = u5 or Sounds;
            v9:Play();
            v9.Ended:Wait();
            v9:Destroy();
        end;
    else
        task.spawn(function() -- Line: 46
            -- upvalues: u4 (ref), Sounds (ref), u7 (copy), u5 (copy)
            pcall(function() -- Line: 47
                -- upvalues: u4 (ref), Sounds (ref), u7 (ref), u5 (ref)
                u4 = Sounds:FindFirstChild(u4);

                if u4 then
                    if u7 == "Tap" then
                        _G.Haptic();
                    end;

                    if u4:GetAttribute("Disabled") then
                        return;
                    end;

                    u4 = u4:Clone();
                    u4.Parent = u5 or Sounds;
                    u4:Play();
                    u4.Ended:Wait();
                    u4:Destroy();
                end;
            end);
        end);
    end;
end;

function _G.FadeIn(...) -- Line: 69
    -- upvalues: u2 (copy)
    u2.FadeIn(...);
end;

function _G.FadeOut(...) -- Line: 73
    -- upvalues: u2 (copy)
    u2.FadeOut(...);
end;

function u2.FadeOut(u10, u11) -- Line: 77
    -- upvalues: Sounds (copy), TweenService (copy)
    task.defer(function() -- Line: 78
        -- upvalues: u10 (ref), Sounds (ref), TweenService (ref), u11 (copy)
        if string.match(type(u10), "string") then
            u10 = Sounds:FindFirstChild(u10) or Sounds.Music:FindFirstChild(u10);
        end;

        if u10 then
            local Volume = u10.Volume;
            local v12 = TweenService:Create(u10, TweenInfo.new(u11 or 0.5), {
                Volume = 0
            });
            v12:Play();
            v12.Completed:Wait();
            u10:Stop();
            u10.Volume = Volume;
            v12:Destroy();
        end;
    end);
end;

function u2.FadeIn(p13, p14, p15) -- Line: 95
    -- upvalues: u2 (copy), Sounds (copy), TweenService (copy)
    if p14 then
        u2.FadeOut(p14);
    end;

    if string.match(type(p13), "string") then
        p13 = Sounds:FindFirstChild(p13) or Sounds.Music:FindFirstChild(p13);
    end;

    if p13 then
        local Volume = p13.Volume;
        p13.Volume = 0;
        p13:Play();
        local v16 = TweenService:Create(p13, TweenInfo.new(p15 or 0.5), {
            Volume = Volume
        });
        v16:Play();
        v16.Completed:Wait();
        v16:Destroy();
    end;
end;

function u2.Initialize() -- Line: 117
    -- upvalues: ContentProvider (copy), Sounds (copy), u1 (copy), u2 (copy)
    ContentProvider:PreloadAsync(Sounds:GetChildren());
    u1:BindEvents({
        PlaySound = function(p17, ...) -- Line: 122, Name: PlaySound
            -- upvalues: u2 (ref)
            if string.match(p17, "Play") then
                _G.Play(...);

                return;
            end;

            if string.match(p17, "FadeOut") then
                u2.FadeOut(...);

                return;
            end;

            if p17 == "FadeIn" then
                u2.FadeIn(...);
            end;
        end
    });
end;

return u2;