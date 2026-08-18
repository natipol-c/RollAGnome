--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BaseOcclusion
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.BaseOcclusion
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
setmetatable(u1, {
    __call = function(p2, ...) -- Line: 10, Name: __call
        -- upvalues: u1 (copy)
        return u1.new(...);
    end
});

function u1.new() -- Line: 15
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;

function u1.CharacterAdded(p3, p4, p5) -- Line: 21
end;

function u1.CharacterRemoving(p6, p7, p8) -- Line: 25
end;

function u1.OnCameraSubjectChanged(p9, p10) -- Line: 28
end;

function u1.GetOcclusionMode(p11) -- Line: 32
    warn("BaseOcclusion GetOcclusionMode must be overridden by derived classes");

    return nil;
end;

function u1.Enable(p12, p13) -- Line: 38
    warn("BaseOcclusion Enable must be overridden by derived classes");
end;

function u1.Update(p14, p15, p16, p17) -- Line: 42
    warn("BaseOcclusion Update must be overridden by derived classes");

    return p16, p17;
end;

return u1;