local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera_upvr = workspace.CurrentCamera
local Gun_upvr = require(script.Parent.Gun)
local function _() -- Line 14, Named "RandomVector"
    return Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
end
local module_upvr = {
    __ClassName = "CarTurret";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
function module_upvr.new(arg1, arg2, arg3) -- Line 22
    local any_new_result1_upvr = Gun_upvr.new(arg1, arg2)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.Maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg2, "VehicleModel", function(arg1_2, arg2_2) -- Line 31
        if not arg1_2 then
        else
            arg2_2:GiveTask(RxInstanceUtils_upvr.observeProperty(arg1_2, "Value", function(arg1_3, arg2_3) -- Line 36
                any_new_result1_upvr.Model = arg1_3
                if not arg1_3 then
                else
                    any_new_result1_upvr:_getTips()
                    if any_new_result1_upvr.Local then
                        arg2_3:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_3, "UpdateHeatRemote", function(arg1_4) -- Line 47
                            any_new_result1_upvr._updateHeatRemote = arg1_4
                        end))
                    end
                end
            end))
        end
    end))
    any_new_result1_upvr.ShootActionButtonConfig = {
        primary = false;
        saturateTo = 100;
        priority = 500;
        keyCodes = {Enum.KeyCode.DPadDown};
    }
    any_new_result1_upvr:Setup()
    any_new_result1_upvr:DefaultDisableCamLock()
    return any_new_result1_upvr
end
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
function module_upvr._getTips(arg1) -- Line 71
    if not arg1.Model then
    else
        local Model = arg1.Model:FindFirstChild("Model")
        if not Model then return end
        local TurretTips = Model:FindFirstChild("TurretTips")
        if not TurretTips then return end
        arg1.Tips = TableUtils_upvr.filter(TurretTips:GetChildren(), function(arg1_5) -- Line 83
            return arg1_5:IsA("Attachment")
        end)
    end
end
function module_upvr._updateIgnoreList(arg1) -- Line 87
    arg1.IgnoreList = {arg1.Character, arg1.Model, workspace.Items}
    if arg1.BulletEmitter then
        arg1.BulletEmitter.IgnoreList = arg1.IgnoreList
    end
end
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local RunService_upvr = game:GetService("RunService")
function module_upvr.Setup(arg1) -- Line 93
    arg1:_updateIgnoreList()
    arg1.LastShoot = 0
    arg1.LastPlayerImpact = 0
    arg1.SpringThirdMousePosition = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.9, 30)
    if arg1.Local then
        arg1.SpringCamera = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.6, 300)
    end
    arg1.SpringSpin = Spring_upvr.new(0, 0, 0.6, 7)
    arg1.SpinTotal = 0
    arg1.MouseDown = false
    if not arg1.Tips then
        arg1.Tips = {}
    end
    arg1.TipIndex = 1
    arg1:SetupBulletEmitter()
    arg1:SetupShoot()
    arg1:UpdateMousePosition()
    arg1.Maid:GiveTask(RunService_upvr.RenderStepped:Connect(function() -- Line 120
        arg1:RenderStepped()
    end))
    arg1.Maid:GiveTask(RunService_upvr.Stepped:Connect(function() -- Line 123
        arg1:Stepped()
    end))
end
function module_upvr.BulletEmitterOnLocalHitPlayer(arg1, ...) -- Line 127
    local tick_result1_2 = tick()
    if 0.1 < tick_result1_2 - arg1.LastPlayerImpact then
        arg1.LastPlayerImpact = tick_result1_2
        Gun_upvr.BulletEmitterOnLocalHitPlayer(arg1, ...)
    end
end
module_upvr.Reload = false
function module_upvr.TransformLocalMousePosition(arg1, arg2) -- Line 137
    return arg1.SpringThirdMousePosition:SetTarget(arg2)
end
function module_upvr.UpdateArmJoints(arg1) -- Line 140
end
function module_upvr.UpdateCamera(arg1) -- Line 141
    local any_Update_result1_2 = arg1.SpringCamera:Update()
    local var23 = CurrentCamera_upvr
    var23.CFrame *= CFrame.new(any_Update_result1_2.x * 4, any_Update_result1_2.y * 4, 0)
end
function module_upvr.RenderStepped(arg1) -- Line 145
    arg1:UpdateMousePosition()
    if arg1.Local then
        arg1:UpdateCamera()
    end
