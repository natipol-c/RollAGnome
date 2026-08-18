--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     lib
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ast.0.2.1-rc.2.conch_ast.src.lib
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:05 2026
]]

-- Decompiled with Potassium's decompiler.

require("../roblox_packages/types");

local function char(p1) -- Line: 8
    return string.byte(p1);
end;

local function parse(u2, u3) -- Line: 13
    local u4 = 0;
    local u5 = 0;
    local u6 = buffer.len(u2);

    local function peek() -- Line: 18
        -- upvalues: u4 (ref), u6 (ref), u2 (ref)
        return u4 == u6 and 0 or buffer.readu8(u2, u4);
    end;

    local function bump() -- Line: 23
        -- upvalues: u4 (ref), u6 (ref)
        u4 = math.min(u4 + 1, u6);
    end;

    local function bump_any() -- Line: 25
        -- upvalues: u4 (ref), u6 (ref), u2 (ref), u5 (ref)
        if (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 10 then
            u5 = u5 + 1;
        end;

        u4 = math.min(u4 + 1, u6);

        return u4 == u6 and 0 or buffer.readu8(u2, u4);
    end;

    local function eof(p7) -- Line: 34
        -- upvalues: u4 (ref), u6 (ref)
        if u6 <= u4 then
            error(p7, 0);
        end;

        return false;
    end;

    local function bump_peek() -- Line: 39
        -- upvalues: u4 (ref), u6 (ref), u2 (ref)
        u4 = math.min(u4 + 1, u6);

        return u4 == u6 and 0 or buffer.readu8(u2, u4);
    end;

    local function is_whitespace(p8) -- Line: 44
        return (p8 == 32 or p8 == 9) and true or p8 == 13;
    end;

    local function is_digit(p9) -- Line: 48
        local v10;

        if p9 >= 48 then
            v10 = p9 <= 57;
        else
            v10 = false;
        end;

        return v10;
    end;

    local function is_alpha(p11) -- Line: 52
        return p11 >= 97 and p11 <= 122 and true or (p11 >= 65 and p11 <= 90 and true or (p11 == 64 and true or p11 == 95));
    end;

    local function string_backslash() -- Line: 59
        -- upvalues: u4 (ref), u6 (ref), u2 (ref), u5 (ref)
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

    local function quoted_string() -- Line: 80
        -- upvalues: u4 (ref), u6 (ref), u2 (ref), string_backslash (copy)
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
                error("unterminated string", 0);
            end;

            if false then
                break;
            end;

            if v15 == 0 or (v15 == 10 or v15 == 13) then
                has_error = true;

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

    local function number() -- Line: 102
        -- upvalues: u4 (ref), u6 (ref), u2 (ref), is_alpha (copy)
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

        while true do
            local v20;

            if v18 >= 48 then
                v20 = v18 <= 57;
            else
                v20 = false;
            end;

            if not v20 and (v18 ~= 46 and v18 ~= 95) then
                break;
            end;

            u4 = math.min(u4 + 1, u6);
            v18 = u4 == u6 and 0 or buffer.readu8(u2, u4);
        end;

        if v18 == 101 or v18 == 69 then
            u4 = math.min(u4 + 1, u6);
            v18 = u4 == u6 and 0 or buffer.readu8(u2, u4);

            if v18 == 43 or v18 == 45 then
                u4 = math.min(u4 + 1, u6);

                if u4 == u6 then
                    v18 = 0;
                else
                    v18 = buffer.readu8(u2, u4);
                end;
            end;
        end;

        while true do
            local v21;

            if v18 >= 48 then
                v21 = v18 <= 57;
            else
                v21 = false;
            end;

            if not v21 and (not is_alpha(v18) and v18 ~= 95) then
                local v22;

                if v17 == 10 then
                    v22 = buffer.readstring(u2, v16, u4 - v16);
                else
                    v22 = buffer.readstring(u2, v16 + 2 + (v19 and 1 or 0), u4 - v16 - 2 - (v19 and 1 or 0));
                end;

                local v23 = string.gsub(v22, "_", "");

                if tonumber(v23, v17) then
                    return "number";
                end;

                has_error = true;

                return "error";
            end;

            u4 = math.min(u4 + 1, u6);
            v18 = u4 == u6 and 0 or buffer.readu8(u2, u4);
        end;
    end;

    local function read_kind() -- Line: 161
        -- upvalues: u4 (ref), u6 (ref), u2 (ref), u5 (ref), read_kind (copy), is_alpha (copy), number (copy), quoted_string (copy)
        local v24 = u4 == u6 and 0 or buffer.readu8(u2, u4);

        if v24 == 0 then
            return "eof";
        end;

        if v24 == 35 then
            while v24 ~= 10 and v24 ~= 0 do
                if (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 10 then
                    u5 = u5 + 1;
                end;

                u4 = math.min(u4 + 1, u6);
                v24 = u4 == u6 and 0 or buffer.readu8(u2, u4);
            end;

            return read_kind();
        end;

        if (v24 == 32 or v24 == 9) and true or v24 == 13 then
            u4 = math.min(u4 + 1, u6);

            return "whitespace";
        end;

        if not is_alpha(v24) then
            local v25;

            if v24 >= 48 then
                v25 = v24 <= 57;
            else
                v25 = false;
            end;

            if v25 or v24 == 45 then
                return number();
            end;

            if v24 == 34 then
                return quoted_string();
            end;

            if v24 == 39 then
                return quoted_string();
            end;

            if v24 == 46 then
                local v26 = u4 == u6 and 0 or buffer.readu8(u2, u4);
                local v27;

                if v26 >= 48 then
                    v27 = v26 <= 57;
                else
                    v27 = false;
                end;

                if v27 then
                    u4 = u4 - 1;

                    return number();
                end;

                u4 = math.min(u4 + 1, u6);

                return ".";
            end;

            if v24 == 61 then
                u4 = math.min(u4 + 1, u6);

                return (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 61 and "==" or "=";
            end;

            if v24 == 126 then
                u4 = math.min(u4 + 1, u6);

                if (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 61 then
                    return "~=";
                end;

                has_error = true;

                return "error";
            end;

            if v24 == 62 then
                u4 = math.min(u4 + 1, u6);

                return (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 61 and ">=" or ">";
            end;

            if v24 == 60 then
                u4 = math.min(u4 + 1, u6);

                return (u4 == u6 and 0 or buffer.readu8(u2, u4)) == 61 and "<=" or "<";
            end;

            if v24 == 36 then
                u4 = math.min(u4 + 1, u6);

                return "$";
            end;

            if v24 == 40 then
                u4 = math.min(u4 + 1, u6);

                return "(";
            end;

            if v24 == 41 then
                u4 = math.min(u4 + 1, u6);

                return ")";
            end;

            if v24 == 123 then
                u4 = math.min(u4 + 1, u6);

                return "{";
            end;

            if v24 == 125 then
                u4 = math.min(u4 + 1, u6);

                return "}";
            end;

            if v24 == 91 then
                u4 = math.min(u4 + 1, u6);

                return "[";
            end;

            if v24 == 93 then
                u4 = math.min(u4 + 1, u6);

                return "]";
            end;

            if v24 == 124 then
                u4 = math.min(u4 + 1, u6);

                return "|";
            end;

            if v24 == 10 then
                u4 = math.min(u4 + 1, u6);

                return "\n";
            end;

            if v24 == 59 then
                u4 = math.min(u4 + 1, u6);

                return ";";
            end;

            if v24 == 44 then
                u4 = math.min(u4 + 1, u6);

                return ",";
            end;

            if (v24 == 32 or v24 == 9) and true or v24 == 13 then
                u4 = math.min(u4 + 1, u6);

                return read_kind();
            end;

            error(`no symbol matching {string.char(v24)}`, 0);

            return "error";
        end;

        local v28 = u4;

        while true do
            local v29;

            repeat
                u4 = math.min(u4 + 1, u6);
                v29 = u4 == u6 and 0 or buffer.readu8(u2, u4);
            until not is_alpha(v29);

            local v30;

            if v29 >= 48 then
                v30 = v29 <= 57;
            else
                v30 = false;
            end;

            if not v30 and v29 ~= 45 then
                local v31 = buffer.readstring(u2, v28, u4 - v28);

                return v31 == "true" and "true" or (v31 == "false" and "false" or (v31 == "nil" and "nil" or (v31 == "return" and "return" or (v31 == "for" and "for" or (v31 == "while" and "while" or (v31 == "if" and "if" or (v31 == "else" and "else" or (v31 == "break" and "break" or (v31 == "continue" and "continue" or "identifier")))))))));
            end;
        end;
    end;

    local function next_token() -- Line: 301
        -- upvalues: u4 (ref), read_kind (copy), u2 (ref)
        local v32 = u4;
        local v33 = read_kind();

        while v33 == "whitespace" or v33 == "comment" do
            v32 = u4;
            v33 = read_kind();
        end;

        return {
            kind = v33,
            text = buffer.readstring(u2, v32, u4 - v32),
            span = vector.create(v32, u4, 0)
        };
    end;

    local u34 = next_token();
    local kind = u34.kind;
    local x = u34.span.x;
    local u35 = next_token();
    local kind2 = u35.kind;
    local x2 = u35.span.x;

    local function consume() -- Line: 324
        -- upvalues: u34 (ref), kind (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy)
        local v36 = u34;
        local v37 = kind;
        u34 = u35;
        kind = kind2;
        x = x2;
        u35 = next_token();
        kind2 = u35.kind;
        x2 = u35.span.x;

        return v36, v37;
    end;

    local function current_is(p38) -- Line: 334
        -- upvalues: kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy)
        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        local v39;

        if kind == p38 then
            v39 = true;
        else
            v39 = false;
        end;

        return v39;
    end;

    local function lookahead_is(p40) -- Line: 342
        -- upvalues: kind2 (ref), u35 (ref), next_token (copy)
        while kind2 == "\n" do
            u35 = next_token();
            kind2 = u35.kind;
        end;

        local v41;

        if kind2 == p40 then
            v41 = true;
        else
            v41 = false;
        end;

        return v41;
    end;

    local function yield() -- Line: 351
        -- upvalues: u3 (copy), u2 (ref), u6 (ref), u34 (ref), next_token (copy), kind (ref), u35 (ref), kind2 (ref)
        if u3 then
            local v42 = coroutine.yield();
            local v43 = typeof(v42) == "buffer";
            assert(v43);
            u2 = v42;
            u6 = buffer.len(v42);
            u34 = next_token();
            kind = u34.kind;
            u35 = next_token();
            kind2 = u35.kind;
        end;
    end;

    local function display(p44) -- Line: 365
        local kind3 = p44.kind;

        if kind3 == "identifier" or (kind3 == "number" or kind3 == "string") then
            return kind3;
        end;

        if p44.kind == "error" then
            return "error \'" .. p44.text .. "\'";
        end;

        return "\'" .. kind3 .. "\'";
    end;

    local function report(p45, p46) -- Line: 377
        -- upvalues: u34 (ref)
        local v47 = {
            message = p45,
            span = p46 or u34.span
        };
        error(`{v47.message} from {v47.span.x} to {v47.span.y}`, 0);
    end;

    local function expect_failure(p48) -- Line: 386
        -- upvalues: report (copy), u34 (ref), kind (ref)
        local v49 = {
            kind = p48
        };
        local kind3 = v49.kind;

        if kind3 ~= "identifier" and (kind3 ~= "number" and kind3 ~= "string") then
            if v49.kind == "error" then
                kind3 = "error \'" .. v49.text .. "\'";
            else
                kind3 = "\'" .. kind3 .. "\'";
            end;
        end;

        local v50 = u34;
        local kind4 = v50.kind;

        if kind4 ~= "identifier" and (kind4 ~= "number" and kind4 ~= "string") then
            if v50.kind == "error" then
                kind4 = "error \'" .. v50.text .. "\'";
            else
                kind4 = "\'" .. kind4 .. "\'";
            end;
        end;

        return report((`expected {kind3}, but got {kind4} of {kind} instead`));
    end;

    local function expect(p51) -- Line: 396
        -- upvalues: kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u3 (copy), u2 (ref), u6 (ref), expect_failure (copy)
        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == p51 then
            local v52 = u34;
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;

            return v52;
        end;

        if kind ~= "eof" or not u3 then
            return expect_failure(p51);
        end;

        if u3 then
            local v53 = coroutine.yield();
            local v54 = typeof(v53) == "buffer";
            assert(v54);
            u2 = v53;
            u6 = buffer.len(v53);
            u34 = next_token();
            kind = u34.kind;
            u35 = next_token();
            kind2 = u35.kind;
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == p51 then
            local v55 = u34;
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;

            return v55;
        end;

        local v56 = {
            kind = p51
        };
        local kind3 = v56.kind;

        if kind3 ~= "identifier" and (kind3 ~= "number" and kind3 ~= "string") then
            if v56.kind == "error" then
                kind3 = "error \'" .. v56.text .. "\'";
            else
                kind3 = "\'" .. kind3 .. "\'";
            end;
        end;

        local v57 = u34;
        local kind4 = v57.kind;

        if kind4 ~= "identifier" and (kind4 ~= "number" and kind4 ~= "string") then
            if v57.kind == "error" then
                kind4 = "error \'" .. v57.text .. "\'";
            else
                kind4 = "\'" .. kind4 .. "\'";
            end;
        end;

        local v58 = {
            message = `expected {kind3}, but got {kind4} of {kind} instead`,
            span = u34.span
        };
        error(`{v58.message} from {v58.span.x} to {v58.span.y}`, 0);

        return nil;
    end;

    local u59 = nil;
    local u60 = nil;
    local u61 = nil;
    local u62 = nil;

    local function parse_var_root() -- Line: 422
        -- upvalues: kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), expect (copy), u62 (ref), report (copy)
        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "identifier" then
            local v63 = expect("identifier");

            return {
                kind = "global",
                span = v63.span,
                token = v63
            };
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "$" then
            while kind2 == "\n" do
                u35 = next_token();
                kind2 = u35.kind;
            end;

            if kind2 == "identifier" then
                local v64 = expect("$");
                local v65 = expect("identifier");

                return {
                    kind = "name",
                    span = vector.create(v64.span.x, v65.span.y, 0),
                    name = v65
                };
            end;
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "$" then
            while kind2 == "\n" do
                u35 = next_token();
                kind2 = u35.kind;
            end;

            if kind2 == "(" then
                local v66 = expect("$");
                expect("(");
                local v67 = u62();
                local v68 = expect(")");

                return {
                    kind = "paren",
                    span = vector.create(v66.span.x, v68.span.y, 0),
                    expr = v67
                };
            end;
        end;

        local v69 = u35;
        local kind3 = v69.kind;

        if kind3 ~= "identifier" and (kind3 ~= "number" and kind3 ~= "string") then
            if v69.kind == "error" then
                kind3 = "error \'" .. v69.text .. "\'";
            else
                kind3 = "\'" .. kind3 .. "\'";
            end;
        end;

        return report((`expected identifier, got {kind3}`));
    end;

    local function parse_var_suffix() -- Line: 451
        -- upvalues: kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), expect (copy), u62 (ref), report (copy)
        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        local v70;

        if kind == "." then
            v70 = true;
        else
            v70 = false;
        end;

        if v70 then
            local v71 = expect(".");
            local v72 = expect("identifier");

            return {
                kind = "nameindex",
                span = vector.create(v71.span.x, v72.span.y, 0),
                name = v72
            };
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        local v73;

        if kind == "[" then
            v73 = true;
        else
            v73 = false;
        end;

        if not v73 then
            return report("invalid");
        end;

        local v74 = expect("[");
        local v75 = u62();
        local v76 = expect("]");

        return {
            kind = "exprindex",
            span = vector.create(v74.span.x, v76.span.y, 0),
            expr = v75
        };
    end;

    local function parse_var_suffixes() -- Line: 474
        -- upvalues: kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), parse_var_suffix (ref)
        local v77 = {};

        while true do
            while kind ~= "\n" do
                local v78;

                if kind ~= "." then
                    while kind == "\n" do
                        u34 = u35;
                        kind = kind2;
                        x = x2;
                        u35 = next_token();
                        kind2 = u35.kind;
                        x2 = u35.span.x;
                    end;

                    if kind ~= "[" then
                        return v77;
                    end;

                    v78 = parse_var_suffix();
                    table.insert(v77, v78);
                end;

                v78 = parse_var_suffix();
                table.insert(v77, v78);
            end;

            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;
    end;

    local function parse_var() -- Line: 483
        -- upvalues: parse_var_root (ref), parse_var_suffixes (ref)
        local v79 = parse_var_root();
        local v80 = v79.kind == "global" and {} or parse_var_suffixes();
        local v81;

        if #v80 > 0 then
            v81 = v80[#v80].span.y;
        else
            v81 = v79.span.y;
        end;

        return {
            span = vector.create(v79.span.x, v81, 0),
            prefix = v79,
            suffixes = v80
        };
    end;

    u62 = function() -- Line: 501, Name: parse_expression_or_command
        -- upvalues: kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u60 (ref), u3 (copy), u2 (ref), u6 (ref), u62 (ref), u59 (ref)
        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "identifier" then
            return u60();
        end;

        if kind ~= "eof" or not u3 then
            return u59();
        end;

        if u3 then
            local v82 = coroutine.yield();
            local v83 = typeof(v82) == "buffer";
            assert(v83);
            u2 = v82;
            u6 = buffer.len(v82);
            u34 = next_token();
            kind = u34.kind;
            u35 = next_token();
            kind2 = u35.kind;
        end;

        return u62();
    end;

    local function parse_function_body() -- Line: 512
        -- upvalues: expect (copy), kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u3 (copy), u2 (ref), u6 (ref), u61 (ref)
        local x3 = expect("|").span.x;
        local v84 = {};
        local v85 = true;

        while true do
            while kind ~= "\n" do
                if kind == "|" then
                    expect("|");
                    expect("{");
                    local v86 = u61("}");
                    local y = expect("}").span.y;

                    return {
                        span = vector.create(x3, y, 0),
                        arguments = v84,
                        block = v86
                    };
                end;

                if kind == "eof" and u3 then
                    if u3 then
                        local v87 = coroutine.yield();
                        local v88 = typeof(v87) == "buffer";
                        assert(v88);
                        u2 = v87;
                        u6 = buffer.len(v87);
                        u34 = next_token();
                        kind = u34.kind;
                        u35 = next_token();
                        kind2 = u35.kind;
                    end;
                else
                    if not v85 then
                        expect(",");
                    end;

                    table.insert(v84, expect("identifier"));
                    v85 = false;
                end;
            end;

            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;
    end;

    local function parse_lambda() -- Line: 541
        -- upvalues: parse_function_body (ref)
        local v89 = parse_function_body();

        return {
            kind = "lambda",
            body = v89,
            span = v89.span
        };
    end;

    function parse_table()
        -- upvalues: expect (copy), kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u59 (ref)
        local x3 = expect("{").span.x;
        local v90 = {};
        local v91 = true;

        while true do
            while kind ~= "\n" do
                if kind == "}" then
                    local y = expect("}").span.y;

                    return {
                        fields = v90,
                        span = vector.create(x3, y, 0)
                    };
                end;

                if v91 then
                    v91 = false;
                else
                    expect(",");
                    v91 = false;
                end;

                while kind == "\n" do
                    u34 = u35;
                    kind = kind2;
                    x = x2;
                    u35 = next_token();
                    kind2 = u35.kind;
                    x2 = u35.span.x;
                end;

                local v92, v93, v94, v95;

                if kind == "identifier" then
                    while kind2 == "\n" do
                        u35 = next_token();
                        kind2 = u35.kind;
                    end;

                    if kind2 == "=" then
                        local v96 = expect("identifier");
                        expect("=");
                        local v97 = {
                            kind = "namekey",
                            name = v96,
                            value = u59()
                        };
                        table.insert(v90, v97);
                    else
                        while kind == "\n" do
                            v92 = kind2;
                            u34 = u35;
                            kind = v92;
                            x = x2;
                            u35 = next_token();
                            kind2 = u35.kind;
                            x2 = u35.span.x;
                        end;

                        if kind == "[" then
                            expect("[");
                            v93 = u59();
                            expect("]");
                            expect("=");
                            v94 = {
                                kind = "exprkey",
                                key = v93,
                                value = u59()
                            };
                            table.insert(v90, v94);
                        else
                            v95 = {
                                kind = "nokey",
                                value = u59()
                            };
                            table.insert(v90, v95);
                        end;
                    end;
                else
                    while kind == "\n" do
                        v92 = kind2;
                        u34 = u35;
                        kind = v92;
                        x = x2;
                        u35 = next_token();
                        kind2 = u35.kind;
                        x2 = u35.span.x;
                    end;

                    if kind == "[" then
                        expect("[");
                        v93 = u59();
                        expect("]");
                        expect("=");
                        v94 = {
                            kind = "exprkey",
                            key = v93,
                            value = u59()
                        };
                        table.insert(v90, v94);
                    else
                        v95 = {
                            kind = "nokey",
                            value = u59()
                        };
                        table.insert(v90, v95);
                    end;
                end;
            end;

            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;
    end;

    function parse_vector()
        -- upvalues: expect (copy), kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u59 (ref)
        local v98 = expect("[");
        local v99 = 0;
        local v100 = {};

        while v99 < 3 do
            while kind == "\n" do
                u34 = u35;
                kind = kind2;
                x = x2;
                u35 = next_token();
                kind2 = u35.kind;
                x2 = u35.span.x;
            end;

            if kind == "]" then
                break;
            end;

            if v99 ~= 0 then
                expect(",");
            end;

            v99 = v99 + 1;
            v100[v99] = u59();
        end;

        local v101 = expect("]");

        return {
            kind = "vector",
            span = vector.create(v98.span.x, v101.span.y, 0),
            contents = v100
        };
    end;

    u59 = function() -- Line: 616, Name: parse_expression
        -- upvalues: kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), expect (copy), u60 (ref), u59 (ref), parse_var (ref), parse_lambda (ref), u3 (copy), u2 (ref), u6 (ref), report (copy)
        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "$" then
            while kind2 == "\n" do
                u35 = next_token();
                kind2 = u35.kind;
            end;

            if kind2 == "(" then
                local x3 = expect("$").span.x;

                while kind2 == "\n" do
                    u35 = next_token();
                    kind2 = u35.kind;
                end;

                local v102;

                if kind2 == "$" then
                    expect("(");
                    v102 = u60();
                else
                    while kind2 == "\n" do
                        u35 = next_token();
                        kind2 = u35.kind;
                    end;

                    if kind2 == "identifier" then
                        expect("(");
                        v102 = u60();
                    else
                        expect("(");
                        v102 = u59();
                    end;
                end;

                local y = expect(")").span.y;

                return {
                    kind = "evaluate",
                    body = v102,
                    span = vector.create(x3, y, 0)
                };
            end;
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "$" then
            local v103 = parse_var();

            return {
                kind = "var",
                var = v103,
                span = v103.span
            };
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "string" then
            local v104 = expect("string");

            return {
                kind = "string",
                token = v104,
                span = v104.span
            };
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "number" then
            local v105 = expect("number");

            return {
                kind = "number",
                token = v105,
                span = v105.span
            };
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "true" then
            local v106 = expect("true");

            return {
                kind = "boolean",
                token = v106,
                span = v106.span
            };
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "false" then
            local v107 = expect("false");

            return {
                kind = "boolean",
                token = v107,
                span = v107.span
            };
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "identifier" then
            local v108 = expect("identifier");

            return {
                kind = "string",
                token = {
                    kind = "string",
                    text = `"{v108.text}"`,
                    span = v108.span
                },
                span = v108.span
            };
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "|" then
            return parse_lambda();
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "{" then
            local v109 = parse_table();

            return {
                kind = "table",
                table = v109,
                span = v109.span
            };
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "[" then
            return parse_vector();
        end;

        if kind ~= "eof" or not u3 then
            return report((`expected expression, got {kind}`));
        end;

        if u3 then
            local v110 = coroutine.yield();
            local v111 = typeof(v110) == "buffer";
            assert(v111);
            u2 = v110;
            u6 = buffer.len(v110);
            u34 = next_token();
            kind = u34.kind;
            u35 = next_token();
            kind2 = u35.kind;
        end;

        return u59();
    end;

    u60 = function() -- Line: 696, Name: parse_command
        -- upvalues: parse_var (ref), kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u59 (ref)
        local v112 = parse_var();
        local v113 = {};

        while kind ~= "\n" do
            while kind == "\n" do
                u34 = u35;
                kind = kind2;
                x = x2;
                u35 = next_token();
                kind2 = u35.kind;
                x2 = u35.span.x;
            end;

            if kind ~= "$" then
                while kind == "\n" do
                    u34 = u35;
                    kind = kind2;
                    x = x2;
                    u35 = next_token();
                    kind2 = u35.kind;
                    x2 = u35.span.x;
                end;

                if kind ~= "string" then
                    while kind == "\n" do
                        u34 = u35;
                        kind = kind2;
                        x = x2;
                        u35 = next_token();
                        kind2 = u35.kind;
                        x2 = u35.span.x;
                    end;

                    if kind ~= "number" then
                        while kind == "\n" do
                            u34 = u35;
                            kind = kind2;
                            x = x2;
                            u35 = next_token();
                            kind2 = u35.kind;
                            x2 = u35.span.x;
                        end;

                        if kind ~= "true" then
                            while kind == "\n" do
                                u34 = u35;
                                kind = kind2;
                                x = x2;
                                u35 = next_token();
                                kind2 = u35.kind;
                                x2 = u35.span.x;
                            end;

                            if kind ~= "false" then
                                while kind == "\n" do
                                    u34 = u35;
                                    kind = kind2;
                                    x = x2;
                                    u35 = next_token();
                                    kind2 = u35.kind;
                                    x2 = u35.span.x;
                                end;

                                if kind ~= "identifier" then
                                    while kind == "\n" do
                                        u34 = u35;
                                        kind = kind2;
                                        x = x2;
                                        u35 = next_token();
                                        kind2 = u35.kind;
                                        x2 = u35.span.x;
                                    end;

                                    if kind ~= "{" then
                                        while kind == "\n" do
                                            u34 = u35;
                                            kind = kind2;
                                            x = x2;
                                            u35 = next_token();
                                            kind2 = u35.kind;
                                            x2 = u35.span.x;
                                        end;

                                        if kind ~= "|" then
                                            while kind == "\n" do
                                                u34 = u35;
                                                kind = kind2;
                                                x = x2;
                                                u35 = next_token();
                                                kind2 = u35.kind;
                                                x2 = u35.span.x;
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

            local v114 = u59();
            table.insert(v113, v114);
        end;

        local v115;

        if #v113 > 0 then
            v115 = v113[#v113].span.y;
        else
            v115 = v112.span.y;
        end;

        return {
            kind = "command",
            prefix = v112,
            arguments = v113,
            span = vector.create(v112.span.x, v115, 0)
        };
    end;

    local function parse_if() -- Line: 731
        -- upvalues: expect (copy), kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u60 (ref), u59 (ref), u61 (ref)
        local x3 = expect("if").span.x;
        local v116 = true;
        local v117 = {};
        local v118 = nil;
        local v119 = 0;

        while true do
            while v116 do
                expect("(");

                while kind == "\n" do
                    u34 = u35;
                    kind = kind2;
                    x = x2;
                    u35 = next_token();
                    kind2 = u35.kind;
                    x2 = u35.span.x;
                end;

                local v120;

                if kind == "identifier" then
                    v120 = u60();
                else
                    v120 = u59();
                end;

                expect(")");
                expect("{");
                local v121 = u61("}");
                v119 = expect("}").span.y;
                table.insert(v117, {
                    condition = v120,
                    block = v121
                });
                v116 = false;
            end;

            while kind == "\n" do
                u34 = u35;
                kind = kind2;
                x = x2;
                u35 = next_token();
                kind2 = u35.kind;
                x2 = u35.span.x;
            end;

            if kind ~= "else" then
                break;
            end;

            while kind2 == "\n" do
                u35 = next_token();
                kind2 = u35.kind;
            end;

            if kind2 ~= "if" then
                break;
            end;

            expect("else");
            expect("if");
            expect("(");

            while kind == "\n" do
                u34 = u35;
                kind = kind2;
                x = x2;
                u35 = next_token();
                kind2 = u35.kind;
                x2 = u35.span.x;
            end;

            local v122;

            if kind == "identifier" then
                v122 = u60();
            else
                v122 = u59();
            end;

            expect(")");
            expect("{");
            local v123 = u61("}");
            v119 = expect("}").span.y;
            table.insert(v117, {
                condition = v122,
                block = v123
            });
        end;

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        if kind == "else" then
            expect("else");
            expect("{");
            v118 = u61("}");
            v119 = expect("}").span.y;
        end;

        return {
            kind = "if",
            ifs = v117,
            fallback = v118,
            span = vector.create(x3, v119, 0)
        };
    end;

    local function parse_while() -- Line: 791
        -- upvalues: expect (copy), kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), u60 (ref), u59 (ref), u61 (ref)
        local x3 = expect("while").span.x;
        expect("(");

        while kind == "\n" do
            u34 = u35;
            kind = kind2;
            x = x2;
            u35 = next_token();
            kind2 = u35.kind;
            x2 = u35.span.x;
        end;

        local v124;

        if kind == "identifier" then
            v124 = u60();
        else
            v124 = u59();
        end;

        expect(")");
        expect("{");
        local v125 = u61("}");
        local y = expect("}").span.y;

        return {
            kind = "while",
            expression = v124,
            block = v125,
            span = vector.create(x3, y, 0)
        };
    end;

    local function parse_for() -- Line: 812
        -- upvalues: expect (copy), u62 (ref), parse_function_body (ref)
        local x3 = expect("for").span.x;
        expect("(");
        local v126 = u62();
        expect(")");
        local v127 = parse_function_body();

        return {
            kind = "for",
            expression = v126,
            call = v127,
            span = vector.create(x3, v127.span.y, 0)
        };
    end;

    local function parse_return() -- Line: 827
        -- upvalues: expect (copy), kind (ref), u59 (ref)
        local span = expect("return").span;
        local x3 = span.x;
        local y = span.y;
        local v128 = {};

        while kind ~= "}" and kind ~= "eof" do
            if #v128 > 0 then
                expect(",");
            end;

            local v129 = u59();
            table.insert(v128, v129);
            y = v129.span.y;
        end;

        return {
            kind = "return",
            values = v128,
            span = vector.create(x3, y, 0)
        };
    end;

    u61 = function(p130, p131) -- Line: 848, Name: parse_block
        -- upvalues: kind (ref), u34 (ref), u35 (ref), kind2 (ref), x (ref), x2 (ref), next_token (copy), expect (copy), u62 (ref), parse_if (ref), parse_while (ref), parse_for (ref), parse_return (ref), u60 (ref), u3 (copy), u2 (ref), u6 (ref)
        local v132 = p131 or 0;
        local v133 = v132;
        local v134 = nil;
        local v135 = {};

        while true do
            if kind == p130 then
                return {
                    span = vector.create(v132, v133, 0),
                    body = v135,
                    last_statement = v134
                };
            end;

            if v134 then
                local v136 = {
                    message = "expected to finish after last statement",
                    span = u34.span
                };
                error(`{v136.message} from {v136.span.x} to {v136.span.y}`, 0);
            end;

            while kind == "\n" do
                u34 = u35;
                kind = kind2;
                x = x2;
                u35 = next_token();
                kind2 = u35.kind;
                x2 = u35.span.x;
            end;

            local v137, v138, v139, v140, v141, v142, v143, v144, v145, v146, v147, v148, v149;

            if kind == "identifier" then
                while kind2 == "\n" do
                    u35 = next_token();
                    kind2 = u35.kind;
                end;

                if kind2 == "=" then
                    local v150 = expect("identifier");
                    expect("=");
                    local v151 = {
                        kind = "assign",
                        left = v150,
                        right = u62()
                    };
                    table.insert(v135, v151);
                else
                    while kind == "\n" do
                        v137 = kind2;
                        u34 = u35;
                        kind = v137;
                        x = x2;
                        u35 = next_token();
                        kind2 = u35.kind;
                        x2 = u35.span.x;
                    end;

                    if kind == "if" then
                        table.insert(v135, parse_if());
                    else
                        while kind == "\n" do
                            v138 = kind2;
                            u34 = u35;
                            kind = v138;
                            x = x2;
                            u35 = next_token();
                            kind2 = u35.kind;
                            x2 = u35.span.x;
                        end;

                        if kind == "while" then
                            table.insert(v135, parse_while());
                        else
                            while kind == "\n" do
                                v139 = kind2;
                                u34 = u35;
                                kind = v139;
                                x = x2;
                                u35 = next_token();
                                kind2 = u35.kind;
                                x2 = u35.span.x;
                            end;

                            if kind == "for" then
                                table.insert(v135, parse_for());
                            else
                                while kind == "\n" do
                                    v140 = kind2;
                                    u34 = u35;
                                    kind = v140;
                                    x = x2;
                                    u35 = next_token();
                                    kind2 = u35.kind;
                                    x2 = u35.span.x;
                                end;

                                if kind == "return" then
                                    v134 = parse_return();
                                else
                                    while kind == "\n" do
                                        v141 = kind2;
                                        u34 = u35;
                                        kind = v141;
                                        x = x2;
                                        u35 = next_token();
                                        kind2 = u35.kind;
                                        x2 = u35.span.x;
                                    end;

                                    if kind == "break" then
                                        v134 = {
                                            kind = "break",
                                            span = expect("break").span
                                        };
                                    else
                                        while kind == "\n" do
                                            v142 = kind2;
                                            u34 = u35;
                                            kind = v142;
                                            x = x2;
                                            u35 = next_token();
                                            kind2 = u35.kind;
                                            x2 = u35.span.x;
                                        end;

                                        if kind == "continue" then
                                            v134 = {
                                                kind = "continue",
                                                span = expect("continue")
                                            };
                                        else
                                            while kind == "\n" do
                                                v143 = kind2;
                                                u34 = u35;
                                                kind = v143;
                                                x = x2;
                                                u35 = next_token();
                                                kind2 = u35.kind;
                                                x2 = u35.span.x;
                                            end;

                                            if kind == "identifier" then
                                                table.insert(v135, u60());
                                            else
                                                while kind == "\n" do
                                                    v144 = kind2;
                                                    u34 = u35;
                                                    kind = v144;
                                                    x = x2;
                                                    u35 = next_token();
                                                    kind2 = u35.kind;
                                                    x2 = u35.span.x;
                                                end;

                                                if kind == "$" then
                                                    table.insert(v135, u60());
                                                else
                                                    while kind == "\n" do
                                                        v145 = kind2;
                                                        u34 = u35;
                                                        kind = v145;
                                                        x = x2;
                                                        u35 = next_token();
                                                        kind2 = u35.kind;
                                                        x2 = u35.span.x;
                                                    end;

                                                    if kind == ";" then
                                                        v146 = kind2;
                                                        u34 = u35;
                                                        kind = v146;
                                                        x = x2;
                                                        u35 = next_token();
                                                        kind2 = u35.kind;
                                                        x2 = u35.span.x;
                                                    elseif kind == "eof" and (p130 ~= "eof" and u3) then
                                                        if u3 then
                                                            v147 = coroutine.yield();
                                                            v148 = typeof(v147) == "buffer";
                                                            assert(v148);
                                                            u2 = v147;
                                                            u6 = buffer.len(v147);
                                                            u34 = next_token();
                                                            kind = u34.kind;
                                                            u35 = next_token();
                                                            kind2 = u35.kind;
                                                        end;
                                                    else
                                                        if kind == p130 then
                                                            v133 = x;
                                                            break;
                                                        end;

                                                        v149 = {
                                                            message = `cannot parse {kind}`,
                                                            span = u34.span
                                                        };
                                                        error(`{v149.message} from {v149.span.x} to {v149.span.y}`, 0);
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
                    v137 = kind2;
                    u34 = u35;
                    kind = v137;
                    x = x2;
                    u35 = next_token();
                    kind2 = u35.kind;
                    x2 = u35.span.x;
                end;

                if kind == "if" then
                    table.insert(v135, parse_if());
                else
                    while kind == "\n" do
                        v138 = kind2;
                        u34 = u35;
                        kind = v138;
                        x = x2;
                        u35 = next_token();
                        kind2 = u35.kind;
                        x2 = u35.span.x;
                    end;

                    if kind == "while" then
                        table.insert(v135, parse_while());
                    else
                        while kind == "\n" do
                            v139 = kind2;
                            u34 = u35;
                            kind = v139;
                            x = x2;
                            u35 = next_token();
                            kind2 = u35.kind;
                            x2 = u35.span.x;
                        end;

                        if kind == "for" then
                            table.insert(v135, parse_for());
                        else
                            while kind == "\n" do
                                v140 = kind2;
                                u34 = u35;
                                kind = v140;
                                x = x2;
                                u35 = next_token();
                                kind2 = u35.kind;
                                x2 = u35.span.x;
                            end;

                            if kind == "return" then
                                v134 = parse_return();
                            else
                                while kind == "\n" do
                                    v141 = kind2;
                                    u34 = u35;
                                    kind = v141;
                                    x = x2;
                                    u35 = next_token();
                                    kind2 = u35.kind;
                                    x2 = u35.span.x;
                                end;

                                if kind == "break" then
                                    v134 = {
                                        kind = "break",
                                        span = expect("break").span
                                    };
                                else
                                    while kind == "\n" do
                                        v142 = kind2;
                                        u34 = u35;
                                        kind = v142;
                                        x = x2;
                                        u35 = next_token();
                                        kind2 = u35.kind;
                                        x2 = u35.span.x;
                                    end;

                                    if kind == "continue" then
                                        v134 = {
                                            kind = "continue",
                                            span = expect("continue")
                                        };
                                    else
                                        while kind == "\n" do
                                            v143 = kind2;
                                            u34 = u35;
                                            kind = v143;
                                            x = x2;
                                            u35 = next_token();
                                            kind2 = u35.kind;
                                            x2 = u35.span.x;
                                        end;

                                        if kind == "identifier" then
                                            table.insert(v135, u60());
                                        else
                                            while kind == "\n" do
                                                v144 = kind2;
                                                u34 = u35;
                                                kind = v144;
                                                x = x2;
                                                u35 = next_token();
                                                kind2 = u35.kind;
                                                x2 = u35.span.x;
                                            end;

                                            if kind == "$" then
                                                table.insert(v135, u60());
                                            else
                                                while kind == "\n" do
                                                    v145 = kind2;
                                                    u34 = u35;
                                                    kind = v145;
                                                    x = x2;
                                                    u35 = next_token();
                                                    kind2 = u35.kind;
                                                    x2 = u35.span.x;
                                                end;

                                                if kind == ";" then
                                                    v146 = kind2;
                                                    u34 = u35;
                                                    kind = v146;
                                                    x = x2;
                                                    u35 = next_token();
                                                    kind2 = u35.kind;
                                                    x2 = u35.span.x;
                                                elseif kind == "eof" and (p130 ~= "eof" and u3) then
                                                    if u3 then
                                                        v147 = coroutine.yield();
                                                        v148 = typeof(v147) == "buffer";
                                                        assert(v148);
                                                        u2 = v147;
                                                        u6 = buffer.len(v147);
                                                        u34 = next_token();
                                                        kind = u34.kind;
                                                        u35 = next_token();
                                                        kind2 = u35.kind;
                                                    end;
                                                else
                                                    if kind == p130 then
                                                        v133 = x;
                                                        break;
                                                    end;

                                                    v149 = {
                                                        message = `cannot parse {kind}`,
                                                        span = u34.span
                                                    };
                                                    error(`{v149.message} from {v149.span.x} to {v149.span.y}`, 0);
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

            v133 = x;
        end;
    end;

    return u61("eof");
end;

return function(p152, u153) -- Line: 932, Name: generate
    -- upvalues: parse (copy)
    local u154 = p152;
    local u155 = coroutine.create(parse);
    local u156 = nil;

    local function append(p157) -- Line: 937
        -- upvalues: u154 (ref), u156 (ref), u155 (copy), u153 (copy)
        u154 = u154 .. p157;
        local v158 = buffer.fromstring(u154);

        return u156(coroutine.resume(u155, v158, u153));
    end;

    local function overwrite(p159) -- Line: 943
        -- upvalues: u154 (ref), u156 (ref), u155 (copy), u153 (copy)
        u154 = p159;
        local v160 = buffer.fromstring(p159);

        return u156(coroutine.resume(u155, v160, u153));
    end;

    u156 = function(p161, p162) -- Line: 949, Name: get_result
        -- upvalues: u155 (copy), u154 (ref), append (copy), overwrite (copy)
        if coroutine.status(u155) == "suspended" then
            return {
                status = "pending",
                src = u154,
                append = append,
                set = overwrite
            };
        end;

        if p161 == false then
            return {
                status = "error",
                src = u154,
                why = p162
            };
        end;

        if coroutine.status(u155) == "dead" then
            return {
                status = "finished",
                src = u154,
                value = p162
            };
        end;

        error("?");
    end;

    return overwrite(p152);
end;