--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Library
  Path:     game.ReplicatedStorage.Library
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:30 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local v1 = {};
local u2 = {};

function v1.get(p3) -- Line: 26
    -- upvalues: u2 (copy)
    if string.match(type(p3), "string") then
        if u2[p3] then
            return u2[p3];
        end;

        local v4 = script:FindFirstChild(p3) or (script.Imported:FindFirstChild(p3) or script.Configs:FindFirstChild(p3));

        if v4 and v4:IsA("ModuleScript") then
            u2[p3] = require(v4);

            return u2[p3];
        end;
    end;
end;

function v1.Initialize(p5) -- Line: 42
    -- upvalues: u2 (copy), RunService (copy), ReplicatedStorage (copy)
    tick();
    local u6 = 0;
    local success, result = pcall(function() -- Line: 46
        -- upvalues: u2 (ref), u6 (ref)
        local v7 = next;
        local v8, v9 = script:GetChildren();

        for _, v in v7, v8, v9 do
            if v:IsA("ModuleScript") then
                u2[v.Name] = require(v);

                if type(u2[v.Name]) == "table" and u2[v.Name].Initialize then
                    task.spawn(function() -- Line: 54
                        -- upvalues: u2 (ref), v (copy), u6 (ref)
                        u2[v.Name]:Initialize();
                        u6 = tick();
                    end);
                end;
            end;
        end;
    end);

    if success then
        RunService.Heartbeat:Wait();
        ReplicatedStorage:SetAttribute("ClientLoaded", true);
        PrintMessage();

        return "Success";
    end;

    warn(result);
end;

function PrintMessage()
    -- upvalues: RunService (copy)
    if not RunService:IsStudio() then
        print("\t\t\n\t\t\n\t\t⚠️ Report all messages colored (red or yellow), in our server\n\t\t\n\t\t        - (^^)\n\t\t          \n\t\t          \n\t\t");
    end;
end;

return v1;