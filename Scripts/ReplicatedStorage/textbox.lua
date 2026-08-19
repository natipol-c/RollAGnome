--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     textbox
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.components.textbox
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../theme");
local v2 = require("../../roblox_packages/vide");
local create = v2.create;
local source = v2.source;
local effect = v2.effect;
local changed = v2.changed;
local read = v2.read;

return function(u3) -- Line: 30
    -- upvalues: source (copy), create (copy), read (copy), u1 (copy), changed (copy), effect (copy)
    local u4 = source("");
    local v5 = create("TextBox");
    local v6 = {
        Size = function() -- Line: 33, Name: Size
            -- upvalues: read (ref), u3 (copy)
            return UDim2.fromOffset(read(u3.width) or 0, read(u3.height) or 0);
        end,

        AutomaticSize = Enum.AutomaticSize.XY,
        Text = u3.text,
        PlaceholderText = u3.placeholder,
        TextSize = u3.text_size or 16,
        TextColor3 = u1.text,
        TextXAlignment = u3.xalignment,
        MultiLine = u3.multiline,
        FontFace = u1.font,
        BackgroundTransparency = 1
    };
    local v7;

    if u3.update_text then
        v7 = changed("Text", u3.update_text);
    else
        v7 = nil;
    end;

    v6[1], v6[2] = v7, changed("Text", u4);

    function v6.Focused() -- Line: 54
        -- upvalues: u3 (copy)
        if not u3.update_focused then
            return;
        end;

        u3.update_focused(true);
    end;

    function v6.FocusLost(p8) -- Line: 59
        -- upvalues: u3 (copy), u4 (copy)
        if u3.update_focused then
            u3.update_focused(false);
        end;

        if not p8 then
            return;
        end;

        if not u3.focused then
            return;
        end;

        u3.enter(u4());
    end;

    v6[3] = unpack(u3);
    local u9 = v5(v6);
    effect(function() -- Line: 69
        -- upvalues: read (ref), u3 (copy), u9 (copy)
        local u10 = read(u3.focused);

        if u9:IsFocused() == u10 then
            return;
        end;

        task.defer(function() -- Line: 72
            -- upvalues: u10 (copy), u9 (ref)
            if u10 then
                u9:CaptureFocus();

                return;
            end;

            u9:ReleaseFocus(false);
        end);
    end);

    return u9;
end;