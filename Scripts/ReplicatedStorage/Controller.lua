--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Controller
  Path:     game.ReplicatedStorage.Library.Controller
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:30 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    connects = {}
};

local function ChangedInput(p2) -- Line: 26
    -- upvalues: u1 (copy)
    for _, v in next, u1.connects do
        v(p2);
    end;
end;

function u1.Connect(p3, p4) -- Line: 32
    -- upvalues: u1 (copy), LocalPlayer (copy)
    table.insert(u1.connects, p4);
    local v5 = LocalPlayer:GetAttribute("Device");

    for _, v in next, u1.connects do
        v(v5);
    end;
end;

function u1.Initialize(p6) -- Line: 38
    -- upvalues: LocalPlayer (copy), u1 (copy)
    task.spawn(function() -- Line: 39
        -- upvalues: LocalPlayer (ref), u1 (ref)
        repeat
            task.wait();
        until LocalPlayer:GetAttribute("Device") ~= nil;

        local v7 = LocalPlayer:GetAttribute("Device");

        for _, v in next, u1.connects do
            v(v7);
        end;

        LocalPlayer:GetAttributeChangedSignal("Device"):Connect(function() -- Line: 44
            -- upvalues: LocalPlayer (ref), u1 (ref)
            local v8 = LocalPlayer:GetAttribute("Device");

            for _, v in next, u1.connects do
                v(v8);
            end;
        end);
    end);
end;

return u1;