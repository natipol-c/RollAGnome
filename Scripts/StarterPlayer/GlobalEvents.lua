--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GlobalEvents
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.GlobalEvents
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

local function getClientEventName(p16) -- Line: 74
    -- upvalues: u5 (copy), getWeatherEvent (copy)
    if u5[p16] then
        return p16;
    end;

    local v17 = getWeatherEvent(p16);

    if not v17 then
        return p16;
    end;

    local v18 = v17.moduleName or v17.eventName or (v17.id or v17.key);

    if v18 and u5[v18] then
        return v18;
    end;

    return p16;
end;

local function formatTime(p19) -- Line: 96
    if p19 <= 0 then
        return "0:00";
    end;

    local v20 = math.floor(p19 / 60);

    return string.format("%d:%02d", v20, p19 % 60);
end;

local function getActiveWeathersContainer() -- Line: 103
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

local function waitForActiveWeathersContainer() -- Line: 110
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

local function addHudIcon(p21, p22, p23, p24, u25, p26, u27) -- Line: 120
    -- upvalues: WeatherIcon (copy), RunService (copy)
    local u28 = WeatherIcon();

    if p23 and p23 ~= "" then
        u28.Image = p23;
    else
        u28.Image = "";
    end;

    u28.Name = p24;
    u28.Parent = p22;
    p21:Add(u28);
    local v29 = p26 and u28:FindFirstChild("Multi");

    if v29 then
        v29.Text = p26;
        v29.Visible = true;
    end;

    local Timer = u28:FindFirstChild("Timer");
    local u30 = nil;
    u30 = RunService.Heartbeat:Connect(function() -- Line: 141
        -- upvalues: u25 (copy), Timer (copy), u27 (copy), u30 (ref), u28 (copy)
        local v31 = u25.value - os.clock();
        local v32 = math.ceil(v31);

        if v32 > 0 then
            local v33;

            if v32 <= 0 then
                v33 = "0:00";
            else
                local v34 = math.floor(v32 / 60);
                v33 = string.format("%d:%02d", v34, v32 % 60);
            end;

            Timer.Text = v33;

            return;
        end;

        if not u27 then
            Timer.Text = "0:00";

            return;
        end;

        u30:Disconnect();
        u28:Destroy();
    end);
    p21:Add(u30);
end;

local function createWeatherHudIcons(p35, p36, p37, p38) -- Line: 155
    -- upvalues: getWeatherEvent (copy), Players (copy), addHudIcon (copy), getEventIcon (copy)
    local v39 = getWeatherEvent(p36);
    local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");
    local v40;

    if PlayerGui then
        v40 = PlayerGui:FindFirstChild("Display");

        if v40 then
            v40 = v40:FindFirstChild("ActiveWeathers");
        end;
    else
        v40 = nil;
    end;

    if not v40 then
        local PlayerGui2 = Players.LocalPlayer:WaitForChild("PlayerGui", 10);

        if PlayerGui2 then
            local Display = PlayerGui2:WaitForChild("Display", 10);

            if Display then
                v40 = Display:WaitForChild("ActiveWeathers", 10);
            else
                v40 = nil;
            end;
        else
            v40 = nil;
        end;
    end;

    if not v40 then
        return;
    end;

    if p37.value <= os.clock() then
        return;
    end;

    addHudIcon(p35, v40, getEventIcon(v39, p38), p36, p37, nil);
end;

local function onEventStart(p41, p42, p43, p44) -- Line: 165
    -- upvalues: u7 (copy), u5 (copy), getWeatherEvent (copy), u2 (copy), createWeatherHudIcons (copy)
    if u7[p41] then
        return;
    end;

    local v45;

    if u5[p42] then
        v45 = p42;
    else
        local v46 = getWeatherEvent(p42);

        if v46 then
            v45 = v46.moduleName or v46.eventName or (v46.id or v46.key);

            if v45 then
                if not u5[v45] then
                    v45 = p42;
                end;
            else
                v45 = p42;
            end;
        else
            v45 = p42;
        end;
    end;

    local v47 = u5[v45];

    if not v47 then
        warn("[GlobalEvents Client] no client module for event:", p42);

        return;
    end;

    local v48 = u2.new();
    local v49 = {
        value = os.clock() + p43
    };
    u7[p41] = {
        trove = v48,
        eventName = v45,
        endTimeRef = v49
    };
    local success, result = pcall(v47.OnStart, v48, p44 or {});

    if not success then
        warn("[GlobalEvents Client] OnStart error for", p42, ":", result);
    end;

    createWeatherHudIcons(v48, p42, v49, p44);
end;

local function onEventEnd(p50, p51) -- Line: 194
    -- upvalues: u7 (copy), u5 (copy), getWeatherEvent (copy)
    local v52 = u7[p50];

    if not v52 then
        return;
    end;

    local v53 = p51 or v52.eventName;
    local v54;

    if u5[v53] then
        v54 = v53;
    else
        local v55 = getWeatherEvent(v53);

        if v55 then
            v54 = v55.moduleName or v55.eventName or (v55.id or v55.key);

            if v54 then
                if not u5[v54] then
                    v54 = v53;
                end;
            else
                v54 = v53;
            end;
        else
            v54 = v53;
        end;
    end;

    local v56 = u5[v54];

    if v56 and v56.OnEnd then
        local success, result = pcall(v56.OnEnd);

        if not success then
            warn("[GlobalEvents Client] OnEnd error for", p51, ":", result);
        end;
    end;

    v52.trove:Clean();
    u7[p50] = nil;
end;

local function onEventExtend(p57, p58, p59) -- Line: 212
    -- upvalues: u7 (copy)
    local v60 = u7[p57];

    if not v60 then
        return;
    end;

    if v60.endTimeRef then
        v60.endTimeRef.value = os.clock() + p59;
    end;
end;

function v8.Initialize(p61) -- Line: 221
    -- upvalues: u1 (copy), onEventStart (copy), onEventEnd (copy), onEventExtend (copy)
    u1:BindEvents({
        GlobalEventStart = onEventStart,
        GlobalEventEnd = onEventEnd,
        GlobalEventExtend = onEventExtend
    });
    u1:FireServer("RequestActiveGlobalEvents");
end;

return v8;