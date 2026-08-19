--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ConnectionUtil.spec
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CommonUtils.ConnectionUtil.spec
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:30 2026
]]

-- Decompiled with Potassium's decompiler.

local CorePackages = game:GetService("CorePackages");
local JestGlobals = require(CorePackages.Packages.Dev.JestGlobals);
local describe = JestGlobals.describe;
local expect = JestGlobals.expect;
local it = JestGlobals.it;
local Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal;
local ConnectionUtil = require(script.Parent.ConnectionUtil);
describe("ConnectionUtil", function() -- Line: 13
    -- upvalues: it (copy), ConnectionUtil (copy), expect (copy), Signal (copy)
    it("should instantiate", function() -- Line: 14
        -- upvalues: ConnectionUtil (ref), expect (ref)
        expect((ConnectionUtil.new())).never.toBeNil();
    end);
    it("should track a connection", function() -- Line: 20
        -- upvalues: ConnectionUtil (ref), Signal (ref), expect (ref)
        local v1 = ConnectionUtil.new();
        local v2 = Signal.new();
        local u3 = "";
        v1:trackConnection("Signal", v2:Connect(function(p4) -- Line: 27
            -- upvalues: u3 (ref)
            u3 = p4;
        end));
        v2:fire("Testing");
        expect(u3).toBe("Testing");
    end);
    it("should disconnect from signal", function() -- Line: 36
        -- upvalues: ConnectionUtil (ref), Signal (ref), expect (ref)
        local v5 = ConnectionUtil.new();
        local v6 = Signal.new();
        local u7 = "";
        v5:trackConnection("Signal", v6:Connect(function(p8) -- Line: 43
            -- upvalues: u7 (ref)
            u7 = p8;
        end));
        v5:disconnect("Signal");
        v6:fire("Testing");
        expect(u7).toBe("");
    end);
    it("should disconnect from all", function() -- Line: 53
        -- upvalues: ConnectionUtil (ref), Signal (ref), expect (ref)
        local v9 = ConnectionUtil.new();
        local v10 = Signal.new();
        local v11 = Signal.new();
        local v12 = Signal.new();
        local u13 = "";
        local u14 = "";
        local u15 = "";
        v9:trackConnection("Signal", v10:Connect(function(p16) -- Line: 65
            -- upvalues: u13 (ref)
            u13 = p16;
        end));
        v9:trackConnection("Signal1", v11:Connect(function(p17) -- Line: 71
            -- upvalues: u14 (ref)
            u14 = p17;
        end));
        v9:trackConnection("Signal2", v12:Connect(function(p18) -- Line: 77
            -- upvalues: u15 (ref)
            u15 = p18;
        end));
        v9:disconnectAll();
        v10:fire("TestingPrimary");
        v10:fire("TestingSecondary");
        v10:fire("TestingTertiary");
        expect(u13).toBe("");
        expect(u14).toBe("");
        expect(u15).toBe("");
    end);
    it("should call manual disconnect", function() -- Line: 92
        -- upvalues: ConnectionUtil (ref), expect (ref)
        local v19 = ConnectionUtil.new();
        local u20 = "";
        v19:trackBoundFunction("Manual", function() -- Line: 96
            -- upvalues: u20 (ref)
            u20 = "Disconnected";
        end);
        v19:disconnect("Manual");
        expect(u20).toBe("Disconnected");
    end);
end);