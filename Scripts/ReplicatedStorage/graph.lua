--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     graph
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.graph
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:02 2026
]]

-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local throw = require(script.Parent.throw);
local flags = require(script.Parent.flags);
local u1 = {
    n = 0
};

local function ycall(p2, p3) -- Line: 27
    local v4 = coroutine.create(xpcall);
    local v6, v7, v8 = coroutine.resume(v4, p2, function(p5) -- Line: 29, Name: efn
        return debug.traceback(p5, 3);
    end, p3);
    assert(v6);

    if coroutine.status(v4) == "dead" then
        return v7, v8;
    end;

    return false, debug.traceback(v4, "attempt to yield in reactive scope");
end;

local function flush_cleanups(p9) -- Line: 83
    -- upvalues: throw (copy)
    if p9.cleanups then
        for _, v in next, p9.cleanups do
            local success, result = pcall(v);

            if not success then
                throw((`cleanup error: {result}`));
            end;
        end;

        table.clear(p9.cleanups);
    end;
end;

local function find_and_swap_pop(p10, p11) -- Line: 94
    local v12 = table.find(p10, p11);
    local v13 = #p10;
    p10[v12] = p10[v13];
    p10[v13] = nil;
end;

local function unparent(p14) -- Line: 101
    local parents = p14.parents;

    for i, v in parents do
        local v15 = table.find(v, p14);
        local v16 = #v;
        v[v15] = v[v16];
        v[v16] = nil;
        parents[i] = nil;
    end;
end;

local function destroy(p17) -- Line: 110
    -- upvalues: flush_cleanups (copy), destroy (copy)
    flush_cleanups(p17);
    local parents = p17.parents;

    for i, v in parents do
        local v18 = table.find(v, p17);
        local v19 = #v;
        v[v18] = v[v19];
        v[v19] = nil;
        parents[i] = nil;
    end;

    if p17.owner then
        local owned = p17.owner.owned;
        local v20 = table.find(owned, p17);
        local v21 = #owned;
        owned[v20] = owned[v21];
        owned[v21] = nil;
        p17.owner = false;
    end;

    if p17.owned then
        local owned = p17.owned;

        while owned[1] do
            destroy(owned[1]);
        end;
    end;
end;

local function destroy_owned(p22) -- Line: 125
    -- upvalues: destroy (copy)
    if p22.owned then
        local owned = p22.owned;

        while owned[1] do
            destroy(owned[1]);
        end;
    end;
end;

local u23 = {
    n = 0
};

local function evaluate_node(p24) -- Line: 134
    -- upvalues: flags (copy), flush_cleanups (copy), destroy (copy), u1 (copy), ycall (copy), u23 (copy), throw (copy)
    if flags.strict then
        local cache = p24.cache;

        for _ = 1, 2 do
            local cache2 = p24.cache;
            flush_cleanups(p24);

            if p24.owned then
                local owned = p24.owned;

                while owned[1] do
                    destroy(owned[1]);
                end;
            end;

            local v25 = u1.n + 1;
            u1.n = v25;
            u1[v25] = p24;
            local v26, v27 = ycall(p24.effect, cache2);
            local n = u1.n;
            u1.n = n - 1;
            u1[n] = nil;

            if not v26 then
                table.clear(u23);
                u23.n = 0;
                throw((`effect stacktrace:\n{v27}`));
            end;

            p24.cache = v27;
        end;

        return cache ~= p24.cache;
    end;

    local cache = p24.cache;
    flush_cleanups(p24);

    if p24.owned then
        local owned = p24.owned;

        while owned[1] do
            destroy(owned[1]);
        end;
    end;

    local v28 = u1.n + 1;
    u1.n = v28;
    u1[v28] = p24;
    local success, result = pcall(p24.effect, p24.cache);
    local n = u1.n;
    u1.n = n - 1;
    u1[n] = nil;

    if not success then
        table.clear(u23);
        u23.n = 0;
        throw((`effect stacktrace:\n{result}\n`));
    end;

    p24.cache = result;

    return cache ~= result;
end;

local function queue_children_for_update(p29) -- Line: 179
    -- upvalues: u23 (copy)
    local n = u23.n;

    while p29[1] do
        n = n + 1;
        u23[n] = p29[1];
        local v30 = p29[1];
        local parents = v30.parents;

        for i, v in parents do
            local v31 = table.find(v, v30);
            local v32 = #v;
            v[v31] = v[v32];
            v[v32] = nil;
            parents[i] = nil;
        end;
    end;

    u23.n = n;
end;

