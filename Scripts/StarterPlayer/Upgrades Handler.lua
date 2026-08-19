--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Upgrades Handler
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Upgrades Handler
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local Replication = require(ReplicatedStorage.Replication);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Numbers");
local u4 = Library.get("Upgrades");
local LocalPlayer = Players.LocalPlayer;
local u5 = u1(u1(LocalPlayer, "PlayerGui"), "SurfaceGuis");
local u6 = u1(LocalPlayer, "Plot");
local v7 = {};
local u8 = {};
local u9 = {};

local function getUpgradeDataName(p10) -- Line: 38
    return string.lower(p10):gsub("%s+", "_");
end;

local function getUpgradeName(p11) -- Line: 42
    -- upvalues: u4 (copy)
    if u4[p11.Name] then
        return p11.Name;
    end;

    local UpgradeName = p11:FindFirstChild("UpgradeName");

    if UpgradeName and u4[UpgradeName.Text] then
        return UpgradeName.Text;
    end;

    return p11.Name;
end;

local function getCurrentTier(p12) -- Line: 55
    -- upvalues: Replication (copy)
    return (Replication.Data.upgrades or {})[string.lower(p12):gsub("%s+", "_")] or 1;
end;

local function getNextTier(p13, p14) -- Line: 60
    local v15 = 10 ^ (p14.decimals or 0);

    return math.round((p13 + (p14.increment or 1)) * v15) / v15;
end;

local function getNextPrice(p16) -- Line: 68
    -- upvalues: u4 (copy), Replication (copy)
    local v17 = u4[p16];
    local v18 = (Replication.Data.upgrades or {})[string.lower(p16):gsub("%s+", "_")] or 1;
    local v19 = 10 ^ (v17.decimals or 0);

    return v17.prices[math.round((v18 + (v17.increment or 1)) * v19) / v19];
end;

local function refreshFrame(p20, p21) -- Line: 74
    -- upvalues: u4 (copy), u1 (copy), Replication (copy), u3 (copy)
    local v22 = u4[p21];

    if not v22 then
        return;
    end;

    local v23 = u1(p20, "Buy");
    local v24 = u1(u1(v23, "Frame"), "Label");
    local v25 = u1(p20, "UpgradeName");
    local v26 = u1(p20, "UpgradeTier");
    local v27 = (Replication.Data.upgrades or {})[string.lower(p21):gsub("%s+", "_")] or 1;
    local v28 = 10 ^ (v22.decimals or 0);
    local v29 = math.round((v27 + (v22.increment or 1)) * v28) / v28;
    local v30 = u4[p21];
    local v31 = (Replication.Data.upgrades or {})[string.lower(p21):gsub("%s+", "_")] or 1;
    local v32 = 10 ^ (v30.decimals or 0);
    local v33 = v30.prices[math.round((v31 + (v30.increment or 1)) * v32) / v32];
    local v34 = p20:GetAttribute("Multi");
    v25.Text = p21;
    v26.Text = v33 and `{v27}{v34 and "x" or ""} > {v29}{v34 and "x" or ""}` or `{v27}{v34 and "x" or ""} > MAX`;
    v23.Visible = v33 ~= nil;
    v24.Text = v33 and `{u3.Comma(v33)}$` or "MAX";
end;

local function refreshAll() -- Line: 95
    -- upvalues: u8 (copy), refreshFrame (copy)
    for i, v in u8 do
        if i.Parent then
            refreshFrame(i, v);
        else
            u8[i] = nil;
        end;
    end;
end;

local function setupFrame(u35) -- Line: 105
    -- upvalues: u4 (copy), u8 (copy), refreshFrame (copy), u1 (copy), u9 (copy), Replication (copy), u2 (copy)
    local u36;

    if u4[u35.Name] then
        u36 = u35.Name;
    else
        local UpgradeName = u35:FindFirstChild("UpgradeName");

        if UpgradeName and u4[UpgradeName.Text] then
            u36 = UpgradeName.Text;
        else
            u36 = u35.Name;
        end;
    end;

    if not u4[u36] or u8[u35] then
        return;
    end;

    u8[u35] = u36;
    refreshFrame(u35, u36);
    local v37 = u1(u35, "Buy");
    local v38 = u1(v37, "Button");
    local u39 = false;
    v37:AddTag("BUTTON");
    u9[u35] = v38.MouseButton1Click:Connect(function() -- Line: 118
        -- upvalues: u39 (ref), u36 (copy), u4 (ref), Replication (ref), u2 (ref)
        if u39 then
            return;
        end;

        local v40 = u36;
        local v41 = u4[v40];
        local v42 = (Replication.Data.upgrades or {})[string.lower(v40):gsub("%s+", "_")] or 1;
        local v43 = 10 ^ (v41.decimals or 0);

        if not v41.prices[math.round((v42 + (v41.increment or 1)) * v43) / v43] then
            _G.Play("Negative");

            return;
        end;

        u39 = true;
        local v44 = u2:InvokeServer("Upgrade", u36);

        if v44 == "Not Enough" or (v44 == "Maxed" or v44 == "Invalid") then
            _G.Play("Negative");
        end;

        task.delay(0.5, function() -- Line: 133
            -- upvalues: u39 (ref)
            u39 = false;
        end);
    end);
    u35.Destroying:Once(function() -- Line: 138
        -- upvalues: u8 (ref), u35 (copy), u9 (ref)
        u8[u35] = nil;

        if u9[u35] then
            u9[u35]:Disconnect();
            u9[u35] = nil;
        end;
    end);
end;

local function gotPlot(u45) -- Line: 148
    -- upvalues: u5 (copy), setupFrame (copy), CollectionService (copy)
    local function added(p46) -- Line: 150
        -- upvalues: u45 (copy), u5 (ref), setupFrame (ref)
        if not p46:IsDescendantOf(u45) then
            return;
        end;

        p46.Adornee = p46.Parent;
        p46.Parent = u5;
        local v47 = next;
        local v48, v49 = p46:GetChildren();

        for _, v in v47, v48, v49 do
            if v:IsA("Frame") then
                setupFrame(v);
            end;
        end;
    end;

    for _, v in pairs(CollectionService:GetTagged("PLOTUPGRADES")) do
        added(v);
    end;

    CollectionService:GetInstanceAddedSignal("PLOTUPGRADES"):Connect(added);
end;

function v7.Initialize(p50) -- Line: 170
    -- upvalues: Replication (copy), refreshAll (copy), u6 (copy), gotPlot (copy)
    Replication:Connect("upgrades", refreshAll);

    if u6.Value then
        gotPlot(u6.Value);

        return;
    end;

    u6.Changed:Once(function() -- Line: 176
        -- upvalues: gotPlot (ref), u6 (ref)
        gotPlot(u6.Value);
    end);
end;

return v7;