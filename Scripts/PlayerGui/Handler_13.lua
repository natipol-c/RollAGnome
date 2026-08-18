--[[
  Type:     LocalScript
  Method:   cached
  Name:     Handler
  Path:     game.Players.Palukalima37806.PlayerGui.Notifications.BottomFrame.SanityDroppingMessage.Handler
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:10 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local u1 = 0;

local function update() -- Line: 23
    -- upvalues: u1 (ref), LocalPlayer (copy)
    u1 = u1 + 1;
    local u2 = u1;

    if LocalPlayer:GetAttribute("InDarkness") then
        task.delay(5, function() -- Line: 34
            -- upvalues: u2 (copy), u1 (ref), LocalPlayer (ref)
            if u2 ~= u1 then
                return;
            end;

            if LocalPlayer:GetAttribute("InDarkness") then
                script.Parent.Visible = true;
            end;
        end);

        return;
    end;

    script.Parent.Visible = false;
end;

u1 = u1 + 1;
local u3 = u1;

if LocalPlayer:GetAttribute("InDarkness") then
    task.delay(5, function() -- Line: 34
        -- upvalues: u3 (copy), u1 (ref), LocalPlayer (copy)
        if u3 ~= u1 then
            return;
        end;

        if LocalPlayer:GetAttribute("InDarkness") then
            script.Parent.Visible = true;
        end;
    end);
else
    script.Parent.Visible = false;
end;

LocalPlayer:GetAttributeChangedSignal("InDarkness"):Connect(update);