--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Active Luck
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Active Luck
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
Library.get("Network");
local u2 = Library.get("Numbers");
local u3 = Library.get("Products");
local _ = ReplicatedStorage.Assets;
local LocalPlayer = Players.LocalPlayer;
local u4 = u1(LocalPlayer, "Plot");
local v5 = {};

local function gotPlot(p6) -- Line: 31
    -- upvalues: u1 (copy), LocalPlayer (copy), u3 (copy), u2 (copy)
    local v7 = u1(u1(u1(u1(p6, "ActiveLuckSign"), "Board"), "SurfaceGui"), "Frame");
    local u8 = u1(v7, "BaseLuck");
    local u9 = u1(v7, "RebirthLuck");
    local u10 = u1(u9, "Label");

    local function updateDisplayLuck() -- Line: 40
        -- upvalues: LocalPlayer (ref), u3 (ref), u8 (copy), u2 (ref)
        local v11 = LocalPlayer:GetAttribute("DisplayRollLuck") or 1;

        if LocalPlayer:GetAttribute("2xLuck_Boost") then
            v11 = v11 * 2;
        end;

        if LocalPlayer:GetAttribute("4xLuck_Boost") then
            v11 = v11 * 4;
        end;

        if u3.check("Lucky Rolls") then
            v11 = v11 * 2;
        end;

        u8.Text = `x{u2.Suffix(v11)}`;
    end;

    updateDisplayLuck();
    LocalPlayer:GetAttributeChangedSignal("DisplayRollLuck"):Connect(updateDisplayLuck);
    LocalPlayer:GetAttributeChangedSignal("2xLuck_Boost"):Connect(updateDisplayLuck);
    LocalPlayer:GetAttributeChangedSignal("4xLuck_Boost"):Connect(updateDisplayLuck);

    local function updateAddedLuck() -- Line: 62
        -- upvalues: LocalPlayer (ref), u3 (ref), u10 (copy), u2 (ref), u9 (copy)
        local v12 = LocalPlayer:GetAttribute("AddedLuck") or 0;

        if u3.check("VIP") then
            v12 = v12 + 1.5;
        end;

        if v12 <= 0 then
            return;
        end;

        u10.Text = `x{u2.Comma(v12)}`;
        u9.Visible = true;
    end;

    local v13 = LocalPlayer:GetAttribute("AddedLuck") or 0;

    if u3.check("VIP") then
        v13 = v13 + 1.5;
    end;

    if v13 > 0 then
        u10.Text = `x{u2.Comma(v13)}`;
        u9.Visible = true;
    end;

    LocalPlayer:GetAttributeChangedSignal("AddedLuck"):Connect(updateAddedLuck);
end;

function v5.Initialize(p14) -- Line: 79
    -- upvalues: u4 (copy), gotPlot (copy)
    if u4.Value then
        gotPlot(u4.Value);

        return;
    end;

    u4.Changed:Once(function() -- Line: 83
        -- upvalues: gotPlot (ref), u4 (ref)
        gotPlot(u4.Value);
    end);
end;

return v5;