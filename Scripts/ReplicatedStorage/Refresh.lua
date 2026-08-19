--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Refresh
  Path:     game.ReplicatedStorage.Library.Refresh
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:23 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TeleportService = game:GetService("TeleportService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Network");
Library.get("Signal");
local v2 = {};

if RunService:IsServer() then
    local u3 = require(game.ServerStorage.ServerLibrary).get("Data");

    function v2.Initialize(p4) -- Line: 27
        -- upvalues: u1 (copy), u3 (copy), TeleportService (copy)
        u1:BindEvents({
            RefreshPlayer = function(u5, p6) -- Line: 31, Name: RefreshPlayer
                -- upvalues: u3 (ref), TeleportService (ref)
                local v7 = p6 or {};
                u3:SetRefresh(u5, true);
                local TeleportOptions = Instance.new("TeleportOptions");
                local Plot = u5:FindFirstChild("Plot");

                if Plot then
                    Plot = Plot.Value;
                end;

                if Plot and (Plot.PrimaryPart and u5.Character) then
                    v7.PlotOffset = Plot.PrimaryPart.CFrame:ToObjectSpace(u5.Character:GetPivot());
                end;

                v7.AutoRolling = u5:GetAttribute("AutoRolling") == true;
                TeleportOptions:SetTeleportData(v7);
                local v8 = u3:GetProfile(u5);

                if not v8 then
                    return;
                end;

                v8:Release();
                v8:ListenToHopReady(function() -- Line: 49
                    -- upvalues: TeleportService (ref), u5 (copy), TeleportOptions (copy)
                    task.wait(5);
                    TeleportService:TeleportAsync(game.PlaceId, { u5 }, TeleportOptions);
                    TeleportOptions:Destroy();
                end);
            end,

            OnJoinRefresh = function(p9, p10) -- Line: 56, Name: OnJoinRefresh
                -- upvalues: u3 (ref)
                if p9 and p10 then
                    local v11 = u3.get(p9);

                    if v11 and v11.Refresh then
                        u3:SetRefresh(p9, false);
                        warn(p10);
                        local Plot = p9:FindFirstChild("Plot");

                        if Plot then
                            Plot = Plot.Value;
                        end;

                        if p10.PlotOffset and (Plot and (Plot.PrimaryPart and p9.Character)) then
                            p9.Character:PivotTo(Plot.PrimaryPart.CFrame * p10.PlotOffset);
                        end;

                        p9:SetAttribute("AutoRolling", p10.AutoRolling == true);
                    end;
                end;
            end
        });
    end;

    return v2;
end;

local LocalPlayer = Players.LocalPlayer;

function v2.Refresh(p12, p13) -- Line: 82
    -- upvalues: LocalPlayer (copy), u1 (copy)
    local v14 = p13 or {};
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("Head");
    end;

    local CurrentCamera = workspace.CurrentCamera;

    if Character and CurrentCamera then
        v14.CameraOffset = Character.CFrame:ToObjectSpace(CurrentCamera.CFrame);
    end;

    u1:FireServer("RefreshPlayer", v14);
end;

function v2.Initialize(u15) -- Line: 95
    -- upvalues: ReplicatedStorage (copy), u1 (copy), LocalPlayer (copy)
    local v16 = game:GetService("TeleportService"):GetLocalPlayerTeleportData();

    if v16 then
        repeat
            task.wait(0.1);
        until ReplicatedStorage:GetAttribute("DataLoaded");

        u1:FireServer("OnJoinRefresh", v16);

        if v16.CameraOffset then
            local Head = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Head", 5);

            if Head then
                task.wait(0.25);
                local CurrentCamera = workspace.CurrentCamera;
                local CameraType = CurrentCamera.CameraType;
                CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                CurrentCamera.CFrame = Head.CFrame * v16.CameraOffset;
                CurrentCamera.Focus = CFrame.new(Head.Position);
                task.wait();
                CurrentCamera.CameraType = CameraType;
            end;
        end;
    end;

    LocalPlayer.Idled:Connect(function(p17) -- Line: 124
        -- upvalues: u15 (copy)
        if p17 >= 1080 then
            u15:Refresh();
        end;
    end);
end;

return v2;