--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Behavior
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Behavior
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:04 2026
]]

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);

return table.freeze({
    EveryInterval = function(p1, p2) -- Line: 15, Name: EveryInterval
        local v3;

        if type(p1) == "number" then
            v3 = p1 >= 0;
        else
            v3 = false;
        end;

        assert(v3, "interval must be non-negative");
        local v4 = NumberRange.new(p1);
        local v5 = typeof(v4) == "NumberRange";
        assert(v5, "interval must be a NumberRange");
        assert(v4.Min >= 0, "interval minimum must be non-negative");

        return {
            Interval = v4,
            Effect = p2
        };
    end,

    EveryRandomInterval = function(p6, p7) -- Line: 5, Name: EveryRandomInterval
        local v8 = typeof(p6) == "NumberRange";
        assert(v8, "interval must be a NumberRange");
        assert(p6.Min >= 0, "interval minimum must be non-negative");

        return {
            Interval = p6,
            Effect = p7
        };
    end
});