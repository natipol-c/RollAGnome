--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Pets
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Pets
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:09 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Network = require(ReplicatedStorage.Library.Imported.Network);
local u1 = {
    CarryFruit = require(script.Actions.CarryFruit),
    Dig = require(script.Actions.Dig),
    Pollinate = require(script.Actions.Pollinate)
};

local function PetAction(p2, ...) -- Line: 15
    -- upvalues: u1 (copy)
    local v3 = u1[p2];

    if v3 then
        v3(...);

        return;
    end;

    warn((`[Pets] Unknown action {p2}`));
end;

return table.freeze({
    Initialize = function(p4) -- Line: 27, Name: Initialize
        -- upvalues: Network (copy), PetAction (copy)
        Network:BindEvents({
            PetAction = {
                MatchParams = { "string" },
                PetAction
            }
        });
    end
});