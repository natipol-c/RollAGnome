--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Replication
  Path:     game.ReplicatedStorage.Replication
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:26 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Network");
local u2 = Library.get("Signal");
local u3 = {};
local u4 = {};

if RunService:IsServer() then
    function u4.UpdateFull(p5, p6, p7) -- Line: 20
        -- upvalues: u1 (copy)
        u1:FireClient(p6, "UpdateFullData", p7);
    end;

    function u4.Update(p8, p9, ...) -- Line: 24
        -- upvalues: u1 (copy)
        u1:FireClient(p9, "UpdateSpecific", ...);
    end;

    return u4;
end;

function u4.Initialize(p10) -- Line: 29
    -- upvalues: u4 (copy), ReplicatedStorage (copy), u1 (copy), u3 (copy)
    u4.Data = {};
    ReplicatedStorage:SetAttribute("DataLoaded", false);
    u1:BindEvents({
        UpdateFullData = function(p11) -- Line: 34, Name: UpdateFullData
            -- upvalues: u4 (ref), ReplicatedStorage (ref), u3 (ref)
            u4.Data = p11;
            ReplicatedStorage:SetAttribute("DataLoaded", true);

            for _, v in pairs(u3) do
                v:Call(p11);
            end;
        end,

        UpdateSpecific = function(p12, p13, p14, ...) -- Line: 43, Name: UpdateSpecific
            -- upvalues: u4 (ref)
            u4.Data[p13] = p12;

            if not p14 then
                u4:Fire(p13, p12, ...);
            end;
        end
    });
end;

function u4.Connect(p15, p16, p17) -- Line: 52
    -- upvalues: RunService (copy), u3 (copy), u2 (copy)
    if not RunService:IsServer() then
        if not u3[p16] then
            u3[p16] = u2.new();
        end;

        u3[p16]:Connect(p17);
    end;
end;

function u4.Fire(p18, p19, ...) -- Line: 62
    -- upvalues: u3 (copy)
    if u3[p19] then
        u3[p19]:Call(...);
    end;
end;

return u4;