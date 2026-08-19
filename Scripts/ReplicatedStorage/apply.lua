--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     apply
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.apply
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local u1 = game and typeof or require("test/mock").typeof;
local v2 = game and Vector2 or require("test/mock").Vector2;
local v3 = game and UDim2 or require("test/mock").UDim2;
local flags = require(script.Parent.flags);
local throw = require(script.Parent.throw);
local bind = require(script.Parent.bind);
local _, u4 = require(script.Parent.action)();
require(script.Parent.graph);
local u5 = nil;

local function borrow_caches() -- Line: 43
    -- upvalues: u5 (ref)
    if not u5 then
        return {
            events = {},
            actions = setmetatable({}, {
                __index = function(p6, p7) -- Line: 52, Name: __index
                    p6[p7] = {};

                    return p6[p7];
                end
            }),
            nested_debug = setmetatable({}, {
                __index = function(p8, p9) -- Line: 55, Name: __index
                    p8[p9] = {};

                    return p8[p9];
                end
            }),
            nested_stack = {}
        };
    end;

    local v10 = u5;
    u5 = nil;

    return v10;
end;

local function return_caches(p11) -- Line: 62
    -- upvalues: u5 (ref)
    u5 = p11;
end;

local u12 = {};

for i, v in {
    CFrame = CFrame,
    Color3 = Color3,
    UDim = UDim,
    UDim2 = v3,
    Vector2 = v2,
    Vector3 = Vector3,
    Rect = Rect
} do
    u12[i] = v.new;
end;

return function(p13, p14) -- Line: 81, Name: apply
    -- upvalues: throw (copy), flags (copy), borrow_caches (copy), u12 (copy), u1 (copy), bind (copy), u4 (copy), u5 (ref)
    if not p14 then
        throw("attempt to call a constructor returned by create() with no properties");
    end;

    local strict = flags.strict;
    local Parent = p14.Parent;
    local v15 = borrow_caches();
    local events = v15.events;
    local actions = v15.actions;
    local nested_debug = v15.nested_debug;
    local nested_stack = v15.nested_stack;
    local v16 = 1;

    while true do
        for i, v in p14 do
            if i ~= "Parent" then
                if type(i) == "string" then
                    if strict then
                        if nested_debug[v16][i] then
                            throw((`duplicate property {i} at depth {v16}`));
                        end;

                        nested_debug[v16][i] = true;
                    end;

                    if type(v) == "table" then
                        local v17 = u12[u1(p13[i])];

                        if v17 == nil then
                            throw((`cannot aggregate type {u1(v)} for property {i}`));
                        end;

                        p13[i] = v17(unpack(v));
                    elseif type(v) == "function" then
                        if u1(p13[i]) == "RBXScriptSignal" then
                            events[i] = v;
                        else
                            bind.property(p13, i, v);
                        end;
                    else
                        p13[i] = v;
                    end;
                elseif type(i) == "number" then
                    if type(v) == "function" then
                        bind.children(p13, v);
                    elseif type(v) == "table" then
                        if u4(v) then
                            table.insert(actions[v.priority], v.callback);
                        else
                            table.insert(nested_stack, v);
                            table.insert(nested_stack, v16 + 1);
                        end;
                    else
                        v.Parent = p13;
                    end;
                end;
            end;
        end;

        v16 = table.remove(nested_stack);
        p14 = table.remove(nested_stack);

        if not p14 then
            for i, v in next, events do
                p13[i]:Connect(v);
            end;

            for _, v in next, actions do
                for _, v4 in next, v do
                    v4(p13);
                end;
            end;

            if Parent then
                if type(Parent) == "function" then
                    bind.parent(p13, Parent);
                else
                    p13.Parent = Parent;
                end;
            end;

            table.clear(events);

            for _, v in next, actions do
                table.clear(v);
            end;

            if strict then
                table.clear(nested_debug);
            end;

            table.clear(nested_stack);
            u5 = v15;

            return p13;
        end;
    end;
end;