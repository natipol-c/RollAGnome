--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TypeWriter
  Path:     game.ReplicatedStorage.Library.TypeWriter
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 9
    p1.Text = p2;
    p1.MaxVisibleGraphemes = 0;

    for i = 1, utf8.len(p2) do
        p1.MaxVisibleGraphemes = i;
        task.wait(0.02);
    end;

    if p3 then
        p3();
    end;
end;