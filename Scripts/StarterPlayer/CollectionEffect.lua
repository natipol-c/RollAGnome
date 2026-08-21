--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CollectionEffect
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.CollectionEffect
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:40 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Workspace = game:GetService("Workspace");
local v1 = {};
local u2 = {};
local u3 = nil;
local u4 = Random.new();

local function getRootPart(p5) -- Line: 23
    if p5:IsA("BasePart") then
        return p5;
    end;

    if p5:IsA("Model") then
        return p5.PrimaryPart or (p5:FindFirstChild("CenterPart", true) or p5:FindFirstChildWhichIsA("BasePart", true));
    end;

    return nil;
end;

local function getPivot(p6) -- Line: 35
    if p6:IsA("Model") then
        return p6:GetPivot();
    end;

    if p6:IsA("BasePart") then
        return p6.CFrame;
    end;

    return CFrame.new();
end;

local function pivotTo(p7, p8) -- Line: 45
    if p7:IsA("Model") then
        p7:PivotTo(p8);

        return;
    end;

    if p7:IsA("BasePart") then
        p7.CFrame = p8;
    end;
end;

local function setScale(p9, p10, p11) -- Line: 53
    if p9:IsA("Model") then
        p9:ScaleTo(p10);

        return;
    end;

    if p9:IsA("BasePart") and p11 then
        p9.Size = p11 * p10;
    end;
end;

local function prepVisual(p12) -- Line: 61
    if not p12:IsA("BasePart") then
        for _, descendant in p12:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
            end;
        end;

        return;
    end;

    p12.Anchored = true;
    p12.CanCollide = false;
    p12.CanQuery = false;
    p12.CanTouch = false;
end;

local function getBezier(p13, p14, p15, p16) -- Line: 80
    local v17 = 1 - p16;

    return v17 * v17 * p13 + 2 * v17 * p16 * p14 + p16 * p16 * p15;
end;

