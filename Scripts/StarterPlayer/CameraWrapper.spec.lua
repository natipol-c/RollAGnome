--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CameraWrapper.spec
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CommonUtils.CameraWrapper.spec
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:42 2026
]]

-- Decompiled with Potassium's decompiler.

local CorePackages = game:GetService("CorePackages");
local JestGlobals = require(CorePackages.Packages.Dev.JestGlobals);
local describe = JestGlobals.describe;
local expect = JestGlobals.expect;
local it = JestGlobals.it;
local waitForEvents = require(CorePackages.Workspace.Packages.TestUtils).DeferredLuaHelpers.waitForEvents;
local CameraWrapper = require(script.Parent.CameraWrapper);
describe("CameraWrapper", function() -- Line: 12
    -- upvalues: it (copy), CameraWrapper (copy), expect (copy), waitForEvents (copy)
    it("should instantiate", function() -- Line: 13
        -- upvalues: CameraWrapper (ref), expect (ref)
        expect((CameraWrapper.new())).never.toBeNil();
    end);
    it("should return updated camera", function() -- Line: 19
        -- upvalues: CameraWrapper (ref), expect (ref), waitForEvents (ref)
        local v1 = CameraWrapper.new();
        v1:Enable();
        local Camera = Instance.new("Camera");
        Camera.Parent = game.Workspace;
        expect(v1:getCamera()).toBe(game.Workspace.CurrentCamera);
        expect(v1:getCamera()).never.toBe(Camera);
        game.Workspace.CurrentCamera = Camera;
        waitForEvents();
        expect(v1:getCamera()).toBe(game.Workspace.CurrentCamera);
        expect(v1:getCamera()).toBe(Camera);
    end);
end);