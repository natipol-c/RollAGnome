--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     untrack
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.untrack
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local get_scope = require(script.Parent.graph).get_scope;

return function(p1) -- Line: 7, Name: untrack
    -- upvalues: get_scope (copy)
    local v2 = get_scope();

    if not v2 then
        return p1();
    end;

    local effect = v2.effect;
    v2.effect = false;
    local success, result = pcall(p1);
    v2.effect = effect;

    if not success then
        error(result, 0);
    end;

    return result;
end;