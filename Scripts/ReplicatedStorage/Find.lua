--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Find
  Path:     game.ReplicatedStorage.Library.Find
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:42:59 2026
]]

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 9
    if p1 and (p2 and type(p2) == "string") then
        return p1:FindFirstChild(p2) or p1:WaitForChild(p2, p3 or 5);
    end;
end;