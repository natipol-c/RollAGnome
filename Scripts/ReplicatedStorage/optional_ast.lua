--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     optional_ast
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_analysis.0.2.2-rc.2.conch_analysis.src.optional_ast
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

local function char(p1) -- Line: 289
    return string.byte(p1);
end;

local function parse(u2, u3) -- Line: 294
    local u4 = 0;
    local u5 = 0;
    local u6 = buffer.len(u2);

    local function peek() -- Line: 299
        -- upvalues: u4 (ref), u6 (copy), u2 (copy)
        return u4 == u6 and 0 or buffer.readu8(u2, u4);
    end;

    local function bump() -- Line: 304
        -- upvalues: u4 (ref), u6 (copy)
        u4 = math.min(u4 + 1, u6);
    end;

    local function bump_any() -- Line: 306
        -- upvalues: u4 (ref), u6 (copy), u2 (copy), u5 (ref)
        if (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 10 then
            u5 = u5 + 1;
        end;

        u4 = math.min(u4 + 1, u6);

        return u4 == u6 and 0 or buffer.readu8(u2, u4);
    end;

    local function eof(p7) -- Line: 315
        -- upvalues: u4 (ref), u6 (copy)
        if u6 <= u4 then
            error(p7, 0);
        end;

        return false;
    end;

    local function bump_peek() -- Line: 320
        -- upvalues: u4 (ref), u6 (copy), u2 (copy)
        u4 = math.min(u4 + 1, u6);

        return u4 == u6 and 0 or buffer.readu8(u2, u4);
    end;

    local function is_whitespace(p8) -- Line: 325
        return (p8 == 32 or p8 == 9) and true or p8 == 13;
    end;

    local function is_digit(p9) -- Line: 329
        local v10;

        if p9 >= 48 then
            v10 = p9 <= 57;
        else
            v10 = false;
        end;

        return v10;
    end;

    local function is_alpha(p11) -- Line: 333
        return p11 >= 97 and p11 <= 122 and true or (p11 >= 65 and p11 <= 90 and true or (p11 == 95 and true or p11 == 64));
    end;

    local function string_backslash() -- Line: 340
        -- upvalues: u4 (ref), u6 (copy), u2 (copy), u5 (ref)
        local v12 = u4 == u6 and 0 or buffer.readu8(u2, u4);

        if v12 == 13 then
            u4 = math.min(u4 + 1, u6);

            if (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 10 then
                u4 = math.min(u4 + 1, u6);
                u5 = u5 + 1;
            end;
        elseif v12 == 122 then
            u4 = math.min(u4 + 1, u6);

            while true do
                local v13 = u4 == u6 and 0 or buffer.readu8(u2, u4);

                if v13 ~= 32 and v13 ~= 9 and v13 ~= 13 then
                    break;
                end;

                if (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 10 then
                    u5 = u5 + 1;
                end;

                u4 = math.min(u4 + 1, u6);

                if u4 ~= u6 then
                    buffer.readu8(u2, u4);
                end;
            end;
        else
            if (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 10 then
                u5 = u5 + 1;
            end;

            u4 = math.min(u4 + 1, u6);

            if u4 == u6 then
                return;
            end;

            buffer.readu8(u2, u4);
        end;
    end;

    local function quoted_string() -- Line: 361
        -- upvalues: u4 (ref), u6 (copy), u2 (copy), string_backslash (copy)
        local v14 = u4 == u6 and 0 or buffer.readu8(u2, u4);
        u4 = math.min(u4 + 1, u6);
        local v15;

        if u4 == u6 then
            v15 = 0;
        else
            v15 = buffer.readu8(u2, u4);
        end;

        while v15 ~= v14 do
            if u6 <= u4 then
                error("expected string to be finished at", 0);
            end;

            if false then
                break;
            end;

            if v15 == 0 or (v15 == 10 or v15 == 13) then
                return "error";
            end;

            if v15 == 92 then
                u4 = math.min(u4 + 1, u6);
                string_backslash();
            else
                u4 = math.min(u4 + 1, u6);
            end;

            v15 = u4 == u6 and 0 or buffer.readu8(u2, u4);
        end;

        u4 = math.min(u4 + 1, u6);

        return "string";
    end;

    local function number() -- Line: 384
        -- upvalues: u4 (ref), u6 (copy), u2 (copy)
        local v16 = u4;
        local v17 = 10;
        local v18 = u4 == u6 and 0 or buffer.readu8(u2, u4);
        local v19;

        if v18 == 45 then
            u4 = math.min(u4 + 1, u6);
            v18 = u4 == u6 and 0 or buffer.readu8(u2, u4);
            v19 = true;
        else
            v19 = false;
        end;

        if v18 == 48 then
            u4 = math.min(u4 + 1, u6);
            v18 = u4 == u6 and 0 or buffer.readu8(u2, u4);

            if v18 == 120 or v18 == 88 then
                u4 = math.min(u4 + 1, u6);
                v18 = u4 == u6 and 0 or buffer.readu8(u2, u4);
                v17 = 16;
            elseif v18 == 98 or v18 == 66 then
                u4 = math.min(u4 + 1, u6);
                v18 = u4 == u6 and 0 or buffer.readu8(u2, u4);
                v17 = 2;
            end;
        end;

        while v18 ~= 32 and v18 ~= 9 and v18 ~= 13 and v18 ~= 0 do
            u4 = math.min(u4 + 1, u6);
            v18 = u4 == u6 and 0 or buffer.readu8(u2, u4);
        end;

        local v20;

        if v17 == 10 then
            v20 = buffer.readstring(u2, v16, u4 - v16);
        else
            v20 = buffer.readstring(u2, v16 + 2 + (v19 and 1 or 0), u4 - v16 - 2 - (v19 and 1 or 0));
        end;

        string.gsub(v20, "_", "");

        return "number";
    end;

    local function read_kind() -- Line: 428
        -- upvalues: u4 (ref), u6 (copy), u2 (copy), u5 (ref), read_kind (copy), is_alpha (copy), number (copy), quoted_string (copy)
        local v21 = u4 == u6 and 0 or buffer.readu8(u2, u4);

        if v21 == 0 then
            return "eof";
        end;

        if v21 == 35 then
            if (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 10 then
                u5 = u5 + 1;
            end;

            u4 = math.min(u4 + 1, u6);

            if u4 ~= u6 then
                buffer.readu8(u2, u4);
            end;

            while v21 ~= 10 and v21 ~= 0 do
                if (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 10 then
                    u5 = u5 + 1;
                end;

                u4 = math.min(u4 + 1, u6);
                v21 = u4 == u6 and 0 or buffer.readu8(u2, u4);
            end;

            return read_kind();
        end;

        if (v21 == 32 or v21 == 9) and true or v21 == 13 then
            u4 = math.min(u4 + 1, u6);

            return "whitespace";
        end;

        if not is_alpha(v21) then
            local v22;

            if v21 >= 48 then
                v22 = v21 <= 57;
            else
                v22 = false;
            end;

            if v22 or v21 == 45 then
                return number();
            end;

            if v21 == 34 then
                return quoted_string();
            end;

            if v21 == 39 then
                return quoted_string();
            end;

            if v21 == 46 then
                local v23 = u4 == u6 and 0 or buffer.readu8(u2, u4);
                local v24;

                if v23 >= 48 then
                    v24 = v23 <= 57;
                else
                    v24 = false;
                end;

                if v24 then
                    u4 = u4 - 1;

                    return number();
                end;

                u4 = math.min(u4 + 1, u6);

                return ".";
            end;

            if v21 == 61 then
                u4 = math.min(u4 + 1, u6);

                return (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 61 and "==" or "=";
            end;

            if v21 == 126 then
                u4 = math.min(u4 + 1, u6);

                if (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 61 then
                    return "~=";
                end;

                has_error = true;

                return "error";
            end;

            if v21 == 62 then
                u4 = math.min(u4 + 1, u6);

                return (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 61 and ">=" or ">";
            end;

            if v21 == 60 then
                u4 = math.min(u4 + 1, u6);

                return (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 61 and "<=" or "<";
            end;

            if v21 == 36 then
                u4 = math.min(u4 + 1, u6);

                return "$";
            end;

            if v21 == 40 then
                u4 = math.min(u4 + 1, u6);

                return "(";
            end;

            if v21 == 41 then
                u4 = math.min(u4 + 1, u6);

                return ")";
            end;

            if v21 == 123 then
                u4 = math.min(u4 + 1, u6);

                return "{";
            end;

            if v21 == 125 then
                u4 = math.min(u4 + 1, u6);

                return "}";
            end;

            if v21 == 91 then
                u4 = math.min(u4 + 1, u6);

                return "[";
            end;

            if v21 == 93 then
                u4 = math.min(u4 + 1, u6);

                return "]";
            end;

            if v21 == 124 then
                u4 = math.min(u4 + 1, u6);

                return "|";
            end;

            if v21 == 10 then
                u4 = math.min(u4 + 1, u6);

                return "\n";
            end;

            if v21 == 59 then
                u4 = math.min(u4 + 1, u6);

                return ";";
            end;

            if v21 == 44 then
                u4 = math.min(u4 + 1, u6);

                return ",";
            end;

            if (v21 == 32 or v21 == 9) and true or v21 == 13 then
                u4 = math.min(u4 + 1, u6);

                return read_kind();
            end;

            u4 = math.min(u4 + 1, u6);

            return "error";
        end;

        local v25 = u4;

        while true do
            local v26;

            repeat
                u4 = math.min(u4 + 1, u6);
                v26 = u4 == u6 and 0 or buffer.readu8(u2, u4);
            until not is_alpha(v26);

            local v27;

            if v26 >= 48 then
                v27 = v26 <= 57;
            else
                v27 = false;
            end;

            if not v27 and v26 ~= 45 then
                local v28 = buffer.readstring(u2, v25, u4 - v25);

                return v28 == "true" and "true" or (v28 == "false" and "false" or (v28 == "nil" and "nil" or (v28 == "return" and "return" or (v28 == "for" and "for" or (v28 == "while" and "while" or (v28 == "if" and "if" or (v28 == "else" and "else" or (v28 == "break" and "break" or (v28 == "continue" and "continue" or "identifier")))))))));
            end;
        end;
    end;

    local function next_token() -- Line: 569
        -- upvalues: u4 (ref), read_kind (copy), u2 (copy)
        local v29 = u4;
        local v30 = read_kind();

        while v30 == "whitespace" or v30 == "comment" do
            v29 = u4;
            v30 = read_kind();
        end;

        return {
            kind = v30,
            text = buffer.readstring(u2, v29, u4 - v29),
            span = vector.create(v29, u4, 0)
        };
    end;

    local u31 = next_token();
    local kind = u31.kind;
    local x = u31.span.x;
    local u32 = next_token();
    local kind2 = u32.kind;
    local x2 = u32.span.x;

    local function consume() -- Line: 592
        -- upvalues: u31 (ref), kind (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy)
        local v33 = u31;
        local v34 = kind;
        u31 = u32;
        kind = kind2;
        x = x2;
        u32 = next_token();
        kind2 = u32.kind;
        x2 = u32.span.x;

        return v33, v34;
    end;

    local function current_is(p35) -- Line: 602
        -- upvalues: kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy)
        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v36;

        if kind == p35 then
            v36 = true;
        else
            v36 = false;
        end;

        return v36;
    end;

    local function lookahead_is(p37) -- Line: 610
        -- upvalues: kind2 (ref), u32 (ref), next_token (copy)
        while kind2 == "\n" do
            u32 = next_token();
            kind2 = u32.kind;
        end;

        local v38;

        if kind2 == p37 then
            v38 = true;
        else
            v38 = false;
        end;

        return v38;
    end;

    local function display(p39) -- Line: 619
        local kind3 = p39.kind;

        if kind3 == "identifier" or (kind3 == "number" or kind3 == "string") then
            return kind3;
        end;

        if p39.kind == "error" then
            return "error \'" .. p39.text .. "\'";
        end;

        return "\'" .. kind3 .. "\'";
    end;

    local function report(p40, p41) -- Line: 631
        -- upvalues: u31 (ref)
        local v42 = {
            message = p40,
            span = p41 or u31.span
        };
        error(`{v42.message} from {v42.span.x} to {v42.span.y}`, 0);
    end;

    local function expect_failure(p43) -- Line: 640
        -- upvalues: report (copy), u31 (ref), kind (ref)
        local v44 = {
            kind = p43
        };
        local kind3 = v44.kind;

        if kind3 ~= "identifier" and (kind3 ~= "number" and kind3 ~= "string") then
            if v44.kind == "error" then
                kind3 = "error \'" .. v44.text .. "\'";
            else
                kind3 = "\'" .. kind3 .. "\'";
            end;
        end;

        local v45 = u31;
        local kind4 = v45.kind;

        if kind4 ~= "identifier" and (kind4 ~= "number" and kind4 ~= "string") then
            if v45.kind == "error" then
                kind4 = "error \'" .. v45.text .. "\'";
            else
                kind4 = "\'" .. kind4 .. "\'";
            end;
        end;

        return report((`expected {kind3}, but got {kind4} of {kind} instead`));
    end;

    local function expect(p46) -- Line: 650
        -- upvalues: kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u3 (copy), expect_failure (copy)
        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == p46 then
            local v47 = u31;
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;

            return v47;
        end;

        if kind ~= "eof" or not u3 then
            return expect_failure(p46);
        end;

        yield();

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == p46 then
            local v48 = u31;
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;

            return v48;
        end;

        local v49 = {
            kind = p46
        };
        local kind3 = v49.kind;

        if kind3 ~= "identifier" and (kind3 ~= "number" and kind3 ~= "string") then
            if v49.kind == "error" then
                kind3 = "error \'" .. v49.text .. "\'";
            else
                kind3 = "\'" .. kind3 .. "\'";
            end;
        end;

        local v50 = u31;
        local kind4 = v50.kind;

        if kind4 ~= "identifier" and (kind4 ~= "number" and kind4 ~= "string") then
            if v50.kind == "error" then
                kind4 = "error \'" .. v50.text .. "\'";
            else
                kind4 = "\'" .. kind4 .. "\'";
            end;
        end;

        local v51 = {
            message = `expected {kind3}, but got {kind4} of {kind} instead`,
            span = u31.span
        };
        error(`{v51.message} from {v51.span.x} to {v51.span.y}`, 0);

        return nil;
    end;

    local u52 = nil;
    local u53 = nil;
    local u54 = nil;
    local u55 = nil;

    local function parse_var_root() -- Line: 677
        -- upvalues: kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), expect (copy), u55 (ref), report (copy)
        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "identifier" then
            local v56 = expect("identifier");

            return {
                kind = "global",
                span = v56.span,
                token = v56
            };
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "$" then
            while kind2 == "\n" do
                u32 = next_token();
                kind2 = u32.kind;
            end;

            if kind2 == "(" then
                local v57 = expect("$");
                local v58 = expect("(");

                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                if kind ~= "eof" then
                    while kind == "\n" do
                        u31 = u32;
                        kind = kind2;
                        x = x2;
                        u32 = next_token();
                        kind2 = u32.kind;
                        x2 = u32.span.x;
                    end;

                    if kind ~= ";" then
                        local v59 = u55();

                        while kind == "\n" do
                            u31 = u32;
                            kind = kind2;
                            x = x2;
                            u32 = next_token();
                            kind2 = u32.kind;
                            x2 = u32.span.x;
                        end;

                        if kind ~= "}" then
                            return {
                                kind = "paren",
                                span = vector.create(v57.span.x, v59.span.y, 0),
                                expr = {
                                    left = v58,
                                    value = v59
                                },
                                operator = v57
                            };
                        end;

                        local v60 = expect("}");

                        return {
                            kind = "paren",
                            span = vector.create(v57.span.x, v60.span.y, 0),
                            expr = {
                                left = v58,
                                right = v60,
                                value = v59
                            },
                            operator = v57
                        };
                    end;
                end;

                return {
                    kind = "paren",
                    span = vector.create(v57.span.x, v58.span.y, 0),
                    expr = {
                        left = v58
                    },
                    operator = v57
                };
            end;
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "$" then
            local v61 = expect("$");

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            if kind ~= "identifier" then
                return {
                    kind = "name",
                    span = vector.create(v61.span.x, v61.span.y, 0),
                    operator = v61
                };
            end;

            local v62 = expect("identifier");

            return {
                kind = "name",
                span = vector.create(v61.span.x, v62.span.y, 0),
                name = v62,
                operator = v61
            };
        end;

        local v63 = u32;
        local kind3 = v63.kind;

        if kind3 ~= "identifier" and (kind3 ~= "number" and kind3 ~= "string") then
            if v63.kind == "error" then
                kind3 = "error \'" .. v63.text .. "\'";
            else
                kind3 = "\'" .. kind3 .. "\'";
            end;
        end;

        return report((`expected identifier, got {kind3}`));
    end;

    local function parse_var_suffix() -- Line: 738
        -- upvalues: kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), expect (copy), u55 (ref), report (copy)
        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "." then
            local v64 = expect(".");

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            if kind == "identifier" == false then
                return {
                    kind = "nameindex",
                    span = vector.create(v64.span.x, v64.span.y, 0),
                    operator = v64
                };
            end;

            local v65 = expect("identifier");

            return {
                kind = "nameindex",
                span = vector.create(v64.span.x, v65.span.y, 0),
                operator = v64,
                name = v65
            };
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind ~= "[" then
            return report("invalid");
        end;

        local v66 = expect("[");

        if kind == "eof" then
            return {
                kind = "exprindex",
                span = vector.create(v66.span.x, v66.span.y, 0),
                expr = {
                    left = v66
                }
            };
        end;

        local v67 = u55();

        if kind ~= "]" then
            return {
                kind = "exprindex",
                span = vector.create(v66.span.x, v67.span.y, 0),
                expr = {
                    left = v66,
                    value = v67
                }
            };
        end;

        local v68 = expect("]");

        return {
            kind = "exprindex",
            span = vector.create(v66.span.x, v68.span.y, 0),
            expr = {
                left = v66,
                right = v68,
                value = v67
            }
        };
    end;

    local function parse_var_suffixes() -- Line: 789
        -- upvalues: kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), parse_var_suffix (ref)
        local v69 = {};

        while true do
            while kind ~= "\n" do
                local v70;

                if kind ~= "." then
                    while kind == "\n" do
                        u31 = u32;
                        kind = kind2;
                        x = x2;
                        u32 = next_token();
                        kind2 = u32.kind;
                        x2 = u32.span.x;
                    end;

                    if kind ~= "[" then
                        return v69;
                    end;

                    v70 = parse_var_suffix();
                    table.insert(v69, v70);
                end;

                v70 = parse_var_suffix();
                table.insert(v69, v70);
            end;

            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;
    end;

    local function parse_var() -- Line: 798
        -- upvalues: parse_var_root (ref), parse_var_suffixes (ref)
        local v71 = parse_var_root();
        local v72 = v71.kind == "global" and {} or parse_var_suffixes();
        local v73;

        if #v72 > 0 then
            v73 = v72[#v72].span.y;
        else
            v73 = v71.span.y;
        end;

        return {
            span = vector.create(v71.span.x, v73, 0),
            prefix = v71,
            suffixes = v72
        };
    end;

    u55 = function() -- Line: 816, Name: parse_expression_or_command
        -- upvalues: kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u53 (ref), u52 (ref)
        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v74;

        if kind == "identifier" then
            v74 = true;
        else
            v74 = false;
        end;

        if v74 then
            return u53();
        end;

        return u52();
    end;

    local function parse_function_body() -- Line: 824
        -- upvalues: expect (copy), kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u54 (ref)
        local v75 = expect("|");
        local v76 = true;
        local v77 = {};

        while true do
            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            if kind == "|" then
                break;
            end;

            if v76 then
                v76 = false;
            else
                expect(",");
                v76 = false;
            end;

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            if kind ~= "identifier" then
                break;
            end;

            table.insert(v77, expect("identifier"));
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v78;

        if kind == "|" then
            v78 = expect("|");
        else
            v78 = nil;
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v79;

        if kind == "{" then
            v79 = expect("{");
        else
            v79 = nil;
        end;

        local v80 = u54("}");

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v81;

        if kind == "}" then
            v81 = expect("}");
        else
            v81 = nil;
        end;

        local v82 = {
            arguments = {
                left = v75,
                right = v78,
                value = v77
            },
            block = (v79 or (v80 or v81)) and {
                left = v79,
                right = v81,
                value = v80
            } or nil
        };
        local v83;

        if v81 then
            v83 = v81.span.y;
        else
            v83 = v80.span.y;
        end;

        v82.span = vector.create(v75.span.x, v83, 0);

        return v82;
    end;

    local function parse_lambda() -- Line: 862
        -- upvalues: parse_function_body (ref)
        local v84 = parse_function_body();

        return {
            kind = "lambda",
            body = v84,
            span = v84.span
        };
    end;

    function parse_table()
        -- upvalues: expect (copy), kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u52 (ref)
        local v85 = expect("{");
        local v86 = true;
        local v87 = {};

        while true do
            local v88, v89, v90, v91, v92, v93, v94, v95, v96, v97, v98, v99, v100, v101;

            while true do
                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                if kind == "}" then
                    while kind == "\n" do
                        u31 = u32;
                        kind = kind2;
                        x = x2;
                        u32 = next_token();
                        kind2 = u32.kind;
                        x2 = u32.span.x;
                    end;

                    if kind == "}" then
                        local v102 = expect("}");

                        return {
                            fields = {
                                left = v85,
                                right = v102,
                                value = v87
                            },
                            span = vector.create(v85.span.x, v102.span.y, 0)
                        };
                    end;

                    local y = v85.span.y;

                    if #v87 > 0 then
                        y = v87[#v87].span.y;
                    end;

                    return {
                        fields = {
                            left = v85,
                            value = v87
                        },
                        span = vector.create(v85.span.x, y, 0)
                    };
                end;

                if v86 then
                    v86 = false;
                else
                    expect(",");
                    v86 = false;
                end;

                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                if kind == "identifier" then
                    break;
                end;

                while kind == "\n" do
                    v88 = kind2;
                    u31 = u32;
                    kind = v88;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                if kind == "[" then
                    v89 = expect("[");

                    if kind == "eof" then
                        v90 = {
                            kind = "exprkey",
                            span = vector.create(v89.span.x, v89.span.y, 0),
                            key = {
                                left = v89
                            }
                        };
                        table.insert(v87, v90);
                        break;
                    end;

                    v91 = u52();

                    while kind == "\n" do
                        v92 = kind2;
                        u31 = u32;
                        kind = v92;
                        x = x2;
                        u32 = next_token();
                        kind2 = u32.kind;
                        x2 = u32.span.x;
                    end;

                    if kind == "]" then
                        v93 = expect("]");
                    else
                        v93 = nil;
                    end;

                    while kind == "\n" do
                        v94 = kind2;
                        u31 = u32;
                        kind = v94;
                        x = x2;
                        u32 = next_token();
                        kind2 = u32.kind;
                        x2 = u32.span.x;
                    end;

                    if kind == "=" then
                        v95 = expect("=");
                    else
                        v95 = nil;
                    end;

                    if kind == "eof" then
                        v96 = {
                            kind = "exprkey"
                        };
                        v97 = v89.span.x;

                        if v95 then
                            v98 = v95.span.y;
                        elseif v93 then
                            v98 = v93.span.y;
                        else
                            v98 = v91.span.y;
                        end;

                        v96.span = vector.create(v97, v98, 0);
                        v96.key = {
                            left = v89,
                            right = v93,
                            value = v91
                        };
                        v96.operator = v95;
                        table.insert(v87, v96);
                        break;
                    end;

                    v99 = u52();
                    v100 = {
                        kind = "exprkey",
                        span = vector.create(v89.span.x, v99.span.y, 0),
                        key = {
                            left = v89,
                            right = v93,
                            value = v91
                        },
                        operator = v95,
                        value = v99
                    };
                    table.insert(v87, v100);
                else
                    if kind == "eof" then
                        break;
                    end;

                    v101 = {
                        kind = "nokey",
                        value = u52()
                    };
                    table.insert(v87, v101);
                end;
            end;

            while kind2 == "\n" do
                u32 = next_token();
                kind2 = u32.kind;
            end;

            if kind2 == "=" then
                local v103 = expect("identifier");
                local v104 = expect("=");

                if kind == "eof" then
                    local v105 = {
                        kind = "namekey",
                        span = vector.create(v103.span.x, v104.span.y, 0),
                        name = v103,
                        operator = v104
                    };
                    table.insert(v87, v105);
                    break;
                end;

                local v106 = {
                    kind = "namekey",
                    name = v103,
                    value = u52()
                };
                table.insert(v87, v106);
            else
                while kind == "\n" do
                    v88 = kind2;
                    u31 = u32;
                    kind = v88;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                if kind == "[" then
                    v89 = expect("[");

                    if kind == "eof" then
                        v90 = {
                            kind = "exprkey",
                            span = vector.create(v89.span.x, v89.span.y, 0),
                            key = {
                                left = v89
                            }
                        };
                        table.insert(v87, v90);
                        break;
                    end;

                    v91 = u52();

                    while kind == "\n" do
                        v92 = kind2;
                        u31 = u32;
                        kind = v92;
                        x = x2;
                        u32 = next_token();
                        kind2 = u32.kind;
                        x2 = u32.span.x;
                    end;

                    if kind == "]" then
                        v93 = expect("]");
                    else
                        v93 = nil;
                    end;

                    while kind == "\n" do
                        v94 = kind2;
                        u31 = u32;
                        kind = v94;
                        x = x2;
                        u32 = next_token();
                        kind2 = u32.kind;
                        x2 = u32.span.x;
                    end;

                    if kind == "=" then
                        v95 = expect("=");
                    else
                        v95 = nil;
                    end;

                    if kind == "eof" then
                        v96 = {
                            kind = "exprkey"
                        };
                        v97 = v89.span.x;

                        if v95 then
                            v98 = v95.span.y;
                        elseif v93 then
                            v98 = v93.span.y;
                        else
                            v98 = v91.span.y;
                        end;

                        v96.span = vector.create(v97, v98, 0);
                        v96.key = {
                            left = v89,
                            right = v93,
                            value = v91
                        };
                        v96.operator = v95;
                        table.insert(v87, v96);
                        break;
                    end;

                    v99 = u52();
                    v100 = {
                        kind = "exprkey",
                        span = vector.create(v89.span.x, v99.span.y, 0),
                        key = {
                            left = v89,
                            right = v93,
                            value = v91
                        },
                        operator = v95,
                        value = v99
                    };
                    table.insert(v87, v100);
                else
                    if kind == "eof" then
                        break;
                    end;

                    v101 = {
                        kind = "nokey",
                        value = u52()
                    };
                    table.insert(v87, v101);
                end;
            end;
        end;
    end;

    local function parse_vector() -- Line: 973
        -- upvalues: expect (copy), kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u52 (ref)
        local v107 = expect("[");
        local x3 = v107.span.x;
        local y = v107.span.y;
        local v108 = 0;
        local v109 = {};

        while v108 < 3 do
            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            if kind == "]" then
                break;
            end;

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            if kind == "eof" then
                break;
            end;

            if v108 ~= 0 then
                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                if kind == "," then
                    expect(",");
                end;
            end;

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            if kind == "eof" then
                break;
            end;

            v108 = v108 + 1;
            local v110 = u52();
            v109[v108] = v110;
            y = v110.span.y;
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v111;

        if kind == "]" then
            v111 = expect("]");
        else
            v111 = nil;
        end;

        if v111 then
            y = v111.span.y;
        end;

        return {
            kind = "vector",
            span = vector.create(x3, y, 0),
            contents = {
                left = v107,
                right = v111,
                value = v109
            }
        };
    end;

    u52 = function() -- Line: 1005, Name: parse_expression
        -- upvalues: kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), expect (copy), u53 (ref), u52 (ref), parse_var (ref), parse_lambda (ref), parse_vector (ref), report (copy)
        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "$" then
            while kind2 == "\n" do
                u32 = next_token();
                kind2 = u32.kind;
            end;

            if kind2 == "(" then
                local v112 = expect("$");
                local v113 = expect("(");

                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                local v114;

                if kind == "$" then
                    v114 = u53();
                else
                    while kind == "\n" do
                        u31 = u32;
                        kind = kind2;
                        x = x2;
                        u32 = next_token();
                        kind2 = u32.kind;
                        x2 = u32.span.x;
                    end;

                    if kind == "identifier" then
                        v114 = u53();
                    else
                        if kind == "eof" then
                            return {
                                kind = "evaluate",
                                body = {
                                    left = v113
                                },
                                operator = v112,
                                span = vector.create(v112.span.x, v113.span.y, 0)
                            };
                        end;

                        v114 = u52();
                    end;
                end;

                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                if kind ~= ")" then
                    return {
                        kind = "evaluate",
                        body = {
                            left = v113,
                            value = v114
                        },
                        operator = v112,
                        span = vector.create(v112.span.x, v114.span.y, 0)
                    };
                end;

                local v115 = expect(")");

                return {
                    kind = "evaluate",
                    body = {
                        left = v113,
                        right = v115,
                        value = v114
                    },
                    operator = v112,
                    span = vector.create(v112.span.x, v115.span.y, 0)
                };
            end;
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "$" then
            while kind2 == "\n" do
                u32 = next_token();
                kind2 = u32.kind;
            end;

            if kind2 == "identifier" then
                local v116 = parse_var();

                return {
                    kind = "var",
                    var = v116,
                    span = v116.span
                };
            end;
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "string" then
            local v117 = expect("string");

            return {
                kind = "string",
                token = v117,
                span = v117.span
            };
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "number" then
            local v118 = expect("number");

            return {
                kind = "number",
                token = v118,
                span = v118.span
            };
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "true" then
            local v119 = expect("true");

            return {
                kind = "boolean",
                token = v119,
                span = v119.span
            };
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "false" then
            local v120 = expect("false");

            return {
                kind = "boolean",
                token = v120,
                span = v120.span
            };
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "identifier" then
            local v121 = expect("identifier");

            return {
                kind = "identifier",
                token = v121,
                span = v121.span
            };
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "|" then
            return parse_lambda();
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "{" then
            local v122 = parse_table();

            return {
                kind = "table",
                table = v122,
                span = v122.span
            };
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "[" then
            return parse_vector();
        end;

        return report((`expected expression, got {kind}`));
    end;

    u53 = function() -- Line: 1096, Name: parse_command
        -- upvalues: parse_var (ref), kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u52 (ref)
        local v123 = parse_var();
        local v124 = {};

        while kind ~= "\n" do
            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            if kind ~= "$" then
                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                if kind ~= "string" then
                    while kind == "\n" do
                        u31 = u32;
                        kind = kind2;
                        x = x2;
                        u32 = next_token();
                        kind2 = u32.kind;
                        x2 = u32.span.x;
                    end;

                    if kind ~= "number" then
                        while kind == "\n" do
                            u31 = u32;
                            kind = kind2;
                            x = x2;
                            u32 = next_token();
                            kind2 = u32.kind;
                            x2 = u32.span.x;
                        end;

                        if kind ~= "true" then
                            while kind == "\n" do
                                u31 = u32;
                                kind = kind2;
                                x = x2;
                                u32 = next_token();
                                kind2 = u32.kind;
                                x2 = u32.span.x;
                            end;

                            if kind ~= "false" then
                                while kind == "\n" do
                                    u31 = u32;
                                    kind = kind2;
                                    x = x2;
                                    u32 = next_token();
                                    kind2 = u32.kind;
                                    x2 = u32.span.x;
                                end;

                                if kind ~= "identifier" then
                                    while kind == "\n" do
                                        u31 = u32;
                                        kind = kind2;
                                        x = x2;
                                        u32 = next_token();
                                        kind2 = u32.kind;
                                        x2 = u32.span.x;
                                    end;

                                    if kind ~= "{" then
                                        while kind == "\n" do
                                            u31 = u32;
                                            kind = kind2;
                                            x = x2;
                                            u32 = next_token();
                                            kind2 = u32.kind;
                                            x2 = u32.span.x;
                                        end;

                                        if kind ~= "|" then
                                            while kind == "\n" do
                                                u31 = u32;
                                                kind = kind2;
                                                x = x2;
                                                u32 = next_token();
                                                kind2 = u32.kind;
                                                x2 = u32.span.x;
                                            end;

                                            if kind ~= "[" then
                                                break;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            local v125 = u52();
            table.insert(v124, v125);
        end;

        local v126;

        if #v124 > 0 then
            v126 = v124[#v124].span.y;
        else
            v126 = v123.span.y;
        end;

        return {
            kind = "command",
            prefix = v123,
            arguments = v124,
            span = vector.create(v123.span.x, v126, 0)
        };
    end;

    local function parse_if() -- Line: 1131
        -- upvalues: expect (copy), kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u53 (ref), u52 (ref), u54 (ref)
        local v127 = true;
        local v128 = {};
        local v129 = nil;
        local v130 = nil;

        while true do
            while v127 do
                local v131 = expect("if");

                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                local v132;

                if kind == "(" then
                    v132 = expect("(");
                else
                    v132 = nil;
                end;

                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                local v133;

                if kind == "identifier" then
                    v133 = u53();
                else
                    v133 = u52();
                end;

                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                local v134;

                if kind == ")" then
                    v134 = expect(")");
                else
                    v134 = nil;
                end;

                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                local v135;

                if kind == "{" then
                    v135 = expect("{");
                else
                    v135 = nil;
                end;

                local v136 = u54("}");

                while kind == "\n" do
                    u31 = u32;
                    kind = kind2;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                local v137;

                if kind == "}" then
                    v137 = expect("}");
                else
                    v137 = nil;
                end;

                local v138 = {
                    keyword = v131,
                    condition = {
                        left = v132,
                        right = v134,
                        value = v133
                    },
                    block = {
                        left = v135,
                        right = v137,
                        value = v136
                    }
                };
                local v139;

                if v137 then
                    v139 = v137.span.y;
                else
                    v139 = v136.span.y;
                end;

                v138.span = vector.create(v131.span.x, v139, 0);
                table.insert(v128, v138);
                v127 = false;
            end;

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            if kind ~= "else" then
                break;
            end;

            while kind2 == "\n" do
                u32 = next_token();
                kind2 = u32.kind;
            end;

            if kind2 ~= "if" then
                break;
            end;

            local v140 = expect("else");
            local v141 = expect("if");

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            local v142;

            if kind == "(" then
                v142 = expect("(");
            else
                v142 = nil;
            end;

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            local v143;

            if kind == "identifier" then
                v143 = u53();
            else
                v143 = u52();
            end;

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            local v144;

            if kind == ")" then
                v144 = expect(")");
            else
                v144 = nil;
            end;

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            local v145;

            if kind == "{" then
                v145 = expect("{");
            else
                v145 = nil;
            end;

            local v146 = u54("}");

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            local v147;

            if kind == "}" then
                v147 = expect("}");
            else
                v147 = nil;
            end;

            local v148 = {
                elsekeyword = v140,
                keyword = v141,
                condition = {
                    left = v142,
                    right = v144,
                    value = v143
                },
                block = {
                    left = v145,
                    right = v147,
                    value = v146
                }
            };
            local v149;

            if v147 then
                v149 = v147.span.y;
            else
                v149 = v146.span.y;
            end;

            v148.span = vector.create(v140.span.x, v149, 0);
            table.insert(v128, v148);
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        if kind == "else" then
            v129 = expect("else");

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            local v150;

            if kind == "{" then
                v150 = expect("{");
            else
                v150 = nil;
            end;

            local v151 = u54("}");

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            local v152;

            if kind == "}" then
                v152 = expect("}");
            else
                v152 = nil;
            end;

            v130 = {
                left = v150,
                right = v152,
                value = v151
            };
        end;

        local v153 = {
            kind = "if",
            ifs = v128,
            else_keyword = v129,
            fallback = v130
        };
        local v154;

        if v130 and v130.right then
            v154 = v130.right.span.y;
        elseif v130 then
            v154 = v130.value.span.y;
        else
            v154 = v128[#v128].span.y;
        end;

        v153.span = vector.create(v128[1].span.x, v154, 0);

        return v153;
    end;

    local function parse_while() -- Line: 1227
        -- upvalues: expect (copy), kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u53 (ref), u52 (ref), u54 (ref)
        local v155 = expect("while");

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v156;

        if kind == "(" then
            v156 = expect("(");
        else
            v156 = nil;
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v157;

        if kind == "identifier" then
            v157 = u53();
        else
            v157 = u52();
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v158;

        if kind == ")" then
            v158 = expect(")");
        else
            v158 = nil;
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v159;

        if kind == "{" then
            v159 = expect("{");
        else
            v159 = nil;
        end;

        local v160 = u54("}");

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v161;

        if kind == "}" then
            v161 = expect("}");
        else
            v161 = nil;
        end;

        local v162 = {
            kind = "while",
            keyword = v155,
            expression = {
                left = v156,
                right = v158,
                value = v157
            },
            block = {
                left = v159,
                right = v161,
                value = v160
            }
        };
        local v163;

        if v161 then
            v163 = v161.span.y;
        else
            v163 = v160.span.y;
        end;

        v162.span = vector.create(v155.span.x, v163, 0);

        return v162;
    end;

    local function parse_for() -- Line: 1254
        -- upvalues: expect (copy), kind (ref), u31 (ref), u32 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u55 (ref), parse_function_body (ref)
        local v164 = expect("for");

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v165;

        if kind == "(" then
            v165 = expect("(");
        else
            v165 = nil;
        end;

        local v166 = u55();

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v167;

        if kind == ")" then
            v167 = expect(")");
        else
            v167 = nil;
        end;

        while kind == "\n" do
            u31 = u32;
            kind = kind2;
            x = x2;
            u32 = next_token();
            kind2 = u32.kind;
            x2 = u32.span.x;
        end;

        local v168;

        if kind == "|" then
            v168 = parse_function_body();
        else
            v168 = nil;
        end;

        local v169 = {
            kind = "for",
            keyword = v164,
            expression = {
                left = v165,
                right = v167,
                value = v166
            },
            call = v168
        };
        local v170;

        if v168 then
            v170 = v168.span.y;
        elseif v167 then
            v170 = v167.span.y;
        else
            v170 = v166.span.y;
        end;

        v169.span = vector.create(v164.span.x, v170, 0);

        return v169;
    end;

    local function parse_return() -- Line: 1277
        -- upvalues: expect (copy), kind (ref), u52 (ref)
        local v171 = expect("return");
        local y = v171.span.y;
        local v172 = {};

        while kind ~= "}" and kind ~= "eof" do
            if #v172 > 0 then
                expect(",");
            end;

            local v173 = u52();
            table.insert(v172, v173);
            y = v173.span.y;
        end;

        return {
            kind = "return",
            values = v172,
            keyword = v171,
            span = vector.create(v171.span.x, y, 0)
        };
    end;

    u54 = function(p174, p175) -- Line: 1298, Name: parse_block
        -- upvalues: x (ref), kind (ref), u31 (ref), u32 (ref), kind2 (ref), x2 (ref), next_token (copy), expect (copy), u55 (ref), parse_if (ref), parse_while (ref), parse_for (ref), parse_return (ref), u53 (ref)
        local v176 = p175 or x;
        local v177 = v176;
        local v178 = nil;
        local v179 = {};

        while true do
            if kind == p174 then
                return {
                    span = vector.create(v176, v177, 0),
                    body = v179,
                    last_statement = v178
                };
            end;

            if v178 then
                local v180 = {
                    message = "expected to finish after last statement",
                    span = u31.span
                };
                error(`{v180.message} from {v180.span.x} to {v180.span.y}`, 0);
            end;

            while kind == "\n" do
                u31 = u32;
                kind = kind2;
                x = x2;
                u32 = next_token();
                kind2 = u32.kind;
                x2 = u32.span.x;
            end;

            local v181, v182, v183, v184, v185, v186, v187, v188, v189, v190, v191, v192, v193;

            if kind == "identifier" then
                while kind2 == "\n" do
                    u32 = next_token();
                    kind2 = u32.kind;
                end;

                if kind2 == "=" then
                    local v194 = expect("identifier");
                    local v195 = expect("=");
                    local v196 = u55();
                    local v197 = {
                        kind = "assign",
                        span = vector.create(v194.span.x, v196.span.y, 0),
                        operator = v195,
                        left = v194,
                        right = v196
                    };
                    table.insert(v179, v197);
                else
                    while kind == "\n" do
                        v181 = kind2;
                        u31 = u32;
                        kind = v181;
                        x = x2;
                        u32 = next_token();
                        kind2 = u32.kind;
                        x2 = u32.span.x;
                    end;

                    if kind == "if" then
                        table.insert(v179, parse_if());
                    else
                        while kind == "\n" do
                            v182 = kind2;
                            u31 = u32;
                            kind = v182;
                            x = x2;
                            u32 = next_token();
                            kind2 = u32.kind;
                            x2 = u32.span.x;
                        end;

                        if kind == "while" then
                            table.insert(v179, parse_while());
                        else
                            while kind == "\n" do
                                v183 = kind2;
                                u31 = u32;
                                kind = v183;
                                x = x2;
                                u32 = next_token();
                                kind2 = u32.kind;
                                x2 = u32.span.x;
                            end;

                            if kind == "for" then
                                table.insert(v179, parse_for());
                            else
                                while kind == "\n" do
                                    v184 = kind2;
                                    u31 = u32;
                                    kind = v184;
                                    x = x2;
                                    u32 = next_token();
                                    kind2 = u32.kind;
                                    x2 = u32.span.x;
                                end;

                                if kind == "return" then
                                    v178 = parse_return();
                                else
                                    while kind == "\n" do
                                        v185 = kind2;
                                        u31 = u32;
                                        kind = v185;
                                        x = x2;
                                        u32 = next_token();
                                        kind2 = u32.kind;
                                        x2 = u32.span.x;
                                    end;

                                    if kind == "break" then
                                        v186 = expect("break");
                                        v178 = {
                                            kind = "break",
                                            span = v186.span,
                                            keyword = v186
                                        };
                                    else
                                        while kind == "\n" do
                                            v187 = kind2;
                                            u31 = u32;
                                            kind = v187;
                                            x = x2;
                                            u32 = next_token();
                                            kind2 = u32.kind;
                                            x2 = u32.span.x;
                                        end;

                                        if kind == "continue" then
                                            v188 = expect("continue");
                                            v178 = {
                                                kind = "continue",
                                                span = v188.span,
                                                keyword = v188
                                            };
                                        else
                                            while kind == "\n" do
                                                v189 = kind2;
                                                u31 = u32;
                                                kind = v189;
                                                x = x2;
                                                u32 = next_token();
                                                kind2 = u32.kind;
                                                x2 = u32.span.x;
                                            end;

                                            if kind == "identifier" then
                                                table.insert(v179, u53());
                                            else
                                                while kind == "\n" do
                                                    v190 = kind2;
                                                    u31 = u32;
                                                    kind = v190;
                                                    x = x2;
                                                    u32 = next_token();
                                                    kind2 = u32.kind;
                                                    x2 = u32.span.x;
                                                end;

                                                if kind == "$" then
                                                    table.insert(v179, u53());
                                                else
                                                    while kind == "\n" do
                                                        v191 = kind2;
                                                        u31 = u32;
                                                        kind = v191;
                                                        x = x2;
                                                        u32 = next_token();
                                                        kind2 = u32.kind;
                                                        x2 = u32.span.x;
                                                    end;

                                                    if kind == ";" then
                                                        v192 = kind2;
                                                        u31 = u32;
                                                        kind = v192;
                                                        x = x2;
                                                        u32 = next_token();
                                                        kind2 = u32.kind;
                                                        x2 = u32.span.x;
                                                    else
                                                        if kind == "eof" then
                                                            break;
                                                        end;

                                                        if kind == p174 then
                                                            v177 = x;
                                                            break;
                                                        end;

                                                        v193 = {
                                                            message = `cannot parse {kind}`,
                                                            span = u31.span
                                                        };
                                                        error(`{v193.message} from {v193.span.x} to {v193.span.y}`, 0);
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            else
                while kind == "\n" do
                    v181 = kind2;
                    u31 = u32;
                    kind = v181;
                    x = x2;
                    u32 = next_token();
                    kind2 = u32.kind;
                    x2 = u32.span.x;
                end;

                if kind == "if" then
                    table.insert(v179, parse_if());
                else
                    while kind == "\n" do
                        v182 = kind2;
                        u31 = u32;
                        kind = v182;
                        x = x2;
                        u32 = next_token();
                        kind2 = u32.kind;
                        x2 = u32.span.x;
                    end;

                    if kind == "while" then
                        table.insert(v179, parse_while());
                    else
                        while kind == "\n" do
                            v183 = kind2;
                            u31 = u32;
                            kind = v183;
                            x = x2;
                            u32 = next_token();
                            kind2 = u32.kind;
                            x2 = u32.span.x;
                        end;

                        if kind == "for" then
                            table.insert(v179, parse_for());
                        else
                            while kind == "\n" do
                                v184 = kind2;
                                u31 = u32;
                                kind = v184;
                                x = x2;
                                u32 = next_token();
                                kind2 = u32.kind;
                                x2 = u32.span.x;
                            end;

                            if kind == "return" then
                                v178 = parse_return();
                            else
                                while kind == "\n" do
                                    v185 = kind2;
                                    u31 = u32;
                                    kind = v185;
                                    x = x2;
                                    u32 = next_token();
                                    kind2 = u32.kind;
                                    x2 = u32.span.x;
                                end;

                                if kind == "break" then
                                    v186 = expect("break");
                                    v178 = {
                                        kind = "break",
                                        span = v186.span,
                                        keyword = v186
                                    };
                                else
                                    while kind == "\n" do
                                        v187 = kind2;
                                        u31 = u32;
                                        kind = v187;
                                        x = x2;
                                        u32 = next_token();
                                        kind2 = u32.kind;
                                        x2 = u32.span.x;
                                    end;

                                    if kind == "continue" then
                                        v188 = expect("continue");
                                        v178 = {
                                            kind = "continue",
                                            span = v188.span,
                                            keyword = v188
                                        };
                                    else
                                        while kind == "\n" do
                                            v189 = kind2;
                                            u31 = u32;
                                            kind = v189;
                                            x = x2;
                                            u32 = next_token();
                                            kind2 = u32.kind;
                                            x2 = u32.span.x;
                                        end;

                                        if kind == "identifier" then
                                            table.insert(v179, u53());
                                        else
                                            while kind == "\n" do
                                                v190 = kind2;
                                                u31 = u32;
                                                kind = v190;
                                                x = x2;
                                                u32 = next_token();
                                                kind2 = u32.kind;
                                                x2 = u32.span.x;
                                            end;

                                            if kind == "$" then
                                                table.insert(v179, u53());
                                            else
                                                while kind == "\n" do
                                                    v191 = kind2;
                                                    u31 = u32;
                                                    kind = v191;
                                                    x = x2;
                                                    u32 = next_token();
                                                    kind2 = u32.kind;
                                                    x2 = u32.span.x;
                                                end;

                                                if kind == ";" then
                                                    v192 = kind2;
                                                    u31 = u32;
                                                    kind = v192;
                                                    x = x2;
                                                    u32 = next_token();
                                                    kind2 = u32.kind;
                                                    x2 = u32.span.x;
                                                else
                                                    if kind == "eof" then
                                                        break;
                                                    end;

                                                    if kind == p174 then
                                                        v177 = x;
                                                        break;
                                                    end;

                                                    v193 = {
                                                        message = `cannot parse {kind}`,
                                                        span = u31.span
                                                    };
                                                    error(`{v193.message} from {v193.span.x} to {v193.span.y}`, 0);
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            v177 = x;
        end;
    end;

    return u54("eof");
end;

local u198 = "ban 3d";

local function get_result(p199, p200) -- Line: 1386
    -- upvalues: u198 (copy)
    return p199 == false and {
        status = "error",
        src = u198,
        why = p200
    } or {
        status = "finished",
        src = u198,
        value = p200
    };
end;

local v201 = buffer.fromstring("ban 3d");
local success, result = pcall(parse, v201);
get_result(success, result);

return function(u202) -- Line: 1383, Name: generate
    -- upvalues: parse (copy)
    local v203 = buffer.fromstring(u202);
    local success2, result2 = pcall(parse, v203);

    return (function(p204, p205) -- Line: 1386, Name: get_result
        -- upvalues: u202 (copy)
        return p204 == false and {
            status = "error",
            src = u202,
            why = p205
        } or {
            status = "finished",
            src = u202,
            value = p205
        };
    end)(success2, result2);
end;