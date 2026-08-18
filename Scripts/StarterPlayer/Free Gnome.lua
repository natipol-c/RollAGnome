--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Free Gnome
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Free Gnome
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
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Numbers");
local u4 = Library.get("Products");
local _ = ReplicatedStorage.Assets;
local u5 = u1(Players.LocalPlayer, "Plot");
local v6 = {};

local function gotPlot(p7) -- Line: 31
    -- upvalues: u1 (copy), Replication (copy), u3 (copy), u4 (copy), u2 (copy)
    local u8 = u1(p7, "FreeGnome");
    local u9 = u1(u8, "BillboardGui");
    local u10 = u1(u9, "Timer");
    local u11 = u1(u1(u8, "Attachment"), "ProximityPrompt");
    local Data = Replication.Data;

    if Data.freeGnome.claimed then
        return;
    end;

    local u12 = false;
    u9.Enabled = true;
    u11.Enabled = true;

    local function update(p13) -- Line: 48
        -- upvalues: u11 (copy), u10 (copy), u12 (ref), u3 (ref)
        local v14 = 300 - p13.total_stats.timePlayed;

        if v14 <= 0 or p13.freeGnome.canClaim then
            u11.ActionText = "Claim!";
            u10.Text = "Ready!";
            u12 = true;

            return;
        end;

        u11.ActionText = "Skip";
        u10.Text = u3.FormatTimePriority(v14);
        u12 = false;
    end;

    local v15 = 300 - Data.total_stats.timePlayed;

    if v15 <= 0 or Data.freeGnome.canClaim then
        u11.ActionText = "Claim!";
        u10.Text = "Ready!";
        u12 = true;
    else
        u11.ActionText = "Skip";
        u10.Text = u3.FormatTimePriority(v15);
        u12 = false;
    end;

    Replication:Connect("total_stats", function() -- Line: 65
        -- upvalues: Replication (ref), u11 (copy), u10 (copy), u12 (ref), u3 (ref)
        local Data2 = Replication.Data;
        local v16 = 300 - Data2.total_stats.timePlayed;

        if v16 <= 0 or Data2.freeGnome.canClaim then
            u11.ActionText = "Claim!";
            u10.Text = "Ready!";
            u12 = true;

            return;
        end;

        u11.ActionText = "Skip";
        u10.Text = u3.FormatTimePriority(v16);
        u12 = false;
    end);
    Replication:Connect("freeGnome", function(p17) -- Line: 68
        -- upvalues: u9 (copy), u11 (copy), u8 (copy)
        if p17.claimed then
            u9.Enabled = false;
            u11.Enabled = false;
            u8:Destroy();
        end;
    end);
    local products = u4.products;
    u11.Triggered:Connect(function() -- Line: 77
        -- upvalues: u12 (ref), u2 (ref), u4 (ref), products (copy)
        if u12 then
            u2:FireServer("ClaimFreeGnome");

            return;
        end;

        u4.prompt(products.skipFreeGnome.id, "product");
    end);
    u8:PivotTo(u8:GetPivot() + Vector3.new(0, 15, 0));
end;

function v6.Initialize(p18) -- Line: 87
    -- upvalues: u5 (copy), gotPlot (copy)
    if u5.Value then
        gotPlot(u5.Value);

        return;
    end;

    u5.Changed:Once(function() -- Line: 91
        -- upvalues: gotPlot (ref), u5 (ref)
        gotPlot(u5.Value);
    end);
end;

return v6;