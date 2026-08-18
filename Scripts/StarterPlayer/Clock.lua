--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Clock
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Clock
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:08 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("UserInputService");
local Library = require(ReplicatedStorage.Library);
require(ReplicatedStorage.Replication);
local u1 = Library.get("Find");
local u2 = Library.get("Numbers");
local u3 = Library.get("SimpleTween");
Library.get("Signal");
Library.get("Products");
local _ = u1(Players.LocalPlayer, "Plot").Value;
local u4 = nil;
local v5 = {};
local u6 = {};

local function cancelTween(p7) -- Line: 38
    -- upvalues: u6 (copy)
    if u6[p7] then
        u6[p7]:Cancel();
        u6[p7]:Destroy();
        u6[p7] = nil;
    end;
end;

function v5.Start(p8, p9) -- Line: 46
    -- upvalues: u1 (copy), u4 (ref), ReplicatedStorage (copy), u2 (copy), u6 (copy), u3 (copy)
    u4 = u1(u1(p9, "TopButtons"), "Clock");
    local u10 = u1(u4, "Label");
    local u11 = u1(u4, "Bar");
    local u12 = u1(u4, "ImageLabel");

    if not (u10 and (u11 and u12)) then
        return;
    end;

    local u13 = u1(u11, "DayGradient");
    local u14 = u1(u11, "NightGradient");
    local _ = u11.Size;
    local _ = u12.Position;
    local u15 = false;

    local function update(p16) -- Line: 61
        -- upvalues: ReplicatedStorage (ref), u10 (copy), u2 (ref), u12 (copy), u6 (ref), u11 (copy), u3 (ref), u13 (copy), u14 (copy)
        local v17 = ReplicatedStorage:GetAttribute("IsDay") == true;
        local v18 = ReplicatedStorage:GetAttribute("Timer") or 0;
        local v19 = ReplicatedStorage:GetAttribute("TimerDuration") or (v17 and 420 or 120);
        local v20 = math.clamp((v19 - v18) / v19, 0, 1);
        u10.Text = `{u2.FormatTimePriority(v18)}`;
        u12.Image = v17 and "rbxassetid://108785145271675" or "rbxassetid://129260910158526";

        if p16 then
            if u6.image then
                u6.image:Cancel();
                u6.image:Destroy();
                u6.image = nil;
            end;

            if u6.bar then
                u6.bar:Cancel();
                u6.bar:Destroy();
                u6.bar = nil;
            end;

            u12.Position = UDim2.fromScale(v20, 0.5);
            u11.Size = UDim2.fromScale(v20, 1);
        else
            if u6.image then
                u6.image:Cancel();
                u6.image:Destroy();
                u6.image = nil;
            end;

            u6.image = u3:Tween(u12, 1.1, "Linear", "Out", {
                Position = UDim2.fromScale(v20, 0.5)
            });

            if u6.bar then
                u6.bar:Cancel();
                u6.bar:Destroy();
                u6.bar = nil;
            end;

            u6.bar = u3:Tween(u11, 1.1, "Linear", "Out", {
                Size = UDim2.fromScale(v20, 1)
            });
        end;

        if u13 then
            u13.Enabled = v17;
        end;

        if u14 then
            u14.Enabled = not v17;
        end;
    end;

    local function snapPhaseChange() -- Line: 100
        -- upvalues: u15 (ref), update (copy)
        u15 = true;
        update(true);
    end;

    update(true);
    ReplicatedStorage:GetAttributeChangedSignal("IsDay"):Connect(snapPhaseChange);
    ReplicatedStorage:GetAttributeChangedSignal("Timer"):Connect(function() -- Line: 107
        -- upvalues: update (copy), u15 (ref)
        update(u15);
        u15 = false;
    end);
    ReplicatedStorage:GetAttributeChangedSignal("TimerDuration"):Connect(snapPhaseChange);
end;

return v5;