--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     observeTag
  Path:     game.ReplicatedStorage.Library.Imported.Observers.observeTag
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");

function observeTag(u1, u2, u3)
    -- upvalues: CollectionService (copy)
    local u4 = {};
    local u5 = {};
    local u6 = nil;

    local function IsGoodAncestor(p7) -- Line: 63
        -- upvalues: u3 (copy)
        if u3 == nil then
            return true;
        end;

        for _, v in u3 do
            if p7:IsDescendantOf(v) then
                return true;
            end;
        end;

        return false;
    end;

    local function AttemptStartup(u8) -- Line: 77
        -- upvalues: u4 (copy), u2 (copy), u1 (copy)
        u4[u8] = "__inflight__";
        task.defer(function() -- Line: 82
            -- upvalues: u4 (ref), u8 (copy), u2 (ref), u1 (ref)
            if u4[u8] ~= "__inflight__" then
                return;
            end;

            local v12, v13 = xpcall(function(p9) -- Line: 88
                -- upvalues: u2 (ref)
                local v10 = u2(p9);
                local v11 = typeof(v10) == "nil" and true or typeof(v10) == "function";
                assert(v11, "callback must return a function");

                return v10;
            end, debug.traceback, u8);

            if v12 then
                if type(v13) == "function" then
                    if u4[u8] ~= "__inflight__" then
                        task.spawn(v13);

                        return;
                    end;

                    u4[u8] = v13;
                end;

                return;
            end;

            local v14 = string.split(v13, "\n")[1];
            local v15 = string.find(v14, ": ");
            local v16 = not v15 and "" or v14:sub(v15 + 1);
            warn((`error while calling observeTag("{u1}") callback:{v16}\n{v13}`));
        end);
    end;

    local function AttemptCleanup(p17) -- Line: 118
        -- upvalues: u4 (copy)
        local v18 = u4[p17];
        u4[p17] = "__dead__";

        if typeof(v18) == "function" then
            task.spawn(v18);
        end;
    end;

    local function OnAncestryChanged(u19) -- Line: 127
        -- upvalues: u3 (copy), u4 (copy), u2 (copy), u1 (copy)
        local v20;

        if u3 == nil then
            v20 = true;
        else
            v20 = false;

            for _, v in u3 do
                if u19:IsDescendantOf(v) then
                    v20 = true;
                    break;
                end;
            end;
        end;

        if v20 then
            if u4[u19] == "__dead__" then
                u4[u19] = "__inflight__";
                task.defer(function() -- Line: 82
                    -- upvalues: u4 (ref), u19 (copy), u2 (ref), u1 (ref)
                    if u4[u19] ~= "__inflight__" then
                        return;
                    end;

                    local v24, v25 = xpcall(function(p21) -- Line: 88
                        -- upvalues: u2 (ref)
                        local v22 = u2(p21);
                        local v23 = typeof(v22) == "nil" and true or typeof(v22) == "function";
                        assert(v23, "callback must return a function");

                        return v22;
                    end, debug.traceback, u19);

                    if v24 then
                        if type(v25) == "function" then
                            if u4[u19] ~= "__inflight__" then
                                task.spawn(v25);

                                return;
                            end;

                            u4[u19] = v25;
                        end;

                        return;
                    end;

                    local v26 = string.split(v25, "\n")[1];
                    local v27 = string.find(v26, ": ");
                    local v28 = not v27 and "" or v26:sub(v27 + 1);
                    warn((`error while calling observeTag("{u1}") callback:{v28}\n{v25}`));
                end);
            end;
        else
            local v29 = u4[u19];
            u4[u19] = "__dead__";

            if typeof(v29) == "function" then
                task.spawn(v29);
            end;
        end;
    end;

    local function OnInstanceAdded(u30) -- Line: 137
        -- upvalues: u6 (ref), u4 (copy), u5 (copy), u3 (copy), u2 (copy), u1 (copy)
        if not u6.Connected then
            return;
        end;

        if u4[u30] ~= nil then
            return;
        end;

        u4[u30] = "__dead__";
        u5[u30] = u30.AncestryChanged:Connect(function() -- Line: 147
            -- upvalues: u30 (copy), u3 (ref), u4 (ref), u2 (ref), u1 (ref)
            local u31 = u30;
            local v32;

            if u3 == nil then
                v32 = true;
            else
                v32 = false;

                for _, v in u3 do
                    if u31:IsDescendantOf(v) then
                        v32 = true;
                        break;
                    end;
                end;
            end;

            if v32 then
                if u4[u31] == "__dead__" then
                    u4[u31] = "__inflight__";
                    task.defer(function() -- Line: 82
                        -- upvalues: u4 (ref), u31 (copy), u2 (ref), u1 (ref)
                        if u4[u31] ~= "__inflight__" then
                            return;
                        end;

                        local v36, v37 = xpcall(function(p33) -- Line: 88
                            -- upvalues: u2 (ref)
                            local v34 = u2(p33);
                            local v35 = typeof(v34) == "nil" and true or typeof(v34) == "function";
                            assert(v35, "callback must return a function");

                            return v34;
                        end, debug.traceback, u31);

                        if v36 then
                            if type(v37) == "function" then
                                if u4[u31] ~= "__inflight__" then
                                    task.spawn(v37);

                                    return;
                                end;

                                u4[u31] = v37;
                            end;

                            return;
                        end;

                        local v38 = string.split(v37, "\n")[1];
                        local v39 = string.find(v38, ": ");
                        local v40 = not v39 and "" or v38:sub(v39 + 1);
                        warn((`error while calling observeTag("{u1}") callback:{v40}\n{v37}`));
                    end);
                end;
            else
                local v41 = u4[u31];
                u4[u31] = "__dead__";

                if typeof(v41) == "function" then
                    task.spawn(v41);
                end;
            end;
        end);
        local v42;

        if u3 == nil then
            v42 = true;
        else
            v42 = false;

            for _, v in u3 do
                if u30:IsDescendantOf(v) then
                    v42 = true;
                    break;
                end;
            end;
        end;

        if v42 then
            if u4[u30] == "__dead__" then
                u4[u30] = "__inflight__";
                task.defer(function() -- Line: 82
                    -- upvalues: u4 (ref), u30 (copy), u2 (ref), u1 (ref)
                    if u4[u30] ~= "__inflight__" then
                        return;
                    end;

                    local v46, v47 = xpcall(function(p43) -- Line: 88
                        -- upvalues: u2 (ref)
                        local v44 = u2(p43);
                        local v45 = typeof(v44) == "nil" and true or typeof(v44) == "function";
                        assert(v45, "callback must return a function");

                        return v44;
                    end, debug.traceback, u30);

                    if v46 then
                        if type(v47) == "function" then
                            if u4[u30] ~= "__inflight__" then
                                task.spawn(v47);

                                return;
                            end;

                            u4[u30] = v47;
                        end;

                        return;
                    end;

                    local v48 = string.split(v47, "\n")[1];
                    local v49 = string.find(v48, ": ");
                    local v50 = not v49 and "" or v48:sub(v49 + 1);
                    warn((`error while calling observeTag("{u1}") callback:{v50}\n{v47}`));
                end);
            end;
        else
            local v51 = u4[u30];
            u4[u30] = "__dead__";

            if typeof(v51) == "function" then
                task.spawn(v51);
            end;
        end;
    end;

    u6 = CollectionService:GetInstanceAddedSignal(u1):Connect(OnInstanceAdded);
    local u55 = CollectionService:GetInstanceRemovedSignal(u1):Connect(function(p52) -- Line: 153, Name: OnInstanceRemoved
        -- upvalues: u4 (copy), u5 (copy)
        local v53 = u4[p52];
        u4[p52] = "__dead__";

        if typeof(v53) == "function" then
            task.spawn(v53);
        end;

        local v54 = u5[p52];

        if v54 then
            v54:Disconnect();
            u5[p52] = nil;
        end;

        u4[p52] = nil;
    end);
    task.defer(function() -- Line: 170
        -- upvalues: u6 (ref), CollectionService (ref), u1 (copy), OnInstanceAdded (copy)
        if not u6.Connected then
            return;
        end;

        for _, v in CollectionService:GetTagged(u1) do
            task.spawn(OnInstanceAdded, v);
        end;
    end);

    return function() -- Line: 181
        -- upvalues: u6 (ref), u55 (ref), u4 (copy), u5 (copy)
        u6:Disconnect();
        u55:Disconnect();
        local v56 = next(u4);

        while v56 do
            local v57 = u4[v56];
            u4[v56] = "__dead__";

            if typeof(v57) == "function" then
                task.spawn(v57);
            end;

            local v58 = u5[v56];

            if v58 then
                v58:Disconnect();
                u5[v56] = nil;
            end;

            u4[v56] = nil;
            v56 = next(u4);
        end;
    end;
end;

return observeTag;