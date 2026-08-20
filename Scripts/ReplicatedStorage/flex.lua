--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     flex
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.components.flex
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:02 2026
]]

-- Decompiled with Potassium's decompiler.

local create = require("../../roblox_packages/vide").create;

return function() -- Line: 5
    -- upvalues: create (copy)
    local u1 = create("UIListLayout")({});

    return setmetatable({ u1 }, {
        __index = {
            row = function(p2) -- Line: 10, Name: row
                -- upvalues: u1 (copy)
                u1.FillDirection = Enum.FillDirection.Vertical;

                return p2;
            end,

            column = function(p3) -- Line: 15, Name: column
                -- upvalues: u1 (copy)
                u1.FillDirection = Enum.FillDirection.Horizontal;

                return p3;
            end,

            layout = function(p4) -- Line: 20, Name: layout
                -- upvalues: u1 (copy)
                u1.SortOrder = Enum.SortOrder.LayoutOrder;

                return p4;
            end,

            name = function(p5) -- Line: 25, Name: name
                -- upvalues: u1 (copy)
                u1.SortOrder = Enum.SortOrder.Name;

                return p5;
            end,

            none = function(p6, p7) -- Line: 30, Name: none
                -- upvalues: u1 (copy)
                if p7 ~= "vertical" then
                    u1.HorizontalFlex = Enum.UIFlexAlignment.None;
                end;

                if p7 ~= "horizontal" then
                    u1.VerticalFlex = Enum.UIFlexAlignment.None;
                end;

                return p6;
            end,

            even = function(p8, p9) -- Line: 40, Name: even
                -- upvalues: u1 (copy)
                if p9 ~= "vertical" then
                    u1.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly;
                end;

                if p9 ~= "horizontal" then
                    u1.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly;
                end;

                return p8;
            end,

            around = function(p10, p11) -- Line: 50, Name: around
                -- upvalues: u1 (copy)
                if p11 ~= "vertical" then
                    u1.HorizontalFlex = Enum.UIFlexAlignment.SpaceAround;
                end;

                if p11 ~= "horizontal" then
                    u1.VerticalFlex = Enum.UIFlexAlignment.SpaceAround;
                end;

                return p10;
            end,

            between = function(p12, p13) -- Line: 60, Name: between
                -- upvalues: u1 (copy)
                if p13 ~= "vertical" then
                    u1.HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween;
                end;

                if p13 ~= "horizontal" then
                    u1.VerticalFlex = Enum.UIFlexAlignment.SpaceBetween;
                end;

                return p12;
            end,

            fill = function(p14, p15) -- Line: 70, Name: fill
                -- upvalues: u1 (copy)
                if p15 ~= "vertical" then
                    u1.HorizontalFlex = Enum.UIFlexAlignment.Fill;
                end;

                if p15 ~= "horizontal" then
                    u1.VerticalFlex = Enum.UIFlexAlignment.Fill;
                end;

                return p14;
            end,

            horizontal = function(p16, p17) -- Line: 80, Name: horizontal
                -- upvalues: u1 (copy)
                local v18;

                if p17 == "left" then
                    v18 = Enum.HorizontalAlignment.Left;
                elseif p17 == "right" then
                    v18 = Enum.HorizontalAlignment.Right;
                else
                    v18 = Enum.HorizontalAlignment.Center;
                end;

                u1.HorizontalAlignment = v18;

                return p16;
            end,

            vertical = function(p19, p20) -- Line: 88, Name: vertical
                -- upvalues: u1 (copy)
                local v21;

                if p20 == "top" then
                    v21 = Enum.VerticalAlignment.Top;
                elseif p20 == "bottom" then
                    v21 = Enum.VerticalAlignment.Bottom;
                else
                    v21 = Enum.VerticalAlignment.Center;
                end;

                u1.VerticalAlignment = v21;

                return p19;
            end,

            gap = function(p22, p23) -- Line: 96, Name: gap
                -- upvalues: u1 (copy)
                u1.Padding = UDim.new(0, p23);

                return p22;
            end
        }
    });
end;