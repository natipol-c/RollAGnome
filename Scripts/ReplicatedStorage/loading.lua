--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     loading
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.components.loading
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:02 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../theme");
local v2 = require("../../roblox_packages/vide");
local create = v2.create;
local source = v2.source;
local cleanup = v2.cleanup;
local read = v2.read;
local u3 = { "-", "/", "|", "\\" };

return function(u4) -- Line: 34
    -- upvalues: source (copy), cleanup (copy), create (copy), read (copy), u3 (copy), u1 (copy)
    local u5 = source(0);
    local u6 = task.spawn(function() -- Line: 36
        -- upvalues: u5 (copy)
        while true do
            u5(u5() + task.wait());
        end;
    end);
    cleanup(function() -- Line: 42
        -- upvalues: u6 (copy)
        task.cancel(u6);
    end);

    return create("TextLabel")({
        Size = function() -- Line: 45, Name: Size
            -- upvalues: read (ref), u4 (copy)
            local v7 = read(u4.width);
            local v8 = read(u4.height);

            return UDim2.new(0, v7 or 0, 0, v8 or 0);
        end,

        Position = function() -- Line: 49, Name: Position
            -- upvalues: read (ref), u4 (copy)
            return UDim2.new(read(u4.xs) or 0, read(u4.x) or 0, read(u4.ys) or 0, read(u4.y) or 0);
        end,

        AnchorPoint = u4.anchor and function() -- Line: 58
            -- upvalues: read (ref), u4 (copy)
            return Vector2.new(read(u4.anchor)[1] or 0, read(u4.anchor)[2] or 0);
        end or nil,
        AutomaticSize = u4.auto,
        LayoutOrder = u4.layout,
        BackgroundTransparency = 1,

        Text = function() -- Line: 70, Name: Text
            -- upvalues: u3 (ref), u5 (copy), u4 (copy)
            return `{u3[u5() * u4.speed // 1 % 4 + 1]} - {u5() * 100 // 1 / 100}\ts`;
        end,

        TextSize = u4.text_size,
        TextColor3 = u4.color or function() -- Line: 74
            -- upvalues: u4 (copy), read (ref), u1 (ref)
            local text_style = u4.text_style;

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
        end,

        FontFace = function() -- Line: 83, Name: FontFace
            -- upvalues: u1 (ref), read (ref), u4 (copy)
            local v9 = u1.font();
            local v10 = read(u4.weight) or Enum.FontWeight.Regular;

            return Font.new(v9.Family, v10);
        end,

        TextWrapped = u4.wrapped,
        TextXAlignment = u4.xalignment,
        BackgroundTransparency = 1,
        unpack(u4)
    });
end;