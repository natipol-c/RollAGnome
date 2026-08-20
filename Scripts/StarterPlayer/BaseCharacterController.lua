--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BaseCharacterController
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.BaseCharacterController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:10 2026
]]

-- Decompiled with Potassium's decompiler.

local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local ConnectionUtil = require(CommonUtils:WaitForChild("ConnectionUtil"));
local u1 = Vector3.new();
local u2 = {};
u2.__index = u2;

function u2.new() -- Line: 33
    -- upvalues: u2 (copy), u1 (copy), ConnectionUtil (copy)
    local v3 = setmetatable({}, u2);
    v3.enabled = false;
    v3.moveVector = u1;
    v3.moveVectorIsCameraRelative = true;
    v3.isJumping = false;
    v3._connectionUtil = ConnectionUtil.new();

    return v3;
end;

function u2.GetMoveVector(p4) -- Line: 45
    return p4.moveVector;
end;

function u2.IsMoveVectorCameraRelative(p5) -- Line: 49
    return p5.moveVectorIsCameraRelative;
end;

function u2.GetIsJumping(p6) -- Line: 53
    return p6.isJumping;
end;

function u2.Enable(p7, p8) -- Line: 59
    error("BaseCharacterController:Enable must be overridden in derived classes and should not be called.");

    return false;
end;

return u2;