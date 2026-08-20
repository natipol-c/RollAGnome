--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     signal
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch.0.2.5-rc.2.conch.src.signal
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:01 2026
]]

-- Decompiled with Potassium's decompiler.

require("./types");

return function() -- Line: 4, Name: create_signal
    local u1 = {};

    return {
        connect = function(p2, p3) -- Line: 8, Name: connect
            -- upvalues: u1 (copy)
            local u4 = false;
            local u5 = {
                callback = p3
            };

            function u5.disconnect() -- Line: 12
                -- upvalues: u4 (ref), u5 (copy), u1 (ref)
                if u4 then
                    return;
                end;

                u4 = true;
                u5.disconnected = true;
                local v6 = table.find(u1, u5);

                if not v6 then
                    return;
                end;

                table.remove(u1, v6);
            end;

            table.insert(u1, u5);

            return u5;
        end,

        fire = function(p7, ...) -- Line: 29, Name: fire
            -- upvalues: u1 (copy)
            for _, v in u1 do
                v.callback(...);
            end;
        end
    };
end;