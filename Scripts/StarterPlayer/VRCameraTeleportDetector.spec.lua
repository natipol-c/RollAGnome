--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VRCameraTeleportDetector.spec
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VRCameraTeleportDetector.spec
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:10 2026
]]

-- Decompiled with Potassium's decompiler.

local CorePackages = game:GetService("CorePackages");
local JestGlobals = require(CorePackages.Packages.Dev.JestGlobals);
local describe = JestGlobals.describe;
local expect = JestGlobals.expect;
local it = JestGlobals.it;
local VRCameraTeleportDetector = require(script.Parent.VRCameraTeleportDetector);
local shouldRecenter = VRCameraTeleportDetector.shouldRecenter;
local JUMP_STUDS = VRCameraTeleportDetector.JUMP_STUDS;
local SETTLED_STUDS = VRCameraTeleportDetector.SETTLED_STUDS;
local DEBOUNCE_SECONDS = VRCameraTeleportDetector.DEBOUNCE_SECONDS;
describe("VRCameraTeleportDetector.shouldRecenter", function() -- Line: 14
    -- upvalues: it (copy), expect (copy), shouldRecenter (copy), JUMP_STUDS (copy), SETTLED_STUDS (copy), DEBOUNCE_SECONDS (copy)
    it("fires on a discrete jump from rest (no prior step, never recentered)", function() -- Line: 15
        -- upvalues: expect (ref), shouldRecenter (ref), JUMP_STUDS (ref)
        expect(shouldRecenter(nil, JUMP_STUDS + 10, nil, 100)).toBe(true);
    end);
    it("fires on a discrete jump preceded by a near-still frame", function() -- Line: 19
        -- upvalues: expect (ref), shouldRecenter (ref), SETTLED_STUDS (ref), JUMP_STUDS (ref)
        expect(shouldRecenter(SETTLED_STUDS - 0.5, JUMP_STUDS + 10, nil, 100)).toBe(true);
    end);
    it("does not fire for sub-threshold motion", function() -- Line: 23
        -- upvalues: expect (ref), shouldRecenter (ref), JUMP_STUDS (ref)
        expect(shouldRecenter(0, JUMP_STUDS - 0.1, nil, 100)).toBe(false);
        expect(shouldRecenter(0, 0, nil, 100)).toBe(false);
    end);
    it("does not fire when the previous frame was already moving (continuous motion)", function() -- Line: 28
        -- upvalues: expect (ref), shouldRecenter (ref), SETTLED_STUDS (ref), JUMP_STUDS (ref)
        expect(shouldRecenter(SETTLED_STUDS + 0.1, JUMP_STUDS + 10, nil, 100)).toBe(false);
    end);
    it("does not fire within the debounce interval", function() -- Line: 33
        -- upvalues: expect (ref), shouldRecenter (ref), JUMP_STUDS (ref), DEBOUNCE_SECONDS (ref)
        expect(shouldRecenter(nil, JUMP_STUDS + 10, 100, 100 + DEBOUNCE_SECONDS - 0.01)).toBe(false);
    end);
    it("fires again once the debounce interval has elapsed", function() -- Line: 38
        -- upvalues: expect (ref), shouldRecenter (ref), JUMP_STUDS (ref), DEBOUNCE_SECONDS (ref)
        expect(shouldRecenter(nil, JUMP_STUDS + 10, 100, 100 + DEBOUNCE_SECONDS + 0.01)).toBe(true);
    end);
    it("does not retrigger every frame under continuous per-frame CFrame writes (oscillation guard)", function() -- Line: 43
        -- upvalues: JUMP_STUDS (ref), shouldRecenter (ref), expect (ref)
        local v1 = JUMP_STUDS + 10;
        local v2 = nil;
        local v3 = nil;
        local v4 = 0;
        local v5 = 0;

        for _ = 1, 120 do
            if shouldRecenter(v2, v1, v3, v4) then
                v5 = v5 + 1;
                v3 = v4;
            end;

            v4 = v4 + 0.016666666666666666;
            v2 = v1;
        end;

        expect(v5).toBe(1);
    end);
end);