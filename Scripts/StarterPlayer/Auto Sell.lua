--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Auto Sell
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Auto Sell
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:39 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local Replication = require(ReplicatedStorage.Replication);
local u1 = Library.get("Find");
Library.get("Network");
Library.get("Products");
local v2 = {};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;

local function update(p9) -- Line: 31
    -- upvalues: u1 (copy), u8 (ref)
    local v10 = u1(u8, "Off");
    local v11 = u1(u8, "On");
    v10.Enabled = not p9;
    v11.Enabled = p9;
end;

function v2.Start(p12, p13) -- Line: 39
    -- upvalues: u3 (ref), u4 (ref), u1 (copy), u5 (ref), u6 (ref), u7 (ref), u8 (ref), Replication (copy)
    u3 = p13;
    u4 = u1(u3, "Indicators");
    u5 = u1(u4, "OtherButtons");
    u6 = u1(u5, "AutoSell");
    u7 = u1(u6, "Frame");
    u8 = u1(u7, "Noti");
    local sell = Replication.Data.autos.sell;
    local v14 = u1(u8, "Off");
    local v15 = u1(u8, "On");
    v14.Enabled = not sell;
    v15.Enabled = sell;
    Replication:Connect("autos", function(p16) -- Line: 52
        -- upvalues: u1 (ref), u8 (ref)
        local sell2 = p16.sell;
        local v17 = u1(u8, "Off");
        local v18 = u1(u8, "On");
        v17.Enabled = not sell2;
        v18.Enabled = sell2;
    end);
end;

return v2;