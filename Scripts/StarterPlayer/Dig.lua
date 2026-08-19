--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Dig
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Pets.Actions.Dig
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
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

return function(p3) -- Line: 18, Name: Dig
    -- upvalues: GetPet (copy), RunService (copy)
    local v4 = GetPet(p3);

    if not v4 then
        return;
    end;

    local v5 = v4:GetPivot();
    local v6 = os.clock();

    while v4.Parent and os.clock() - v6 < 0.8 do
        local v7 = (os.clock() - v6) / 0.8 * 3.141592653589793 * 10;
        local v8 = math.sin(v7) * 0.08726646259971647;
        v4:PivotTo(v5 * CFrame.Angles(-0.4363323129985824, 0, v8));
        RunService.RenderStepped:Wait();
    end;

    if v4.Parent then
        v4:PivotTo(v5);
    end;
end;