local function ease(p18) -- Line: 87
    -- upvalues: TweenService (copy)
    return TweenService:GetValue(p18, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
end;

local function stopRenderLoop() -- Line: 91
    -- upvalues: u3 (ref)
    if u3 then
        u3:Disconnect();
        u3 = nil;
    end;
end;

local function startRenderLoop() -- Line: 98
    -- upvalues: u3 (ref), RunService (copy), u2 (copy), TweenService (copy)
    if u3 then
        return;
    end;

    u3 = RunService.RenderStepped:Connect(function(p19) -- Line: 101
        -- upvalues: u2 (ref), TweenService (ref), u3 (ref)
        for i = #u2, 1, -1 do
            local v20 = u2[i];
            local Visual = v20.Visual;
            local Target = v20.Target;

            if Visual.Parent and Target.Parent then
                v20.Elapsed = v20.Elapsed + p19;
                v20.ScaleElapsed = v20.ScaleElapsed + p19;
                local v21 = math.clamp(v20.Elapsed / v20.Duration, 0, 1);
                local v22 = TweenService:GetValue(v21, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                local Position = Target.Position;
                local v23 = (v20.StartPosition + Position) / 2 + Vector3.new(0, v20.ArcHeight, 0) + v20.Side;
                local v24 = 1 - v22;
                local v25 = v24 * v24 * v20.StartPosition + 2 * v24 * v22 * v23 + v22 * v22 * Position;

                if v20.ScaleElapsed >= 0.05 or v21 >= 1 then
                    v20.ScaleElapsed = 0;
                    local v26 = v20.StartScale * (1 - 0.5 * v22);
                    local BasePartSize = v20.BasePartSize;

                    if Visual:IsA("Model") then
                        Visual:ScaleTo(v26);
                    elseif Visual:IsA("BasePart") and BasePartSize then
                        Visual.Size = BasePartSize * v26;
                    end;
                end;

                local v27 = CFrame.new(v25) * v20.StartPivot.Rotation;

                if Visual:IsA("Model") then
                    Visual:PivotTo(v27);
                elseif Visual:IsA("BasePart") then
                    Visual.CFrame = v27;
                end;

                if v21 >= 1 then
                    table.remove(u2, i);

                    if v20.OnReached then
                        v20.OnReached();
                    end;

                    Visual:Destroy();
                end;
            else
                table.remove(u2, i);
                Visual:Destroy();
            end;
        end;

        if #u2 == 0 and u3 then
            u3:Disconnect();
            u3 = nil;
        end;
    end);
end;

function v1.Play(p28, p29, p30) -- Line: 148
    -- upvalues: u4 (copy), prepVisual (copy), Workspace (copy), u2 (copy), u3 (ref), RunService (copy), TweenService (copy)
    if p29 then
        p29 = p29:FindFirstChild("HumanoidRootPart");
    end;

    if not p28 then
        return;
    end;

    if not (p29 and p29:IsA("BasePart")) then
        p28:Destroy();

        return;
    end;

    local v31;

    if p28:IsA("BasePart") then
        v31 = p28;
    elseif p28:IsA("Model") then
        v31 = p28.PrimaryPart or (p28:FindFirstChild("CenterPart", true) or p28:FindFirstChildWhichIsA("BasePart", true));
    else
        v31 = nil;
    end;

    if not v31 then
        p28:Destroy();

        return;
    end;

    local v32;

    if p28:IsA("Model") then
        v32 = p28:GetPivot();
    elseif p28:IsA("BasePart") then
        v32 = p28.CFrame;
    else
        v32 = CFrame.new();
    end;

    local Position = v32.Position;
    local v33 = u4:NextNumber(-1, 1);
    local v34 = Vector3.new(v33, 0, u4:NextNumber(-1, 1));
    local v35 = (v34.Magnitude < 0.05 and Vector3.new(1, 0, 0) or v34).Unit * u4:NextNumber(4, 10);
    local v36 = u4:NextNumber(5, 10);
    prepVisual(p28);

    if p28:IsA("Model") then
        p28:PivotTo(v32);
    elseif p28:IsA("BasePart") then
        p28.CFrame = v32;
    end;

    p28.Parent = Workspace;
    local v37 = {
        Elapsed = 0,
        ScaleElapsed = 0.05,
        Visual = p28,
        Target = p29,
        StartPivot = v32,
        StartPosition = Position,
        Side = v35,
        ArcHeight = v36,
        StartScale = not p28:IsA("Model") and 1 or p28:GetScale(),
        BasePartSize = p28:IsA("BasePart") and p28.Size or nil,
        Duration = u4:NextNumber(0.25, 1.05),
        OnReached = p30
    };
    table.insert(u2, v37);

    if u3 then
        return;
    end;

    u3 = RunService.RenderStepped:Connect(function(p38) -- Line: 101
        -- upvalues: u2 (ref), TweenService (ref), u3 (ref)
        for i = #u2, 1, -1 do
            local v39 = u2[i];
            local Visual = v39.Visual;
            local Target = v39.Target;

            if Visual.Parent and Target.Parent then
                v39.Elapsed = v39.Elapsed + p38;
                v39.ScaleElapsed = v39.ScaleElapsed + p38;
                local v40 = math.clamp(v39.Elapsed / v39.Duration, 0, 1);
                local v41 = TweenService:GetValue(v40, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                local Position2 = Target.Position;
                local v42 = (v39.StartPosition + Position2) / 2 + Vector3.new(0, v39.ArcHeight, 0) + v39.Side;
                local v43 = 1 - v41;
                local v44 = v43 * v43 * v39.StartPosition + 2 * v43 * v41 * v42 + v41 * v41 * Position2;

                if v39.ScaleElapsed >= 0.05 or v40 >= 1 then
                    v39.ScaleElapsed = 0;
                    local v45 = v39.StartScale * (1 - 0.5 * v41);
                    local BasePartSize = v39.BasePartSize;

                    if Visual:IsA("Model") then
                        Visual:ScaleTo(v45);
                    elseif Visual:IsA("BasePart") and BasePartSize then
                        Visual.Size = BasePartSize * v45;
                    end;
                end;

                local v46 = CFrame.new(v44) * v39.StartPivot.Rotation;

                if Visual:IsA("Model") then
                    Visual:PivotTo(v46);
                elseif Visual:IsA("BasePart") then
                    Visual.CFrame = v46;
                end;

                if v40 >= 1 then
                    table.remove(u2, i);

                    if v39.OnReached then
                        v39.OnReached();
                    end;

                    Visual:Destroy();
                end;
            else
                table.remove(u2, i);
                Visual:Destroy();
            end;
        end;

        if #u2 == 0 and u3 then
            u3:Disconnect();
            u3 = nil;
        end;
    end);
end;

return v1;