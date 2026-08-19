--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TransparencyController
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.TransparencyController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:30 2026
]]

-- Decompiled with Potassium's decompiler.

local VRService = game:GetService("VRService");
local u1 = { "BasePart", "Decal", "Beam", "ParticleEmitter", "Trail", "Fire", "Smoke", "Sparkles", "Explosion" };
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local success, result = pcall(function() -- Line: 27
    return UserSettings():IsUserFeatureEnabled("UserHideCharacterParticlesInFirstPerson");
end);
local u2 = success and result;
local u3 = {};
u3.__index = u3;

function u3.new() -- Line: 38
    -- upvalues: u3 (copy)
    local v4 = setmetatable({}, u3);
    v4.transparencyDirty = false;
    v4.enabled = false;
    v4.lastTransparency = nil;
    v4.descendantAddedConn = nil;
    v4.descendantRemovingConn = nil;
    v4.toolDescendantAddedConns = {};
    v4.toolDescendantRemovingConns = {};
    v4.cachedParts = {};

    return v4;
end;

function u3.HasToolAncestor(p5, p6) -- Line: 54
    if p6.Parent == nil then
        return false;
    end;

    assert(p6.Parent, "");

    return p6.Parent:IsA("Tool") or p5:HasToolAncestor(p6.Parent);
end;

function u3.IsValidPartToModify(p7, p8) -- Line: 60
    -- upvalues: u2 (ref), u1 (copy)
    if u2 then
        for _, v in u1 do
            if p8:IsA(v) then
                return not p7:HasToolAncestor(p8);
            end;
        end;
    elseif p8:IsA("BasePart") or p8:IsA("Decal") then
        return not p7:HasToolAncestor(p8);
    end;

    return false;
end;

function u3.CachePartsRecursive(p9, p10) -- Line: 76
    if p10 then
        if p9:IsValidPartToModify(p10) then
            p9.cachedParts[p10] = true;
            p9.transparencyDirty = true;
        end;

        for _, child in pairs(p10:GetChildren()) do
            p9:CachePartsRecursive(child);
        end;
    end;
end;

function u3.TeardownTransparency(p11) -- Line: 88
    for i, _ in pairs(p11.cachedParts) do
        i.LocalTransparencyModifier = 0;
    end;

    p11.cachedParts = {};
    p11.transparencyDirty = true;
    p11.lastTransparency = nil;

    if p11.descendantAddedConn then
        p11.descendantAddedConn:disconnect();
        p11.descendantAddedConn = nil;
    end;

    if p11.descendantRemovingConn then
        p11.descendantRemovingConn:disconnect();
        p11.descendantRemovingConn = nil;
    end;

    for i, v in pairs(p11.toolDescendantAddedConns) do
        v:Disconnect();
        p11.toolDescendantAddedConns[i] = nil;
    end;

    for i, v in pairs(p11.toolDescendantRemovingConns) do
        v:Disconnect();
        p11.toolDescendantRemovingConns[i] = nil;
    end;
end;

function u3.SetupTransparency(u12, u13) -- Line: 114
    u12:TeardownTransparency();

    if u12.descendantAddedConn then
        u12.descendantAddedConn:disconnect();
    end;

    u12.descendantAddedConn = u13.DescendantAdded:Connect(function(p14) -- Line: 118
        -- upvalues: u12 (copy), u13 (copy)
        if not u12:IsValidPartToModify(p14) then
            if p14:IsA("Tool") then
                if u12.toolDescendantAddedConns[p14] then
                    u12.toolDescendantAddedConns[p14]:Disconnect();
                end;

                u12.toolDescendantAddedConns[p14] = p14.DescendantAdded:Connect(function(p15) -- Line: 126
                    -- upvalues: u12 (ref)
                    u12.cachedParts[p15] = nil;

                    if p15:IsA("BasePart") or p15:IsA("Decal") then
                        p15.LocalTransparencyModifier = 0;
                    end;
                end);

                if u12.toolDescendantRemovingConns[p14] then
                    u12.toolDescendantRemovingConns[p14]:disconnect();
                end;

                u12.toolDescendantRemovingConns[p14] = p14.DescendantRemoving:Connect(function(p16) -- Line: 134
                    -- upvalues: u13 (ref), u12 (ref)
                    wait();

                    if u13 and (p16 and (p16:IsDescendantOf(u13) and u12:IsValidPartToModify(p16))) then
                        u12.cachedParts[p16] = true;
                        u12.transparencyDirty = true;
                    end;
                end);
            end;

            return;
        end;

        u12.cachedParts[p14] = true;
        u12.transparencyDirty = true;
    end);

    if u12.descendantRemovingConn then
        u12.descendantRemovingConn:disconnect();
    end;

    u12.descendantRemovingConn = u13.DescendantRemoving:connect(function(p17) -- Line: 146
        -- upvalues: u12 (copy)
        if u12.cachedParts[p17] then
            u12.cachedParts[p17] = nil;
            p17.LocalTransparencyModifier = 0;
        end;
    end);
    u12:CachePartsRecursive(u13);
end;

function u3.Enable(p18, p19) -- Line: 157
    if p18.enabled ~= p19 then
        p18.enabled = p19;
    end;
end;

function u3.SetSubject(p20, p21) -- Line: 163
    local v22;

    if p21 and p21:IsA("Humanoid") then
        v22 = p21.Parent;
    else
        v22 = nil;
    end;

    if p21 and (p21:IsA("VehicleSeat") and p21.Occupant) then
        v22 = p21.Occupant.Parent;
    end;

    if v22 then
        p20:SetupTransparency(v22);

        return;
    end;

    p20:TeardownTransparency();
end;

function u3.Update(p23, p24) -- Line: 178
    -- upvalues: CameraUtils (copy), VRService (copy)
    local CurrentCamera = workspace.CurrentCamera;

    if CurrentCamera and p23.enabled then
        local magnitude = (CurrentCamera.Focus.p - CurrentCamera.CoordinateFrame.p).magnitude;
        local v25 = magnitude < 2 and 1 - (magnitude - 0.5) / 1.5 or 0;
        local v26 = v25 < 0.5 and 0 or v25;

        if p23.lastTransparency and (v26 < 1 and p23.lastTransparency < 0.95) then
            local v27 = 2.8 * p24;
            local v28 = math.clamp(v26 - p23.lastTransparency, -v27, v27);
            v26 = p23.lastTransparency + v28;
        else
            p23.transparencyDirty = true;
        end;

        local v29 = CameraUtils.Round(v26, 2);
        local v30 = math.clamp(v29, 0, 1);

        if p23.transparencyDirty or p23.lastTransparency ~= v30 then
            for i, _ in pairs(p23.cachedParts) do
                if VRService.VREnabled and VRService.AvatarGestures then
                    local v31 = {
                        [Enum.AccessoryType.Hat] = true,
                        [Enum.AccessoryType.Hair] = true,
                        [Enum.AccessoryType.Face] = true,
                        [Enum.AccessoryType.Eyebrow] = true,
                        [Enum.AccessoryType.Eyelash] = true
                    };

                    if i.Parent:IsA("Accessory") and v31[i.Parent.AccessoryType] or i.Name == "Head" then
                        i.LocalTransparencyModifier = v30;
                    else
                        i.LocalTransparencyModifier = 0;
                    end;
                else
                    i.LocalTransparencyModifier = v30;
                end;
            end;

            p23.transparencyDirty = false;
            p23.lastTransparency = v30;
        end;
    end;
end;

return u3;