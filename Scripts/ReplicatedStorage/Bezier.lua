--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Bezier
  Path:     game.ReplicatedStorage.Library.Bezier
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Quadratic = function(p1, p2, p3, p4) -- Line: 3, Name: Quadratic
        return p2:Lerp(p3, p1):Lerp(p3:Lerp(p4, p1), p1);
    end
};