--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Assets
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Assets
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:04 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Workspace");
local Pets = ReplicatedStorage.Assets:WaitForChild("Pets");
local Animations = ReplicatedStorage.Assets:WaitForChild("Animations");

return table.freeze({
    GetAnimations = function(p1) -- Line: 13, Name: GetAnimations
        -- upvalues: Animations (copy)
        local v2 = {};

        if not p1 then
            return v2;
        end;

        local v3 = Animations:FindFirstChild(p1);

        if not v3 then
            return v2;
        end;

        for _, v in { "Idle", "Walk" } do
            local v4 = v3:FindFirstChild(v);

            if v4 and v4:IsA("Animation") then
                v2[v] = v4;
            end;
        end;

        return v2;
    end,

    GetModel = function(p5) -- Line: 9, Name: GetModel
        -- upvalues: Pets (copy)
        return Pets:FindFirstChild(p5);
    end
});