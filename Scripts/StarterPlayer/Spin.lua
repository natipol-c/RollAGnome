--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Spin
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Effects Controller.Spin
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

local function Loop(p5) -- Line: 28
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

    u3.loop = RunService.RenderStepped:Connect(function() -- Line: 42
        -- upvalues: u4 (ref), u1 (ref), Loop (ref)
        local v6 = false;

        for i, v in next, u4 do
            v6 = true;

            if v.CanLoop then
                v.CanLoop = false;
                local v7 = math.rad(v.Inverted and -45 or 45);
                local v8 = v.Speed / 8;

                if v.IsModel then
                    local CFrameValue = Instance.new("CFrameValue");
                    CFrameValue.Value = i:GetPivot();
                    v.PivotValue = CFrameValue;
                    v.PivotConnection = CFrameValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 59
                        -- upvalues: i (copy), CFrameValue (copy)
                        if i.Parent then
                            i:PivotTo(CFrameValue.Value);
                        end;
                    end);
                    u1:Tween(CFrameValue, v8, "Linear", "Out", {
                        Value = i:GetPivot() * CFrame.Angles(0, v7, 0)
                    }, nil, function() -- Line: 67
                        -- upvalues: v (copy), u4 (ref), i (copy)
                        if v.PivotConnection then
                            v.PivotConnection:Disconnect();
                            v.PivotConnection = nil;
                        end;

                        if v.PivotValue then
                            v.PivotValue:Destroy();
                            v.PivotValue = nil;
                        end;

                        if u4[i] then
                            v.CanLoop = true;
                        end;
                    end);
                else
                    u1:Tween(i, v8, "Linear", "Out", {
                        Orientation = i.Orientation + Vector3.new(0, v.Inverted and -45 or 45, 0)
                    }, nil, function() -- Line: 89
                        -- upvalues: u4 (ref), i (copy), v (copy)
                        if u4[i] then
                            v.CanLoop = true;
                        end;
                    end);
                end;
            end;
        end;

        if not v6 then
            Loop(true);
        end;
    end);
end;

