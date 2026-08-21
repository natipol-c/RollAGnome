--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Products Client
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Products Client
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:40 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Network");
local u2 = Library.get("Products");

return {
    Initialize = function(p3) -- Line: 28, Name: Initialize
        -- upvalues: u1 (copy), u2 (copy)
        u1:BindEvents({
            PromptProductClient = function(p4) -- Line: 32, Name: PromptProductClient
                -- upvalues: u2 (ref)
                u2.prompt(p4, "product");
            end,

            PromptGnome = function(p5) -- Line: 36, Name: PromptGnome
                -- upvalues: u2 (ref)
                local v6 = u2.products.gnomes[p5];

                if v6 and v6.id then
                    u2.prompt(v6.id, "product");

                    return;
                end;

                warn((`No gnome product found for {p5}`));
            end
        });
    end
};