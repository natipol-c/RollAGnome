--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Currency
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Currency
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:28 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("UserInputService");
local Library = require(ReplicatedStorage.Library);
local Replication = require(ReplicatedStorage.Replication);
local u1 = Library.get("Find");
local u2 = Library.get("Numbers");
local u3 = Library.get("SimpleTween");
Library.get("Signal");
Library.get("Products");
local _ = Players.LocalPlayer;
local u4 = nil;
local v5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = {};

local function getAmount(p10) -- Line: 34
    -- upvalues: u2 (copy)
    if p10 >= 100000000000 then
        return u2.Suffix(p10);
    end;

    return u2.Comma(p10);
end;

function v5.updateMoney(p11) -- Line: 41
    -- upvalues: u6 (copy), Replication (copy), u7 (copy), u4 (ref), u2 (copy), u8 (copy), u9 (copy), u3 (copy)
    if not u6.money then
        u6.money = Instance.new("NumberValue");
    end;

    local money = u6.money;
    local v12 = Replication.Data.stats[string.lower("money")];

    if not u7.money then
        local Label = u4.Label;
        local v13;

        if v12 == 0 then
            local v14 = math.floor(money.Value);
            local v15;

            if v14 >= 100000000000 then
                v15 = u2.Suffix(v14);
            else
                v15 = u2.Comma(v14);
            end;

            v13 = v15 or "";
        else
            v13 = "";
        end;

        Label.Text = v13 .. "$";
        u7.money = money:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 51
            -- upvalues: u4 (ref), money (copy), u2 (ref)
            local Label2 = u4.Label;
            local v16 = math.floor(money.Value);
            local v17;

            if v16 >= 100000000000 then
                v17 = u2.Suffix(v16);
            else
                v17 = u2.Comma(v16);
            end;

            Label2.Text = v17 .. "$";
        end);
    end;

    if not u8.money or math.abs(u8.money - v12) ~= 1 then
        if u9.money then
            u9.money:Cancel();
            u9.money:Destroy();
            u9.money = nil;
        end;

        u9.money = u3:Tween(money, 0.5, "Sine", "Out", {
            Value = v12 or 0
        });

        return;
    end;

    money.Value = v12;
    local Label = u4.Label;
    local v18 = math.floor(money.Value);
    local v19;

    if v18 >= 100000000000 then
        v19 = u2.Suffix(v18);
    else
        v19 = u2.Comma(v18);
    end;

    Label.Text = v19 .. "$";
end;

local function showMinusAnimation(p20, p21) -- Line: 72
    -- upvalues: u2 (copy), u3 (copy)
    p20.Label.TextColor3 = Color3.fromRGB(255, 0, 0);
    local u22 = p20.Minus:Clone();
    local v23 = math.abs(p21);
    local v24;

    if v23 >= 100000000000 then
        v24 = u2.Suffix(v23);
    else
        v24 = u2.Comma(v23);
    end;

    u22.Text = "-" .. v24 .. "$";
    u22.Parent = p20;
    u22.Visible = true;
    u3:Tween(u22, 1.4, "Quad", "Out", {
        TextTransparency = 1,
        Position = UDim2.fromScale(0.034, -0.6)
    }, nil, function() -- Line: 82
        -- upvalues: u22 (copy)
        u22:Destroy();
    end);
    task.wait(0.15);
    u3:Tween(p20.Label, 0.2, "Quad", "Out", {
        TextColor3 = Color3.fromRGB(255, 255, 255)
    });
end;

function v5.Start(u25, p26) -- Line: 91
    -- upvalues: u4 (ref), u1 (copy), Replication (copy), u8 (copy), showMinusAnimation (copy)
    u4 = u1(p26, "Indicators");
    u4 = u1(u4, "Money");
    u25:updateMoney();
    u8.money = Replication.Data.stats.money;
    Replication:Connect("stats", function(p27) -- Line: 101
        -- upvalues: u8 (ref), u25 (copy), showMinusAnimation (ref), u4 (ref)
        if type(p27) ~= "table" then
            return;
        end;

        if p27.money ~= u8.money then
            u25:updateMoney();
            local v28 = p27.money - u8.money;

            if v28 < 0 then
                showMinusAnimation(u4, v28);
            end;
        end;

        u8.money = p27.money;
    end);
end;

return v5;