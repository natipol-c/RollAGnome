--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     bind
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.bind
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:05 2026
]]

-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local graph = require(script.Parent.graph);
local create_node = graph.create_node;
local assert_stable_scope = graph.assert_stable_scope;
local evaluate_node = graph.evaluate_node;

function create_implicit_effect(p1, p2)
    -- upvalues: evaluate_node (copy), create_node (copy), assert_stable_scope (copy)
    evaluate_node(create_node(assert_stable_scope(), p1, p2));
end;

local function update_property_effect(p3) -- Line: 19
    p3.instance[p3.property] = p3.source();

    return p3;
end;

local function update_parent_effect(p4) -- Line: 29
    p4.instance.Parent = p4.parent();

    return p4;
end;

local function update_children_effect(u5) -- Line: 42
    local cur_children_set = u5.cur_children_set;
    local new_children_set = u5.new_children_set;
    local v6 = u5.children();

    local function process_child(p7) -- Line: 52
        -- upvalues: process_child (copy), new_children_set (copy), cur_children_set (copy), u5 (copy)
        if type(p7) == "table" then
            for _, v in next, p7 do
                process_child(v);
            end;

            return;
        end;

        if new_children_set[p7] then
            return;
        end;

        new_children_set[p7] = true;

        if cur_children_set[p7] then
            cur_children_set[p7] = nil;

            return;
        end;

        p7.Parent = u5.instance;
    end;

    process_child(type(v6) ~= "table" and { v6 } or v6);

    for i in next, cur_children_set do
        i.Parent = nil;
    end;

    table.clear(cur_children_set);
    u5.cur_children_set = new_children_set;
    u5.new_children_set = cur_children_set;

    return u5;
end;

return {
    property = function(p8, p9, p10) -- Line: 82, Name: property
        -- upvalues: update_property_effect (copy)
        return create_implicit_effect(update_property_effect, {
            instance = p8,
            property = p9,
            source = p10
        });
    end,

    parent = function(p11, p12) -- Line: 90, Name: parent
        -- upvalues: update_parent_effect (copy)
        return create_implicit_effect(update_parent_effect, {
            instance = p11,
            parent = p12
        });
    end,

    children = function(p13, p14) -- Line: 97, Name: children
        -- upvalues: update_children_effect (copy)
        return create_implicit_effect(update_children_effect, {
            instance = p13,
            cur_children_set = {},
            new_children_set = {},
            children = p14
        });
    end
};