--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     observeCharacter
  Path:     game.ReplicatedStorage.Library.Imported.Observers.observeCharacter
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

return function(u1, u2) -- Line: 18, Name: observeCharacter
    local u3 = nil;
    local u4 = nil;

    local function OnCharacterAdded(u5) -- Line: 23
        -- upvalues: u2 (copy), u1 (copy), u4 (ref), u3 (ref)
        local u6 = nil;
        task.defer(function() -- Line: 27
            -- upvalues: u2 (ref), u1 (ref), u5 (copy), u4 (ref), u6 (ref), u3 (ref)
            local v7 = u2(u1, u5);

            if typeof(v7) == "function" then
                if u4.Connected and u5.Parent then
                    u6 = v7;
                    u3 = v7;

                    return;
                end;

                task.spawn(v7);
            end;
        end);
        local u8 = nil;
        u8 = u5.AncestryChanged:Connect(function(p9, p10) -- Line: 43
            -- upvalues: u8 (ref), u6 (ref), u3 (ref)
            if p10 == nil and u8.Connected then
                u8:Disconnect();

                if u6 ~= nil then
                    task.spawn(u6);

                    if u3 == u6 then
                        u3 = nil;
                    end;

                    u6 = nil;
                end;
            end;
        end);
    end;

    u4 = u1.CharacterAdded:Connect(OnCharacterAdded);
    task.defer(function() -- Line: 61
        -- upvalues: u1 (copy), u4 (ref), OnCharacterAdded (copy)
        if u1.Character and u4.Connected then
            task.spawn(OnCharacterAdded, u1.Character);
        end;
    end);

    return function() -- Line: 68
        -- upvalues: u4 (ref), u3 (ref)
        u4:Disconnect();

        if u3 ~= nil then
            task.spawn(u3);
            u3 = nil;
        end;
    end;
end;