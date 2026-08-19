--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     maps
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.maps
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

local throw = require(script.Parent.throw);
local flags = require(script.Parent.flags);
local graph = require(script.Parent.graph);
local create_node = graph.create_node;
local create_source_node = graph.create_source_node;
local push_child_to_scope = graph.push_child_to_scope;
local update_descendants = graph.update_descendants;
local assert_stable_scope = graph.assert_stable_scope;
local push_scope = graph.push_scope;
local pop_scope = graph.pop_scope;
local evaluate_node = graph.evaluate_node;
local destroy = graph.destroy;

local function check_primitives(p1) -- Line: 20
    -- upvalues: flags (copy), throw (copy)
    if not flags.strict then
        return;
    end;

    for _, v in next, p1 do
        if type(v) ~= "table" and (type(v) ~= "userdata" and type(v) ~= "function") then
            throw("table source map cannot return primitives");
        end;
    end;
end;

local function indexes(u2, u3) -- Line: 29
    -- upvalues: assert_stable_scope (copy), create_node (copy), destroy (copy), push_scope (copy), create_source_node (copy), push_child_to_scope (copy), pop_scope (copy), update_descendants (copy), check_primitives (copy), evaluate_node (copy)
    local v4 = assert_stable_scope();
    local u5 = create_node(v4, false, false);
    local u6 = {};
    local u7 = {};
    local u8 = {};
    local u9 = {};
    local u10 = {};

    local function update_children(p11) -- Line: 39
        -- upvalues: u6 (copy), u9 (copy), destroy (ref), u10 (copy), u7 (copy), u8 (copy), push_scope (ref), u5 (copy), create_node (ref), create_source_node (ref), u3 (copy), push_child_to_scope (ref), pop_scope (ref), update_descendants (ref), check_primitives (ref)
        for i in next, u6 do
            if p11[i] == nil then
                table.insert(u9, i);
            end;
        end;

        for _, v in next, u9 do
            destroy(u10[v]);
            u6[v] = nil;
            u7[v] = nil;
            u8[v] = nil;
            u10[v] = nil;
        end;

        table.clear(u9);
        push_scope(u5);

        for i, v in next, p11 do
            local v12 = u6[i];

            if v12 ~= v then
                if v12 == nil then
                    local v13 = create_node(u5, false, false);
                    u10[i] = v13;
                    local u14 = create_source_node(v);
                    push_scope(v13);
                    local success, result = pcall(u3, function() -- Line: 74
                        -- upvalues: push_child_to_scope (ref), u14 (copy)
                        push_child_to_scope(u14);

                        return u14.cache;
                    end, i);
                    pop_scope();

                    if not success then
                        pop_scope();
                        error(result, 0);
                    end;

                    u8[i] = u14;
                    u7[i] = result;
                else
                    u8[i].cache = v;
                    update_descendants(u8[i]);
                end;

                u6[i] = v;
            end;
        end;

        pop_scope();
        local v15 = table.create(#u10);

        for _, v in next, u7 do
            table.insert(v15, v);
        end;

        check_primitives(v15);

        return v15;
    end;

    local u16 = create_node(v4, function() -- Line: 108
        -- upvalues: update_children (copy), u2 (copy)
        return update_children(u2());
    end, false);
    evaluate_node(u16);

    return function() -- Line: 114
        -- upvalues: push_child_to_scope (ref), u16 (copy)
        push_child_to_scope(u16);

        return u16.cache;
    end;
end;

local function values(u17, u18) -- Line: 120
    -- upvalues: assert_stable_scope (copy), create_node (copy), flags (copy), throw (copy), push_scope (copy), create_source_node (copy), push_child_to_scope (copy), pop_scope (copy), update_descendants (copy), destroy (copy), check_primitives (copy), evaluate_node (copy)
    local v19 = assert_stable_scope();
    local u20 = create_node(v19, false, false);
    local u21 = {};
    local u22 = {};
    local u23 = {};
    local u24 = {};
    local u25 = {};

    local function u34(p26) -- Line: 130
        -- upvalues: u21 (ref), u22 (ref), flags (ref), throw (ref), push_scope (ref), u20 (copy), create_node (ref), u25 (copy), create_source_node (ref), u18 (copy), push_child_to_scope (ref), pop_scope (ref), u24 (copy), u23 (copy), update_descendants (ref), destroy (ref), check_primitives (ref)
        local v27 = u21;
        local v28 = u22;

        if flags.strict then
            local v29 = {};

            for _, v in next, p26 do
                if v29[v] ~= nil then
                    throw("duplicate table value detected");
                end;

                v29[v] = true;
            end;
        end;

        push_scope(u20);

        for i, v in next, p26 do
            v28[v] = i;
            local v30 = v27[v];

            if v30 == nil then
                local v31 = create_node(u20, false, false);
                u25[v] = v31;
                local u32 = create_source_node(i);
                push_scope(v31);
                local success, result = pcall(u18, v, function() -- Line: 159
                    -- upvalues: push_child_to_scope (ref), u32 (copy)
                    push_child_to_scope(u32);

                    return u32.cache;
                end);
                pop_scope();

                if not success then
                    pop_scope();
                    error(result, 0);
                end;

                u24[v] = u32;
                u23[v] = result;
            else
                if v30 ~= i then
                    u24[v].cache = i;
                    update_descendants(u24[v]);
                end;

                v27[v] = nil;
            end;
        end;

        pop_scope();

        for i in next, v27 do
            destroy(u25[i]);
            u23[i] = nil;
            u24[i] = nil;
            u25[i] = nil;
        end;

        table.clear(v27);
        u21 = v28;
        u22 = v27;
        local v33 = table.create(#u25);

        for _, v in next, u23 do
            table.insert(v33, v);
        end;

        check_primitives(v33);

        return v33;
    end;

    local u35 = create_node(v19, function() -- Line: 207
        -- upvalues: u34 (copy), u17 (copy)
        return u34(u17());
    end, false);
    evaluate_node(u35);

    return function() -- Line: 213
        -- upvalues: push_child_to_scope (ref), u35 (copy)
        push_child_to_scope(u35);

        return u35.cache;
    end;
end;

return function() -- Line: 219
    -- upvalues: indexes (copy), values (copy)
    return indexes, values;
end;