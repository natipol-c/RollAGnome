--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     observeTagNoAncestry
  Path:     game.ReplicatedStorage.Library.Imported.Observers.observeTagNoAncestry
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:00 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");

function observeTagNoAncestry(u1, u2)
    -- upvalues: CollectionService (copy)
    local u3 = {};
    local u4 = nil;

    local function OnInstanceAdded(u5) -- Line: 11
        -- upvalues: u4 (ref), u2 (copy), u1 (copy), u3 (copy)
        if not u4.Connected then
            return;
        end;

        task.defer(function() -- Line: 17
            -- upvalues: u2 (ref), u5 (copy), u1 (ref), u3 (ref)
            local v9, v10 = xpcall(function(p6) -- Line: 19
                -- upvalues: u2 (ref)
                local v7 = u2(p6);
                local v8 = typeof(v7) == "nil" and true or typeof(v7) == "function";
                assert(v8, "callback must return a function");

                return v7;
            end, debug.traceback, u5);

            if v9 then
                if type(v10) == "function" then
                    if not u5:HasTag(u1) then
                        task.spawn(v10);

                        return;
                    end;

                    u3[u5] = v10;
                end;

                return;
            end;

            local v11 = string.split(v10, "\n")[1];
            local v12 = string.find(v11, ": ");
            local v13 = not v12 and "" or v11:sub(v12 + 1);
            warn((`error while calling observeTag("{u1}") callback:{v13}\n{v10}`));
        end);
    end;

    u4 = CollectionService:GetInstanceAddedSignal(u1):Connect(OnInstanceAdded);
    local u16 = CollectionService:GetInstanceRemovedSignal(u1):Connect(function(p14) -- Line: 49, Name: OnInstanceRemoved
        -- upvalues: u3 (copy)
        local v15 = u3[p14];

        if typeof(v15) == "function" then
            task.spawn(v15);
        end;
    end);
    task.defer(function() -- Line: 61
        -- upvalues: u4 (ref), CollectionService (ref), u1 (copy), OnInstanceAdded (copy)
        if not u4.Connected then
            return;
        end;

        for _, v in CollectionService:GetTagged(u1) do
            task.spawn(OnInstanceAdded, v);
        end;
    end);

    return function() -- Line: 72
        -- upvalues: u4 (ref), u16 (ref), u3 (copy)
        u4:Disconnect();
        u16:Disconnect();
        local v17 = next(u3);

        while v17 do
            local v18 = u3[v17];

            if typeof(v18) == "function" then
                task.spawn(v18);
            end;

            v17 = next(u3);
        end;
    end;
end;

return observeTagNoAncestry;