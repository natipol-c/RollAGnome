--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rainbow
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Rainbow
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:09 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local u1 = {};
local v2 = {};

local function add(p3) -- Line: 23
    -- upvalues: u1 (copy)
    if p3:IsA("BasePart") then
        u1[p3] = true;
    end;
end;

local function remove(p4) -- Line: 29
    -- upvalues: u1 (copy)
    u1[p4] = nil;
end;

function v2.Initialize(p5) -- Line: 33
    -- upvalues: CollectionService (copy), u1 (copy), add (copy), remove (copy), RunService (copy)
    for _, v in CollectionService:GetTagged("RAINBOW") do
        if v:IsA("BasePart") then
            u1[v] = true;
        end;
    end;

    CollectionService:GetInstanceAddedSignal("RAINBOW"):Connect(add);
    CollectionService:GetInstanceRemovedSignal("RAINBOW"):Connect(remove);
    local u6 = 0;
    RunService.Heartbeat:Connect(function() -- Line: 42
        -- upvalues: u6 (ref), u1 (ref)
        local v7 = os.clock();

        if v7 - u6 < 0.1 then
            return;
        end;

        u6 = v7;
        local v8 = Color3.fromHSV(workspace:GetServerTimeNow() * 0.15 % 1, 1, 1);

        for i in u1 do
            if i.Parent then
                i.Color = v8;
            else
                u1[i] = nil;
            end;
        end;
    end);
end;

return v2;