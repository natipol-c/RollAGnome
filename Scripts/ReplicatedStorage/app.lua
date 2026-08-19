--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     app
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.app
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

local TextService = game:GetService("TextService");
local UserInputService = game:GetService("UserInputService");
local u1 = require("./components/background");
local u2 = require("../roblox_packages/conch");
local u3 = require("./components/corner");
local u4 = require("./components/flex");
local u5 = require("./components/gap");
local u6 = require("./components/loading");
local u7 = require("./components/padding");
local u8 = require("./components/screen");
local u9 = require("./state");
local u10 = require("./components/suggestion");
local u11 = require("./components/text");
local u12 = require("./components/textbox");
local u13 = require("./theme");
local u14 = require("../roblox_packages/vide");
local source = u14.source;
local derive = u14.derive;
local show = u14.show;
local changed = u14.changed;
local effect = u14.effect;
local cleanup = u14.cleanup;
local indexes = u14.indexes;
local u15 = 0;
local u16 = {};

return function() -- Line: 34
    -- upvalues: u9 (copy), u2 (copy), source (copy), derive (copy), effect (copy), u13 (copy), TextService (copy), cleanup (copy), UserInputService (copy), u15 (ref), u16 (copy), u8 (copy), u4 (copy), u7 (copy), show (copy), u14 (copy), u10 (copy), u1 (copy), u3 (copy), indexes (copy), u11 (copy), u5 (copy), u6 (copy), u12 (copy), changed (copy)
    local function output(p17) -- Line: 35
        -- upvalues: u9 (ref)
        for _, v in string.split(p17.text, "\n") do
            local v18 = u9.logs();
            table.insert(v18, 1, {
                kind = p17.kind,
                text = v
            });
            table.remove(v18, 100);
            u9.logs(v18);
        end;
    end;

    u2.console.output = output;

    for _, v in string.split(
        "Conch 0.2.x\nCopyright (c) alicesays_hallo - This project is licensed under MIT, you can view the included license with `license`",
        "\n"
    ) do
        output({
            kind = "normal",
            text = v
        });
    end;

    output({
        kind = "warn",
        text = "If you got here accidentally, run the `close-ui` command to close this UI."
    });
    u2.register("clear", {
        description = "Clears the console.",
        permissions = {},

        arguments = function() -- Line: 59, Name: arguments
        end,

        callback = function() -- Line: 60, Name: callback
            -- upvalues: u9 (ref)
            u9.logs({});
        end
    });
    u2.register("close-ui", {
        description = "Close the CLI",
        permissions = {},

        arguments = function() -- Line: 66, Name: arguments
        end,

        callback = function() -- Line: 67, Name: callback
            -- upvalues: u9 (ref)
            u9.opened(false);
            u9.focused(false);
        end
    });
    local u19 = source("");
    local u20 = source(false);
    local u21 = source(0);
    local u22 = source(Vector2.zero);
    local u23 = source();
    local u24 = derive(function() -- Line: 79
        -- upvalues: u23 (copy), u19 (copy)
        debug.profilebegin("this");

        if u23() then
            debug.profileend();

            return u23().src .. u19();
        end;

        debug.profileend();

        return u19();
    end);
    local u26 = derive(function() -- Line: 90
        -- upvalues: u2 (ref), u24 (copy)
        local v25 = u2.parse(u24());

        if v25.status == "error" then
            return v25.why;
        end;

        return nil;
    end);
    local u27 = source(u2.analyze("", 0));
    local u28 = source(1);
    effect(function() -- Line: 99
        -- upvalues: u28 (copy), u27 (copy)
        local v29 = u28();
        local v30 = #u27().suggestions;
        local v31 = math.max(1, v30);
        u28((math.clamp(v29, 1, v31)));
    end);
    local u32 = false;
    effect(function() -- Line: 111
        -- upvalues: u19 (copy), u21 (copy), u32 (ref), u27 (copy), u2 (ref)
        u19();
        u21();

        if u32 then
            return;
        end;

        u32 = true;
        task.defer(function() -- Line: 116
            -- upvalues: u32 (ref), u27 (ref), u2 (ref), u19 (ref), u21 (ref)
            u32 = false;
            u27(u2.analyze(u19(), u21() - 1));
        end);
    end);
    local u35 = derive(function() -- Line: 123
        -- upvalues: u19 (copy), u21 (copy)
        local v33 = u19();
        local v34 = u21() - 1;

        return string.sub(v33, 1, v34);
    end);
    local u36 = source(Vector3.new(0, 0, 0));
    local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
    GetTextBoundsParams.Font = u13.font();
    GetTextBoundsParams.RichText = false;
    GetTextBoundsParams.Size = 20;
    GetTextBoundsParams.Width = 100000;
    effect(function() -- Line: 134
        -- upvalues: u35 (copy), GetTextBoundsParams (copy), TextService (ref), u36 (copy)
        local u37 = u35();
        GetTextBoundsParams.Text = u37;
        task.spawn(function() -- Line: 137
            -- upvalues: TextService (ref), GetTextBoundsParams (ref), u37 (copy), u35 (ref), u36 (ref)
            local v38 = TextService:GetTextBoundsAsync(GetTextBoundsParams);

            if u37 ~= u35() then
                return;
            end;

            u36(v38);
        end);
    end);

    local function autofill(p39, p40, p41) -- Line: 144
        -- upvalues: u21 (copy)
        local v42 = string.sub(p39, 1, p40.x);
        local v43 = string.sub(p39, p40.y + 1, -1);
        task.defer(u21, p40.x + #p41 + 2);

        return v42 .. p41 .. " " .. v43;
    end;

    cleanup(UserInputService.InputBegan:Connect(function(p44) -- Line: 152
        -- upvalues: u27 (copy), u15 (ref), u16 (ref), u19 (copy), u21 (copy), u28 (copy)
        if p44.KeyCode ~= Enum.KeyCode.Down then
            if p44.KeyCode == Enum.KeyCode.Up then
                if #u27().suggestions == 0 then
                    if u15 == 0 then
                        u16[u15] = u19();
                    end;

                    u15 = math.clamp(u15 + 1, 0, #u16);
                    u19(u16[u15] or "");
                    u21(#u19() + 1);

                    return;
                end;

                local v45 = u28() - 1;
                u28((math.max(1, v45)));
            end;

            return;
        end;

        if #u27().suggestions == 0 then
            if u15 == 0 then
                u16[u15] = u19();
            end;

            u15 = math.clamp(u15 - 1, 0, #u16);
            u19(u16[u15] or "");
            u21(#u19() + 1);

            return;
        end;

        local v46 = u28() + 1;
        local v47 = #u27().suggestions;
        u28((math.min(v46, v47)));
    end));
    local u48 = false;

    return u8({
        name = "Command Executor",
        display_order = 100000,
        enabled = u9.opened,
        u4():fill("horizontal"):vertical("bottom"),
        u7({
            padding = 12
        }),
        show(u27, function() -- Line: 187
            -- upvalues: u14 (ref), u10 (ref), u35 (copy), u36 (copy), u22 (copy), u28 (copy), u27 (copy)
            return u14.create("Folder")({ u10({
                    x = function() -- Line: 190, Name: x
                        -- upvalues: u35 (ref)
                        local v49 = string.split(u35(), "\n");

                        return #v49[#v49] * 10 + 10;
                    end,

                    y = function() -- Line: 194, Name: y
                        -- upvalues: u36 (ref), u22 (ref)
                        return u36().Y + u22().Y - 20;
                    end,

                    selected = u28,

                    analyzing = function() -- Line: 201, Name: analyzing
                        -- upvalues: u27 (ref)
                        return u27().analyzing;
                    end,

                    suggestions = function() -- Line: 202, Name: suggestions
                        -- upvalues: u27 (ref)
                        return u27().suggestions;
                    end
                }) });
        end),
        u1({
            auto = "Y",
            u4(),
            u3(4),
            u7({
                y = 4
            }),
            indexes(function() -- Line: 214
                -- upvalues: u26 (copy), u27 (copy)
                local v50 = u26();
                local v51 = table.clone(u27() and u27().logs or {});

                if v50 then
                    table.insert(v51, {
                        kind = "error",
                        text = v50
                    });
                end;

                return v51;
            end, function(u52, p53) -- Line: 221
                -- upvalues: u11 (ref), u7 (ref)
                return u11({
                    order = 0 - p53 + 100,
                    height = 20,

                    text = function() -- Line: 226, Name: text
                        -- upvalues: u52 (copy)
                        return u52().text;
                    end,

                    text_size = 16,

                    text_style = function() -- Line: 228, Name: text_style
                        -- upvalues: u52 (copy)
                        return u52().kind;
                    end,

                    xalignment = Enum.TextXAlignment.Left,
                    u7({
                        x = 8
                    })
                });
            end),
            indexes(u9.logs, function(u54, p55) -- Line: 235
                -- upvalues: u11 (ref), u7 (ref)
                return u11({
                    height = 20,
                    order = -p55 - 1,

                    text = function() -- Line: 240, Name: text
                        -- upvalues: u54 (copy)
                        return u54().text;
                    end,

                    text_size = 16,

                    text_style = function() -- Line: 242, Name: text_style
                        -- upvalues: u54 (copy)
                        return u54().kind;
                    end,

                    xalignment = Enum.TextXAlignment.Left,
                    u7({
                        x = 8
                    })
                });
            end)
        }),
        u5({
            height = 4
        }),
        u1({
            auto = Enum.AutomaticSize.Y,
            u3(4),
            show(u20, function() -- Line: 258
                -- upvalues: u6 (ref)
                return u6({
                    height = 18,
                    speed = 6,
                    text_size = 18,
                    xalignment = Enum.TextXAlignment.Left
                });
            end, function() -- Line: 266
                -- upvalues: u12 (ref), u19 (copy), u48 (ref), u21 (copy), u27 (copy), u28 (copy), u23 (copy), u2 (ref), u15 (ref), u16 (ref), u9 (ref), u20 (copy), changed (ref)
                return u12({
                    text = u19,

                    update_text = function(p56) -- Line: 269, Name: update_text
                        -- upvalues: u48 (ref), u21 (ref), u27 (ref), u19 (ref), u28 (ref)
                        local v57 = u48 or u21();
                        local v58 = string.sub(p56, v57 - 1, v57 - 1);
                        local suggestions = u27().suggestions;

                        if v58 == "\t" and suggestions[1] then
                            local v59 = u19();
                            local replace = suggestions[u28()].replace;
                            local with = suggestions[u28()].with;
                            local v60 = string.sub(v59, 1, replace.x);
                            local v61 = string.sub(v59, replace.y + 1, -1);
                            task.defer(u21, replace.x + #with + 2);
                            p56 = v60 .. with .. " " .. v61;
                        end;

                        u19(p56);
                    end,

                    placeholder = "Enter your command",
                    text_size = 18,
                    xalignment = Enum.TextXAlignment.Left,

                    multiline = function() -- Line: 289, Name: multiline
                        -- upvalues: u23 (ref), u2 (ref), u19 (ref)
                        if u23() then
                            return u2.parse(u23().src .. u19(), "yield").status == "pending";
                        end;

                        return u2.parse(u19(), "yield").status == "pending";
                    end,

                    enter = function(p62) -- Line: 302, Name: enter
                        -- upvalues: u15 (ref), u16 (ref), u19 (ref), u9 (ref), u23 (ref), u2 (ref), u20 (ref)
                        u15 = 0;
                        table.insert(u16, 1, p62);
                        u19("");
                        u9.focused(true);

                        if u23() then
                            u23(u23().append(p62));
                        else
                            u23(u2.parse(p62, true));
                        end;

                        if u23().status ~= "pending" then
                            u20(true);
                            u23(nil);
                            u2.execute(p62);
                            u20(false);
                        end;
                    end,

                    focused = u9.focused,
                    update_focused = u9.focused,
                    {
                        CursorPosition = u21,
                        changed("CursorPosition", function(p63) -- Line: 327
                            -- upvalues: u48 (ref), u21 (ref)
                            if u48 then
                                u48 = p63;

                                return;
                            end;

                            u48 = p63;
                            task.defer(function() -- Line: 335
                                -- upvalues: u21 (ref), u48 (ref)
                                u21(u48);
                                u48 = false;
                            end);
                        end)
                    }
                });
            end),
            u7({
                x = 8,
                y = 8
            }),
            u4():fill():vertical("center"):horizontal("left"),
            changed("AbsolutePosition", u22)
        })
    });
end;