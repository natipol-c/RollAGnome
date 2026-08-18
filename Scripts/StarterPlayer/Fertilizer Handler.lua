--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fertilizer Handler
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Fertilizer Handler
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Find");
local u2 = Library.get("Numbers");
local FertilizerInfo = ReplicatedStorage.Assets.Billboards.FertilizerInfo;
local LocalPlayer = Players.LocalPlayer;
local u3 = v1(LocalPlayer, "Plot");
local v4 = {};
local u5 = {};
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;

local function hideInfo(p10) -- Line: 39
    -- upvalues: u5 (copy)
    local v11 = u5[p10];

    if not v11 then
        return;
    end;

    if v11.TimeConnection then
        v11.TimeConnection:Disconnect();
        v11.TimeConnection = nil;
    end;

    if v11.Billboard then
        v11.Billboard:Destroy();
        v11.Billboard = nil;
    end;
end;

local function removeInfo(p12) -- Line: 53
    -- upvalues: u5 (copy)
    local v13 = u5[p12];

    if v13 then
        if v13.TimeConnection then
            v13.TimeConnection:Disconnect();
            v13.TimeConnection = nil;
        end;

        if v13.Billboard then
            v13.Billboard:Destroy();
            v13.Billboard = nil;
        end;
    end;

    u5[p12] = nil;
end;

local function updateText(p14, p15) -- Line: 59
    -- upvalues: u2 (copy)
    local v16 = p14:GetAttribute("ItemName") or p14.Name;
    local v17 = p14:GetAttribute("TimeRemaining");
    local v18 = p15:FindFirstChild("FertilizerName") or (p15:FindFirstChild("ItemName") or p15:FindFirstChild("SprinklerName"));
    local TimeRemaining = p15:FindFirstChild("TimeRemaining");

    if v18 and v18:IsA("TextLabel") then
        v18.Text = v16;
    end;

    if TimeRemaining and TimeRemaining:IsA("TextLabel") then
        TimeRemaining.Text = u2.FormatTimePriority(v17 or 0);
    end;
end;

local function showInfo(u19) -- Line: 76
    -- upvalues: u5 (copy), FertilizerInfo (copy), updateText (copy)
    local v20 = u5[u19];

    if v20 and v20.Billboard then
        return v20.Billboard;
    end;

    local u21 = FertilizerInfo:Clone();
    u21.Adornee = u19;
    u21.Parent = u19;
    local v22 = v20 or {};
    v22.Billboard = u21;
    v22.TimeConnection = u19:GetAttributeChangedSignal("TimeRemaining"):Connect(function() -- Line: 88
        -- upvalues: updateText (ref), u19 (copy), u21 (copy)
        updateText(u19, u21);
    end);
    u5[u19] = v22;
    updateText(u19, u21);

    return u21;
end;

local function trackFertilizer(u23) -- Line: 98
    -- upvalues: u5 (copy)
    if u5[u23] then
        return;
    end;

    if not u23:IsA("BasePart") then
        return;
    end;

    u5[u23] = {};
    u23.Destroying:Once(function() -- Line: 104
        -- upvalues: u23 (copy), u5 (ref)
        local v24 = u23;
        local v25 = u5[v24];

        if v25 then
            if v25.TimeConnection then
                v25.TimeConnection:Disconnect();
                v25.TimeConnection = nil;
            end;

            if v25.Billboard then
                v25.Billboard:Destroy();
                v25.Billboard = nil;
            end;
        end;

        u5[v24] = nil;
    end);
end;

local function updateFertilizer() -- Line: 109
    -- upvalues: LocalPlayer (copy), u5 (copy), showInfo (copy), updateText (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    for i in u5 do
        if i.Parent then
            if (Character.Position - i.Position).Magnitude <= 15 then
                updateText(i, (showInfo(i)));
            else
                local v26 = u5[i];

                if v26 then
                    if v26.TimeConnection then
                        v26.TimeConnection:Disconnect();
                        v26.TimeConnection = nil;
                    end;

                    if v26.Billboard then
                        v26.Billboard:Destroy();
                        v26.Billboard = nil;
                    end;
                end;
            end;
        else
            local v27 = u5[i];

            if v27 then
                if v27.TimeConnection then
                    v27.TimeConnection:Disconnect();
                    v27.TimeConnection = nil;
                end;

                if v27.Billboard then
                    v27.Billboard:Destroy();
                    v27.Billboard = nil;
                end;
            end;

            u5[i] = nil;
        end;
    end;
end;

local function watchFertilizer(p28) -- Line: 130
    -- upvalues: trackFertilizer (copy), u6 (ref), u7 (ref), removeInfo (copy), u9 (ref), RunService (copy), updateFertilizer (copy)
    for _, child in p28:GetChildren() do
        trackFertilizer(child);
    end;

    u6 = p28.ChildAdded:Connect(trackFertilizer);
    u7 = p28.ChildRemoved:Connect(removeInfo);
    u9 = RunService.Heartbeat:Connect(updateFertilizer);
end;

local function gotPlot(p29) -- Line: 140
    -- upvalues: watchFertilizer (copy), u8 (ref)
    local Fertilizer = p29:FindFirstChild("Fertilizer");

    if Fertilizer then
        watchFertilizer(Fertilizer);

        return;
    end;

    u8 = p29.ChildAdded:Connect(function(p30) -- Line: 147
        -- upvalues: u8 (ref), watchFertilizer (ref)
        if p30.Name ~= "Fertilizer" then
            return;
        end;

        if u8 then
            u8:Disconnect();
            u8 = nil;
        end;

        watchFertilizer(p30);
    end);
end;

function v4.Initialize(p31) -- Line: 159
    -- upvalues: u3 (copy), watchFertilizer (copy), u8 (ref)
    if not u3.Value then
        u3.Changed:Once(function() -- Line: 163
            -- upvalues: u3 (ref), watchFertilizer (ref), u8 (ref)
            local Value = u3.Value;
            local Fertilizer = Value:FindFirstChild("Fertilizer");

            if Fertilizer then
                watchFertilizer(Fertilizer);

                return;
            end;

            u8 = Value.ChildAdded:Connect(function(p32) -- Line: 147
                -- upvalues: u8 (ref), watchFertilizer (ref)
                if p32.Name ~= "Fertilizer" then
                    return;
                end;

                if u8 then
                    u8:Disconnect();
                    u8 = nil;
                end;

                watchFertilizer(p32);
            end);
        end);

        return;
    end;

    local Value = u3.Value;
    local Fertilizer = Value:FindFirstChild("Fertilizer");

    if Fertilizer then
        watchFertilizer(Fertilizer);

        return;
    end;

    u8 = Value.ChildAdded:Connect(function(p33) -- Line: 147
        -- upvalues: u8 (ref), watchFertilizer (ref)
        if p33.Name ~= "Fertilizer" then
            return;
        end;

        if u8 then
            u8:Disconnect();
            u8 = nil;
        end;

        watchFertilizer(p33);
    end);
end;

return v4;