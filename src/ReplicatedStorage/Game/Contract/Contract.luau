local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
module_upvr.__ClassName = "Contract"
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local ContractConsts_upvr = require(script.Parent.ContractConsts)
local Data_upvr = script.Parent.Data
local SeasonUtils_upvr = require(ReplicatedStorage.Game.Season.SeasonUtils)
function module_upvr.new(arg1) -- Line 15
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._obj = arg1
    module_upvr_2.obj = module_upvr_2._obj
    module_upvr_2._maid:GiveTask(function() -- Line 22
        module_upvr_2._obj = nil
        module_upvr_2.obj = nil
    end)
    module_upvr_2._stateValue = arg1:WaitForChild(ContractConsts_upvr.STATE_VALUE_NAME, 5)
    local any_GetStateId_result1_2_upvw = module_upvr_2:GetStateId()
    module_upvr_2._maid:GiveTask(module_upvr_2:GetStateValue():GetPropertyChangedSignal("Value"):Connect(function() -- Line 30
        local any_GetStateId_result1 = module_upvr_2:GetStateId()
        if module_upvr_2._onStateChanged then
            module_upvr_2._onStateChanged:Fire(any_GetStateId_result1, any_GetStateId_result1_2_upvw)
        end
        any_GetStateId_result1_2_upvw = any_GetStateId_result1
    end))
    module_upvr_2._progressValue = arg1:WaitForChild(ContractConsts_upvr.PROGRESS_VALUE_NAME, 5)
    module_upvr_2._goalValue = arg1:WaitForChild(ContractConsts_upvr.GOAL_VALUE_NAME, 5)
    module_upvr_2._lastStateUpdateValue = arg1:WaitForChild(ContractConsts_upvr.LAST_STATE_UPDATE_VALUE_NAME, 5)
    module_upvr_2._contractActionRemote = arg1:WaitForChild(ContractConsts_upvr.CONTRACT_ACTION_REMOTE_NAME, 5)
    module_upvr_2._requireSeasonPassValue = arg1:WaitForChild(ContractConsts_upvr.REQUIRE_SEASON_PASS_VALUE_NAME, 5)
    module_upvr_2._rerolledValue = arg1:WaitForChild(ContractConsts_upvr.REROLLED_VALUE_NAME, 5)
    local any_GetName_result1 = module_upvr_2:GetName()
    local SOME = Data_upvr:FindFirstChild(any_GetName_result1)
    if not SOME then
        error("Cannot find client data module for contract: %s":format(any_GetName_result1))
    end
    local var13_2 = require(SOME)
    if not var13_2.teamId then
        error("Missing `clientData.teamId` value")
    end
    module_upvr_2:SetTeamId(var13_2.teamId)
    if not var13_2.rewardExp then
        error("Missing `clientData.rewardExp` value")
    end
    module_upvr_2:SetRewardExp(var13_2.rewardExp * SeasonUtils_upvr.getSeasonExpMult())
    if not var13_2.message then
        error("Missing `clientData.message` value")
    end
    local var15
    if type(var13_2.message) == "string" then
        var15 = var13_2.message
    elseif type(var13_2.message) == "function" then
        var15 = var13_2.message(module_upvr_2)
    end
    module_upvr_2:SetMessage(var15)
    return module_upvr_2
end
local Players_upvr = game:GetService("Players")
function module_upvr.GetPlayer(arg1) -- Line 86
    local any_GetPlayerByUserId_result1 = Players_upvr:GetPlayerByUserId(arg1._obj.Parent.Name)
    local var18
    if not any_GetPlayerByUserId_result1 then return end
    if any_GetPlayerByUserId_result1.Parent ~= game:GetService("Players") then
        var18 = false
    else
        var18 = true
    end
    assert(var18)
    return any_GetPlayerByUserId_result1
end
function module_upvr.GetName(arg1) -- Line 95
    return arg1._obj.Name
end
function module_upvr.SetMessage(arg1, arg2) -- Line 98
    if arg2 == nil then
    else
    end
    assert(true)
    if type(arg2) ~= "string" then
    else
    end
    assert(true)
    arg1._message = arg2
end
function module_upvr.GetMessage(arg1) -- Line 104
    return arg1._message
end
function module_upvr.GetRequireSeasonPassValue(arg1) -- Line 107
    return arg1._requireSeasonPassValue
end
function module_upvr.GetRequireSeasonPass(arg1) -- Line 110
    return arg1:GetRequireSeasonPassValue().Value
end
function module_upvr.GetStateValue(arg1) -- Line 113
    return arg1._stateValue
end
function module_upvr.GetStateId(arg1) -- Line 116
    return arg1._stateValue.Value
end
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
function module_upvr.GetOnStateChangedSignal(arg1) -- Line 119
    if not arg1._onStateChanged then
        arg1._onStateChanged = Signal_upvr.new()
        arg1._maid:GiveTask(arg1._onStateChanged)
    end
    return arg1._onStateChanged
end
function module_upvr.GetProgressValue(arg1) -- Line 126
    return arg1._progressValue
end
function module_upvr.GetProgress(arg1) -- Line 129
    return arg1._progressValue.Value
end
function module_upvr.SetTeamId(arg1, arg2) -- Line 132
    arg1._teamId = arg2
end
function module_upvr.GetTeamId(arg1) -- Line 135
    return arg1._teamId
end
function module_upvr.SetGoal(arg1, arg2) -- Line 138
    if arg2 == nil then
    else
    end
    assert(true)
    if type(arg2) ~= "number" then
    else
    end
    assert(true)
    arg1._goalValue.Value = arg2
end
function module_upvr.GetGoal(arg1) -- Line 143
    return arg1._goalValue.Value
end
function module_upvr.GetRewardExp(arg1) -- Line 146
    return arg1._rewardExp
end
function module_upvr.SetRewardExp(arg1, arg2) -- Line 149
    arg1._rewardExp = arg2
end
function module_upvr.GetLastStateUpdate(arg1) -- Line 152
    return arg1._lastStateUpdateValue.Value
end
function module_upvr.Destroy(arg1) -- Line 155
    local var20
    if arg1._maid == nil then
        var20 = false
    else
        var20 = true
    end
    assert(var20)
    arg1._maid:Destroy()
    arg1._maid = nil
    var20 = arg1
    setmetatable(var20, nil)
end
return module_upvr