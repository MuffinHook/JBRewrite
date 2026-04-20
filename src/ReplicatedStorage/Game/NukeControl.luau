local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local function SetVisible_upvr(arg1, arg2) -- Line 26, Named "SetVisible"
    for _, v in ipairs(arg1:GetChildren()) do
        local children = v:IsA("BasePart")
        if children then
            if arg2 then
                children = 0
            else
                children = 1
            end
            v.Transparency = children
        end
        SetVisible_upvr(v, arg2)
    end
end
local module = {}
local var11_upvw
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Silo_upvr = require(ReplicatedStorage_upvr.Game.Silo)
local CamShaker_upvr = require(ReplicatedStorage_upvr.Game.CamShaker.CamShaker)
local CurrentCamera_upvr = workspace.CurrentCamera
local Nuke_upvr = require(ReplicatedStorage_upvr.Game.Nuke)
local RunService_upvr = game:GetService("RunService")
local Shockwave_upvr = require(ReplicatedStorage_upvr.Game.Shockwave)
local VehicleUtils_upvr = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
local CharacterUtil_upvr = require(ReplicatedStorage_upvr.Game.CharacterUtil)
local Falling_upvr = require(ReplicatedStorage_upvr.Game.Falling)
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local Confirmation_upvr = require(ReplicatedStorage_upvr.Module.Confirmation)
local Format_upvr = require(ReplicatedStorage_upvr.Module.Format)
local CircleAction_upvr = require(ReplicatedStorage_upvr.Module.UI).CircleAction
local CollectionService_upvr = game:GetService("CollectionService")
local Joint_upvr = require(ReplicatedStorage_upvr.Std.Joint)
local TweenService_upvr = game:GetService("TweenService")
function module.Init(arg1) -- Line 37
    var11_upvw = arg1.Event
    local em = arg1.em
    function em.mhtt3u3k(arg1_2) -- Line 41
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if arg1_2 == nil then
        else
        end
        assert(true)
        if arg1_2.Nuke == nil then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        assert(true)
        if arg1_2.Shockwave == nil then
        else
        end
        assert(true)
        local any_ObjectLocal_result1_upvr = Audio_upvr.ObjectLocal(LocalPlayer_upvr, 9058580326, {
            Looped = true;
            Volume = 0;
            Pitch = 0.35;
        })
        Audio_upvr.FadeTo(any_ObjectLocal_result1_upvr, 0.5, 5)
        local any_new_result1 = Silo_upvr.new(workspace:WaitForChild("Silo", 1))
        local any_new_result1_2_upvr = CamShaker_upvr.new(Enum.RenderPriority.Camera.Value + 1, function(arg1_3) -- Line 54
            CurrentCamera_upvr.CFrame *= arg1_3
        end)
        any_new_result1_2_upvr:Start()
        local any_new_result1_upvr_2 = Nuke_upvr.new()
        any_new_result1:Open()
        local tick_result1_upvr_3 = tick()
        local var43_upvw
        local var44_upvr = any_new_result1.Model.Tube.Position + Vector3.new(0, any_new_result1.Model.Tube.Size.Y * 0.5, 0)
        var43_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 65
            local var45 = (tick() - tick_result1_upvr_3) / 5
            if 1 < var45 then
                var45 = 1
                var43_upvw:Disconnect()
            end
            any_new_result1_upvr_2.Model:SetPrimaryPartCFrame(CFrame.new(var44_upvr) * CFrame.Angles((math.pi/2), 0, 0) * CFrame.new(0, 0, 48 * (1 - var45) + 12 * var45))
        end)
        any_new_result1.OnOpened:Connect(function() -- Line 81
            arg1_2.Nuke.Origin = any_new_result1_upvr_2.Model.PrimaryPart.CFrame.p
            any_new_result1_upvr_2:Launch(arg1_2.Nuke)
            Audio_upvr.ObjectLocal(LocalPlayer_upvr, 2205008075)
            local any_ObjectLocal_result1_upvw_2 = Audio_upvr.ObjectLocal(LocalPlayer_upvr, 4828205974, {
                Volume = 0;
                Looped = true;
            })
            Audio_upvr.FadeTo(any_ObjectLocal_result1_upvw_2, 0.8, 0.5)
            local any_ShakeSustain_result1_upvr = any_new_result1_2_upvr:ShakeSustain(CamShaker_upvr.Presets.Vibration)
            any_new_result1_upvr_2.OnImpact:Connect(function() -- Line 90
                Audio_upvr.FadeTo(any_ObjectLocal_result1_upvr, 0, 5)
                delay(5, function() -- Line 92
                    any_ObjectLocal_result1_upvr:Destroy()
                end)
                Audio_upvr.ObjectLocal(LocalPlayer_upvr, 2205008239, {
                    Volume = 1;
                })
                any_new_result1_2_upvr:Shake(CamShaker_upvr.Presets.Explosion)
                any_ShakeSustain_result1_upvr:StartFadeOut(1)
                Audio_upvr.FadeTo(any_ObjectLocal_result1_upvw_2, 0, 0.5)
                delay(0.5, function() -- Line 100
                    any_ObjectLocal_result1_upvw_2:Destroy()
                    any_ObjectLocal_result1_upvw_2 = nil
                end)
                local clone_2_upvr = ReplicatedStorage_upvr.Resource.MushroomCloud:Clone()
                clone_2_upvr.CFrame = CFrame.new(arg1_2.Nuke.Target) + Vector3.new(0, 261.645, 0)
                clone_2_upvr.Transparency = 1
                clone_2_upvr.Parent = workspace
                local function _() -- Line 110, Named "FadeInCloud"
                    local tick_result1_upvr_5 = tick()
                    local var57_upvw
                    var57_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 114
                        local var58 = (tick() - tick_result1_upvr_5) / 5
                        if 1 < var58 then
                            var58 = 1
                            var57_upvw:Disconnect()
                        end
                        clone_2_upvr.Transparency = 1 * (1 - var58) + 0 * var58
                    end)
                end
                local function _() -- Line 125, Named "FadeOutCloud"
                    local tick_result1_upvr = tick()
                    local var61_upvw
                    var61_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 129
                        local var62 = (tick() - tick_result1_upvr) / 2
                        if 1 < var62 then
                            var62 = 1
                            var61_upvw:Disconnect()
                        end
                        clone_2_upvr.Transparency = 0 * (1 - var62) + 1 * var62
                    end)
                end
                local tick_result1_upvr_4 = tick()
                local var65_upvw
                var65_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 114
                    local var66 = (tick() - tick_result1_upvr_4) / 5
                    if 1 < var66 then
                        var66 = 1
                        var65_upvw:Disconnect()
                    end
                    clone_2_upvr.Transparency = 1 * (1 - var66) + 0 * var66
                end)
                tick_result1_upvr_4 = Shockwave_upvr
                tick_result1_upvr_4 = tick_result1_upvr_4.new(arg1_2.Nuke.Target, arg1_2.Shockwave)
                local var67 = tick_result1_upvr_4
                var67.OnPastLocalPlayer:Connect(function() -- Line 144
                    var11_upvw:FireServer("czvldnyr")
                    local any_GetLocalVehiclePacket_result1 = VehicleUtils_upvr.GetLocalVehiclePacket()
                    if any_GetLocalVehiclePacket_result1 ~= nil then
                        if any_GetLocalVehiclePacket_result1.Make == "AdminNuke" and not any_GetLocalVehiclePacket_result1.Passenger then
                            VehicleUtils_upvr.Classes.Chassis.runAction(true)
                            return
                        end
                        CharacterUtil_upvr.OnJump()
                        task.wait(0.1)
                    end
                    Falling_upvr.StartRagdolling(5)
                end)
                var67.OnDestroyed:Connect(function() -- Line 158
                    any_new_result1_2_upvr:Stop()
                    local tick_result1_upvr_2 = tick()
                    local var73_upvw
                    var73_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 129
                        local var74 = (tick() - tick_result1_upvr_2) / 2
                        if 1 < var74 then
                            var74 = 1
                            var73_upvw:Disconnect()
                        end
                        clone_2_upvr.Transparency = 0 * (1 - var74) + 1 * var74
                    end)
                end)
            end)
        end)
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    function em.uqhnlpn9() -- Line 166
        local pcall_result1, pcall_result2 = pcall(function() -- Line 167
            return MarketplaceService_upvr:GetProductInfo(980194938, Enum.InfoType.Product)
        end)
        local var78_upvr
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var78_upvr = pcall_result2.PriceInRobux
            return var78_upvr
        end
        if not pcall_result1 or not pcall_result2 or not decompInlinedCondition() then
            var78_upvr = 16000
        end
        local any_new_result1_upvw = Confirmation_upvr.new("Do you want to buy Uranium to launch a Nuke?")
        any_new_result1_upvw.OnYes:Connect(function() -- Line 172
            any_new_result1_upvw = nil
            local any_new_result1_upvw_2 = Confirmation_upvr.new(string.format("Are you SURE? It costs %s Robux.", Format_upvr.Comma(var78_upvr)))
            any_new_result1_upvw_2.OnYes:Connect(function() -- Line 177
                MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, 980194938)
                any_new_result1_upvw_2 = nil
            end)
            any_new_result1_upvw_2.OnNo:Connect(function() -- Line 182
                any_new_result1_upvw_2 = nil
            end)
        end)
        any_new_result1_upvw.OnNo:Connect(function() -- Line 186
            any_new_result1_upvw = nil
        end)
    end
    local function Action_upvr(arg1_4, arg2) -- Line 191, Named "Action"
        if arg2 then
            var11_upvw:FireServer('u'.."xdbvdl0":sub(5, 5):reverse():reverse():reverse().."".."".."a9fpovl1nn":sub(4, 6):reverse():reverse():reverse().."".."96u")
            return true
        end
    end
    local var85_upvw
    local function AddedFun(arg1_5) -- Line 198
        var85_upvw = arg1_5
        local Button = arg1_5:WaitForChild("Button")
        CircleAction_upvr.Add({
            Part = Button;
            ValidRoot = Button.Parent;
            Name = "Launch Nuke";
            Timed = true;
            Duration = 3;
            Dist = 10;
            Callback = Action_upvr;
        }, arg1_5)
    end
    for _, v_2 in ipairs(CollectionService_upvr:GetTagged("NukeUranium")) do
        AddedFun(v_2)
    end
    CollectionService_upvr:GetInstanceAddedSignal("NukeUranium"):Connect(AddedFun)
    CollectionService_upvr:GetInstanceRemovedSignal("NukeUranium"):Connect(function(arg1_6) -- Line 212, Named "RemovedFun"
        var85_upvw = nil
        CircleAction_upvr.Remove(arg1_6)
    end)
    function em.joj45cwd(arg1_7) -- Line 222
        if var85_upvw ~= nil then
            local Visual_2 = var85_upvw:FindFirstChild("Visual")
            if Visual_2 ~= nil then
                SetVisible_upvr(Visual_2, arg1_7)
            end
        end
    end
    CollectionService_upvr:GetInstanceAddedSignal("C4Nuke"):Connect(function(arg1_8) -- Line 231
        local any_new_result1_upvr = CamShaker_upvr.new(Enum.RenderPriority.Camera.Value + 1, function(arg1_9) -- Line 238
            CurrentCamera_upvr.CFrame *= arg1_9
        end)
        any_new_result1_upvr:Start()
        Audio_upvr.ObjectLocal(LocalPlayer_upvr, 2205008075)
        local any_ObjectLocal_result1_upvw = Audio_upvr.ObjectLocal(LocalPlayer_upvr, 4828205974, {
            Volume = 0;
            Looped = true;
        })
        Audio_upvr.FadeTo(any_ObjectLocal_result1_upvw, 0.8, 0.5)
        local clone = ReplicatedStorage_upvr.Resource.Nuke:Clone()
        local Base = clone.Base
        clone.PrimaryPart = Base
        local Position = (arg1_8.CFrame * CFrame.new(0, 0, 0)).Position
        clone.Parent = workspace
        Joint_upvr.WeldAllTo(clone, Base)
        Base.Anchored = true
        clone:PivotTo(CFrame.new((arg1_8.CFrame * CFrame.new(0, 0, -400)).Position, Position))
        TweenService_upvr:Create(Base, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            CFrame = Base.CFrame - Base.CFrame.Position + Position;
        }):Play()
        task.wait(2)
        clone:Destroy()
        Audio_upvr.ObjectLocal(LocalPlayer_upvr, 2205008239, {
            Volume = 1;
        })
        any_new_result1_upvr:ShakeSustain(CamShaker_upvr.Presets.Vibration):StartFadeOut(1)
        any_new_result1_upvr:Shake(CamShaker_upvr.Presets.Explosion)
        Audio_upvr.FadeTo(any_ObjectLocal_result1_upvw, 0, 0.5)
        task.delay(0.5, function() -- Line 272
            any_ObjectLocal_result1_upvw:Destroy()
            any_ObjectLocal_result1_upvw = nil
        end)
        Shockwave_upvr.new(Position, {
            Duration = 1;
            MaxRadius = 150;
            EndTransparency = 1;
            StartTransparency = 0;
            FxDisabled = true;
        }).OnDestroyed:Connect(function() -- Line 284
            any_new_result1_upvr:Stop()
        end)
    end)
end
return module