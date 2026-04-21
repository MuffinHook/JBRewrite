local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeasonSystem_upvr = require(ReplicatedStorage.Game.Season.SeasonSystem)
local ContractConsts_upvr = require(script.Parent.ContractConsts)
local ContractSystem_upvr = require(script.Parent.ContractSystem)
local ContractUtils_upvr = require(script.Parent.ContractUtils)
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
module_2_upvr.__ClassName = "ContractUI"
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_2_upvr.new() -- Line 22
    local module = {}
    setmetatable(module, module_2_upvr)
    module._maid = Maid_upvr.new()
    return module
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Confirmation_upvr = require(ReplicatedStorage.Module.Confirmation)
local String_upvr = require(ReplicatedStorage.Std.String)
function module_2_upvr.SetFrame(arg1, arg2) -- Line 30
    if arg2 == nil then
    else
    end
    assert(true)
    assert(not arg1._frame)
    arg1._frame = arg2
    arg1._maid:GiveTask(arg1._frame)
    arg1._maid:GiveTask(arg1._frame.Background.Body.Bottom.Action.MouseButton1Down:Connect(function() -- Line 36
        Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105461542)
        if arg1._contract:GetStateId() == ContractConsts_upvr.enumState.ACTIVE then
            local any_new_result1 = Confirmation_upvr.new(string.format("Re-roll for a random contract for $%s?", String_upvr.comma(ContractConsts_upvr.REROLL_PRICE)))
            any_new_result1.Maid:GiveTask(any_new_result1.OnYes:Connect(function() -- Line 43
                arg1._contract._contractActionRemote:FireServer()
            end))
            arg1._contract._rerollConfirm = any_new_result1
        else
            arg1._contract._contractActionRemote:FireServer()
        end
    end))
    arg1._maid:GiveTask(ContractSystem_upvr.getAnyContractActiveTransitionSignal():Connect(function() -- Line 52
        if getmetatable(arg1) == nil then
        else
            if getmetatable(arg1._contract) == nil then return end
            arg1:_updateState(arg1._contract:GetStateId())
        end
    end))
end
function module_2_upvr.SetLayoutOrder(arg1, arg2) -- Line 62
    if arg2 == nil then
    else
    end
    assert(true)
    arg1._frame.LayoutOrder = arg2
end
function module_2_upvr.SetContract(arg1, arg2) -- Line 66
    assert(not arg1._contract)
    arg1._contract = arg2
    arg1._maid:GiveTask(arg1._contract:GetProgressValue():GetPropertyChangedSignal("Value"):Connect(function() -- Line 69
        arg1:_updateProgress()
    end))
    arg1:_updateProgress()
    local function updateState() -- Line 74
        arg1:_updateState(arg1._contract:GetStateId())
    end
    arg1._maid:GiveTask(arg1._contract:GetRequireSeasonPassValue():GetPropertyChangedSignal("Value"):Connect(updateState))
    arg1._maid:GiveTask(arg1._contract:GetStateValue():GetPropertyChangedSignal("Value"):Connect(updateState))
    arg1._maid:GiveTask(ContractUtils_upvr.getNumTimesRerolledObject(arg1._contract.obj).Changed:Connect(updateState))
    arg1:_updateState(arg1._contract:GetStateId())
    arg1._maid:GiveTask(SeasonSystem_upvr.getSeasonPassOwnedSignal():Connect(function(arg1_2) -- Line 83
        if arg1_2 ~= LocalPlayer_upvr then
        else
            arg1:_updateState(arg1._contract:GetStateId())
        end
    end))
    arg1._frame.Name = arg1._contract:GetName()
    arg1:_setTeamId(arg1._contract:GetTeamId())
    arg1:_setRewardExp(arg1._contract:GetRewardExp())
    arg1:_setMessage(arg1._contract:GetMessage())
end
function module_2_upvr.SetTitle(arg1, arg2) -- Line 96
    arg1._frame.Background.Title.TextLabel.Text = arg2
end
function module_2_upvr._setMessage(arg1, arg2) -- Line 99
    arg1._frame.Background.Body.Top.ContractDesc.Text = arg2
end
function module_2_upvr._setRewardExp(arg1, arg2) -- Line 104
    arg1._frame.Background.Body.Bottom.Reward.Amount.Text = string.format("REWARD: %d XP", arg2)
end
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
function module_2_upvr._setTeamId(arg1, arg2) -- Line 109
    local var20
    if arg2 == Settings_upvr.EnumTeam.Police then
        var20 = 5955472455
    elseif arg2 == Settings_upvr.EnumTeam.Criminal then
        var20 = 5955427564
    else
        error(string.format("Invalid teamId: %d", arg2))
    end
    arg1._frame.Background.Image = string.format("rbxassetid://%d", var20)
end
function module_2_upvr._updateProgress(arg1) -- Line 120
    local var21
    local var22
    if arg1._contract:GetStateId() == ContractConsts_upvr.enumState.ACTIVE then
        var21 = arg1._contract:GetProgress()
    end
    local Bottom = arg1._frame.Background.Body.Bottom
    if var21 == nil then
        var22 = false
    else
        var22 = true
    end
    Bottom.Progress.Visible = var22
    if var21 ~= nil then
        var22 = string.format("PROGRESS: %d/%d", arg1._contract:GetProgress(), arg1._contract:GetGoal())
        Bottom.Progress.Text = var22
    end
end
local GamepassSystem_upvr = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils_upvr = require(ReplicatedStorage.Gamepass.GamepassUtils)
local SeasonUtils_upvr = require(ReplicatedStorage.Game.Season.SeasonUtils)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_2_upvr._updateState(arg1, arg2) -- Line 133
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if getmetatable(arg1) == nil then return end
    if arg2 == ContractConsts_upvr.enumState.ACCEPTABLE then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg2 == ContractConsts_upvr.enumState.ACTIVE and ContractUtils_upvr.canReroll(arg1._contract.obj, GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.VIP)) then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_2_upvr.Destroy(arg1) -- Line 218
    local var28
    if arg1._maid == nil then
        var28 = false
    else
        var28 = true
    end
    assert(var28)
    arg1._maid:Destroy()
    arg1._maid = nil
    var28 = arg1
    setmetatable(var28, nil)
end
return module_2_upvr