--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     padding
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.components.padding
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:02 2026
]]

-- Decompiled with Potassium's decompiler.

local create = require("../../roblox_packages/vide").create;

return function(p1) -- Line: 16, Name: padding
    -- upvalues: create (copy)
    local v2 = p1.padding or 0;
    local v3 = p1.x or v2;
    local v4 = p1.y or v2;
    local v5 = p1.left or v3;
    local v6 = p1.right or v3;
    local v7 = p1.top or v4;
    local v8 = p1.bottom or v4;

    return create("UIPadding")({
        PaddingLeft = UDim.new(0, v5),
        PaddingRight = UDim.new(0, v6),
        PaddingTop = UDim.new(0, v7),
        PaddingBottom = UDim.new(0, v8)
    });
end;