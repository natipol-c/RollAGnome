--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     observePlayer
  Path:     game.ReplicatedStorage.Library.Imported.Observers.observePlayer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");

return function(u1) -- Line: 21, Name: observePlayer
    -- upvalues: Players (copy)
    local u2 = nil;
    local u3 = {};

    local function OnPlayerAdded(u4) -- Line: 27
        -- upvalues: u2 (ref), u1 (copy), u3 (copy)
        if not u2.Connected then
            return;
        end;

        task.spawn(function() -- Line: 32
            -- upvalues: u1 (ref), u4 (copy), u2 (ref), u3 (ref)
            local v5 = u1(u4);

            if typeof(v5) == "function" then
                if u2.Connected and u4.Parent then
                    u3[u4] = v5;

                    return;
                end;

                task.spawn(v5);
            end;
        end);
    end;

    u2 = Players.PlayerAdded:Connect(OnPlayerAdded);
    local u8 = Players.PlayerRemoving:Connect(function(p6) -- Line: 44, Name: OnPlayerRemoving
        -- upvalues: u3 (copy)
        local v7 = u3[p6];
        u3[p6] = nil;

        if typeof(v7) == "function" then
            task.spawn(v7);
        end;
    end);
    task.defer(function() -- Line: 57
        -- upvalues: u2 (ref), Players (ref), OnPlayerAdded (copy)
        if not u2.Connected then
            return;
        end;

        for _, v in Players:GetPlayers() do
            task.spawn(OnPlayerAdded, v);
        end;
    end);

    return function() -- Line: 68
        -- upvalues: u2 (ref), u8 (ref), u3 (copy)
        u2:Disconnect();
        u8:Disconnect();
        local v9 = next(u3);

        while v9 do
            local v10 = u3[v9];
            u3[v9] = nil;

            if typeof(v10) == "function" then
                task.spawn(v10);
            end;

            v9 = next(u3);
        end;
    end;
end;