end
function module_upvr.Shoot(arg1) -- Line 151
    arg1:_updateIgnoreList()
    local var24 = arg1.Tips[arg1.TipIndex]
    if not var24 then
        arg1:_getTips()
    else
        arg1.Tip = var24
        arg1.BulletEmitter:Emit(var24.WorldPosition, var24.WorldCFrame.LookVector, arg1.Config.BulletSpeed)
        arg1.TipIndex = arg1.TipIndex % #arg1.Tips + 1
        if arg1.Local then
            arg1.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * math.clamp(20 / (arg1.Model.PrimaryPart.Position - CurrentCamera_upvr.CFrame.p).Magnitude, 0.1, 1) * 50)
        end
    end
end
function module_upvr.ShootCheckConditions(arg1) -- Line 170
    return true
end
function module_upvr.AnimateBarrel(arg1, arg2, arg3) -- Line 173
    if not arg1.Model then
    else
        local tick_result1_3 = tick()
        if arg1.Sound then
            arg1.Sound.Volume = arg3 * 0.5
        end
        local MaxHeat = arg1.Config.MaxHeat
        local var27
        if 0.6 <= arg3 and var27 < MaxHeat then
            if 1 / (10 + 30 * arg3) < tick_result1_3 - arg1.LastShoot then
                var27 += arg2
                if MaxHeat <= var27 then
                    var27 += 3
                    arg1:InputEnded({
                        UserInputType = Enum.UserInputType.MouseButton1;
                    })
                end
                arg1.LastShoot = tick_result1_3
                if arg1.Local then
                    arg1:_attemptShoot()
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        else
            if 0 < var27 then
                var27 -= arg2
            end
            if var27 < 0 then
                var27 = 0
            end
        end
        if arg1.Model:FindFirstChild("Model") and arg1.Model.Model:FindFirstChild("Turret") then
            arg1.Model.Model.Turret.Color = arg1.Config.ColorNormal:Lerp(arg1.Config.ColorHeat, math.clamp(var27, 0, MaxHeat) / MaxHeat)
        end
        arg1.Model:SetAttribute("Heat", var27)
    end
end
function module_upvr.Stepped(arg1) -- Line 217
    if not arg1.Model then
    else
        local tick_result1 = tick()
        local var30 = tick_result1 - (arg1.LastUpdate or tick_result1)
        arg1.LastUpdate = tick_result1
        local any_Update_result1 = arg1.SpringSpin:Update()
        local var32 = arg1.SpinTotal + var30 * any_Update_result1
        if (-math.pi*2) < var32 then
            var32 -= (-math.pi*2)
        end
        arg1.SpinTotal = var32
        arg1:AnimateBarrel(var30, any_Update_result1)
    end
end
module_upvr.ApplySkin = false
module_upvr.ScopeBegin = false
function module_upvr.Heartbeat(arg1) -- Line 238
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 239
    if arg3 then
        return false
    end
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
    else
    end
    if true then
        if arg1.Model:GetAttribute("Heat") < arg1.Config.MaxHeat then
            arg1.SpringSpin:SetTarget(1)
            arg1.MouseDown = true
            if not arg1.Sound then
                local Sound_2 = Instance.new("Sound")
                Sound_2.SoundId = "rbxassetid://2198390391"
                Sound_2.Volume = 0
                Sound_2.Looped = true
                Sound_2.Parent = arg1.Model.PrimaryPart
                Sound_2:Play()
                arg1.Sound = Sound_2
            end
        end
        if arg1.Local then
            arg1:BroadcastInputBegan(arg2)
        end
    end
end
function module_upvr.InputEnded(arg1, arg2, arg3) -- Line 264
    if arg3 then
        return false
    end
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
    else
    end
    if true then
        arg1.SpringSpin:SetTarget(0)
        arg1.MouseDown = false
        delay(0.5, function() -- Line 272
            if arg1.Sound and not arg1.MouseDown then
                arg1.Sound:Destroy()
                arg1.Sound = nil
            end
        end)
        if arg1.Local then
            arg1:BroadcastInputEnded(arg2)
        end
    end
end
function module_upvr.Unequip(arg1) -- Line 283
    if arg1.Local and arg1._updateHeatRemote then
        arg1._updateHeatRemote:FireServer(arg1.Model:GetAttribute("Heat"))
    end
    if arg1.Model:FindFirstChild("Model") and arg1.Model.Model:FindFirstChild("Turret") then
        arg1.Model.Model.Turret.Color = arg1.Config.ColorNormal
    end
    if arg1.Sound then
        arg1.Sound:Destroy()
        arg1.Sound = nil
    end
end
return module_upvr