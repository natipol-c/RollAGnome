--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Sprinkler Handler
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Sprinkler Handler
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:40 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Find");
local u2 = Library.get("Numbers");
local u3 = Library.get("Sprinklers");
local Assets = ReplicatedStorage.Assets;
local SprinklerInfo = Assets.Billboards.SprinklerInfo;
local LocalPlayer = Players.LocalPlayer;
local u4 = v1(LocalPlayer, "Plot");
local v5 = {};
local u6 = {};
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;

local function getCenterPart(p11) -- Line: 41
    if p11 then
        p11 = p11:FindFirstChild("CenterPart", true);
    end;

    return p11;
end;

local function hideInfo(p12) -- Line: 45
    -- upvalues: u6 (copy)
    local v13 = u6[p12];

    if not v13 then
        return;
    end;

    if v13.TimeConnection then
        v13.TimeConnection:Disconnect();
        v13.TimeConnection = nil;
    end;

    if v13.Billboard then
        v13.Billboard:Destroy();
        v13.Billboard = nil;
    end;

    if v13.Ring then
        v13.Ring:Destroy();
        v13.Ring = nil;
    end;
end;

local function removeInfo(p14) -- Line: 63
    -- upvalues: u6 (copy)
    local v15 = u6[p14];

    if v15 then
        if v15.TimeConnection then
            v15.TimeConnection:Disconnect();
            v15.TimeConnection = nil;
        end;

        if v15.Billboard then
            v15.Billboard:Destroy();
            v15.Billboard = nil;
        end;

        if v15.Ring then
            v15.Ring:Destroy();
            v15.Ring = nil;
        end;
    end;

    u6[p14] = nil;
end;

local function updateText(p16, p17) -- Line: 69
    -- upvalues: u3 (copy), u2 (copy)
    local v18 = p16:GetAttribute("ItemName") or p16.Name;
    local v19 = u3[v18] or {};

    if not p16:GetAttribute("Multi") then
        local _ = v19.multi;
    end;

    local v20 = p16:GetAttribute("TimeRemaining");
    p17.SprinklerName.Text = v18;
    p17.TimeRemaining.Text = u2.FormatTimePriority(v20 or 0);
end;

local function showInfo(u21, p22) -- Line: 79
    -- upvalues: u6 (copy), SprinklerInfo (copy), updateText (copy)
    local v23 = u6[u21];

    if v23 and v23.Billboard then
        return v23.Billboard;
    end;

    local u24 = SprinklerInfo:Clone();
    u24.Adornee = p22;
    u24.Parent = p22;
    local v25 = v23 or {};
    v25.Billboard = u24;
    v25.TimeConnection = u21:GetAttributeChangedSignal("TimeRemaining"):Connect(function() -- Line: 91
        -- upvalues: updateText (ref), u21 (copy), u24 (copy)
        updateText(u21, u24);
    end);
    u6[u21] = v25;
    updateText(u21, u24);

    return u24;
end;

local function showRing(p26, p27) -- Line: 101
    -- upvalues: u6 (copy), u3 (copy), Assets (copy)
    local v28 = u6[p26];

    if not v28 then
        return;
    end;

    local v29 = u3[p26:GetAttribute("ItemName") or p26.Name];
    local v30;

    if v29 then
        v30 = v29.range;
    else
        v30 = v29;
    end;

    if type(v30) ~= "number" then
        return;
    end;

    if not v28.Ring then
        local v31 = v29.ring or "SprinklerRing";
        local v32 = Assets:FindFirstChild(v31) or Assets:FindFirstChild("SprinklerRing");

        if not v32 then
            return;
        end;

        local v33 = v32:Clone();
        v33.Name = v31;
        v33.Anchored = true;
        v33.CanCollide = false;
        v33.CanTouch = false;
        v33.CanQuery = false;
        v33.Size = Vector3.new(v30 * 2, v33.Size.Y, v30 * 2);
        v33.Parent = p26;
        v28.Ring = v33;
    end;

    v28.Ring:PivotTo(p26:GetPivot());
end;

local function trackSprinkler(u34) -- Line: 129
    -- upvalues: u6 (copy)
    if u6[u34] then
        return;
    end;

    u6[u34] = {};
    u34.Destroying:Once(function() -- Line: 134
        -- upvalues: u34 (copy), u6 (ref)
        local v35 = u34;
        local v36 = u6[v35];

        if v36 then
            if v36.TimeConnection then
                v36.TimeConnection:Disconnect();
                v36.TimeConnection = nil;
            end;

            if v36.Billboard then
                v36.Billboard:Destroy();
                v36.Billboard = nil;
            end;

            if v36.Ring then
                v36.Ring:Destroy();
                v36.Ring = nil;
            end;
        end;

        u6[v35] = nil;
    end);
