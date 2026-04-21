local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Time_upvr = require(ReplicatedStorage.Module.Time)
local DoorUtils_upvr = require(ReplicatedStorage.Door2.DoorUtils)
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local VaultConsts_upvr = require(script.VaultConsts)
function tbl_upvr.new(arg1) -- Line 20
    local module_upvr = {}
    setmetatable(module_upvr, tbl_upvr)
    module_upvr._homeItem = arg1
    module_upvr._obj = module_upvr._homeItem._obj
    module_upvr.obj = module_upvr._obj
    module_upvr._maid = Maid_upvr.new()
    module_upvr.maid = module_upvr._maid
    module_upvr._deadlineValue = module_upvr._obj:WaitForChild(VaultConsts_upvr.DEADLINE_VALUE_NAME)
    module_upvr._maid:GiveTask(module_upvr._deadlineValue.Changed:Connect(function() -- Line 31
        module_upvr:_onDeadlineChanged()
    end))
    module_upvr:_onDeadlineChanged()
    module_upvr._amountValue = module_upvr._obj:WaitForChild(VaultConsts_upvr.AMOUNT_VALUE_NAME)
    module_upvr._maid:GiveTask(module_upvr._amountValue.Changed:Connect(function() -- Line 37
        module_upvr:_onAmountChanged()
    end))
    module_upvr:_onAmountChanged()
    module_upvr._vaultInteractRemote = module_upvr._obj:WaitForChild(VaultConsts_upvr.VAULT_INTERACT_REMOTE_NAME)
    module_upvr:_findDoor()
    return module_upvr
end
function tbl_upvr._setArmJ(arg1, arg2) -- Line 47
    for _, v in ipairs(DoorUtils_upvr.getInnerModel(arg1._doorModel):GetChildren()) do
        if v.Name == "Arm" then
            v.Size = Vector3.new(arg2 * 7.6 + (1 - arg2) * 4, 0.5, 0.5)
            v.CFrame = v.CFrame
        end
    end
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function tbl_upvr._onDeadlineChanged(arg1) -- Line 59
    local any_GetNowSync_result1_upvw = Time_upvr.GetNowSync()
    if any_GetNowSync_result1_upvw < arg1:GetDeadline() then
        arg1._maid._deadlineLoop = Interval_upvr.every(1):Connect(function() -- Line 62
            any_GetNowSync_result1_upvw = Time_upvr.GetNowSync()
            local var18 = arg1:GetDeadline() - any_GetNowSync_result1_upvw
            if var18 < 0 then
                var18 = 0
            end
            arg1:_updateDeadlineUi(var18)
            if var18 == 0 then
                arg1._maid._deadlineLoop = nil
            end
        end)
    else
        arg1:_updateDeadlineUi(0)
    end
end
local BinderUtils_upvr = require(ReplicatedStorage.Std.Binder.BinderUtils)
local DoorBinder_upvr = require(ReplicatedStorage.Door2.DoorBinder)
function tbl_upvr._findDoor(arg1) -- Line 77
    local Door = arg1._obj:WaitForChild("Door")
    arg1._doorModel = Door
    BinderUtils_upvr.promiseBoundClass(DoorBinder_upvr, Door):andThen(function(arg1_2) -- Line 81
        arg1:_receiveDoor(arg1_2)
    end):catch(warn)
end
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function tbl_upvr._receiveDoor(arg1, arg2) -- Line 86
    local Body_upvr = DoorUtils_upvr.getInnerModel(arg1.obj.Door).Body
    arg1.maid:GiveTask(function() -- Line 130
    end)
    CircleAction_upvr.Add({
        Part = Body_upvr;
        Name = "";
        NoRay = true;
        Timed = true;
        Duration = 3;
        Dist = 10;
        Callback = function(arg1_4, arg2_2) -- Line 112, Named "action"
            if arg2_2 then
                arg1._vaultInteractRemote:FireServer()
                return true
            end
        end;
        PreUpdateFun = function(arg1_3) -- Line 87, Named "preUpdateFun"
            local var25 = false
            local any_GetHome_result1 = arg1._homeItem:GetHome()
            if any_GetHome_result1 and any_GetHome_result1:HasPermissionToEnter(LocalPlayer_upvr) and not arg1:IsCounting() then
                var25 = true
                arg1_3.Name = "Arm"
            end
            if arg1._homeItem:IsBeingDragged() then
                var25 = false
            end
            if not DoorUtils_upvr.getOpen(arg1._doorModel) then
                var25 = false
            end
            arg1_3.Enabled = var25
        end;
    }, Body_upvr)
    arg1._maid:GiveTask(function() -- Line 132
        CircleAction_upvr.Remove(Body_upvr)
    end)
end
function tbl_upvr.GetIsVaultArmed(arg1) -- Line 136
    return not DoorUtils_upvr.getOpen(arg1.obj.Door)
end
local VaultUtils_upvr = require(script.VaultUtils)
function tbl_upvr.GetArmingTeamId(arg1) -- Line 139
    return VaultUtils_upvr.getArmingTeamId(arg1.obj)
end
function tbl_upvr._updateDeadlineUi(arg1, arg2) -- Line 142
    DoorUtils_upvr.getInnerModel(arg1._obj.Door).Timer.SurfaceGui.TextLabel.Text = string.format("%02d:%02d", math.floor(arg2 / 60), arg2 % 60)
end
local Format_upvr = require(ReplicatedStorage.Module.Format)
function tbl_upvr._onAmountChanged(arg1) -- Line 148
    local SurfaceGui = DoorUtils_upvr.getInnerModel(arg1._obj.Door).Cash.SurfaceGui
    if 0 < arg1._amountValue.Value then
        SurfaceGui.TextLabel.BackgroundColor3 = Color3.fromRGB(115, 250, 121)
        SurfaceGui.TextLabel.BackgroundTransparency = 0
        SurfaceGui.TextLabel.TextColor3 = Color3.new(0, 0, 0)
    else
        SurfaceGui.TextLabel.BackgroundTransparency = 1
    end
    SurfaceGui.TextLabel.Text = string.format("%s", Format_upvr.Currency(arg1._amountValue.Value));
end
function tbl_upvr.GetDeadline(arg1) -- Line 160
    return arg1._deadlineValue.Value
end
function tbl_upvr.IsCounting(arg1) -- Line 163
    local var34
    if Time_upvr.GetNowSync() >= arg1:GetDeadline() then
        var34 = false
    else
        var34 = true
    end
    return var34
end
function tbl_upvr.Destroy(arg1) -- Line 166
    local _maid = arg1._maid
    local var36
    if _maid == nil then
        var36 = false
    else
        var36 = true
    end
    assert(var36)
    arg1._maid = nil
    _maid:Destroy()
end
return {
    setup = function(arg1) -- Line 174, Named "setup"
        local any_new_result1 = tbl_upvr.new(arg1)
        arg1._maid:GiveTask(any_new_result1)
        arg1._vault = any_new_result1
    end;
}