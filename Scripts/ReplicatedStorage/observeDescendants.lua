--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     observeDescendants
  Path:     game.ReplicatedStorage.Library.Imported.Observers.observeDescendants
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

function observeChildren(u1, u2)
    local u3 = {};
    local u4 = nil;

    local function OnInstanceAdded(p5) -- Line: 19
        -- upvalues: u4 (ref), u2 (copy), u3 (copy)
        if not u4.Connected then
            return;
        end;

        u3[p5] = u2(p5);
    end;

    u4 = u1.DescendantAdded:Connect(OnInstanceAdded);
    local u8 = u1.DescendantRemoving:Connect(function(p6) -- Line: 10, Name: OnInstanceRemoved
        -- upvalues: u3 (copy)
        local v7 = u3[p6];
        u3[p6] = nil;

        if typeof(v7) == "function" then
            task.spawn(v7);
        end;
    end);
    task.defer(function() -- Line: 33
        -- upvalues: u4 (ref), u1 (copy), OnInstanceAdded (copy)
        if not u4.Connected then
            return;
        end;

        for _, descendant in u1:GetDescendants() do
            task.spawn(OnInstanceAdded, descendant);
        end;
    end);

    return function() -- Line: 44
        -- upvalues: u4 (ref), u8 (ref), u3 (copy)
        u4:Disconnect();
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

return observeChildren;