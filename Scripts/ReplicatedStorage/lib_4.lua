--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     lib
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_analysis.0.2.2-rc.2.conch_analysis.src.lib
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:01 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("./optional_ast");
require("../roblox_packages/types");

return {
    generate_analysis_info = function(u2) -- Line: 33, Name: generate_analysis_info
        -- upvalues: u1 (copy)
        local u3 = {};
        local where = u2.where;

        local function LOG(p4, p5) -- Line: 56
            -- upvalues: u3 (copy)
            table.insert(u3, {
                kind = p4,
                text = p5
            });
        end;

        local function get_span(p6) -- Line: 60
            local v7;

            if p6.left then
                v7 = p6.left.span.x;
            elseif p6.value then
                v7 = p6.value.span.x;
            else
                v7 = p6.right.span.x;
            end;

            local v8;

            if p6.right then
                v8 = p6.right.span.y;
            elseif p6.value then
                v8 = p6.value.span.y;
            else
                v8 = p6.left.span.y;
            end;

            return vector.create(v7, v8, 0);
        end;

        local function get_text_token(p9) -- Line: 85
            -- upvalues: where (copy)
            return string.sub(p9.text, 1, where - p9.span.x);
        end;

        local function position_relative(p10) -- Line: 91
            -- upvalues: where (copy)
            return where >= p10.x and where <= p10.y and "within" or (where < p10.x and "before" or "after");
        end;

        local u11 = u1(u2.code);

        local function no_suggestions(p12) -- Line: 103
            -- upvalues: where (copy), u3 (copy), u11 (copy)
            local v13 = {
                at = where,
                text = p12,
                logs = u3,
                suggestions = {}
            };
            local v14 = u11;

            if v14 then
                if u11.status == "finished" then
                    v14 = u11.value;
                else
                    v14 = false;
                end;
            end;

            v13.ast = v14;

            return v13;
        end;

        if u11.status == "error" then
            table.insert(u3, {
                kind = "error",
                text = u11.why
            });

            return no_suggestions("");
        end;

        local u15 = nil;
        local u16 = nil;
        local u17 = nil;

        local function process_command(p18, p19) -- Line: 135
            -- upvalues: where (copy), u2 (copy), no_suggestions (copy), u16 (ref), u3 (copy)
            local span = p18.prefix.span;
            local v20 = where >= span.x and where <= span.y and "within" or (where < span.x and "before" or "after");

            if v20 == "within" then
                return process_variable(p18.prefix, p19);
            end;

            if v20 ~= "after" then
                return no_suggestions("");
            end;

            local prefix = p18.prefix.prefix;
            local v21 = nil;

            if prefix.kind == "global" then
                for _, v in u2.commands do
                    if v.name == prefix.token.text then
                        v21 = v;
                        break;
                    end;
                end;
            end;

            if not v21 then
                return no_suggestions("");
            end;

            local v22 = vector.create(p18.prefix.span.y + 1, p18.prefix.span.y + 1);
            local v23 = no_suggestions("");
            local v24 = 1;

            for _, v in p18.arguments do
                local span2 = v.span;
                local v25 = where >= span2.x and where <= span2.y and "within" or (where < span2.x and "before" or "after");

                if v25 == "within" then
                    v22 = v.span;
                    v23 = u16(v);
                    break;
                end;

                if v25 == "after" then
                    v22 = vector.create(v.span.y + 1, v.span.y + 1, 0);
                    v24 = v24 + 1;
                elseif v25 == "before" then
                    break;
                end;
            end;

            local v26 = v21.arguments[v24];

            if #v21.arguments < v24 then
                v26 = v21.arguments[#v21.arguments];

                if v26 and v26.kind ~= "variadic" then
                    if v23.text ~= v23.text:match("%s*") then
                        local v27 = {
                            kind = "warn",
                            text = `no argument #{v24}`
                        };
                        table.insert(u3, v27);
                    end;

                    return v23;
                end;
            end;

            if v26 and v26.suggestion_generator then
                local text = v23.text;
                local v28 = v26.suggestion_generator(text);

                for i, v in v28 do
                    v28[i] = {
                        name = v,
                        type = text,
                        replace = v22,
                        with = v
                    };
                end;

                table.move(v28, 1, #v28, #v23.suggestions + 1, v23.suggestions);
            end;

            v23.analyzing = v23.analyzing or v26;

            return v23;
        end;

        function process_if(p29)
            -- upvalues: get_span (copy), where (copy), u17 (ref), u15 (ref)
            local condition = p29.condition;
            local v30 = get_span(condition);

            if (where >= v30.x and where <= v30.y and "within" or (where < v30.x and "before" or "after")) == "within" then
                return u17(condition.value);
            end;

            if p29.block then
                return u15(p29.block.value);
            end;
        end;

        function parse_if_stat(p31)
            -- upvalues: where (copy), get_span (copy), u15 (ref)
            for _, v in p31.ifs do
                local span = v.span;
                local v32 = where >= span.x and where <= span.y and "within" or (where < span.x and "before" or "after");

                if v32 ~= "before" then
                    if v32 ~= "after" then
                        return process_if(v);
                    end;

                    break;
                end;
            end;

            local fallback = p31.fallback;

            if fallback then
                local v33 = get_span(fallback);

                if (where >= v33.x and where <= v33.y and "within" or (where < v33.x and "before" or "after")) == "within" then
                    return u15(fallback.value);
                end;
            end;
        end;

        local function process_function(p34) -- Line: 253
            -- upvalues: no_suggestions (copy), get_span (copy), where (copy), u15 (ref)
            if not p34.block then
                return no_suggestions("");
            end;

            local v35 = get_span(p34.block);

            if (where >= v35.x and where <= v35.y and "within" or (where < v35.x and "before" or "after")) == "within" then
                return u15(p34.block.value);
            end;

            return no_suggestions("");
        end;

        function process_var_prefix(p36, p37)
            -- upvalues: where (copy), u2 (copy), u17 (ref), u3 (copy), u11 (copy)
            local prefix = p36.prefix;
            local v38 = nil;
            local v39 = nil;
            local v40 = {};

            if prefix.kind == "global" then
                local token = prefix.token;
                v39 = string.sub(token.text, 1, where - token.span.x);

                if p37 and string.sub("true", 1, #v39) == v39 then
                    table.insert(v40, {
                        name = "true",
                        type = "true",
                        with = "true",
                        replace = p36.span
                    });
                end;

                if p37 and string.sub("false", 1, #v39) == v39 then
                    table.insert(v40, {
                        name = "false",
                        type = "false",
                        with = "false",
                        replace = p36.span
                    });
                end;

                if p37 and string.sub("nil", 1, #v39) == v39 then
                    table.insert(v40, {
                        name = "nil",
                        type = "nil",
                        with = "nil",
                        replace = p36.span
                    });
                end;

                if not p37 and string.sub("for", 1, #v39) == v39 then
                    table.insert(v40, {
                        name = "for",
                        type = "for",
                        with = "for",
                        replace = p36.span
                    });
                end;

                if not p37 and string.sub("if", 1, #v39) == v39 then
                    table.insert(v40, {
                        name = "if",
                        type = "if",
                        with = "if",
                        replace = p36.span
                    });
                end;

                if not p37 and string.sub("while", 1, #v39) == v39 then
                    table.insert(v40, {
                        name = "while",
                        type = "while",
                        with = "while",
                        replace = p36.span
                    });
                end;

                if not p37 and string.sub("else", 1, #v39) == v39 then
                    table.insert(v40, {
                        name = "else",
                        type = "else",
                        with = "else",
                        replace = p36.span
                    });
                end;

                for _, v in u2.commands do
                    local v41 = string.lower(v39);
                    local v42 = string.lower(v.name);

                    if string.sub(v42, 1, #v41) == v41 then
                        if #v41 == #v.name then
                            v38 = v;
                        end;

                        table.insert(v40, {
                            type = "Command",
                            name = v.name,
                            description = v.description,
                            replace = p36.span,
                            with = v.name
                        });
                    end;
                end;
            elseif prefix.kind == "name" then
                v39 = prefix.name and (prefix.name.text or "") or "";

                for i, v in u2.variables do
                    local v43 = string.lower(v39);
                    local v44 = string.lower(i);

                    if string.sub(v44, 1, #v43) == v43 then
                        v38 = #v43 == #i and {
                            kind = "argument",
                            name = i,
                            type = typeof(v)
                        } or v38;
                        local v45 = {
                            name = i,
                            type = typeof(v),
                            replace = prefix.name and prefix.name.span or vector.create(prefix.span.x + 1, prefix.span.y),
                            with = i
                        };
                        table.insert(v40, v45);
                    end;
                end;
            elseif prefix.kind == "paren" and prefix.expr.value then
                return u17(prefix.expr.value);
            end;

            return {
                at = where,
                text = v39,
                logs = u3,
                ast = u11.value,
                analyzing = v38,
                suggestions = v40
            };
        end;

        function process_variable(p46, p47)
            -- upvalues: where (copy), no_suggestions (copy), u2 (copy), u3 (copy)
            local span = p46.prefix.span;

            if (where >= span.x and where <= span.y and "within" or (where < span.x and "before" or "after")) == "within" then
                return process_var_prefix(p46, p47);
            end;

            if p46.prefix.kind == "paren" then
                return no_suggestions("");
            end;

            if p46.prefix.kind == "global" then
                return no_suggestions("");
            end;

            local prefix = p46.prefix;
            local v48 = prefix.name and prefix.name.text;

            if not v48 then
                return no_suggestions("");
            end;

            local v49 = u2.variables[v48];
            local v50 = vector.create(p46.span.x, 0);
            local v51 = nil;

            if v49 == nil then
                local v52 = {
                    kind = "warn",
                    text = `no defined variable named "{v48}"`
                };
                table.insert(u3, v52);

                return no_suggestions(v48);
            end;

            for _, v in p46.suffixes do
                if type(v49) ~= "table" and (type(v49) ~= "userdata" and type(v49) ~= "vector") then
                    local v53 = {
                        kind = "warn",
                        text = `probably can't index "{v48}" which is a "{typeof(v49)}"`
                    };
                    table.insert(u3, v53);
                end;

                local span2 = v.span;

                if (where >= span2.x and where <= span2.y and "within" or (where < span2.x and "before" or "after")) == "within" then
                    if v.kind == "nameindex" then
                        v51 = v.name and v.name.text;

                        if not v51 then
                            return no_suggestions(v51);
                        end;

                        v50 = v.name and v.name.span or vector.create(v.span.x + 1, v.span.x + 1);
                    elseif v.kind == "exprindex" then
                        return no_suggestions("");
                    end;

                    break;
                end;

                if v.kind ~= "nameindex" then
                    return no_suggestions("");
                end;

                v51 = v.name and v.name.text;

                if not v51 then
                    return no_suggestions(v51);
                end;

                v49 = v49[v51];
            end;

            local v54 = {};
            local v55 = v49[v51] and {
                kind = "argument",
                name = v51,
                type = typeof(v49[v51])
            } or nil;

            if type(v49) == "table" then
                for i, v in v49 do
                    local v56 = string.lower(v51);
                    local v57 = string.lower(i);

                    if string.sub(v57, 1, #v56) == v56 then
                        local v58 = {
                            name = i,
                            with = i,
                            type = typeof(v),
                            replace = v50
                        };
                        table.insert(v54, v58);
                    end;
                end;
            end;

            return {
                at = where,
                text = v51,
                logs = u3,
                analyzing = v55,
                suggestions = v54
            };
        end;

        u16 = function(p59) -- Line: 497, Name: process_expression
            -- upvalues: process_function (ref), get_span (copy), where (copy), u17 (ref), u16 (ref), no_suggestions (copy)
            if p59.kind == "lambda" then
                return process_function(p59.body);
            end;

            if p59.kind == "evaluate" then
                local v60 = get_span(p59.body);

                if (where >= v60.x and where <= v60.y and "within" or (where < v60.x and "before" or "after")) == "within" and p59.body.value then
                    return u17(p59.body.value);
                end;
            elseif p59.kind == "vector" then
                for _, v in p59.contents.value do
                    local span = v.span;

                    if (where >= span.x and where <= span.y and "within" or (where < span.x and "before" or "after")) ~= "before" then
                        return u16(v);
                    end;
                end;
            else
                if p59.kind == "identifier" then
                    return no_suggestions(p59.token.text);
                end;

                if p59.kind == "string" then
                    return no_suggestions((string.sub(p59.token.text, 2, -2)));
                end;

                if p59.kind == "number" then
                    return no_suggestions(p59.token.text);
                end;

                if p59.kind == "var" then
                    return process_variable(p59.var, true);
                end;
            end;

            return no_suggestions("");
        end;

        local function process_return(p61) -- Line: 527
            -- upvalues: where (copy), u17 (ref), no_suggestions (copy)
            for _, v in p61.values do
                local span = v.span;

                if (where >= span.x and where <= span.y and "within" or (where < span.x and "before" or "after")) ~= "before" then
                    return u17(v);
                end;
            end;

            return no_suggestions("");
        end;

        u17 = function(p62) -- Line: 535, Name: process_expression_or_command
            -- upvalues: process_command (ref), u16 (ref)
            if p62.kind == "command" then
                return process_command(p62, true);
            end;

            return u16(p62);
        end;

        local function process_assignment(p63) -- Line: 543
            -- upvalues: no_suggestions (copy), where (copy), u17 (ref)
            if not p63.right then
                return no_suggestions("");
            end;

            local span = p63.operator.span;

            if (where >= span.x and where <= span.y and "within" or (where < span.x and "before" or "after")) == "before" then
                return no_suggestions("");
            end;

            return u17(p63.right);
        end;

        local function process_while(p64) -- Line: 551
            -- upvalues: get_span (copy), where (copy), u17 (ref), u15 (ref), no_suggestions (copy)
            local v65 = get_span(p64.expression);

            if (where >= v65.x and where <= v65.y and "within" or (where < v65.x and "before" or "after")) == "within" then
                return u17(p64.expression.value, true);
            end;

            local block = p64.block;

            if block then
                local v66 = get_span(block);

                if (where >= v66.x and where <= v66.y and "within" or (where < v66.x and "before" or "after")) == "within" then
                    return u15(block.value);
                end;
            end;

            return no_suggestions("");
        end;

        function parse_for(p67)
            -- upvalues: get_span (copy), where (copy), no_suggestions (copy), u16 (ref), process_function (ref)
            if p67.expression then
                local v68 = get_span(p67.expression);

                if (where >= v68.x and where <= v68.y and "within" or (where < v68.x and "before" or "after")) == "within" then
                    if p67.expression.value == nil then
                        return no_suggestions("");
                    end;

                    return u16(p67.expression.value);
                end;
            end;

            if p67.call then
                return process_function(p67.call);
            end;
        end;

        u15 = function(p69) -- Line: 576, Name: process_block
            -- upvalues: where (copy), no_suggestions (copy), process_assignment (ref), process_command (ref), process_return (ref), process_while (ref)
            for i, v in p69.body do
                local span = v.span;
                local v70 = where >= span.x and where <= span.y and "within" or (where < span.x and "before" or "after");

                if v70 ~= "before" and (v70 ~= "after" or i >= #p69.body) then
                    if v == nil then
                        return no_suggestions("");
                    end;

                    if v.kind == "if" then
                        return parse_if_stat(v);
                    end;

                    if v.kind == "assign" then
                        return process_assignment(v);
                    end;

                    if v.kind == "command" then
                        return process_command(v);
                    end;

                    if v.kind == "return" then
                        return process_return(v);
                    end;

                    if v.kind == "for" then
                        return parse_for(v);
                    end;

                    if v.kind == "while" then
                        return process_while(v);
                    end;

                    return no_suggestions("");
                end;
            end;

            return no_suggestions("");
        end;

        return u15(u11.value);
    end
};