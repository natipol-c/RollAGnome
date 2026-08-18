--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ButtonPlus
  Path:     game.ReplicatedStorage.Library.ButtonPlus
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:03 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local u1 = LocalPlayer:GetMouse();
local u2 = {};
u2.__index = u2;

function u2.UpdateList(p3) -- Line: 30
    p3._List = {};
    local Added_Elements = p3.Added_Elements;

    for _, v in next, type(p3._ParentList) == "table" and p3._ParentList or p3._ParentList:GetChildren() do
        if v:FindFirstChildWhichIsA("TextButton") then
            p3._List[v:FindFirstChildWhichIsA("TextButton")] = true;
        end;
    end;

    if Added_Elements then
        for i, _ in next, Added_Elements do
            if i:FindFirstChildWhichIsA("TextButton") then
                p3._List[i:FindFirstChildWhichIsA("TextButton")] = true;
            end;
        end;
    end;
end;

function u2.new(p4, p5) -- Line: 48
    -- upvalues: u2 (copy)
    local v6 = setmetatable({}, u2);
    v6._ParentList = p4;
    v6._Connections = {};
    v6._Settings = p5;
    v6._Events = p5.Events;
    v6._Hovering = false;
    v6._HoveringObject = nil;
    v6:UpdateList();

    return v6;
end;

function u2.AddElement(p7, p8) -- Line: 64
    if p8 then
        if not p7.Added_Elements then
            p7.Added_Elements = {};
        end;

        p7.Added_Elements[p8] = true;

        if p8:FindFirstChildWhichIsA("TextButton") then
            p7._List[p8:FindFirstChildWhichIsA("TextButton")] = true;
        end;
    end;
end;

function u2.Events(u9, p10) -- Line: 78
    -- upvalues: LocalPlayer (copy), UserInputService (copy), u1 (copy)
    if u9._Connections.Button2Down then
        u9._Connections.Button2Down:Disconnect();
        u9._Connections.Button2Down = nil;
    end;

    if u9._Connections.Button2Click then
        u9._Connections.Button2Click:Disconnect();
        u9._Connections.Button2Click = nil;
    end;

    if u9._Connections.Button1Down then
        u9._Connections.Button1Down:Disconnect();
        u9._Connections.Button1Down = nil;
    end;

    if u9._Connections.Button1Click then
        u9._Connections.Button1Click:Disconnect();
        u9._Connections.Button1Click = nil;
    end;

    if u9._Connections.ButtonRandomClick then
        u9._Connections.ButtonRandomClick:Disconnect();
        u9._Connections.ButtonRandomClick = nil;
    end;

    if u9._Events.RightDown then
        if LocalPlayer:GetAttribute("Device") == "Controller" then
            u9._Connections.Button2Down = UserInputService.InputBegan:Connect(function(p11, p12) -- Line: 105
                -- upvalues: u9 (copy)
                if p12 then
                    return;
                end;

                if p11.KeyCode == Enum.KeyCode.ButtonL2 then
                    u9._Events.RightDown(u9._HoveringObject.Parent);
                end;
            end);
        else
            u9._Connections.Button2Down = p10.MouseButton2Down:Connect(function() -- Line: 113
                -- upvalues: u9 (copy)
                u9._Events.RightDown(u9._HoveringObject.Parent);
            end);
        end;
    end;

    if u9._Events.RightClick then
        if LocalPlayer:GetAttribute("Device") == "Controller" then
            u9._Connections.Button2Click = UserInputService.InputEnded:Connect(function(p13, p14) -- Line: 120
                -- upvalues: u9 (copy)
                if p14 then
                    return;
                end;

                if p13.KeyCode == Enum.KeyCode.ButtonL2 then
                    u9._Events.RightClick(u9._HoveringObject.Parent);
                end;
            end);
        else
            u9._Connections.Button2Click = p10.MouseButton2Click:Connect(function() -- Line: 128
                -- upvalues: u9 (copy)
                u9._Events.RightClick(u9._HoveringObject.Parent);
            end);
        end;
    end;

    if u9._Events.Down then
        u9._Connections.Button1Down = p10.MouseButton1Down:Connect(function() -- Line: 135
            -- upvalues: u9 (copy)
            u9._Events.Down(u9._HoveringObject.Parent);
        end);
    end;

    if u9._Events.Click then
        u9._Connections.Button1Click = p10.MouseButton1Click:Connect(function() -- Line: 141
            -- upvalues: u9 (copy)
            u9._Events.Click(u9._HoveringObject.Parent);
        end);
        u9._Connections.ButtonRandomClick = u1.Button1Down:Connect(function() -- Line: 146
            -- upvalues: u9 (copy)
            u9._Events.Click();
        end);
    end;
end;

function u2.Start(u15) -- Line: 153
    -- upvalues: RunService (copy), UserInputService (copy), GuiService (copy), PlayerGui (copy)
    u15:UpdateList();
    tick();
    u15._Connections.Move = RunService.Heartbeat:Connect(function() -- Line: 159
        -- upvalues: UserInputService (ref), GuiService (ref), PlayerGui (ref), u15 (copy)
        local v16 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
        local v17 = PlayerGui:GetGuiObjectsAtPosition(v16.X, v16.Y);
        local v18 = false;

        for _, v in next, v17 do
            if u15._List[v] then
                v18 = true;

                if u15._Hovering then
                    local _HoveringObject = u15._HoveringObject;

                    if _HoveringObject and _HoveringObject ~= v then
                        if u15._Events.Leave then
                            u15._Events.Leave(_HoveringObject.Parent);
                        end;

                        u15._HoveringObject = v;

                        if u15._Events.Enter then
                            u15._Events.Enter(v.Parent);
                        end;

                        u15:Events(v);
                    end;
                else
                    u15._Hovering = true;
                    u15._HoveringObject = v;

                    if u15._Events.Enter then
                        u15._Events.Enter(v.Parent);
                    end;

                    u15:Events(v);
                end;

                break;
            end;
        end;

        if not v18 and u15._Hovering then
            u15._Hovering = false;

            if u15._Connections.Button1Down then
                u15._Connections.Button1Down:Disconnect();
                u15._Connections.Button1Down = nil;
            end;

            if u15._Connections.Button1Click then
                u15._Connections.Button1Click:Disconnect();
                u15._Connections.Button1Click = nil;
            end;

            if u15._Connections.Button2Down then
                u15._Connections.Button2Down:Disconnect();
                u15._Connections.Button2Down = nil;
            end;

            if u15._Connections.Button2Click then
                u15._Connections.Button2Click:Disconnect();
                u15._Connections.Button2Click = nil;
            end;

            if u15._Events.Leave then
                u15._Events.Leave(u15._HoveringObject.Parent);
            end;

            u15._HoveringObject = nil;
        end;
    end);
end;

function u2.Stop(p19) -- Line: 236
    if p19._Connections.Move then
        p19._Connections.Move:Disconnect();
        p19._Connections.Move = nil;
    end;

    p19.Added_Elements = {};

    if p19._Connections.Button1Down then
        p19._Connections.Button1Down:Disconnect();
        p19._Connections.Button1Down = nil;
    end;

    if p19._Connections.Button1Click then
        p19._Connections.Button1Click:Disconnect();
        p19._Connections.Button1Click = nil;
    end;

    if p19._Connections.ButtonRandomClick then
        p19._Connections.ButtonRandomClick:Disconnect();
        p19._Connections.ButtonRandomClick = nil;
    end;

    if p19._HoveringObject and p19._Events.Leave then
        p19._Events.Leave(p19._HoveringObject.Parent);
    end;
end;

return u2;