return table.freeze({
    push_scope = function(p33) -- Line: 63, Name: push_scope
        -- upvalues: u1 (copy)
        local v34 = u1.n + 1;
        u1.n = v34;
        u1[v34] = p33;
    end,

    pop_scope = function() -- Line: 69, Name: pop_scope
        -- upvalues: u1 (copy)
        local n = u1.n;
        u1.n = n - 1;
        u1[n] = nil;
    end,

    evaluate_node = evaluate_node,

    get_scope = function() -- Line: 41, Name: get_scope
        -- upvalues: u1 (copy)
        return u1[u1.n];
    end,

    assert_stable_scope = function() -- Line: 45, Name: assert_stable_scope
        -- upvalues: u1 (copy), throw (copy)
        local v35 = u1[u1.n];

        if not v35 then
            return throw((`cannot use {debug.info(2, "n")}() outside a stable or reactive scope`));
        end;

        if v35.effect then
            throw("cannot create a new reactive scope inside another reactive scope");
        end;

        return v35;
    end,

    push_cleanup = function(p36, p37) -- Line: 75, Name: push_cleanup
        if p36.cleanups then
            table.insert(p36.cleanups, p37);

            return;
        end;

        p36.cleanups = { p37 };
    end,

    destroy = destroy,
    flush_cleanups = flush_cleanups,

    push_child_to_scope = function(p38) -- Line: 233, Name: push_child_to_scope
        -- upvalues: u1 (copy)
        local v39 = u1[u1.n];

        if v39 and v39.effect then
            table.insert(p38, v39);
            table.insert(v39.parents, p38);
        end;
    end,

    update_descendants = function(p40) -- Line: 210, Name: update_descendants
        -- upvalues: u23 (copy), flags (copy), evaluate_node (copy)
        local n = u23.n;
        local n2 = u23.n;

        while p40[1] do
            n2 = n2 + 1;
            u23[n2] = p40[1];
            local v41 = p40[1];
            local parents = v41.parents;

            for i, v in parents do
                local v42 = table.find(v, v41);
                local v43 = #v;
                v[v42] = v[v43];
                v[v43] = nil;
                parents[i] = nil;
            end;
        end;

        u23.n = n2;

        if flags.batch then
            return;
        end;

        local v44 = n + 1;

        while v44 <= u23.n do
            local v45 = u23[v44];

            if v45.owner and evaluate_node(v45) then
                local n3 = u23.n;

                while v45[1] do
                    n3 = n3 + 1;
                    u23[n3] = v45[1];
                    local v46 = v45[1];
                    local parents = v46.parents;

                    for i, v in parents do
                        local v47 = table.find(v, v46);
                        local v48 = #v;
                        v[v47] = v[v48];
                        v[v48] = nil;
                        parents[i] = nil;
                    end;
                end;

                u23.n = n3;
            end;

            u23[v44] = false;
            v44 = v44 + 1;
        end;

        u23.n = n;
    end,

    push_child = function(p49, p50) -- Line: 58, Name: push_child
        table.insert(p49, p50);
        table.insert(p50.parents, p49);
    end,

    create_node = function(p51, p52, p53) -- Line: 240, Name: create_node
        local v54 = {
            cleanups = false,
            context = false,
            owned = false,
            cache = p53,
            effect = p52,
            owner = p51,
            parents = {}
        };

        if p51 then
            if p51.owned then
                table.insert(p51.owned, v54);

                return v54;
            end;

            p51.owned = { v54 };
        end;

        return v54;
    end,

    create_source_node = function(p55) -- Line: 265, Name: create_source_node
        return {
            cache = p55
        };
    end,

    get_children = function(p56) -- Line: 269, Name: get_children
        return { unpack(p56) };
    end,

    flush_update_queue = function(p57) -- Line: 193, Name: flush_update_queue
        -- upvalues: u23 (copy), evaluate_node (copy)
        local v58 = p57 + 1;

        while v58 <= u23.n do
            local v59 = u23[v58];

            if v59.owner and evaluate_node(v59) then
                local n = u23.n;

                while v59[1] do
                    n = n + 1;
                    u23[n] = v59[1];
                    local v60 = v59[1];
                    local parents = v60.parents;

                    for i, v in parents do
                        local v61 = table.find(v, v60);
                        local v62 = #v;
                        v[v61] = v[v62];
                        v[v62] = nil;
                        parents[i] = nil;
                    end;
                end;

                u23.n = n;
            end;

            u23[v58] = false;
            v58 = v58 + 1;
        end;

        u23.n = p57;
    end,

    get_update_queue_length = function() -- Line: 189, Name: get_update_queue_length
        -- upvalues: u23 (copy)
        return u23.n;
    end,

    set_context = function(p63, p64, p65) -- Line: 273, Name: set_context
        if p63.context then
            p63.context[p64] = p65;

            return;
        end;

        p63.context = {
            [p64] = p65
        };
    end,

    scopes = u1
});