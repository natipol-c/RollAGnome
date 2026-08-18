--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GlobalEvents
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.GlobalEvents
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
local u1 = Library.get("Network");
local u2 = Library.get("Trove");
local v3 = Library.get("Conch");
local u4 = Library.get("WeatherEvents");
local WeatherIcon = require(script.WeatherIcon);
local u5 = {};
local v6 = {};

for _, child in script.Events:GetChildren() do
    if child:IsA("ModuleScript") then
        u5[child.Name] = require(child);
        v6[child.Name] = child.Name;
    end;
end;

v3.register_type("GlobalEvent", v3.args.enum_map(v6));
local u7 = {};
local v8 = {};

local function normalizeEventName(p9) -- Line: 32
    return string.lower(string.gsub(tostring(p9 or ""), "%W", ""));
end;

local function getWeatherEvent(p10) -- Line: 36
    -- upvalues: u4 (copy)
    local v11 = string.lower(string.gsub(tostring(p10 or ""), "%W", ""));

    for _, v in u4.events do
        if string.lower(string.gsub(tostring(v.name or ""), "%W", "")) == v11 or (string.lower(string.gsub(tostring(v.eventName or ""), "%W", "")) == v11 or (string.lower(string.gsub(tostring(v.moduleName or ""), "%W", "")) == v11 or (string.lower(string.gsub(tostring(v.id or ""), "%W", "")) == v11 or string.lower(string.gsub(tostring(v.key or ""), "%W", "")) == v11))) then
            return v;
        end;
    end;

    return nil;
end;

local function getEventIcon(p12, p13) -- Line: 52
    if type(p13) == "table" then
        local v14 = p13.icon or (p13.Icon or p13.image or (p13.Image or p13.iconImage));

        if v14 and v14 ~= "" then
            return v14;
        end;
    end;

    if type(p12) == "table" then
        local v15 = p12.icon or (p12.Icon or p12.image or (p12.Image or p12.iconImage));

        if v15 and v15 ~= "" then
            return v15;
        end;
    end;

    return nil;
end;

local function formatTime(p16) -- Line: 74
    if p16 <= 0 then
        return "0:00";
    end;

    local v17 = math.floor(p16 / 60);

    return string.format("%d:%02d", v17, p16 % 60);
end;

local function getActiveWeathersContainer() -- Line: 81
    -- upvalues: Players (copy)
    local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");

    if not PlayerGui then
        return nil;
    end;

    local Display = PlayerGui:FindFirstChild("Display");

    if Display then
        Display = Display:FindFirstChild("ActiveWeathers");
    end;

    return Display;
end;

local function waitForActiveWeathersContainer() -- Line: 88
    -- upvalues: Players (copy)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui", 10);

    if not PlayerGui then
        return nil;
    end;

    local Display = PlayerGui:WaitForChild("Display", 10);

    if Display then
        return Display:WaitForChild("ActiveWeathers", 10);
    end;

    return nil;
end;

local function addHudIcon(p18, p19, p20, p21, u22, p23, u24) -- Line: 98
    -- upvalues: WeatherIcon (copy), RunService (copy)
    local u25 = WeatherIcon();

    if p20 and p20 ~= "" then
        u25.Image = p20;
    else
        u25.Image = "";
    end;

    u25.Name = p21;
    u25.Parent = p19;
    p18:Add(u25);
    local v26 = p23 and u25:FindFirstChild("Multi");

    if v26 then
        v26.Text = p23;
        v26.Visible = true;
    end;

    local Timer = u25:FindFirstChild("Timer");
    local u27 = nil;
    u27 = RunService.Heartbeat:Connect(function() -- Line: 119
        -- upvalues: u22 (copy), Timer (copy), u24 (copy), u27 (ref), u25 (copy)
        local v28 = u22.value - os.clock();
        local v29 = math.ceil(v28);

        if v29 > 0 then
            local v30;

            if v29 <= 0 then
                v30 = "0:00";
            else
                local v31 = math.floor(v29 / 60);
                v30 = string.format("%d:%02d", v31, v29 % 60);
            end;

            Timer.Text = v30;

            return;
        end;

        if not u24 then
            Timer.Text = "0:00";

            return;
        end;

        u27:Disconnect();
        u25:Destroy();
    end);
    p18:Add(u27);
end;

local function createWeatherHudIcons(p32, p33, p34, p35) -- Line: 133
    -- upvalues: getWeatherEvent (copy), Players (copy), addHudIcon (copy), getEventIcon (copy)
    local v36 = getWeatherEvent(p33);
    local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");
    local v37;

    if PlayerGui then
        v37 = PlayerGui:FindFirstChild("Display");

        if v37 then
            v37 = v37:FindFirstChild("ActiveWeathers");
        end;
    else
        v37 = nil;
    end;

    if not v37 then
        local PlayerGui2 = Players.LocalPlayer:WaitForChild("PlayerGui", 10);

        if PlayerGui2 then
            local Display = PlayerGui2:WaitForChild("Display", 10);

            if Display then
                v37 = Display:WaitForChild("ActiveWeathers", 10);
            else
                v37 = nil;
            end;
        else
            v37 = nil;
        end;
    end;

    if not v37 then
        return;
    end;

    if p34.value <= os.clock() then
        return;
    end;

    addHudIcon(p32, v37, getEventIcon(v36, p35), p33, p34, nil);
end;

local function onEventStart(p38, p39, p40, p41) -- Line: 143
    -- upvalues: u7 (copy), u5 (copy), u2 (copy), createWeatherHudIcons (copy)
    if u7[p38] then
        return;
    end;

    local v42 = u5[p39];

    if not v42 then
        warn("[GlobalEvents Client] no client module for event:", p39);

        return;
    end;

    local v43 = u2.new();
    local v44 = {
        value = os.clock() + p40
    };
    u7[p38] = {
        trove = v43,
        eventName = p39,
        endTimeRef = v44
    };
    local success, result = pcall(v42.OnStart, v43, p41 or {});

    if not success then
        warn("[GlobalEvents Client] OnStart error for", p39, ":", result);
    end;

    createWeatherHudIcons(v43, p39, v44, p41);
end;

local function onEventEnd(p45, p46) -- Line: 171
    -- upvalues: u7 (copy), u5 (copy)
    local v47 = u7[p45];

    if not v47 then
        return;
    end;

    local v48 = u5[p46 or v47.eventName];

    if v48 and v48.OnEnd then
        local success, result = pcall(v48.OnEnd);

        if not success then
            warn("[GlobalEvents Client] OnEnd error for", p46, ":", result);
        end;
    end;

    v47.trove:Clean();
    u7[p45] = nil;
end;

local function onEventExtend(p49, p50, p51) -- Line: 189
    -- upvalues: u7 (copy)
    local v52 = u7[p49];

    if not v52 then
        return;
    end;

    if v52.endTimeRef then
        v52.endTimeRef.value = os.clock() + p51;
    end;
end;

function v8.Initialize(p53) -- Line: 198
    -- upvalues: u1 (copy), onEventStart (copy), onEventEnd (copy), onEventExtend (copy)
    u1:BindEvents({
        GlobalEventStart = onEventStart,
        GlobalEventEnd = onEventEnd,
        GlobalEventExtend = onEventExtend
    });
    u1:FireServer("RequestActiveGlobalEvents");
end;

return v8;