end;

local function updateSprinklers() -- Line: 139
    -- upvalues: LocalPlayer (copy), u6 (copy), showInfo (copy), updateText (copy), showRing (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    for i in u6 do
        if i.Parent then
            local v37;

            if i then
                v37 = i:FindFirstChild("CenterPart", true);
            else
                v37 = i;
            end;

            if v37 then
                if (Character.Position - v37.Position).Magnitude <= 15 then
                    updateText(i, (showInfo(i, v37)));
                    showRing(i, v37);
                else
                    local v38 = u6[i];

                    if v38 then
                        if v38.TimeConnection then
                            v38.TimeConnection:Disconnect();
                            v38.TimeConnection = nil;
                        end;

                        if v38.Billboard then
                            v38.Billboard:Destroy();
                            v38.Billboard = nil;
                        end;

                        if v38.Ring then
                            v38.Ring:Destroy();
                            v38.Ring = nil;
                        end;
                    end;
                end;
            else
                local v39 = u6[i];

                if v39 then
                    if v39.TimeConnection then
                        v39.TimeConnection:Disconnect();
                        v39.TimeConnection = nil;
                    end;

                    if v39.Billboard then
                        v39.Billboard:Destroy();
                        v39.Billboard = nil;
                    end;

                    if v39.Ring then
                        v39.Ring:Destroy();
                        v39.Ring = nil;
                    end;
                end;

                u6[i] = nil;
            end;
        else
            local v40 = u6[i];

            if v40 then
                if v40.TimeConnection then
                    v40.TimeConnection:Disconnect();
                    v40.TimeConnection = nil;
                end;

                if v40.Billboard then
                    v40.Billboard:Destroy();
                    v40.Billboard = nil;
                end;

                if v40.Ring then
                    v40.Ring:Destroy();
                    v40.Ring = nil;
                end;
            end;

            u6[i] = nil;
        end;
    end;
end;

local function watchSprinklers(p41) -- Line: 167
    -- upvalues: trackSprinkler (copy), u7 (ref), u8 (ref), removeInfo (copy), u10 (ref), RunService (copy), updateSprinklers (copy)
    for _, child in p41:GetChildren() do
        trackSprinkler(child);
    end;

    u7 = p41.ChildAdded:Connect(trackSprinkler);
    u8 = p41.ChildRemoved:Connect(removeInfo);
    u10 = RunService.Heartbeat:Connect(updateSprinklers);
end;

local function gotPlot(p42) -- Line: 177
    -- upvalues: watchSprinklers (copy), u9 (ref)
    local Sprinklers = p42:FindFirstChild("Sprinklers");

    if Sprinklers then
        watchSprinklers(Sprinklers);

        return;
    end;

    u9 = p42.ChildAdded:Connect(function(p43) -- Line: 184
        -- upvalues: u9 (ref), watchSprinklers (ref)
        if p43.Name ~= "Sprinklers" then
            return;
        end;

        if u9 then
            u9:Disconnect();
            u9 = nil;
        end;

        watchSprinklers(p43);
    end);
end;

function v5.Initialize(p44) -- Line: 196
    -- upvalues: u4 (copy), watchSprinklers (copy), u9 (ref)
    if not u4.Value then
        u4.Changed:Once(function() -- Line: 200
            -- upvalues: u4 (ref), watchSprinklers (ref), u9 (ref)
            local Value = u4.Value;
            local Sprinklers = Value:FindFirstChild("Sprinklers");

            if Sprinklers then
                watchSprinklers(Sprinklers);

                return;
            end;

            u9 = Value.ChildAdded:Connect(function(p45) -- Line: 184
                -- upvalues: u9 (ref), watchSprinklers (ref)
                if p45.Name ~= "Sprinklers" then
                    return;
                end;

                if u9 then
                    u9:Disconnect();
                    u9 = nil;
                end;

                watchSprinklers(p45);
            end);
        end);

        return;
    end;

    local Value = u4.Value;
    local Sprinklers = Value:FindFirstChild("Sprinklers");

    if Sprinklers then
        watchSprinklers(Sprinklers);

        return;
    end;

    u9 = Value.ChildAdded:Connect(function(p46) -- Line: 184
        -- upvalues: u9 (ref), watchSprinklers (ref)
        if p46.Name ~= "Sprinklers" then
            return;
        end;

        if u9 then
            u9:Disconnect();
            u9 = nil;
        end;

        watchSprinklers(p46);
    end);
end;

return v5;