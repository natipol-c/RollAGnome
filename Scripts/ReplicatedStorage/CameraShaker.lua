--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CameraShaker
  Path:     game.ReplicatedStorage.Library.Imported.CameraShaker
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:00 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require(game.ReplicatedStorage.Library).get("Settings");
local u2 = {};
u2.__index = u2;
local profilebegin = debug.profilebegin;
local profileend = debug.profileend;
local new = CFrame.new;
local Angles = CFrame.Angles;
local rad = math.rad;
local u3 = Vector3.new();
local CameraShakeInstance = require(script.CameraShakeInstance);
local CameraShakeState = CameraShakeInstance.CameraShakeState;
u2.CameraShakeInstance = CameraShakeInstance;
u2.Presets = require(script.CameraShakePresets);

function u2.new(p4, p5) -- Line: 88
    -- upvalues: u3 (copy), u2 (copy)
    local v6 = type(p4) == "number";
    assert(v6, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)");
    local v7 = type(p5) == "function";
    assert(v7, "Callback must be a function");

    return setmetatable({
        _running = false,
        _renderName = "CameraShaker",
        _renderPriority = p4,
        _posAddShake = u3,
        _rotAddShake = u3,
        _camShakeInstances = {},
        _removeInstances = {},
        _callback = p5
    }, u2);
end;

function u2.Start(u8) -- Line: 109
    -- upvalues: profilebegin (copy), profileend (copy)
    if u8._running then
        return;
    end;

    u8._running = true;
    local _callback = u8._callback;
    game:GetService("RunService"):BindToRenderStep(u8._renderName, u8._renderPriority, function(p9) -- Line: 113
        -- upvalues: profilebegin (ref), u8 (copy), profileend (ref), _callback (copy)
        profilebegin("CameraShakerUpdate");
        local v10 = u8:Update(p9);
        profileend();
        _callback(v10);
    end);
end;

function u2.Stop(p11) -- Line: 122
    if not p11._running then
        return;
    end;

    game:GetService("RunService"):UnbindFromRenderStep(p11._renderName);
    p11._running = false;
end;

function u2.StopSustained(p12, p13) -- Line: 129
    for _, v in pairs(p12._camShakeInstances) do
        if v.fadeOutDuration == 0 then
            v:StartFadeOut(p13 or v.fadeInDuration);
        end;
    end;
end;

function u2.Update(p14, p15) -- Line: 138
    -- upvalues: u3 (copy), CameraShakeState (copy), new (copy), Angles (copy), rad (copy)
    local v16 = u3;
    local v17 = u3;
    local _camShakeInstances = p14._camShakeInstances;

    for i = 1, #_camShakeInstances do
        local v18 = _camShakeInstances[i];
        local v19 = v18:GetState();

        if v19 == CameraShakeState.Inactive and v18.DeleteOnInactive then
            p14._removeInstances[#p14._removeInstances + 1] = i;
        elseif v19 ~= CameraShakeState.Inactive then
            local v20 = v18:UpdateShake(p15);
            v16 = v16 + v20 * v18.PositionInfluence;
            v17 = v17 + v20 * v18.RotationInfluence;
        end;
    end;

    for i = #p14._removeInstances, 1, -1 do
        table.remove(_camShakeInstances, p14._removeInstances[i]);
        p14._removeInstances[i] = nil;
    end;

    return new(v16) * Angles(0, rad(v17.Y), 0) * Angles(rad(v17.X), 0, (rad(v17.Z)));
end;

function u2.Shake(p21, p22) -- Line: 175
    local v23;

    if type(p22) == "table" then
        v23 = p22._camShakeInstance;
    else
        v23 = false;
    end;

    assert(v23, "ShakeInstance must be of type CameraShakeInstance");
    p21._camShakeInstances[#p21._camShakeInstances + 1] = p22;

    return p22;
end;

function u2.ShakeSustain(p24, p25) -- Line: 182
    -- upvalues: u1 (copy)
    if u1.check("CameraShake") then
        local v26;

        if type(p25) == "table" then
            v26 = p25._camShakeInstance;
        else
            v26 = false;
        end;

        assert(v26, "ShakeInstance must be of type CameraShakeInstance");
        p24._camShakeInstances[#p24._camShakeInstances + 1] = p25;
        p25:StartFadeIn(p25.fadeInDuration);

        return p25;
    end;
end;

function u2.ShakeOnce(p27, p28, p29, p30, p31, p32, p33) -- Line: 192
    -- upvalues: CameraShakeInstance (copy)
    local v34 = CameraShakeInstance.new(p28, p29, p30, p31);
    v34.PositionInfluence = typeof(p32) == "Vector3" and p32 and p32 or Vector3.new(0.15, 0.15, 0.15);
    v34.RotationInfluence = typeof(p33) == "Vector3" and p33 and p33 or Vector3.new(1, 1, 1);
    p27._camShakeInstances[#p27._camShakeInstances + 1] = v34;

    return v34;
end;

function u2.StartShake(p35, p36, p37, p38, p39, p40) -- Line: 201
    -- upvalues: CameraShakeInstance (copy)
    local v41 = CameraShakeInstance.new(p36, p37, p38);
    v41.PositionInfluence = typeof(p39) == "Vector3" and p39 and p39 or Vector3.new(0.15, 0.15, 0.15);
    v41.RotationInfluence = typeof(p40) == "Vector3" and p40 and p40 or Vector3.new(1, 1, 1);
    v41:StartFadeIn(p38);
    p35._camShakeInstances[#p35._camShakeInstances + 1] = v41;

    return v41;
end;

return u2;