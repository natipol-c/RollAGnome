--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TimedShop
  Path:     game.ReplicatedStorage.Library.TimedShop
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:23 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

local function getWeightedRandomItems(p2, p3, p4) -- Line: 10
    local v5 = {};
    local v6 = 0;
    local v7 = {};

    for i, v in pairs(p2) do
        table.insert(v5, {
            name = i,
            weight = v.stockWeight or 1,
            data = v
        });
        v6 = v6 + (v.stockWeight or 1);
    end;

    for _ = 1, math.min(p3, #v5) do
        if v6 <= 0 then
            break;
        end;

        local v8 = p4:NextNumber(0, v6);
        local v9 = 0;

        for i, v in ipairs(v5) do
            v9 = v9 + v.weight;

            if v8 <= v9 then
                table.insert(v7, v);
                v6 = v6 - v.weight;
                table.remove(v5, i);
                break;
            end;
        end;
    end;

    return v7;
end;

local function generateStock(p10, p11) -- Line: 46
    local v12 = Random.new(p11);
    local v13 = {};

    for i, v in pairs(p10.Items) do
        local v14 = v.chanceInStock or 100;
        local v15 = v12:NextInteger(1, 100);

        if v.AlwaysAvailable or v15 <= v14 then
            v13[i] = v12:NextInteger(v.minStock or 1, v.maxStock or 10);
        else
            v13[i] = 0;
        end;
    end;

    return v13;
end;

function u1.new(p16) -- Line: 69
    -- upvalues: u1 (copy)
    local v17 = setmetatable({}, u1);
    v17.Items = p16.Items or {};
    v17.RestockDuration = p16.RestockDuration or 300;
    v17.MinShopItems = p16.MinShopItems or 1;
    v17.MaxShopItems = p16.MaxShopItems or #v17.Items;
    v17._epoch = 0;
    v17._lastGeneratedSlotId = -1;
    v17._currentStock = {};
    v17.OnRestock = Instance.new("BindableEvent");

    return v17;
end;

function u1._getCurrentTimeSlotId(p18) -- Line: 86
    local v19 = (os.time() - p18._epoch) / p18.RestockDuration;

    return math.floor(v19);
end;

function u1.GetStock(p20) -- Line: 91
    -- upvalues: generateStock (copy)
    local v21 = p20:_getCurrentTimeSlotId();

    if v21 ~= p20._lastGeneratedSlotId then
        p20._currentStock = generateStock(p20, v21);
        p20._lastGeneratedSlotId = v21;
        p20.OnRestock:Fire(p20._currentStock);
    end;

    local v22 = {};

    for i, v in pairs(p20._currentStock) do
        v22[i] = v;
    end;

    return v22;
end;

function u1.GetSecondsLeft(p23) -- Line: 108
    local v24 = (os.time() - p23._epoch) % p23.RestockDuration;

    return math.ceil(p23.RestockDuration - v24);
end;

function u1.ForceRestock(p25, p26) -- Line: 114
    if not p26 or type(p26) ~= "table" then
        warn("TimedShop:ForceRestock() called with invalid or no itemsToAdd table.");

        return p25:GetStock();
    end;

    p25:GetStock();

    for i, v in pairs(p26) do
        p25._currentStock[i] = (p25._currentStock[i] or 0) + v;
    end;

    p25.OnRestock:Fire(p25._currentStock);
    local v27 = {};

    for i, v in pairs(p25._currentStock) do
        v27[i] = v;
    end;

    return v27;
end;

function u1.Destroy(p28) -- Line: 136
    p28.OnRestock:Destroy();

    for i in pairs(p28) do
        p28[i] = nil;
    end;

    setmetatable(p28, nil);
end;

return u1;