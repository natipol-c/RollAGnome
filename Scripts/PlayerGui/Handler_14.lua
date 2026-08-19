--[[
  Type:     LocalScript
  Method:   cached
  Name:     Handler
  Path:     game.Players.Palukalima37806.PlayerGui.UpgradeTree.Indicators.Money.Label.Handler
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:31 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Replication = require(ReplicatedStorage.Replication);
local u1 = require(ReplicatedStorage.Library).get("Numbers");

repeat
    task.wait(0.1);
until ReplicatedStorage:GetAttribute("DataLoaded");

local function getAmount(p2) -- Line: 28
    -- upvalues: u1 (copy)
    if p2 >= 100000000000 then
        return u1.Suffix(p2);
    end;

    return u1.Comma(p2);
end;

local function update() -- Line: 35
    -- upvalues: Replication (copy), u1 (copy)
    local Parent = script.Parent;
    local money = Replication.Data.stats.money;
    local v3;

    if money >= 100000000000 then
        v3 = u1.Suffix(money);
    else
        v3 = u1.Comma(money);
    end;

    Parent.Text = `${v3}`;
end;

local Parent = script.Parent;
local money = Replication.Data.stats.money;
local v4;

if money >= 100000000000 then
    v4 = u1.Suffix(money);
else
    v4 = u1.Comma(money);
end;

Parent.Text = `${v4}`;
Replication:Connect("stats", function(p5) -- Line: 44
    -- upvalues: Replication (copy), u1 (copy)
    if type(p5) ~= "table" then
        return;
    end;

    local Parent2 = script.Parent;
    local money2 = Replication.Data.stats.money;
    local v6;

    if money2 >= 100000000000 then
        v6 = u1.Suffix(money2);
    else
        v6 = u1.Comma(money2);
    end;

    Parent2.Text = `${v6}`;
end);

if UserInputService.TouchEnabled then
    script.Parent.Parent.Parent.UIScale.Scale = 1.35;
end;