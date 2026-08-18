--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LightingController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.LightingController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local Lighting = game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Network");
Library.get("Game");
local u2 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local Lighting2 = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Lighting");
local u3 = { "Ambient", "Brightness", "ColorShift_Bottom", "ColorShift_Top", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "OutdoorAmbient", "ShadowSoftness", "ClockTime", "GeographicLatitude", "ExposureCompensation", "FogColor", "FogEnd", "FogStart" };
local u4 = { "GlobalShadows" };
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = nil;
local u10 = nil;
local u11 = 0;
local u12 = false;
local u13 = false;
local v14 = {};

local function captureDefaults() -- Line: 55
    -- upvalues: u12 (ref), u3 (copy), Lighting (copy), u5 (copy), u4 (copy), u6 (copy)
    if u12 then
        return;
    end;

    u12 = true;

    for _, v in u3 do
        local success, result = pcall(function() -- Line: 62
            -- upvalues: Lighting (ref), v (copy)
            return Lighting[v];
        end);

        if success then
            u5[v] = result;
        end;
    end;

    for _, v in u4 do
        local success, result = pcall(function() -- Line: 71
            -- upvalues: Lighting (ref), v (copy)
            return Lighting[v];
        end);

        if success then
            u5[v] = result;
        end;
    end;

    for _, child in Lighting:GetChildren() do
        u6[child.Name] = child:Clone();
    end;
end;

local function cancelCurrentTween() -- Line: 84
    -- upvalues: u10 (ref)
    if u10 then
        u10:Cancel();
        u10 = nil;
    end;
end;

local function applyFromPreset(p15) -- Line: 91
    -- upvalues: u10 (ref), u7 (ref), u6 (copy), Lighting (copy), u3 (copy), TweenService (copy), u2 (copy), u4 (copy)
    if u10 then
        u10:Cancel();
        u10 = nil;
    end;

    for _, v in u7 do
        if v.Parent then
            v:Destroy();
        end;
    end;

    u7 = {};

    for i, v in u6 do
        if not Lighting:FindFirstChild(i) then
            v:Clone().Parent = Lighting;
        end;
    end;

    local v16 = {};

    for _, v in u3 do
        local v17 = p15:GetAttribute(v);

        if v17 ~= nil then
            v16[v] = v17;
        end;
    end;

    if next(v16) then
        u10 = TweenService:Create(Lighting, u2, v16);
        u10:Play();
    end;

    for _, v in u4 do
        local v18 = p15:GetAttribute(v);

        if v18 ~= nil then
            Lighting[v] = v18;
        end;
    end;

    for _, child in p15:GetChildren() do
        local v19 = Lighting:FindFirstChild(child.Name);

        if v19 then
            v19:Destroy();
        end;

        local v20 = child:Clone();
        v20.Parent = Lighting;
        table.insert(u7, v20);
    end;
end;

local function revertToDefaults() -- Line: 139
    -- upvalues: u10 (ref), u7 (ref), u3 (copy), u5 (copy), TweenService (copy), Lighting (copy), u2 (copy), u4 (copy), u6 (copy)
    if u10 then
        u10:Cancel();
        u10 = nil;
    end;

    for _, v in u7 do
        if v.Parent then
            v:Destroy();
        end;
    end;

    u7 = {};
    local v21 = {};

    for _, v in u3 do
        if u5[v] ~= nil then
            v21[v] = u5[v];
        end;
    end;

    if next(v21) then
        u10 = TweenService:Create(Lighting, u2, v21);
        u10:Play();
    end;

    for _, v in u4 do
        if u5[v] ~= nil then
            Lighting[v] = u5[v];
        end;
    end;

    for i, v in u6 do
        if not Lighting:FindFirstChild(i) then
            v:Clone().Parent = Lighting;
        end;
    end;
end;

local function refresh() -- Line: 175
    -- upvalues: u8 (copy), u9 (ref), Lighting2 (copy), applyFromPreset (copy), revertToDefaults (copy)
    local v22 = nil;
    local v23 = nil;

    for i, v in u8 do
        if not v22 or (v.priority > v22.priority or v.priority == v22.priority and v.order > v22.order) then
            v23 = i;
            v22 = v;
        end;
    end;

    if v22 then
        if u9 ~= v23 then
            u9 = v23;
            local v24 = Lighting2:FindFirstChild(v23);

            if v24 then
                applyFromPreset(v24);

                return;
            end;

            warn("[LightingController] preset not found:", v23);
        end;
    elseif u9 ~= nil then
        u9 = nil;
        revertToDefaults();
    end;
end;

function v14.Apply(p25, p26, p27) -- Line: 207
    -- upvalues: captureDefaults (copy), u11 (ref), u8 (copy), refresh (copy)
    captureDefaults();
    u11 = u11 + 1;
    u8[p26] = {
        priority = p27 or 10,
        order = u11
    };
    refresh();
end;

function v14.Remove(p28, p29) -- Line: 219
    -- upvalues: captureDefaults (copy), u8 (copy), refresh (copy)
    captureDefaults();
    u8[p29] = nil;
    refresh();
end;

local function getCyclePreset() -- Line: 226
    -- upvalues: ReplicatedStorage (copy)
    local v30 = ReplicatedStorage:GetAttribute("IsDay");

    return v30 ~= nil and (v30 and "Day" or "Night") or nil;
end;

function v14.Initialize(u31) -- Line: 235
    -- upvalues: u13 (ref), captureDefaults (copy), u1 (copy), ReplicatedStorage (copy), u9 (ref)
    if u13 then
        return;
    end;

    u13 = true;
    captureDefaults();
    u1:BindEvents({
        ChangeLighting = function(...) -- Line: 245, Name: ChangeLighting
            -- upvalues: u31 (copy)
            u31:Apply(...);
        end
    });
    local v32 = ReplicatedStorage:GetAttribute("IsDay");
    local v33 = v32 ~= nil and (v32 and "Day" or "Night") or nil;

    if u9 == nil and v33 then
        u31:Apply(v33, 10);
    end;
end;

return v14;