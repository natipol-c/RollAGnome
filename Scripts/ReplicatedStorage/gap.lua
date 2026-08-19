--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     gap
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.components.gap
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

return function(u2) -- Line: 14
    -- upvalues: create (copy), read (copy)
    return create("Frame")({
        Name = "gap",

        Size = function() -- Line: 17, Name: Size
            -- upvalues: read (ref), u2 (copy)
            return UDim2.fromOffset(read(u2.width) or 0, read(u2.height) or 0);
        end,

        BackgroundTransparency = 1,
        unpack(u2)
    });
end;