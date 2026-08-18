--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CameraToggleStateController
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.CameraToggleStateController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
game:GetService("UserInputService");
UserSettings():GetService("UserGameSettings");
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUI = require(script.Parent:WaitForChild("CameraUI"));
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local u1 = false;
local u2 = tick();
local u3 = false;
local u4 = false;
local u5 = false;
CameraUI.setCameraModeToastEnabled(false);

return function(p6) -- Line: 20
    -- upvalues: CameraInput (copy), u1 (ref), u3 (ref), u2 (ref), CameraUI (copy), u5 (ref), u4 (ref), CameraUtils (copy)
    local v7 = CameraInput.getTogglePan();

    if p6 and v7 ~= u1 then
        u3 = true;
    end;

    if u1 ~= v7 or tick() - u2 > 3 then
        local v8;

        if v7 then
            v8 = tick() - u2 < 3;
        else
            v8 = v7;
        end;

        CameraUI.setCameraModeToastOpen(v8);

        if v7 then
            u3 = false;
        end;

        u2 = tick();
        u1 = v7;
    end;

    if p6 ~= u5 then
        if p6 then
            u4 = CameraInput.getTogglePan();
            CameraInput.setTogglePan(true);
        elseif not u3 then
            CameraInput.setTogglePan(u4);
        end;
    end;

    if p6 then
        if CameraInput.getTogglePan() then
            CameraUtils.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png");
            CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter);
            CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative);
        else
            CameraUtils.restoreMouseIcon();
            CameraUtils.restoreMouseBehavior();
            CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative);
        end;
    elseif CameraInput.getTogglePan() then
        CameraUtils.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png");
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter);
        CameraUtils.setRotationTypeOverride(Enum.RotationType.MovementRelative);
    elseif CameraInput.getHoldPan() then
        CameraUtils.restoreMouseIcon();
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition);
        CameraUtils.setRotationTypeOverride(Enum.RotationType.MovementRelative);
    else
        CameraUtils.restoreMouseIcon();
        CameraUtils.restoreMouseBehavior();
        CameraUtils.restoreRotationType();
    end;

    u5 = p6;
end;