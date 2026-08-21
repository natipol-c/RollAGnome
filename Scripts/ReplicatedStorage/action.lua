--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     action
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.action
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:34 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = table.freeze({});

local function is_action(p2) -- Line: 8
    -- upvalues: u1 (copy)
    return getmetatable(p2) == u1;
end;

local function action(p3, p4) -- Line: 12
    -- upvalues: u1 (copy)
    local v5 = {
        priority = p4 or 1,
        callback = p3
    };
    setmetatable(v5, u1);

    return table.freeze(v5);
end;

return function() -- Line: 23
    -- upvalues: action (copy), is_action (copy)
    return action, is_action;
end;