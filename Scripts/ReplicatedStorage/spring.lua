--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     spring
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.spring
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local u1 = game and Vector3 or require("test/mock").Vector3;
local throw = require(script.Parent.throw);
local graph = require(script.Parent.graph);
local create_node = graph.create_node;
local create_source_node = graph.create_source_node;
local assert_stable_scope = graph.assert_stable_scope;
local evaluate_node = graph.evaluate_node;
local update_descendants = graph.update_descendants;
local push_child_to_scope = graph.push_child_to_scope;

local function Vec3(p2, p3, p4) -- Line: 40
    -- upvalues: u1 (copy)
    return u1.new(p2, p3, p4);
end;

local u5 = u1.new(0, 0, 0);
local u14 = {
    number = function(p6) -- Line: 69
        -- upvalues: u1 (copy), u5 (copy)
        return u1.new(p6, 0, 0), u5;
    end,

    CFrame = function(p7) -- Line: 73
        -- upvalues: Vec3 (copy)
        return p7.Position, Vec3(p7:ToEulerAnglesXYZ());
    end,

    Color3 = function(p8) -- Line: 77
        -- upvalues: u1 (copy), u5 (copy)
        return u1.new(p8.R, p8.G, p8.B), u5;
    end,

    UDim = function(p9) -- Line: 82
        -- upvalues: u1 (copy), u5 (copy)
        return u1.new(p9.Scale, p9.Offset, 0), u5;
    end,

    UDim2 = function(p10) -- Line: 86
        -- upvalues: u1 (copy), Vec3 (copy)
        return u1.new(p10.X.Scale, p10.X.Offset, p10.Y.Scale), Vec3(p10.Y.Offset, 0, 0);
    end,

    Vector2 = function(p11) -- Line: 90
        -- upvalues: u1 (copy), u5 (copy)
        return u1.new(p11.X, p11.Y, 0), u5;
    end,

    Vector3 = function(p12) -- Line: 94
        -- upvalues: u5 (copy)
        return p12, u5;
    end,

    Rect = function(p13) -- Line: 98
        -- upvalues: u1 (copy), Vec3 (copy)
        return u1.new(p13.Min.X, p13.Min.Y, p13.Max.X), Vec3(p13.Max.Y, 0, 0);
    end
};
local u27 = {
    number = function(p15, p16) -- Line: 104
        return p15.X;
    end,

    CFrame = function(p17, p18) -- Line: 108
        return CFrame.new(p17) * CFrame.fromEulerAnglesXYZ(p18.X, p18.Y, p18.Z);
    end,

    Color3 = function(p19) -- Line: 112
        return Color3.new(math.clamp(p19.X, 0, 1), math.clamp(p19.Y, 0, 1), (math.clamp(p19.Z, 0, 1)));
    end,

    UDim = function(p20) -- Line: 116
        return UDim.new(p20.X, (math.round(p20.Y)));
    end,

    UDim2 = function(p21, p22) -- Line: 120
        return UDim2.new(p21.X, math.round(p21.Y), p21.Z, (math.round(p22.X)));
    end,

    Vector2 = function(p23) -- Line: 124
        return Vector2.new(p23.X, p23.Y);
    end,

    Vector3 = function(p24) -- Line: 128
        return p24;
    end,

    Rect = function(p25, p26) -- Line: 132
        return Rect.new(p25.X, p25.Y, p25.Z, p26.X);
    end
};
local v30 = {
    __index = function(p28, p29) -- Line: 138, Name: __index
        -- upvalues: throw (copy)
        throw((`cannot spring type {p29}`));
    end
};
setmetatable(u14, v30);
setmetatable(u27, v30);
local u31 = {};
setmetatable(u31, {
    __mode = "v"
});

local function spring(u32, p33, p34) -- Line: 151
    -- upvalues: assert_stable_scope (copy), throw (copy), u5 (copy), create_source_node (copy), u14 (copy), u31 (copy), create_node (copy), evaluate_node (copy), push_child_to_scope (copy)
    local v35 = assert_stable_scope();
    local v36 = 6.283185307179586 / (p33 or 1);
    local v37 = (p34 or 1) * (2 * v36);

    if v37 > 240 then
        throw("spring damping too high, consider reducing damping or increasing period");
    end;

    local u38 = {
        source_value = false,
        k = v36 ^ 2,
        c = v37,
        x0_123 = u5,
        x1_123 = u5,
        v_123 = u5,
        x0_456 = u5,
        x1_456 = u5,
        v_456 = u5
    };
    local u39 = create_source_node(false);
    evaluate_node((create_node(v35, function() -- Line: 186, Name: updater_effect
        -- upvalues: u32 (copy), u38 (copy), u14 (ref), u31 (ref), u39 (copy)
        local v40 = u32();
        local v41, v42 = u14[typeof(v40)](v40);
        u38.x1_123 = v41;
        u38.x1_456 = v42;
        u38.source_value = v40;
        u31[u38] = u39;

        return v40;
    end, false)));
    local x1_456 = u38.x1_456;
    u38.x0_123 = u38.x1_123;
    u38.x0_456 = x1_456;
    u39.cache = u38.source_value;

    return function(...) -- Line: 204
        -- upvalues: push_child_to_scope (ref), u39 (copy), u38 (copy), u14 (ref), u5 (ref), u31 (ref)
        if select("#", ...) == 0 then
            push_child_to_scope(u39);

            return u39.cache;
        end;

        local v43 = ...;
        local v44, v45 = u14[typeof(v43)](v43);
        u38.x0_123 = v44;
        u38.x0_456 = v45;
        u38.v_123 = u5;
        u38.v_456 = u5;
        u31[u38] = u39;
        u39.cache = v43;

        return v43;
    end;
end;

local function step_springs(p46) -- Line: 228
    -- upvalues: u31 (copy)
    for i in next, u31 do
        local k = i.k;
        local c = i.c;
        local x0_123 = i.x0_123;
        local v_123 = i.v_123;
        local x0_456 = i.x0_456;
        local v_456 = i.v_456;
        local v47 = v_123 + ((x0_123 - i.x1_123) * -k + v_123 * -c) * p46;
        local v48 = v_456 + ((x0_456 - i.x1_456) * -k + v_456 * -c) * p46;
        i.x0_123 = x0_123 + v47 * p46;
        i.x0_456 = x0_456 + v48 * p46;
        i.v_123 = v47;
        i.v_456 = v48;
    end;
end;

local u49 = {};

local function update_spring_sources() -- Line: 268
    -- upvalues: u31 (copy), u49 (copy), u27 (copy), update_descendants (copy)
    for i, v in next, u31 do
        local x0_123 = i.x0_123;
        local x0_456 = i.x0_456;

        if (i.v_123 + i.v_456 + (x0_123 - i.x1_123) + (x0_456 - i.x1_456)).Magnitude < 0.0001 then
            table.insert(u49, i);
            v.cache = i.source_value;
        else
            v.cache = u27[typeof(i.source_value)](x0_123, x0_456);
        end;

        update_descendants(v);
    end;

    for _, v in next, u49 do
        u31[v] = nil;
    end;

    table.clear(u49);
end;

return function() -- Line: 298
    -- upvalues: spring (copy), step_springs (copy), update_spring_sources (copy)
    local u50 = 0;

    return spring, function(p51) -- Line: 301
        -- upvalues: u50 (ref), step_springs (ref), update_spring_sources (ref)
        u50 = u50 + p51;

        while u50 > 0.008333333333333333 do
            u50 = u50 - 0.008333333333333333;
            step_springs(0.008333333333333333);
        end;

        update_spring_sources();
    end;
end;