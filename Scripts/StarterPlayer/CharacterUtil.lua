--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CharacterUtil
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CommonUtils.CharacterUtil
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:10 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = {
    _connectionUtil = require(script.Parent:WaitForChild("ConnectionUtil")).new(),
    _boundEvents = {},

    getLocalPlayer = function() -- Line: 53, Name: getLocalPlayer
        -- upvalues: Players (copy)
        return Players.LocalPlayer;
    end
};

function u1.onLocalPlayer(p2) -- Line: 57
    -- upvalues: u1 (copy), Players (copy)
    local v3 = u1.getLocalPlayer();

    if v3 then
        p2(v3);
    end;

    u1._connectionUtil:trackConnection("LOCAL_PLAYER", Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function() -- Line: 66
        -- upvalues: u1 (ref)
        local v4 = u1.getLocalPlayer();
        assert(v4);
        u1._getOrCreateBoundEvent("LOCAL_PLAYER"):Fire(v4);
    end));

    return u1._getOrCreateBoundEvent("LOCAL_PLAYER").Event:Connect(p2);
end;

function u1.getCharacter() -- Line: 77
    -- upvalues: u1 (copy)
    local v5 = u1.getLocalPlayer();

    if v5 then
        return v5.Character;
    end;

    return nil;
end;

function u1.onCharacter(u6) -- Line: 85
    -- upvalues: u1 (copy)
    u1._connectionUtil:trackConnection("ON_LOCAL_PLAYER", u1.onLocalPlayer(function(p7) -- Line: 89
        -- upvalues: u1 (ref), u6 (copy)
        local v8 = u1.getCharacter();

        if v8 then
            u6(v8);
        end;

        u1._connectionUtil:trackConnection("CHARACTER_ADDED", p7.CharacterAdded:Connect(function(p9) -- Line: 98
            -- upvalues: u1 (ref)
            assert(p9);
            u1._getOrCreateBoundEvent("CHARACTER_ADDED"):Fire(p9);
        end));
    end));

    return u1._getOrCreateBoundEvent("CHARACTER_ADDED").Event:Connect(u6);
end;

function u1.getChild(p10, p11) -- Line: 110
    -- upvalues: u1 (copy)
    local v12 = u1.getCharacter();

    if not v12 then
        return nil;
    end;

    local v13 = v12:FindFirstChild(p10);

    if v13 and v13:IsA(p11) then
        return v13;
    end;

    return nil;
end;

function u1.onChild(u14, u15, u16) -- Line: 122
    -- upvalues: u1 (copy)
    u1._connectionUtil:trackConnection("ON_CHARACTER", u1.onCharacter(function(p17) -- Line: 126
        -- upvalues: u1 (ref), u14 (copy), u15 (copy), u16 (copy)
        local v18 = u1.getChild(u14, u15);

        if v18 then
            u16(v18);
        end;

        u1._connectionUtil:trackConnection("CHARACTER_CHILD_ADDED", p17.ChildAdded:Connect(function(p19) -- Line: 135
            -- upvalues: u14 (ref), u15 (ref), u1 (ref)
            if p19.Name == u14 and p19:IsA(u15) then
                u1._getOrCreateBoundEvent("CHARACTER_CHILD_ADDED" .. u14 .. u15):Fire(p19);
            end;
        end));
    end));

    return u1._getOrCreateBoundEvent("CHARACTER_CHILD_ADDED" .. u14 .. u15).Event:Connect(u16);
end;

function u1._getOrCreateBoundEvent(p20) -- Line: 149
    -- upvalues: u1 (copy)
    if not u1._boundEvents[p20] then
        u1._boundEvents[p20] = Instance.new("BindableEvent");
    end;

    return u1._boundEvents[p20];
end;

return u1;