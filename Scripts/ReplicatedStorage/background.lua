--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     background
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.components.background
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:05 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../theme");
local v2 = require("../../roblox_packages/vide");
local create = v2.create;
local read = v2.read;

return function(u3) -- Line: 24
    -- upvalues: create (copy), read (copy), u1 (copy)
    return create("Frame")({
        Size = function() -- Line: 26, Name: Size
            -- upvalues: read (ref), u3 (copy)
            local v4 = read(u3.width);
            local v5 = read(u3.height);

            return UDim2.new(v4 and 0 or 1, v4 or 0, v5 and 0 or 1, v5 or 0);
        end,

        Position = function() -- Line: 35, Name: Position
            -- upvalues: read (ref), u3 (copy)
            return UDim2.new(read(u3.xs) or 0, read(u3.x) or 0, read(u3.ys) or 0, read(u3.y) or 0);
        end,

        AnchorPoint = u3.anchor and function() -- Line: 44
            -- upvalues: read (ref), u3 (copy)
            return Vector2.new(read(u3.anchor)[1] or 0, read(u3.anchor)[2] or 0);
        end or nil,
        AutomaticSize = u3.auto,
        LayoutOrder = u3.layout,
        BackgroundColor3 = u3.color or u1.background,
        BackgroundTransparency = u1.background_transparency,
        unpack(u3)
    });
end;