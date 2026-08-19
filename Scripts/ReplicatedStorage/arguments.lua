--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     arguments
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch.0.2.5-rc.2.conch.src.arguments
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local v1 = require("./console");
local u2 = require("./context");
require("./types");

local function noop(p3) -- Line: 7
    return p3;
end;

local function wrap_if_not(p4) -- Line: 9
    return type(p4) ~= "table" and { p4 } or p4;
end;

local v5 = {
    convert = tostring,
    analysis = {
        kind = "argument",
        optional = false,
        name = "string",
        type = "string"
    }
};

local function enum_map(u6, p7, p8) -- Line: 234
    return {
        convert = function(p9) -- Line: 240, Name: convert
            -- upvalues: u6 (copy)
            local v10 = tostring(p9);

            if u6[v10] == nil then
                error(`{v10} is not valid`, 0);
            end;

            return u6[v10];
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = p7 or "enum",
            description = p8,
            type = p7 or "enum",

            suggestion_generator = function(p11) -- Line: 252, Name: suggestion_generator
                -- upvalues: u6 (copy)
                local v12 = p11:lower();
                local v13 = {};

                for i in u6 do
                    local v14 = i:lower();

                    if string.sub(v14, 1, #v12) == v12 then
                        if string.find(i, "[^%w_-]") then
                            local i = string.format("%q", i);
                        end;

                        table.insert(v13, i);
                    end;
                end;

                return v13;
            end
        }
    };
end;

local function convert_arg_to_player(p15) -- Line: 283
    -- upvalues: u2 (copy), Players (copy)
    local v16 = u2.get_command_context();

    if p15 == "@s" then
        return v16 and v16.executor.player or error("not executed by a player");
    end;

    if typeof(p15) == "number" then
        local v17 = Players:GetPlayerByUserId(p15);
        local v18 = `player with id {p15} is not in this server`;

        return assert(v17, v18);
    end;

    if typeof(p15) == "string" then
        local v19 = Players:FindFirstChild(p15);
        local v20 = `player "{p15}" is not valid`;

        return assert(v19, v20);
    end;

    if typeof(p15) == "Instance" and p15:IsA("Player") then
        return p15;
    end;

    error((`unknown arg {p15}`));
end;

local function convert_arg_to_players(p21) -- Line: 308
    -- upvalues: Players (copy), convert_arg_to_player (copy)
    if p21 == "@a" then
        return Players:GetPlayers();
    end;

    if typeof(p21) ~= "table" then
        return { convert_arg_to_player(p21) };
    end;

    local v22 = table.clone(p21);

    for i, v in v22 do
        v22[i] = convert_arg_to_player(v);
    end;

    return v22;
end;

local function convert_arg_to_userid(u23) -- Line: 391
    -- upvalues: u2 (copy), Players (copy)
    local v24 = u2.get_command_context();

    if u23 == "@s" then
        return v24 and (v24.executor.player and v24.executor.player.UserId) or error("not executed by a player");
    end;

    if typeof(u23) == "number" then
        local success, result = pcall(function() -- Line: 400
            -- upvalues: Players (ref), u23 (copy)
            return Players:GetNameFromUserIdAsync(u23);
        end);

        if not success and result:find("Unknown User") then
            error(`No user found with UserId {u23}`, 0);
        end;

        return u23;
    end;

    if typeof(u23) == "string" then
        local v25 = Players:FindFirstChild(u23);

        if v25 then
            assert(v25:IsA("Player"));

            return v25.UserId;
        end;

        local success, result = pcall(function() -- Line: 413
            -- upvalues: Players (ref), u23 (copy)
            return Players:GetUserIdFromNameAsync(u23);
        end);

        if success or not result:find("Unknown User") then
            error(`Could not fetch player name, try again later: {u23}`, 0);

            return result;
        end;

        error(`No user found with name {u23}`, 0);

        return result;
    end;

    if typeof(u23) == "Instance" and u23:IsA("Player") then
        return u23.UserId;
    end;

    error(`unknown arg {u23}`, 0);
end;

local function convert_arg_to_userids(p26) -- Line: 435
    -- upvalues: Players (copy), convert_arg_to_userid (copy)
    if p26 == "@a" then
        p26 = Players:GetPlayers();
    end;

    if typeof(p26) ~= "table" then
        return { convert_arg_to_userid(p26) };
    end;

    local v27 = {};

    for i, v in v27 do
        v27[i] = convert_arg_to_userid(v);
    end;

    return v27;
end;

