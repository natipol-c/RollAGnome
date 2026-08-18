--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VERSION
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.VERSION
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:06 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    appVersion = "v3.3.1",
    latestVersion = nil
};

function u1.getLatestVersion() -- Line: 14
    -- upvalues: u1 (copy)
    local latestVersion = u1.latestVersion;

    if latestVersion then
        return latestVersion;
    end;

    local v2;

    while true do
        local v3;
        v3, v2 = pcall(function() -- Line: 22
            return game:GetService("MarketplaceService"):GetProductInfo(117501901079852);
        end);

        if v3 and v2 then
            break;
        end;

        task.wait(1);
    end;

    local v4 = string.match(v2.Name, "^TopbarPlus (.*)$");

    if v4 then
        v4 = v4:gsub("%s+", "");
    end;

    u1.latestVersion = v4;

    return v4;
end;

function u1.getAppVersion() -- Line: 39
    -- upvalues: u1 (copy)
    return u1.appVersion;
end;

function u1.isUpToDate() -- Line: 43
    -- upvalues: u1 (copy)
    local v5 = u1.getLatestVersion();
    local v6 = u1.getAppVersion();
    local v7;

    if v5 == nil then
        v7 = false;
    else
        v7 = v5 == v6;
    end;

    return v7;
end;

return u1;