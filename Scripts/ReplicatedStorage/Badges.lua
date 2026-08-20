--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Badges
  Path:     game.ReplicatedStorage.Library.Badges
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:42:59 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local RunService = game:GetService("RunService");
local BadgeService = game:GetService("BadgeService");
local u1 = {
    Badges = {
        Joined = 1974697679245651
    }
};

function u1.Give(p2, p3, p4) -- Line: 23
    -- upvalues: RunService (copy), u1 (copy), BadgeService (copy)
    if not RunService:IsStudio() then
        if p3 then
            if not u1.Badges[p4] then
                return;
            end;

            if not p2:IsOwned(p3, p4) then
                BadgeService:AwardBadgeAsync(p3.UserId, u1.Badges[p4]);

                return true;
            end;
        end;

        return false;
    end;
end;

function u1.IsOwned(p5, u6, u7) -- Line: 39
    -- upvalues: BadgeService (copy), u1 (copy)
    local _, result = pcall(function() -- Line: 40
        -- upvalues: BadgeService (ref), u6 (copy), u1 (ref), u7 (copy)
        return BadgeService:UserHasBadgeAsync(u6.UserId, u1.Badges[u7]);
    end);

    return result;
end;

return u1;