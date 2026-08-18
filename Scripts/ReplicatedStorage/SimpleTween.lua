--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SimpleTween
  Path:     game.ReplicatedStorage.Library.Imported.SimpleTween
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:05 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");

return {
    Tween = function(p1, p2, p3, p4, p5, p6, p7, u8, p9) -- Line: 5, Name: Tween
        -- upvalues: TweenService (copy)
        if p2 then
            local u10 = TweenService:Create(p2, TweenInfo.new(p3, Enum.EasingStyle[p4].Value, Enum.EasingDirection[p5].Value, p9 or 0, p7 or false), p6);
            u10:Play();
            local u11 = nil;
            u11 = u10.Completed:Connect(function() -- Line: 16
                -- upvalues: u10 (copy), u8 (copy), u11 (ref)
                if u10 then
                    u10:Destroy();
                end;

                if u8 then
                    u8();
                end;

                u11:Disconnect();
            end);

            return u10;
        end;
    end,

    TweenModel = function(p12, u13, p14, p15, p16, p17, p18, u19, p20) -- Line: 28, Name: TweenModel
        -- upvalues: TweenService (copy)
        local CFrameValue = Instance.new("CFrameValue");

        if u13.PrimaryPart then
            CFrameValue.Value = u13:GetPivot();
            CFrameValue.Changed:Connect(function() -- Line: 37
                -- upvalues: u13 (copy), CFrameValue (copy)
                if not (u13.Parent and u13.PrimaryPart) then
                    CFrameValue:Destroy();
                end;

                u13:PivotTo(CFrameValue.Value);
            end);
            local u21 = TweenService:Create(CFrameValue, TweenInfo.new(p14, Enum.EasingStyle[p15].Value, Enum.EasingDirection[p16].Value, p20 or 0, p18 or false), {
                Value = p17
            });
            u21:Play();
            local u22 = nil;
            u22 = u21.Completed:Connect(function() -- Line: 49
                -- upvalues: CFrameValue (copy), u21 (copy), u19 (copy), u22 (ref)
                CFrameValue:Destroy();
                u21:Destroy();

                if u19 then
                    u19();
                end;

                u22:Disconnect();
            end);

            return u21;
        end;

        if u19 then
            u19();
        end;
    end
};