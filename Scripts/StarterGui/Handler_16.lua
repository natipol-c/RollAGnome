--[[
  Type:     LocalScript
  Method:   decompile
  Name:     Handler
  Path:     game.StarterGui._loading_.Handler
  Service:  StarterGui
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:07 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Find");
Library.get("Network");
local u2 = Library.get("SimpleTween");
local _ = ReplicatedStorage.Assets.Sounds;
local Parent = script.Parent;
local u3 = v1(Parent, "Frame");
local Slider = Parent.Slider;

if RunService:IsStudio() then
    return;
end;

local function done() -- Line: 37
    -- upvalues: u2 (copy), Slider (copy), Parent (copy), u3 (copy)
    u2:Tween(Slider, 0.7, "Quad", "In", {
        Position = UDim2.fromScale(0.5, 0.5)
    }, nil, function() -- Line: 58
        -- upvalues: Parent (ref), u3 (ref), u2 (ref), Slider (ref)
        Parent.Background.Visible = false;
        u3.Visible = false;
        u2:Tween(Slider, 0.7, "Quad", "Out", {
            Position = UDim2.fromScale(-1.5, 0.5)
        }, nil, function() -- Line: 64
            -- upvalues: Slider (ref), Parent (ref)
            Slider.Visible = false;
            Parent:Destroy();
        end);
    end);
end;

local function load() -- Line: 72
    -- upvalues: done (copy)
    done();
end;

local function start() -- Line: 76
    -- upvalues: u3 (copy), Parent (copy), u2 (copy), done (copy)
    task.spawn(function() -- Line: 77
        -- upvalues: u3 (ref), Parent (ref), u2 (ref), done (ref)
        u3.GroupTransparency = 1;
        Parent.Enabled = true;
        task.wait(0.5);
        task.spawn(function() -- Line: 91
            if not _G.Play then
                repeat
                    task.wait(0.1);
                until _G.Play ~= nil;
            end;

            _G.Play("STARTUP");
        end);
        u2:Tween(u3, 2.6, "Sine", "Out", {
            GroupTransparency = 0
        }, nil, function() -- Line: 102
            -- upvalues: done (ref)
            done();
        end);
    end);
end;

if UserInputService.TouchEnabled then
    v1(u3, "UIScale").Scale = 1.3;
end;

task.spawn(function() -- Line: 77
    -- upvalues: u3 (copy), Parent (copy), u2 (copy), done (copy)
    u3.GroupTransparency = 1;
    Parent.Enabled = true;
    task.wait(0.5);
    task.spawn(function() -- Line: 91
        if not _G.Play then
            repeat
                task.wait(0.1);
            until _G.Play ~= nil;
        end;

        _G.Play("STARTUP");
    end);
    u2:Tween(u3, 2.6, "Sine", "Out", {
        GroupTransparency = 0
    }, nil, function() -- Line: 102
        -- upvalues: done (ref)
        done();
    end);
end);