--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     container
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.components.container
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = require("../../roblox_packages/vide");
local create = v1.create;
local read = v1.read;

return function(u2) -- Line: 22
    -- upvalues: create (copy), read (copy)
    return create("Frame")({
        Size = function() -- Line: 24, Name: Size
            -- upvalues: read (ref), u2 (copy)
            return UDim2.fromOffset(read(u2.width) or 0, read(u2.height) or 0);
        end,

        Position = function() -- Line: 30, Name: Position
            -- upvalues: read (ref), u2 (copy)
            return UDim2.new(read(u2.xs) or 0, read(u2.x) or 0, read(u2.ys) or 0, read(u2.y) or 0);
        end,

        AnchorPoint = u2.anchor and function() -- Line: 39
            -- upvalues: read (ref), u2 (copy)
            return Vector2.new(read(u2.anchor)[1] or 0, read(u2.anchor)[2] or 0);
        end or nil,
        AutomaticSize = u2.auto,
        LayoutOrder = u2.layout,
        ZIndex = u2.zindex,
        BackgroundTransparency = 1,
        unpack(u2)
    });
end;