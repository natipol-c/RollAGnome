--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CameraShakePresets
  Path:     game.ReplicatedStorage.Library.Imported.CameraShaker.CameraShakePresets
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

local CameraShakeInstance = require(script.Parent.CameraShakeInstance);
local u11 = {
    Snap = function() -- Line: 23, Name: Snap
        -- upvalues: CameraShakeInstance (copy)
        local v1 = CameraShakeInstance.new(1.08, 1.6, 0.08, 0.08);
        v1.PositionInfluence = Vector3.new(0.1, 0.1, 0.1);
        v1.RotationInfluence = Vector3.new(0, 0.35, 0.35);

        return v1;
    end,

    Swing = function() -- Line: 30, Name: Swing
        -- upvalues: CameraShakeInstance (copy)
        local v2 = CameraShakeInstance.new(1.1, 2, 0.1, 0.5);
        v2.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v2.RotationInfluence = Vector3.new(0, 0.5, 0.5);

        return v2;
    end,

    Bump = function() -- Line: 39, Name: Bump
        -- upvalues: CameraShakeInstance (copy)
        local v3 = CameraShakeInstance.new(0.75, 4, 0.1, 0.75);
        v3.PositionInfluence = Vector3.new(0.15, 0.15, 0.15);
        v3.RotationInfluence = Vector3.new(1, 1, 1);

        return v3;
    end,

    Explosion = function() -- Line: 49, Name: Explosion
        -- upvalues: CameraShakeInstance (copy)
        local v4 = CameraShakeInstance.new(3, 4, 0, 1.5);
        v4.PositionInfluence = Vector3.new(0.2, 0.2, 0.2);
        v4.RotationInfluence = Vector3.new(1, 1, 1);

        return v4;
    end,

    Earthquake = function() -- Line: 59, Name: Earthquake
        -- upvalues: CameraShakeInstance (copy)
        local v5 = CameraShakeInstance.new(0.6, 3.5, 2, 10);
        v5.PositionInfluence = Vector3.new(0.25, 0.25, 0.25);
        v5.RotationInfluence = Vector3.new(2, 2, 6);

        return v5;
    end,

    BadTrip = function() -- Line: 69, Name: BadTrip
        -- upvalues: CameraShakeInstance (copy)
        local v6 = CameraShakeInstance.new(10, 0.15, 5, 10);
        v6.PositionInfluence = Vector3.new(0, 0, 0.15);
        v6.RotationInfluence = Vector3.new(2, 1, 4);

        return v6;
    end,

    HandheldCamera = function() -- Line: 79, Name: HandheldCamera
        -- upvalues: CameraShakeInstance (copy)
        local v7 = CameraShakeInstance.new(1, 0.25, 5, 10);
        v7.PositionInfluence = Vector3.new(0, 0, 0);
        v7.RotationInfluence = Vector3.new(1, 0.5, 0.5);

        return v7;
    end,

    Vibration = function() -- Line: 89, Name: Vibration
        -- upvalues: CameraShakeInstance (copy)
        local v8 = CameraShakeInstance.new(0.4, 20, 2, 2);
        v8.PositionInfluence = Vector3.new(0, 0.15, 0);
        v8.RotationInfluence = Vector3.new(1.25, 0, 4);

        return v8;
    end,

    RoughDriving = function() -- Line: 99, Name: RoughDriving
        -- upvalues: CameraShakeInstance (copy)
        local v9 = CameraShakeInstance.new(1, 2, 1, 1);
        v9.PositionInfluence = Vector3.new(0, 0, 0);
        v9.RotationInfluence = Vector3.new(1, 1, 1);

        return v9;
    end,

    UnlockPortal = function() -- Line: 106, Name: UnlockPortal
        -- upvalues: CameraShakeInstance (copy)
        local v10 = CameraShakeInstance.new(6, 6, 0.5, 1.5);
        v10.PositionInfluence = Vector3.new(0.2, 0.2, 0.2);
        v10.RotationInfluence = Vector3.new(1, 1, 1);

        return v10;
    end
};

return setmetatable({}, {
    __index = function(p12, p13) -- Line: 117, Name: __index
        -- upvalues: u11 (copy)
        local v14 = u11[p13];

        if type(v14) == "function" then
            return v14();
        end;

        error("No preset found with index \"" .. p13 .. "\"");
    end
});