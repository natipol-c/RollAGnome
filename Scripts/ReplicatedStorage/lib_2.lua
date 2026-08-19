--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     lib
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_vm.0.2.1.conch_vm.src.lib
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

require("../roblox_packages/types");

local function error_handler(p1) -- Line: 8
    error(p1);
end;

local function LOG(...) -- Line: 10
end;

return function() -- Line: 15, Name: create_vm
    -- upvalues: LOG (copy)
    local u2 = os.clock();
    local u3 = {};
    local u4 = {};
    local u5 = {};
    local u6 = table.create(255);
    local u7 = 1;
    local u8 = 0;
    local u9 = 0;

    local function PUSH(p10) -- Line: 25
        -- upvalues: u6 (ref), u9 (ref)
        u6[u9 + 1] = p10;
        u9 = u9 + 1;
    end;

    local function POP() -- Line: 31
        -- upvalues: u9 (ref), u6 (ref)
        u9 = u9 - 1;

        return u6[u9 + 1];
    end;

    local function POPN(p11) -- Line: 37
        -- upvalues: u9 (ref), u6 (ref)
        local v12 = u9;
        local v13 = u9 - p11 + 1;
        u9 = u9 - p11;

        return unpack(u6, v13, v12);
    end;

    local function GET(p14) -- Line: 45
        -- upvalues: u9 (ref), u6 (ref)
        if p14 < 0 then
            p14 = u9 + p14 + 1;
        end;

        if u9 < p14 then
            return nil;
        end;

        return u6[p14];
    end;

    local function call_success(p15, p16, p17, ...) -- Line: 51
        -- upvalues: u6 (ref), u9 (ref)
        if not p17 then
            error(`{table.concat({ ... }, " ")}`, 0);
        end;

        for i = 1, math.min(p15, select("#", ...)) do
            local v18 = select(i, ...);
            u6[u9 + 1] = v18;
            u9 = u9 + 1;
        end;
    end;

    local function process(u19) -- Line: 64
        -- upvalues: u2 (ref), POPN (copy), u9 (ref), u6 (ref), call_success (copy), u7 (ref), u5 (ref), u3 (ref), u4 (ref), u8 (ref), process (copy), LOG (ref)
        if os.clock() > u2 + 30 then
            error("reached execution time limit", 0);
        end;

        if u19.kind == "call" then
            local v20 = { POPN(u19.arguments) };
            u9 = u9 - 1;
            local v21 = u6[u9 + 1];
            call_success(u19.results, typeof(v21), pcall(v21, unpack(v20)));

            return;
        end;

        if u19.kind == "goto" then
            u7 = u19.to - 1;

            return;
        end;

        if u19.kind ~= "index" then
            if u19.kind == "jump_if" then
                u9 = u9 - 1;

                if not u6[u9 + 1] then
                    u7 = u19.to - 1;
                    u9 = 0;

                    return;
                end;
            elseif u19.kind == "jump_if_not_nil" then
                local v22 = 1;

                if v22 < 0 then
                    v22 = u9 + v22 + 1;
                end;

                local v23;

                if u9 < v22 then
                    v23 = nil;
                else
                    v23 = u6[v22];
                end;

                if v23 == nil then
                    u7 = u19.to - 1;
                    u9 = 0;

                    return;
                end;
            else
                if u19.kind == "push_boolean" then
                    u6[u9 + 1] = u19.b;
                    u9 = u9 + 1;

                    return;
                end;

                if u19.kind == "push_cmd" then
                    u6[u9 + 1] = u5[u19.name];
                    u9 = u9 + 1;

                    return;
                end;

                if u19.kind == "push_function" then
                    local body = u19.body;

                    u6[u9 + 1] = function(...) -- Line: 106, Name: VM_FN
                        -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u9 (ref), u7 (ref), u8 (ref), u19 (copy), body (copy), process (ref)
                        local v24 = {
                            start = u2,
                            locals = u3,
                            globals = u4,
                            commands = u5,
                            stack = u6,
                            n = u9,
                            instruction_at = u7,
                            instruction_end = u8
                        };
                        local v25 = { ... };
                        u3 = {};
                        u2 = os.clock();
                        u6 = v25;
                        u9 = u19.arguments;
                        u7 = 1;
                        u8 = #body;

                        while u7 <= u8 do
                            process(body[u7]);
                            u7 = u7 + 1;
                        end;

                        u3 = v24.locals;
                        u4 = v24.globals;
                        u5 = v24.commands;
                        u6 = v24.stack;
                        u2 = v24.start;
                        u9 = v24.n;
                        u7 = v24.instruction_at;
                        u8 = v24.instruction_end;

                        return unpack(v25, 1, u9);
                    end;

                    u9 = u9 + 1;

                    return;
                end;

                if u19.kind == "push_global" then
                    u6[u9 + 1] = u4[u19.name];
                    u9 = u9 + 1;

                    return;
                end;

                if u19.kind == "push_vector" then
                    u9 = u9 - 1;
                    local v26 = u6[u9 + 1];
                    u9 = u9 - 1;
                    local v27 = u6[u9 + 1];
                    u9 = u9 - 1;
                    local v28 = vector.create(u6[u9 + 1], v27, v26);
                    u6[u9 + 1] = v28;
                    u9 = u9 + 1;

                    return;
                end;

                if u19.kind == "push_local" then
                    u6[u9 + 1] = u3[u19.index];
                    u9 = u9 + 1;

                    return;
                end;

                if u19.kind == "push_nil" then
                    u6[u9 + 1] = nil;
                    u9 = u9 + 1;

                    return;
                end;

                if u19.kind == "push_number" then
                    u6[u9 + 1] = u19.n;
                    u9 = u9 + 1;

                    return;
                end;

                if u19.kind == "push_string" then
                    u6[u9 + 1] = u19.s;
                    u9 = u9 + 1;

                    return;
                end;

                if u19.kind == "push_table" then
                    local v29 = table.create(u19.alloc);
                    u6[u9 + 1] = v29;
                    u9 = u9 + 1;

                    return;
                end;

                if u19.kind == "set_global" then
                    u9 = u9 - 1;
                    u4[u19.name] = u6[u9 + 1];

                    return;
                end;

                if u19.kind == "set_local" then
                    u9 = u9 - 1;
                    u3[u19.index] = u6[u9 + 1];

                    return;
                end;

                if u19.kind == "set_table" then
                    u9 = u9 - 1;
                    local v30 = u6[u9 + 1];
                    u9 = u9 - 1;
                    local v31 = u9;

                    if v31 < 0 then
                        v31 = u9 + v31 + 1;
                    end;

                    local v32;

                    if u9 < v31 then
                        v32 = nil;
                    else
                        v32 = u6[v31];
                    end;

                    v32[u6[u9 + 1]] = v30;

                    return;
                end;

                if u19.kind == "return" then
                    LOG("stack", #u6, u6[1]);
                    u7 = u8;

                    return;
                end;

                if u19.kind == "reset" then
                    u9 = 0;

                    return;
                end;

                if u19.kind == "turn-into-iterator" then
                    u9 = u9 - 1;
                    local u33 = u6[u9 + 1];

                    if typeof(u33) == "table" then
                        local v34 = pairs;
                        local v35 = getmetatable(u33);

                        if typeof(v35) == "table" then
                            local _ = v35.__iter or v34;
                        end;

                        local u36 = pairs(u33);
                        local u37 = {};

                        u6[u9 + 1] = function() -- Line: 194
                            -- upvalues: u36 (copy), u33 (copy), u37 (ref)
                            local v38 = { u36(u33, unpack(u37)) };
                            u37 = v38;

                            return unpack(v38);
                        end;

                        u9 = u9 + 1;

                        return;
                    end;

                    u6[u9 + 1] = u33;
                    u9 = u9 + 1;
                end;
            end;

            return;
        end;

        local v39 = u9;
        local v40 = u9 - 2 + 1;
        u9 = u9 - 2;
        local v41, u42 = unpack(u6, v40, v39);
        local u43 = v41;
        local success, result = pcall(function() -- Line: 81
            -- upvalues: u43 (copy), u42 (copy)
            return u43[u42];
        end);

        if not success then
            error(`attempt to index {typeof(u43)} with {tostring(u42)}`, 0);
        end;

        u6[u9 + 1] = result;
        u9 = u9 + 1;
    end;

    local function run(p44) -- Line: 205
        -- upvalues: u2 (ref), u7 (ref), u8 (ref), process (copy), u9 (ref), u6 (ref)
        u2 = os.clock();
        u7 = 1;
        u8 = #p44;

        while u7 <= u8 do
            process(p44[u7]);
            u7 = u7 + 1;
        end;

        local v45 = u9;
        u9 = 0;

        return v45, unpack(u6, 1, v45);
    end;

    u2 = os.clock();

    return {
        commands = u5,
        globals = u4,
        locals = u3,
        run = run
    };
end;