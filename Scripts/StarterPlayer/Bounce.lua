--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Bounce
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Effects Controller.Bounce
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:40 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local u1 = require(ReplicatedStorage.Library).get("SimpleTween");
local v2 = {};
local u3 = {};
local u4 = {};

local function Loop(p5) -- Line: 29
    -- upvalues: u3 (copy), RunService (copy), u4 (copy), u1 (copy), Loop (copy)
    if p5 then
        if u3.loop then
            u3.loop:Disconnect();
            u3.loop = nil;
        end;

        return;
    end;

    if u3.loop then
        return;
    end;

    u3.loop = RunService.RenderStepped:Connect(function() -- Line: 40
        -- upvalues: u4 (ref), u1 (ref), Loop (ref)
        local v6 = false;

        for i, v in next, u4 do
            v6 = true;

            if v.CanLoop then
                v.CanLoop = false;

                if not v.IsModel then
                    u1:Tween(i, v.Speed, "Sine", "InOut", {
                        Position = i.Position + Vector3.new(0, 1, 0)
                    }, true, function() -- Line: 53
                        -- upvalues: v (copy)
                        v.CanLoop = true;
                    end);
                end;
            end;
        end;

        if not v6 then
            Loop(true);
        end;
    end);
end;

local function Added(p7) -- Line: 66
    -- upvalues: u4 (copy), u3 (copy), RunService (copy), u1 (copy), Loop (copy)
    if not p7:IsDescendantOf(workspace) then
        return;
    end;

    if not u4[p7] then
        if p7:IsA("Model") then
            return;
        end;

        if p7:IsA("BasePart") then
            u4[p7] = {
                Speed = 4,
                IsModel = false,
                CanLoop = true
            };

            if u3.loop then
                return;
            end;

            u3.loop = RunService.RenderStepped:Connect(function() -- Line: 40
                -- upvalues: u4 (ref), u1 (ref), Loop (ref)
                local v8 = false;

                for i, v in next, u4 do
                    v8 = true;

                    if v.CanLoop then
                        v.CanLoop = false;

                        if not v.IsModel then
                            u1:Tween(i, v.Speed, "Sine", "InOut", {
                                Position = i.Position + Vector3.new(0, 1, 0)
                            }, true, function() -- Line: 53
                                -- upvalues: v (copy)
                                v.CanLoop = true;
                            end);
                        end;
                    end;
                end;

                if not v8 then
                    Loop(true);
                end;
            end);
        end;
    end;
end;

local function Removed(p9) -- Line: 84
    -- upvalues: u4 (copy)
    if u4[p9] then
        u4[p9] = nil;
    end;
end;

function v2.Initialize(p10) -- Line: 90
    -- upvalues: CollectionService (copy), Added (copy), Removed (copy)
    task.spawn(function() -- Line: 91
        -- upvalues: CollectionService (ref), Added (ref), Removed (ref)
        CollectionService:GetInstanceAddedSignal("Bounce"):Connect(Added);
        CollectionService:GetInstanceRemovedSignal("Bounce"):Connect(Removed);
        local v11 = next;
        local v12, v13 = CollectionService:GetTagged("Bounce");

        for _, v in v11, v12, v13 do
            Added(v);
        end;
    end);
end;

return v2;