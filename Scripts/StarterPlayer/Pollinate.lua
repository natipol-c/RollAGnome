--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Pollinate
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Pets.Actions.Pollinate
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:09 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");

local function GetPet(p1) -- Line: 6
    -- upvalues: Workspace (copy)
    local Plots = Workspace:FindFirstChild("Plots");

    if not Plots then
        return nil;
    end;

    for _, descendant in Plots:GetDescendants() do
        if descendant.Name == "ClientPets" then
            local v2 = descendant:FindFirstChild(p1);

            if v2 and v2:IsA("Model") then
                return v2;
            end;
        end;
    end;

    return nil;
end;

return function(p3, p4, p5) -- Line: 18, Name: Pollinate
    -- upvalues: GetPet (copy), RunService (copy)
    local v6 = GetPet(p3);

    if not v6 or (typeof(p4) ~= "Instance" or not p4.Parent) then
        return;
    end;

    local v7 = v6:GetPivot();
    local v8 = p4:GetPivot() - Vector3.new(0, 3, 0);
    local v9 = math.max((p5 or 1.2) - 0.35, 0.35);
    v6:SetAttribute("ActionLocked", true);
    local v10 = os.clock();

    while v6.Parent and (p4.Parent and os.clock() - v10 < v9) do
        local v11 = (os.clock() - v10) / v9;
        local v12 = math.clamp(v11, 0, 1);
        local v13 = math.sin(v12 * 3.141592653589793) * 2;
        local v14 = v7.Position:Lerp(v8.Position, v12) + Vector3.new(0, 1, 0) * v13;
        v6:PivotTo(CFrame.lookAt(v14, v8.Position));
        RunService.RenderStepped:Wait();
    end;

    local v15 = os.clock();

    while v6.Parent and (p4.Parent and os.clock() - v15 < 0.35) do
        local v16 = (os.clock() - v15) / 0.35;
        local v17 = math.clamp(v16, 0, 1);
        v6:PivotTo(v8 * CFrame.Angles(0, 6.283185307179586 * v17, 0));
        RunService.RenderStepped:Wait();
    end;

    if v6.Parent then
        task.wait(2);
    end;

    if v6.Parent then
        v6:SetAttribute("ActionLocked", nil);
    end;
end;