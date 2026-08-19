--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     lib
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_compiler.0.2.2.conch_compiler.src.lib
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

require("../roblox_packages/types");

local function DEFINE_LOCAL(p1, p2) -- Line: 11
    table.insert(p1.locals, p2);
end;

local function compile(p3, u4) -- Line: 29
    -- upvalues: compile (copy)
    local instructions = u4.instructions;
    local u5 = #instructions + 1;
    local u6 = false;

    local function INSERT(p7) -- Line: 34
        -- upvalues: instructions (copy), u5 (ref)
        instructions[u5] = p7;
        u5 = u5 + 1;
    end;

    local function GET_VALUE(p8) -- Line: 39
        -- upvalues: u4 (copy), instructions (copy), u5 (ref)
        local v9 = table.find(u4.locals, p8);

        if v9 then
            instructions[u5] = {
                kind = "push_local",
                index = v9
            };
            u5 = u5 + 1;

            return;
        end;

        instructions[u5] = {
            kind = "push_global",
            name = p8
        };
        u5 = u5 + 1;
    end;

    local function SET_VALUE(p10) -- Line: 48
        -- upvalues: u4 (copy), instructions (copy), u5 (ref)
        local v11 = table.find(u4.locals, p10);

        if v11 then
            instructions[u5] = {
                kind = "set_local",
                index = v11
            };
            u5 = u5 + 1;

            return;
        end;

        instructions[u5] = {
            kind = "set_global",
            name = p10
        };
        u5 = u5 + 1;
    end;

    local u12 = nil;
    local u13 = nil;
    local u14 = nil;
    local u15 = nil;
    local u16 = nil;
    local u17 = nil;

    local function compile_expression(p18) -- Line: 70
        -- upvalues: instructions (copy), u5 (ref), u13 (ref), compile_expression (ref), u14 (ref), u12 (ref), u15 (ref), u17 (ref)
        if p18.kind == "boolean" then
            instructions[u5] = {
                kind = "push_boolean",
                b = p18.token.kind == "true"
            };
            u5 = u5 + 1;

            return;
        end;

        if p18.kind ~= "number" then
            if p18.kind == "evaluate" then
                if p18.body.kind == "command" then
                    u13(p18.body, 1);

                    return;
                end;

                compile_expression(p18.body);

                return;
            end;

            if p18.kind == "lambda" then
                u14(p18.body);

                return;
            end;

            if p18.kind == "nil" then
                instructions[u5] = {
                    kind = "push_nil"
                };
                u5 = u5 + 1;

                return;
            end;

            if p18.kind == "string" then
                instructions[u5] = {
                    kind = "push_string",
                    s = string.sub(p18.token.text, 2, -2)
                };
                u5 = u5 + 1;

                return;
            end;

            if p18.kind == "table" then
                u12(p18.table);

                return;
            end;

            if p18.kind == "var" then
                u15(p18.var);

                return;
            end;

            if p18.kind == "vector" then
                u17(p18);
            end;

            return;
        end;

        local v19 = string.gsub(p18.token.text, "_", "");
        local v20 = string.sub(p18.token.text, 2);
        local v21 = v20 == "0b" and 2 or (v20 == "0x" and 16 or 10);

        if v21 ~= 10 then
            v19 = string.sub(v19, 3);
        end;

        local v22 = tonumber(v19, v21);

        if not v22 then
            error(`{p18.token.text} could not be converted into a number`, 0);
        end;

        instructions[u5] = {
            kind = "push_number",
            n = v22
        };
        u5 = u5 + 1;
    end;

    u17 = function(p23) -- Line: 119, Name: compile_vector
        -- upvalues: compile_expression (ref), instructions (copy), u5 (ref)
        local v24 = p23.contents[1];
        local v25 = p23.contents[2];
        local v26 = p23.contents[3];

        if v24 then
            compile_expression(v24);
        else
            instructions[u5] = {
                kind = "push_number",
                n = 0
            };
            u5 = u5 + 1;
        end;

        if v25 then
            compile_expression(v25);
        else
            instructions[u5] = {
                kind = "push_number",
                n = 0
            };
            u5 = u5 + 1;
        end;

        if v26 then
            compile_expression(v26);
        else
            instructions[u5] = {
                kind = "push_number",
                n = 0
            };
            u5 = u5 + 1;
        end;

        instructions[u5] = {
            kind = "push_vector"
        };
        u5 = u5 + 1;
    end;

    u12 = function(p27) -- Line: 145, Name: compile_table
        -- upvalues: instructions (copy), u5 (ref), compile_expression (ref)
        instructions[u5] = {
            kind = "push_table",
            alloc = 1
        };
        u5 = u5 + 1;
        local v28 = 1;

        for _, v in p27.fields do
            if v.kind == "exprkey" then
                compile_expression(v.key);
                compile_expression(v.value);
                instructions[u5] = {
                    kind = "set_table"
                };
                u5 = u5 + 1;
            elseif v.kind == "namekey" then
                instructions[u5] = {
                    kind = "push_string",
                    s = v.name.text
                };
                u5 = u5 + 1;
                compile_expression(v.value);
                instructions[u5] = {
                    kind = "set_table"
                };
                u5 = u5 + 1;
            elseif v.kind == "nokey" then
                instructions[u5] = {
                    kind = "push_number",
                    n = v28
                };
                u5 = u5 + 1;
                compile_expression(v.value);
                instructions[u5] = {
                    kind = "set_table"
                };
                u5 = u5 + 1;
                v28 = v28 + 1;
            end;
        end;
    end;

    u13 = function(p29, p30) -- Line: 167, Name: compile_command
        -- upvalues: u15 (ref), compile_expression (ref), instructions (copy), u5 (ref)
        u15(p29.prefix);

        for _, v in p29.arguments do
            compile_expression(v);
        end;

        instructions[u5] = {
            kind = "call",
            arguments = #p29.arguments,
            results = p30 or (1 / 0)
        };
        u5 = u5 + 1;
    end;

    u14 = function(p31) -- Line: 180, Name: compile_lambda
        -- upvalues: u4 (copy), compile (ref), instructions (copy), u5 (ref)
        local v32 = {
            locals = {},
            upvalues = {},
            instructions = {},
            up = u4
        };

        for i, v in p31.arguments do
            table.insert(v32.locals, v.text);
            table.insert(v32.instructions, {
                kind = "set_local",
                index = i
            });
        end;

        compile(p31.block, v32);
        instructions[u5] = {
            kind = "push_function",
            body = v32.instructions,
            arguments = #p31.arguments
        };
        u5 = u5 + 1;
    end;

    u15 = function(p33) -- Line: 201, Name: compile_var
        -- upvalues: instructions (copy), u5 (ref), GET_VALUE (copy), u13 (ref), compile_expression (ref)
        local prefix = p33.prefix;

        if prefix.kind == "global" then
            instructions[u5] = {
                kind = "push_cmd",
                name = prefix.token.text
            };
            u5 = u5 + 1;
        elseif prefix.kind == "name" then
            GET_VALUE(prefix.name.text);
        elseif prefix.kind == "paren" then
            if prefix.expr.kind == "command" then
                u13(prefix.expr);
            else
                compile_expression(prefix.expr);
            end;
        end;

        for _, v in p33.suffixes do
            if v.kind == "exprindex" then
                if v.expr.kind == "command" then
                    u13(v.expr, 1);
                else
                    compile_expression(v.expr);
                end;

                instructions[u5] = {
                    kind = "index"
                };
                u5 = u5 + 1;
            elseif v.kind == "nameindex" then
                instructions[u5] = {
                    kind = "push_string",
                    s = v.name.text
                };
                u5 = u5 + 1;
                instructions[u5] = {
                    kind = "index"
                };
                u5 = u5 + 1;
            end;
        end;
    end;

    local function compile_assignment(p34) -- Line: 231
        -- upvalues: u13 (ref), compile_expression (ref), instructions (copy), u5 (ref)
        local text = p34.left.text;
        local right = p34.right;

        if right.kind == "command" then
            u13(right);
        else
            compile_expression(right);
        end;

        instructions[u5] = {
            kind = "set_global",
            name = text
        };
        u5 = u5 + 1;
    end;

    local function compile_last(p35) -- Line: 243
        -- upvalues: u13 (ref), compile_expression (ref), instructions (copy), u5 (ref), u6 (ref)
        if p35.kind == "return" then
            for _, v in p35.values do
                if v.kind == "command" then
                    u13(v);
                else
                    compile_expression(v);
                end;
            end;

            instructions[u5] = {
                kind = "return"
            };
            u5 = u5 + 1;

            return;
        end;

        if p35.kind == "break" then
            assert(u6, "cannot use continue outside a loop");
            instructions[u5] = {
                kind = "goto-pending",
                type = "break"
            };
            u5 = u5 + 1;

            return;
        end;

        if p35.kind ~= "continue" then
            error((`unimplemented {p35.kind}`));

            return;
        end;

        assert(u6, "cannot use continue outside a loop");
        instructions[u5] = {
            kind = "goto",
            to = u6
        };
        u5 = u5 + 1;
    end;

    local function compile_if(p36) -- Line: 266
        -- upvalues: u5 (ref), u13 (ref), compile_expression (ref), instructions (copy), u16 (ref)
        local v37 = u5;

        for _, v in p36.ifs do
            local v38 = u5;

            if v.condition.kind == "command" then
                u13(v.condition, 1);
            else
                compile_expression(v.condition);
            end;

            instructions[u5] = {
                kind = "goto-pending",
                type = "next-if"
            };
            u5 = u5 + 1;
            u16(v.block);
            instructions[u5] = {
                kind = "goto-pending",
                type = "if-end"
            };
            u5 = u5 + 1;

            for i = u5 - 1, v38, -1 do
                local v39 = instructions[i];

                if v39.kind == "goto-pending" and v39.type == "next-if" then
                    instructions[i] = {
                        kind = "jump_if",
                        to = u5
                    };
                end;
            end;
        end;

        if p36.fallback then
            u16(p36.fallback);
        end;

        for i = u5 - 1, v37, -1 do
            local v40 = instructions[i];

            if v40.kind == "goto-pending" and v40.type == "if-end" then
                instructions[i] = {
                    kind = "goto",
                    to = u5
                };
            end;
        end;
    end;

    local function compile_for(p41) -- Line: 304
        -- upvalues: u6 (ref), u13 (ref), compile_expression (ref), instructions (copy), u5 (ref), SET_VALUE (copy), GET_VALUE (copy), u16 (ref)
        local v42 = #p41.call.arguments;
        local v43 = u6;

        if p41.expression.kind == "command" then
            u13(p41.expression, 1);
        else
            compile_expression(p41.expression);
        end;

        instructions[u5] = {
            kind = "turn-into-iterator"
        };
        u5 = u5 + 1;
        SET_VALUE("--iterator");
        local v44 = u5;
        u6 = v44;
        GET_VALUE("--iterator");
        instructions[u5] = {
            kind = "call",
            arguments = 0,
            results = math.max(1, v42)
        };
        u5 = u5 + 1;
        local v45 = {
            kind = "jump_if_not_nil",
            index = 1,
            to = 0
        };
        instructions[u5] = v45;
        u5 = u5 + 1;
        local v46 = u5;

        for i = #p41.call.arguments, 1, -1 do
            SET_VALUE(p41.call.arguments[i].text);
        end;

        instructions[u5] = {
            kind = "reset"
        };
        u5 = u5 + 1;
        u16(p41.call.block);
        instructions[u5] = {
            kind = "goto",
            to = v44
        };
        u5 = u5 + 1;
        v45.to = u5;

        for i = u5 - 1, v46, -1 do
            local v47 = instructions[i];

            if v47.kind == "goto-pending" and v47.type == "break" then
                instructions[i] = {
                    kind = "goto",
                    to = u5
                };
            end;
        end;

        u6 = v43;
    end;

    local function compile_while(p48) -- Line: 348
        -- upvalues: u5 (ref), u6 (ref), u13 (ref), compile_expression (ref), instructions (copy), u16 (ref)
        local v49 = u5;
        local v50 = u6;
        u6 = v49;

        if p48.expression.kind == "command" then
            u13(p48.expression, 0);
        else
            compile_expression(p48.expression);
        end;

        local v51 = {
            kind = "jump_if",
            index = 1,
            to = 0
        };
        instructions[u5] = v51;
        u5 = u5 + 1;
        local v52 = u5;
        u16(p48.block);
        instructions[u5] = {
            kind = "goto",
            to = v49
        };
        u5 = u5 + 1;
        v51.to = u5;

        for i = u5 - 1, v52, -1 do
            local v53 = instructions[i];

            if v53.kind == "goto-pending" and v53.type == "break" then
                instructions[i] = {
                    kind = "goto",
                    to = u5
                };
            end;
        end;

        u6 = v50;
    end;

    u16 = function(p54) -- Line: 378, Name: compile_block
        -- upvalues: compile_assignment (ref), u4 (copy), u13 (ref), compile_for (ref), compile_if (ref), compile_while (ref), compile_last (ref)
        for i, v in p54.body do
            if v.kind == "assign" then
                compile_assignment(v, u4);
            elseif v.kind == "command" then
                u13(v, (p54.last_statement or i ~= #p54.body) and 0 or 8000);
            elseif v.kind == "for" then
                compile_for(v);
            elseif v.kind == "if" then
                compile_if(v);
            elseif v.kind == "while" then
                compile_while(v);
            else
                error((`not implemented {v.kind}`));
            end;
        end;

        if p54.last_statement then
            compile_last(p54.last_statement);
        end;
    end;

    u16(p3);

    return u4.instructions;
end;

return compile;