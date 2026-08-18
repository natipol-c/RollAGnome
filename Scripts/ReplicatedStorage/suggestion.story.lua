--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     suggestion.story
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.stories.suggestion.story
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:05 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../../roblox_packages/conch");
local u2 = require("../../roblox_packages/vide");
local u3 = require("../state");
local u4 = require("../components/suggestion");
local source = u2.source;

return function(p5) -- Line: 9
    -- upvalues: u3 (copy), u1 (copy), u2 (copy), u4 (copy), source (copy)
    u3.opened(true);
    u1._.create_local_user();

    return u2.mount(function() -- Line: 13
        -- upvalues: u4 (ref), source (ref)
        return u4({
            highlighted_suggestion = source({
                name = "highlight",
                description = "this argument onmly takes like a vector or something and does this and that i honestly dont care.",
                type = "meow"
            }),
            suggestions = source({ "test", "value", "grapes", "apples" })
        });
    end, p5);
end;