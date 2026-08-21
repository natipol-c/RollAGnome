--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     lib
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch_ui.0.2.5-rc.1.conch_ui.src.lib
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:34 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local u1 = require("./app");
local v2 = require("../roblox_packages/conch");
local v3 = require("./state");
local u4 = require("../roblox_packages/vide");
local u5 = false;
local opened = v3.opened;
local focused = v3.focused;

return {
    app = u1,

    mount = function() -- Line: 12, Name: mount
        -- upvalues: u5 (ref), u4 (copy), u1 (copy), Players (copy)
        if not u5 then
            u5 = true;

            return u4.mount(u1, Players.LocalPlayer:WaitForChild("PlayerGui"));
        end;
    end,

    opened = opened,

    bind_to = function(u6) -- Line: 18, Name: bind_to
        -- upvalues: u5 (ref), u4 (copy), u1 (copy), Players (copy), UserInputService (copy), opened (copy), focused (copy)
        if not u5 then
            u5 = true;
            u4.mount(u1, Players.LocalPlayer:WaitForChild("PlayerGui"));
        end;

        UserInputService.InputBegan:Connect(function(p7) -- Line: 20
            -- upvalues: u6 (copy), opened (ref), focused (ref)
            if p7.KeyCode ~= u6 and p7.UserInputType ~= u6 then
                return;
            end;

            opened(not opened());
            focused(opened());
        end);
    end,

    conch = v2
};