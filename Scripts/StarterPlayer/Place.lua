--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Place
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Place
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:28 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Signal");
Library.get("SimpleTween");
local v3 = {};
local u4 = nil;

function v3.Start(p5, p6) -- Line: 27
    -- upvalues: u4 (ref), u1 (copy), u2 (copy)
    u4 = p6;
    local u7 = u1(u4, "Button");
    local u8 = nil;
    u2.new("PlaceButton"):Connect(function(p9) -- Line: 32
        -- upvalues: u4 (ref), u8 (ref), u7 (copy)
        if not p9 then
            if u8 then
                u8:Disconnect();
                u8 = nil;
            end;

            u4.Visible = false;

            return;
        end;

        if u4.Visible then
            return;
        end;

        u4.Visible = true;
        local u10 = false;
        u8 = u7.MouseButton1Click:Connect(function() -- Line: 39
            -- upvalues: u10 (ref)
            if u10 then
                return;
            end;

            u10 = true;

            if _G.PlaceCurrentItem then
                _G.PlaceCurrentItem();
            end;

            task.wait(0.5);
            u10 = false;
        end);
    end);
end;

return v3;