local u28 = {
    ms = 0.001,
    milisecond = 0.001,
    s = 1,
    sec = 1,
    second = 1,
    min = 60,
    minute = 60,
    hr = 3600,
    hour = 3600,
    d = 86400,
    day = 86400,
    wk = 604800,
    week = 604800,
    mo = 2592000,
    month = 2592000,
    y = 31536000,
    yr = 31536000,
    year = 31536000
};

local function parse_duration(p29) -- Line: 610
    -- upvalues: u28 (copy)
    local v30 = 0;

    for _, v in string.split(p29, " ") do
        local v31, v32 = string.match(v, "(.-)([A-z]+)$");

        if v31 and v32 then
            local v33 = u28[v32];

            if not v33 then
                error(`"{v33}" is not a valid suffix`, 0);
            end;

            local v34 = tonumber(v31);

            if not v34 then
                error(`could not convert "{v}" into a duration`, 0);
            end;

            v30 = v30 + v34 * v33;
        else
            local v35 = tonumber(v);

            if not v35 then
                error(`could not convert "{v}" into a duration`, 0);
            end;

            v30 = v30 + v35;
        end;
    end;

    return v30;
end;

local function optional(p36) -- Line: 695
    p36.optional = true;

    return p36;
end;

return {
    any = v1.register_type("any", {
        convert = noop,
        analysis = {
            kind = "argument",
            optional = false,
            name = "any",
            type = "any"
        }
    }),
    string = v1.register_type("string", v5),
    strings = v1.register_type("strings", {
        convert = function(p37) -- Line: 36, Name: convert
            if typeof(p37) ~= "table" then
                return { (tostring(p37)) };
            end;

            local v38 = table.clone(p37);

            for i, v in v38 do
                v38[i] = tostring(v);
            end;

            return v38;
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "strings",
            type = "{ string }"
        }
    }),
    number = v1.register_type("number", {
        convert = function(p39) -- Line: 57, Name: convert
            local v40 = tonumber(p39);

            if v40 == nil then
                error((`{p39} is not a valid number`));
            end;

            return v40;
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "number",
            type = "number"
        }
    }),
    numbers = v1.register_type("numbers", {
        convert = function(p41) -- Line: 72, Name: convert
            local v42 = type(p41) ~= "table" and { p41 } or p41;
            local v43 = {};

            for i, _ in v42 do
                local v44 = tonumber(v42);

                if v44 == nil then
                    error((`{v42} is not a valid number`));
                end;

                v43[i] = v44;
            end;

            return v43;
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "numbers",
            type = "{ number }"
        }
    }),
    boolean = v1.register_type("boolean", {
        convert = function(p45) -- Line: 92, Name: convert
            if typeof(p45) == "boolean" then
                return p45;
            end;

            if typeof(p45) == "number" and p45 > 0 then
                return true;
            end;

            if typeof(p45) == "number" and p45 <= 0 then
                return false;
            end;

            error((`{typeof(p45)} is not a valid boolean`));
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "boolean",
            type = "boolean",

            suggestion_generator = function(p46) -- Line: 110, Name: suggestion_generator
                local v47 = {};

                if string.sub("true", 1, #p46) == p46 then
                    table.insert(v47, "true");
                end;

                if string.sub("false", 1, #p46) == p46 then
                    table.insert(v47, "false");
                end;

                return v47;
            end
        }
    }),
    booleans = v1.register_type("booleans", {
        convert = function(p48) -- Line: 127, Name: convert
            if typeof(p48) == "table" then
                local v49 = table.clone(p48);

                for i, v in v49 do
                    if typeof(v) == "boolean" then
                        v49[i] = v;
                    elseif typeof(v) == "number" and v > 0 then
                        v49[i] = true;
                    elseif typeof(v) == "number" and v <= 0 then
                        v49[i] = false;
                    else
                        error((`type {typeof(v)} of {i} is not a valid boolean`));
                    end;
                end;

                return v49;
            end;

            if typeof(p48) == "boolean" then
                return { p48 };
            end;

            if typeof(p48) == "number" and p48 > 0 then
                return { true };
            end;

            if typeof(p48) == "number" and p48 <= 0 then
                return { false };
            end;

            error((`{typeof(p48)} is not a valid boolean`));
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "boolean",
            type = "boolean",

            suggestion_generator = function(p50) -- Line: 159, Name: suggestion_generator
                local v51 = {};

                if string.sub("true", 1, #p50) == p50 then
                    table.insert(v51, "true");
                end;

                if string.sub("false", 1, #p50) == p50 then
                    table.insert(v51, "false");
                end;

                return v51;
            end
        }
    }),
    table = v1.register_type("table", {
        convert = noop,
        analysis = {
            kind = "argument",
            optional = false,
            name = "table",
            type = "table"
        }
    }),
    vector = v1.register_type("vector", {
        convert = function(p52) -- Line: 186, Name: into_vector
            if type(p52) == "vector" then
                return p52;
            end;

            if typeof(p52) == "table" then
                return vector.create(p52[1] or 0, p52[2] or 0, p52[3] or 0);
            end;

            error(`{p52} is not valid`, 0);
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "vector",
            type = "vector"
        }
    }),
    vectors = v1.register_type("vectors", {
        convert = function(p53) -- Line: 207, Name: convert
            if type(p53) == "vector" then
                return { p53 };
            end;

            if typeof(p53) == "table" then
                local v54 = {};

                for i, v in p53 do
                    if type(v) ~= "vector" then
                        local v;

                        if typeof(v) == "table" then
                            v = vector.create(v[1] or 0, v[2] or 0, v[3] or 0);
                        else
                            error(`{v} is not valid`, 0);
                            v = nil;
                        end;
                    end;

                    v54[i] = v;
                end;

                return v54;
            end;

            error(`{p53} is not valid`, 0);
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "vector",
            type = "vector"
        }
    }),
    player = v1.register_type("player", {
        convert = function(p55) -- Line: 327, Name: convert
            -- upvalues: convert_arg_to_player (copy)
            return convert_arg_to_player(p55);
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "player",
            type = "Player",

            suggestion_generator = function(p56) -- Line: 334, Name: suggestion_generator
                -- upvalues: Players (copy)
                local v57 = p56:lower();
                local v58 = {};

                if string.sub("@s", 1, #v57) == v57 then
                    table.insert(v58, "@s");
                end;

                for _, v in Players:GetPlayers() do
                    local v59 = v.Name:lower();

                    if string.sub(v59, 1, #v57) == v57 then
                        table.insert(v58, v.Name);
                    else
                        local v60 = v.DisplayName:lower();

                        if string.sub(v60, 1, #v57) == v57 then
                            table.insert(v58, v.Name);
                        end;
                    end;
                end;

                return v58;
            end
        }
    }),
    players = v1.register_type("players", {
        convert = function(p61) -- Line: 358, Name: convert
            -- upvalues: convert_arg_to_players (copy)
            return convert_arg_to_players(p61);
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "players",
            type = "{ Player }",

            suggestion_generator = function(p62) -- Line: 365, Name: suggestion_generator
                -- upvalues: Players (copy)
                local v63 = p62:lower();
                local v64 = {};

                if string.sub("@s", 1, #v63) == v63 then
                    table.insert(v64, "@s");
                end;

                if string.sub("@a", 1, #v63) == v63 then
                    table.insert(v64, "@a");
                end;

                for _, v in Players:GetPlayers() do
                    local v65 = v.Name:lower();

                    if string.sub(v65, 1, #v63) == v63 then
                        table.insert(v64, v.Name);
                    else
                        local v66 = v.DisplayName:lower();

                        if string.sub(v66, 1, #v63) == v63 then
                            table.insert(v64, v.Name);
                        end;
                    end;
                end;

                return v64;
            end
        }
    }),
    userid = v1.register_type("userid", {
        convert = function(p67) -- Line: 454, Name: convert
            -- upvalues: convert_arg_to_userid (copy)
            return convert_arg_to_userid(p67);
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "userid",
            type = "number",

            suggestion_generator = function(p68) -- Line: 461, Name: suggestion_generator
                -- upvalues: Players (copy)
                local v69 = p68:lower();
                local v70 = {};

                if string.sub("@s", 1, #v69) == v69 then
                    table.insert(v70, "@s");
                end;

                for _, v in Players:GetPlayers() do
                    local v71 = v.Name:lower();

                    if string.sub(v71, 1, #v69) == v69 then
                        table.insert(v70, v.Name);
                    else
                        local v72 = v.DisplayName:lower();

                        if string.sub(v72, 1, #v69) == v69 then
                            table.insert(v70, v.Name);
                        end;
                    end;
                end;

                return v70;
            end
        }
    }),
    userids = v1.register_type("userids", {
        convert = function(p73) -- Line: 485, Name: convert
            -- upvalues: convert_arg_to_userids (copy)
            return convert_arg_to_userids(p73);
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "userids",
            type = "{ number }",

            suggestion_generator = function(p74) -- Line: 492, Name: suggestion_generator
                -- upvalues: Players (copy)
                local v75 = p74:lower();
                local v76 = {};

                if string.sub("@s", 1, #v75) == v75 then
                    table.insert(v76, "@s");
                end;

                if string.sub("@a", 1, #v75) == v75 then
                    table.insert(v76, "@a");
                end;

                for _, v in Players:GetPlayers() do
                    local v77 = v.Name:lower();

                    if string.sub(v77, 1, #v75) == v75 then
                        table.insert(v76, v.Name);
                    else
                        local v78 = v.DisplayName:lower();

                        if string.sub(v78, 1, #v75) == v75 then
                            table.insert(v76, v.Name);
                        end;
                    end;
                end;

                return v76;
            end
        }
    }),
    color = v1.register_type("color", {
        convert = function(p79) -- Line: 519, Name: convert
            if typeof(p79) == "Color3" then
                return p79;
            end;

            if typeof(p79) == "string" then
                return Color3.fromHex(p79);
            end;

            if type(p79) == "vector" then
                return Color3.fromRGB(p79.x, p79.y, p79.z);
            end;

            return error(`cannot convert {typeof(p79)} into color3`, 0);
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "Color3",
            type = "Color3"
        }
    }),
    colors = v1.register_type("colors", {
        convert = function(p80) -- Line: 540, Name: convert
            if typeof(p80) == "Color3" then
                return p80;
            end;

            if typeof(p80) == "string" then
                return Color3.fromHex(p80);
            end;

            if type(p80) == "vector" then
                return Color3.fromRGB(p80.x, p80.y, p80.z);
            end;

            if typeof(p80) ~= "table" then
                return error(`cannot convert {typeof(p80)} into color3`, 0);
            end;

            local v81 = {};

            for i, v in p80 do
                local v82;

                if typeof(v) == "Color3" then
                    v82 = p80;
                elseif typeof(v) == "string" then
                    v82 = Color3.fromHex(v);
                elseif type(v) == "vector" then
                    v82 = Color3.fromRGB(v.x, v.y, v.z);
                else
                    v82 = error(`cannot convert {typeof(p80)} into color3`, 0);
                end;

                v81[i] = v82;
            end;

            return v81;
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "Color3",
            type = "Color3"
        }
    }),
    duration = v1.register_type("duration", {
        convert = function(p83) -- Line: 637, Name: convert
            -- upvalues: parse_duration (copy)
            if typeof(p83) == "number" then
                return p83;
            end;

            return parse_duration(p83);
        end,

        analysis = {
            kind = "argument",
            optional = false,
            name = "duration",
            type = "number",

            suggestion_generator = function(p84) -- Line: 647, Name: suggestion_generator
                -- upvalues: u28 (copy)
                local v85 = string.split(p84, " ");
                local v86 = v85[#v85] or "1";
                local v87 = {};
                local v88 = table.concat(v85, " ", 1, #v85 - 1);
                local v89, v90 = string.match(v86, "(.-)([A-z]+)$");

                if v90 then
                    for i in u28 do
                        if v90 == string.sub(i, 1, #v90) then
                            local v91 = `{v89}{i}`;
                            table.insert(v87, v91);
                        end;
                    end;
                else
                    for i in u28 do
                        local v92 = `{v86}{i}`;
                        table.insert(v87, v92);
                    end;
                end;

                if #v88 > 0 then
                    v88 = `{v88} `;
                end;

                for i, v in v87 do
                    v87[i] = `"{v88}{v}"`;
                end;

                return v87;
            end
        }
    }),
    userinput = v1.register_type("userinput", ((function(p93) -- Line: 677, Name: generate_names_for_enum
        -- upvalues: enum_map (copy)
        local v94 = {};

        for _, v in p93:GetEnumItems() do
            v94[v.Name] = v;
        end;

        return enum_map(v94, (tostring(p93)));
    end)(Enum.UserInputType))),

    variadic = function(p95) -- Line: 689, Name: variadic
        p95.kind = "varargs";

        return p95;
    end,

    optional = optional,
    opt = optional,

    enum_new = function(p96, p97, p98) -- Line: 273, Name: enum_new
        -- upvalues: enum_map (copy)
        local v99 = {};

        for _, v in p96 do
            v99[tostring(v)] = v;
        end;

        return enum_map(v99, p97, p98);
    end,

    enum_map = enum_map
};