local function Added(p9) -- Line: 104
    -- upvalues: u4 (copy), u3 (copy), RunService (copy), u1 (copy), Loop (copy)
    if not p9:IsDescendantOf(workspace) then
        return;
    end;

    if u4[p9] then
        return;
    end;

    local v10 = math.random(0, 360);
    local v11 = math.rad(v10);

    if not p9:IsA("Model") then
        if p9:IsA("BasePart") then
            local Orientation = p9.Orientation;
            local v12 = math.random(0, 360);
            p9.Orientation = Orientation + Vector3.new(0, v12, 0);
            u4[p9] = {
                IsModel = false,
                CanLoop = true,
                Speed = p9:GetAttribute("SpinSpeed") or 4,
                Inverted = p9:GetAttribute("Invert") or false
            };

            if u3.loop then
                return;
            end;

            u3.loop = RunService.RenderStepped:Connect(function() -- Line: 42
                -- upvalues: u4 (ref), u1 (ref), Loop (ref)
                local v13 = false;

                for i, v in next, u4 do
                    v13 = true;

                    if v.CanLoop then
                        v.CanLoop = false;
                        local v14 = math.rad(v.Inverted and -45 or 45);
                        local v15 = v.Speed / 8;

                        if v.IsModel then
                            local CFrameValue = Instance.new("CFrameValue");
                            CFrameValue.Value = i:GetPivot();
                            v.PivotValue = CFrameValue;
                            v.PivotConnection = CFrameValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 59
                                -- upvalues: i (copy), CFrameValue (copy)
                                if i.Parent then
                                    i:PivotTo(CFrameValue.Value);
                                end;
                            end);
                            u1:Tween(CFrameValue, v15, "Linear", "Out", {
                                Value = i:GetPivot() * CFrame.Angles(0, v14, 0)
                            }, nil, function() -- Line: 67
                                -- upvalues: v (copy), u4 (ref), i (copy)
                                if v.PivotConnection then
                                    v.PivotConnection:Disconnect();
                                    v.PivotConnection = nil;
                                end;

                                if v.PivotValue then
                                    v.PivotValue:Destroy();
                                    v.PivotValue = nil;
                                end;

                                if u4[i] then
                                    v.CanLoop = true;
                                end;
                            end);
                        else
                            u1:Tween(i, v15, "Linear", "Out", {
                                Orientation = i.Orientation + Vector3.new(0, v.Inverted and -45 or 45, 0)
                            }, nil, function() -- Line: 89
                                -- upvalues: u4 (ref), i (copy), v (copy)
                                if u4[i] then
                                    v.CanLoop = true;
                                end;
                            end);
                        end;
                    end;
                end;

                if not v13 then
                    Loop(true);
                end;
            end);
        end;

        return;
    end;

    p9:PivotTo(p9:GetPivot() * CFrame.Angles(0, v11, 0));
    u4[p9] = {
        IsModel = true,
        CanLoop = true,
        Speed = p9:GetAttribute("SpinSpeed") or 4,
        Inverted = p9:GetAttribute("Invert") or false
    };

    if u3.loop then
        return;
    end;

    u3.loop = RunService.RenderStepped:Connect(function() -- Line: 42
        -- upvalues: u4 (ref), u1 (ref), Loop (ref)
        local v16 = false;

        for i, v in next, u4 do
            v16 = true;

            if v.CanLoop then
                v.CanLoop = false;
                local v17 = math.rad(v.Inverted and -45 or 45);
                local v18 = v.Speed / 8;

                if v.IsModel then
                    local CFrameValue = Instance.new("CFrameValue");
                    CFrameValue.Value = i:GetPivot();
                    v.PivotValue = CFrameValue;
                    v.PivotConnection = CFrameValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 59
                        -- upvalues: i (copy), CFrameValue (copy)
                        if i.Parent then
                            i:PivotTo(CFrameValue.Value);
                        end;
                    end);
                    u1:Tween(CFrameValue, v18, "Linear", "Out", {
                        Value = i:GetPivot() * CFrame.Angles(0, v17, 0)
                    }, nil, function() -- Line: 67
                        -- upvalues: v (copy), u4 (ref), i (copy)
                        if v.PivotConnection then
                            v.PivotConnection:Disconnect();
                            v.PivotConnection = nil;
                        end;

                        if v.PivotValue then
                            v.PivotValue:Destroy();
                            v.PivotValue = nil;
                        end;

                        if u4[i] then
                            v.CanLoop = true;
                        end;
                    end);
                else
                    u1:Tween(i, v18, "Linear", "Out", {
                        Orientation = i.Orientation + Vector3.new(0, v.Inverted and -45 or 45, 0)
                    }, nil, function() -- Line: 89
                        -- upvalues: u4 (ref), i (copy), v (copy)
                        if u4[i] then
                            v.CanLoop = true;
                        end;
                    end);
                end;
            end;
        end;

        if not v16 then
            Loop(true);
        end;
    end);
end;

local function Removed(p19) -- Line: 142
    -- upvalues: u4 (copy)
    local v20 = u4[p19];

    if not v20 then
        return;
    end;

    if v20.PivotConnection then
        v20.PivotConnection:Disconnect();
    end;

    if v20.PivotValue then
        v20.PivotValue:Destroy();
    end;

    u4[p19] = nil;
end;

function v2.Initialize(p21) -- Line: 160
    -- upvalues: CollectionService (copy), Added (copy), Removed (copy)
    task.spawn(function() -- Line: 161
        -- upvalues: CollectionService (ref), Added (ref), Removed (ref)
        CollectionService:GetInstanceAddedSignal("Spin"):Connect(Added);
        CollectionService:GetInstanceRemovedSignal("Spin"):Connect(Removed);
        local v22 = next;
        local v23, v24 = CollectionService:GetTagged("Spin");

        for _, v in v22, v23, v24 do
            Added(v);
        end;
    end);
end;

return v2;