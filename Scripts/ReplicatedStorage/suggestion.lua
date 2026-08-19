--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     suggestion
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.components.suggestion
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("./background");
local u2 = require("./container");
local u3 = require("./flex");
local u4 = require("./padding");
local u5 = require("./text");
local v6 = require("../../roblox_packages/vide");
local show = v6.show;
local indexes = v6.indexes;
local source = v6.source;
local effect = v6.effect;

return function(u7) -- Line: 49
    -- upvalues: source (copy), effect (copy), u2 (copy), u3 (copy), show (copy), u1 (copy), u4 (copy), u5 (copy), indexes (copy)
    local u8 = source(u7.selected());
    effect(function() -- Line: 52
        -- upvalues: u7 (copy), u8 (copy)
        local v9 = u7.selected();
        local v10 = u8();
        local v11 = u8() + 10 - 1;

        if v11 >= v9 then
            if v9 < v10 then
                u8(u8() + (v9 - v10));
            end;

            return;
        end;

        u8(u8() + (v9 - v11));
    end);

    return u2({
        x = u7.x,
        y = u7.y,
        width = 300,
        auto = "Y",
        anchor = { 0, 1 },
        zindex = 10000,
        u3():column():gap(4):vertical("bottom"),
        show(u7.analyzing, function() -- Line: 77
            -- upvalues: u7 (copy), u1 (ref), u3 (ref), u4 (ref), u5 (ref)
            local function _() -- Line: 78
                -- upvalues: u7 (ref)
                return u7.analyzing() or {
                    kind = "",
                    name = "",
                    description = "",
                    optional = false
                };
            end;

            return u1({
                width = 300,
                layout = 10,
                auto = Enum.AutomaticSize.Y,
                {
                    BackgroundTransparency = 0
                },
                u3(),
                u1({
                    height = 24,
                    width = 300,
                    u3():column():between("horizontal"):vertical("center"),
                    u4({
                        x = 4
                    }),
                    u5({
                        text_size = 20,

                        text = function() -- Line: 104, Name: text
                            -- upvalues: u7 (ref)
                            return (u7.analyzing() or {
                                kind = "",
                                name = "",
                                description = "",
                                optional = false
                            }).kind == "variadic" and "..." or ((u7.analyzing() or {
                                kind = "",
                                name = "",
                                description = "",
                                optional = false
                            }).name or "");
                        end,

                        weight = Enum.FontWeight.Bold
                    }),
                    u5({
                        text_size = 18,

                        text = function() -- Line: 114, Name: text
                            -- upvalues: u7 (ref)
                            return `{(u7.analyzing() or {
                                kind = "",
                                name = "",
                                description = "",
                                optional = false
                            }).type}{(u7.analyzing() or {
                                kind = "",
                                name = "",
                                description = "",
                                optional = false
                            }).optional and "?" or ""}` or "";
                        end,

                        weight = Enum.FontWeight.Light
                    })
                }),
                u5({
                    u4({
                        padding = 4
                    }),
                    width = 300,
                    wrapped = true,
                    text_size = 16,
                    xalignment = Enum.TextXAlignment.Left,

                    text = function() -- Line: 130, Name: text
                        -- upvalues: u7 (ref)
                        return (u7.analyzing() or {
                            kind = "",
                            name = "",
                            description = "",
                            optional = false
                        }).description or "";
                    end
                })
            });
        end),
        show(function() -- Line: 135
            -- upvalues: u7 (copy)
            return u7.suggestions()[1] ~= nil;
        end, function() -- Line: 135
            -- upvalues: u1 (ref), u3 (ref), indexes (ref), u7 (copy), u8 (copy), u5 (ref), u4 (ref)
            return u1({
                ys = 1,
                width = 200,
                height = 0,
                anchor = { 0, 1 },
                auto = Enum.AutomaticSize.Y,
                {
                    BackgroundTransparency = 0
                },
                u3():vertical("bottom"),
                indexes(function() -- Line: 148
                    -- upvalues: u7 (ref), u8 (ref)
                    local v12 = u7.suggestions();
                    table.sort(v12, function(p13, p14) -- Line: 153
                        return p13.name < p14.name;
                    end);
                    local v15 = {};

                    for i = u8(), u8() + 10 - 1 do
                        v15[i - u8() + 1] = v12[i];
                    end;

                    return v15;
                end, function(u16, u17) -- Line: 162
                    -- upvalues: u5 (ref), u7 (ref), u8 (ref), u4 (ref)
                    return u5({
                        width = 200,
                        height = 20,
                        order = u17,
                        text_size = 16,
                        xalignment = Enum.TextXAlignment.Left,

                        text = function() -- Line: 170, Name: text
                            -- upvalues: u16 (copy)
                            return u16().name;
                        end,

                        text_style = function() -- Line: 171, Name: text_style
                            -- upvalues: u17 (copy), u7 (ref), u8 (ref)
                            return u17 == u7.selected() - u8() + 1 and "info" or "normal";
                        end,

                        u4({
                            left = 4
                        })
                    });
                end)
            });
        end)
    });
end;