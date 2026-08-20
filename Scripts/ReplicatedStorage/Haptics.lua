--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Haptics
  Path:     game.ReplicatedStorage.Library.Haptics
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:42:59 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local HapticService = game:GetService("HapticService");
local _ = Players.LocalPlayer;
local v1 = {};

function _G.Haptic(p2, p3, p4) -- Line: 25
    -- upvalues: HapticService (copy)
    if not _G.Vibrations then
        return;
    end;

    local Large = Enum.VibrationMotor.Large;
    local v5 = 0.033;
    local v6 = 0.4;

    if HapticService:IsMotorSupported(Enum.UserInputType.Gamepad1, Large) then
        HapticService:SetMotor(Enum.UserInputType.Gamepad1, Large, v6);
        task.wait(v5);
        HapticService:SetMotor(Enum.UserInputType.Gamepad1, Large, 0);
    end;
end;

function v1.HitMarker(p7) -- Line: 38
    -- upvalues: HapticService (copy)
    task.spawn(function() -- Line: 39
        -- upvalues: HapticService (ref)
        if not _G.Vibrations then
            return;
        end;

        local Large = Enum.VibrationMotor.Large;
        local v8 = 0.04;
        local v9 = 0.35;

        if HapticService:IsMotorSupported(Enum.UserInputType.Gamepad1, Large) then
            HapticService:SetMotor(Enum.UserInputType.Gamepad1, Large, v9);
            task.wait(v8);
            HapticService:SetMotor(Enum.UserInputType.Gamepad1, Large, 0);
        end;
    end);
end;

return v1;