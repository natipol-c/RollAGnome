--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     app.story
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.stories.app.story
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../../roblox_packages/conch");
local u2 = require("../../roblox_packages/vide");
local u3 = require("../app");
local u4 = require("../state");

return function(p5) -- Line: 7
    -- upvalues: u4 (copy), u1 (copy), u2 (copy), u3 (copy)
    u4.opened(true);
    u1.register_default_commands();
    u1._.create_local_user();

    return u2.mount(function() -- Line: 11
        -- upvalues: u3 (ref)
        return u3();
    end, p5);
end;