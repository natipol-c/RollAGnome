--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     text
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.components.text
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:34 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../theme");
local v2 = require("../../roblox_packages/vide");
local create = v2.create;
local read = v2.read;

return function(u3) -- Line: 23
    -- upvalues: create (copy), read (copy), u1 (copy)
    local v4 = create("TextLabel");
    local v5 = {
        Size = function() -- Line: 25, Name: Size
            -- upvalues: read (ref), u3 (copy)
            return UDim2.fromOffset(read(u3.width) or 0, read(u3.height) or 0);
        end
    };
    local v6;

    if u3.width and u3.height then
        v6 = nil;
    elseif u3.width then
        v6 = Enum.AutomaticSize.Y;
    else
        v6 = Enum.AutomaticSize.X;
    end;

    v5.AutomaticSize = v6;
    v5.Text = u3.text;
    v5.TextSize = u3.text_size;

    function v5.TextColor3() -- Line: 38
        -- upvalues: u3 (copy), read (ref), u1 (ref)
        local text_style = u3.text_style;

        if read(text_style) == "normal" then
            return u1.text();
        end;

        if read(text_style) == "warn" then
            return u1.text_warn();
        end;

        if read(text_style) == "error" then
            return u1.text_error();
        end;

        if read(text_style) == "info" then
            return u1.text_info();
        end;

        return u1.text();
    end;

    function v5.FontFace() -- Line: 47
        -- upvalues: u1 (ref), read (ref), u3 (copy)
        local v7 = u1.font();
        local v8 = read(u3.weight) or Enum.FontWeight.Regular;

        return Font.new(v7.Family, v8);
    end;

    v5.TextWrapped = u3.wrapped;
    v5.TextXAlignment = u3.xalignment;
    v5.LayoutOrder = u3.order;
    v5.BackgroundTransparency = 1;
    v5[1] = unpack(u3);

    return v4(v5);
end;