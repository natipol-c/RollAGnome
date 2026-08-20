--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     loadHeadshot
  Path:     game.ReplicatedStorage.Library.loadHeadshot
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:42:59 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local HeadShot = Enum.ThumbnailType.HeadShot;
local Size150x150 = Enum.ThumbnailSize.Size150x150;
local Size352x352 = Enum.ThumbnailSize.Size352x352;

local function Retry(p1, p2) -- Line: 15
    local v3 = 0;

    while true do
        local success, result = pcall(p1);

        if not success then
            v3 = v3 + 1;
            warn(result);
            task.wait(0.25);
        end;

        if v3 >= 3 or success then
            if success then
                return result;
            end;

            return nil;
        end;
    end;
end;

return function(u4) -- Line: 35
    -- upvalues: Retry (copy), Players (copy), HeadShot (copy), Size150x150 (copy), Size352x352 (copy)
    local u5 = nil;
    local u6 = nil;

    if u4.UserId > 0 then
        Retry(function() -- Line: 40
            -- upvalues: u5 (ref), Players (ref), u4 (copy), HeadShot (ref), Size150x150 (ref)
            u5 = Players:GetUserThumbnailAsync(u4.UserId, HeadShot, Size150x150);
        end);
        Retry(function() -- Line: 41
            -- upvalues: u6 (ref), Players (ref), u4 (copy), HeadShot (ref), Size352x352 (ref)
            u6 = Players:GetUserThumbnailAsync(u4.UserId, HeadShot, Size352x352);
        end);
    end;

    u4:SetAttribute("Headshot", u5 or "rbxthumb://type=AvatarHeadShot&id=1&w=100&h=100");
    u4:SetAttribute("BigHeadshot", u6 or "rbxthumb://type=AvatarHeadShot&id=1&w=420&h=420");
end;