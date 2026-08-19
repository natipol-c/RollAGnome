--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     observeProperty
  Path:     game.ReplicatedStorage.Library.Imported.Observers.observeProperty
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

return function(u1, u2, u3) -- Line: 19, Name: observeProperty
    local u4 = nil;
    local u5 = nil;
    local u6 = 0;

    local function OnPropertyChanged() -- Line: 25
        -- upvalues: u4 (ref), u6 (ref), u1 (copy), u2 (copy), u3 (copy), u5 (ref)
        if u4 ~= nil then
            task.spawn(u4);
            u4 = nil;
        end;

        u6 = u6 + 1;
        local u7 = u6;
        local u8 = u1[u2];
        task.spawn(function() -- Line: 36
            -- upvalues: u3 (ref), u8 (copy), u7 (copy), u6 (ref), u5 (ref), u4 (ref)
            local v9 = u3(u8);

            if u7 == u6 and u5.Connected then
                u4 = v9;

                return;
            end;

            task.spawn(v9);
        end);
    end;

    u5 = u1:GetPropertyChangedSignal(u2):Connect(OnPropertyChanged);
    task.defer(function() -- Line: 50
        -- upvalues: u5 (ref), u4 (ref), u6 (ref), u1 (copy), u2 (copy), u3 (copy)
        if not u5.Connected then
            return;
        end;

        if u4 ~= nil then
            task.spawn(u4);
            u4 = nil;
        end;

        u6 = u6 + 1;
        local u10 = u6;
        local u11 = u1[u2];
        task.spawn(function() -- Line: 36
            -- upvalues: u3 (ref), u11 (copy), u10 (copy), u6 (ref), u5 (ref), u4 (ref)
            local v12 = u3(u11);

            if u10 == u6 and u5.Connected then
                u4 = v12;

                return;
            end;

            task.spawn(v12);
        end);
    end);

    return function() -- Line: 58
        -- upvalues: u5 (ref), u4 (ref)
        u5:Disconnect();

        if u4 ~= nil then
            task.spawn(u4);
            u4 = nil;
        end;
    end;
end;