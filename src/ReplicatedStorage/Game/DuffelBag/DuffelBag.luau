local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RobberyMoneyUI_upvr = require(ReplicatedStorage.Game.RobberyMoneyUI.RobberyMoneyUI)
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
local DuffelBagConsts_upvr = require(script.Parent.DuffelBagConsts)
local function _(arg1) -- Line 12, Named "GetDevProdByTier"
    for _, v in ipairs(Settings_upvr.DevProduct) do
        if v.Type == "DuffelBagUpgrade" and v.Tier == arg1 then
            return v
        end
    end
end
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr.new(arg1) -- Line 25
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._obj = arg1
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._ownerMaid = Maid_upvr.new()
    module_upvr_2._maid:GiveTask(module_upvr_2._ownerMaid)
    module_upvr_2._ownerObj = arg1:WaitForChild(DuffelBagConsts_upvr.OWNER_VALUE_NAME, 2)
    module_upvr_2._maid:GiveTask(module_upvr_2._ownerObj.Changed:Connect(function() -- Line 36
        module_upvr_2:_handleOwner()
    end))
    module_upvr_2:_handleOwner()
    local function _(arg1_2) -- Line 41, Named "updateParent"
        module_upvr_2:_handleOwner()
    end
    module_upvr_2._maid:GiveTask(arg1.AncestryChanged:Connect(function(arg1_3, arg2) -- Line 44
        module_upvr_2:_handleOwner()
    end))
    local SOME = arg1:WaitForChild(DuffelBagConsts_upvr.REMOTE_EVENT_NAME, 2)
    module_upvr_2._maid:GiveTask(SOME.OnClientEvent:Connect(function(...) -- Line 50
        module_upvr_2:_onClientEvent(...)
    end))
    module_upvr_2._remoteEvent = SOME
    module_upvr_2._robberyEnumValue = arg1:WaitForChild(DuffelBagConsts_upvr.ROBBERY_ENUM_VALUE_NAME, 2)
    return module_upvr_2
end
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local MarketplaceService_upvr = game:GetService("MarketplaceService")
function module_upvr._handleOwner(arg1) -- Line 60
    arg1._ownerMaid:DoCleaning()
    if not arg1:IsHeld() then
    else
        local var20
        if arg1:GetOwner() == LocalPlayer_upvr then
            RobberyMoneyUI_upvr.Show()
            arg1._ownerMaid:GiveTask(function() -- Line 68
                RobberyMoneyUI_upvr.Hide()
            end)
            local _obj = arg1._obj
            local SOME_upvr = _obj:WaitForChild(DuffelBagConsts_upvr.AMOUNT_VALUE_NAME)
            local SOME_5_upvr = _obj:WaitForChild(DuffelBagConsts_upvr.MAXIMUM_VALUE_NAME)
            local SOME_4_upvr = _obj:WaitForChild(DuffelBagConsts_upvr.MULT_VALUE_NAME)
            local SOME_upvr_3 = _obj:WaitForChild(DuffelBagConsts_upvr.MULT_ENABLED_VALUE_NAME)
            local SOME_2_upvr = _obj:WaitForChild(DuffelBagConsts_upvr.TIER_VALUE_NAME)
            local SOME_upvr_2 = _obj:WaitForChild(DuffelBagConsts_upvr.ROBBERY_ENUM_VALUE_NAME)
            local function setAmountValue() -- Line 81
                local var29
                local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var29 = math.ceil(SOME_5_upvr.Value * SOME_4_upvr.Value)
                    return var29
                end
                if not SOME_upvr_3.Value or not decompInlinedCondition() then
                    var29 = SOME_5_upvr
                    var29 = var29.Value
                end
                arg1:_setAmount(SOME_upvr.Value, var29)
            end
            local SOME_6_upvr = _obj:WaitForChild(DuffelBagConsts_upvr.FORMATTER_VALUE_NAME)
            var20 = SOME_6_upvr.Value
            arg1:_setFormatter(var20)
            var20 = SOME_6_upvr:GetPropertyChangedSignal("Value")
            var20 = var20:Connect(function() -- Line 88
                arg1:_setFormatter(SOME_6_upvr.Value)
                arg1:_setTier(SOME_2_upvr.Value, SOME_upvr_3.Value)
                local var32
                local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var32 = math.ceil(SOME_5_upvr.Value * SOME_4_upvr.Value)
                    return var32
                end
                if not SOME_upvr_3.Value or not decompInlinedCondition_2() then
                    var32 = SOME_5_upvr
                    var32 = var32.Value
                end
                arg1:_setAmount(SOME_upvr.Value, var32)
            end)
            arg1._ownerMaid:GiveTask(var20)
            var20 = SOME_upvr:GetPropertyChangedSignal("Value"):Connect(setAmountValue)
            arg1._ownerMaid:GiveTask(var20)
            var20 = SOME_5_upvr:GetPropertyChangedSignal("Value"):Connect(setAmountValue)
            arg1._ownerMaid:GiveTask(var20)
            var20 = DuffelBagConsts_upvr
            var20 = var20.TIME_VALUE_NAME
            local SOME_upvr_4 = _obj:WaitForChild(var20)
            arg1:_setTime(SOME_upvr_4.Value)
            arg1._ownerMaid:GiveTask(SOME_upvr_4:GetPropertyChangedSignal("Value"):Connect(function() -- Line 99
                arg1:_setTime(SOME_upvr_4.Value)
            end))
            arg1:_setTier(SOME_2_upvr.Value, SOME_upvr_3.Value)
            arg1._ownerMaid:GiveTask(SOME_2_upvr:GetPropertyChangedSignal("Value"):Connect(function() -- Line 104
                arg1:_setTier(SOME_2_upvr.Value, SOME_upvr_3.Value)
                local var36
                local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var36 = math.ceil(SOME_5_upvr.Value * SOME_4_upvr.Value)
                    return var36
                end
                if not SOME_upvr_3.Value or not decompInlinedCondition_3() then
                    var36 = SOME_5_upvr
                    var36 = var36.Value
                end
                arg1:_setAmount(SOME_upvr.Value, var36)
            end))
            arg1._ownerMaid:GiveTask(SOME_4_upvr:GetPropertyChangedSignal("Value"):Connect(function() -- Line 109
                local var38
                local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var38 = math.ceil(SOME_5_upvr.Value * SOME_4_upvr.Value)
                    return var38
                end
                if not SOME_upvr_3.Value or not decompInlinedCondition_4() then
                    var38 = SOME_5_upvr
                    var38 = var38.Value
                end
                arg1:_setAmount(SOME_upvr.Value, var38)
            end))
            arg1._ownerMaid:GiveTask(SOME_upvr_3:GetPropertyChangedSignal("Value"):Connect(function() -- Line 112
                arg1:_setTier(SOME_2_upvr.Value, SOME_upvr_3.Value)
                local var40
                local function decompInlinedCondition_5() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var40 = math.ceil(SOME_5_upvr.Value * SOME_4_upvr.Value)
                    return var40
                end
                if not SOME_upvr_3.Value or not decompInlinedCondition_5() then
                    var40 = SOME_5_upvr
                    var40 = var40.Value
                end
                arg1:_setAmount(SOME_upvr.Value, var40)
            end))
            local SOME_3_upvr = _obj:WaitForChild(DuffelBagConsts_upvr.MESSAGE_VALUE_NAME)
            var20 = arg1:_setMessage
            var20(SOME_3_upvr.Value)
            var20 = arg1._ownerMaid
            var20 = var20:GiveTask
            var20(SOME_3_upvr:GetPropertyChangedSignal("Value"):Connect(function() -- Line 119
                arg1:_setMessage(SOME_3_upvr.Value)
            end))
            var20 = arg1._ownerMaid
            var20 = var20:GiveTask
            var20(RobberyMoneyUI_upvr.getUpgradeButton().MouseButton1Down:Connect(function() -- Line 123
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                for _, v_2 in ipairs(Settings_upvr.DevProduct) do
                    if v_2.Type == "DuffelBagUpgrade" then
                        if v_2.Tier == SOME_2_upvr.Value + 1 then
                            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                        end
                    end
                end
                local var52
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                assert(var52)
                MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, var52.Id)
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            end))
            var20 = arg1:_setRobbery
            var20(SOME_upvr_2.Value)
            var20 = arg1._ownerMaid
            var20 = var20:GiveTask
            var20(SOME_upvr_2:GetPropertyChangedSignal("Value"):Connect(function() -- Line 132
                arg1:_setRobbery(SOME_upvr_2.Value)
            end))
            local function decompInlinedCondition_6() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var20 = math.ceil(SOME_5_upvr.Value * SOME_4_upvr.Value)
                return var20
            end
            if not SOME_upvr_3.Value or not decompInlinedCondition_6() then
                var20 = SOME_5_upvr.Value
            end
            arg1:_setAmount(SOME_upvr.Value, var20)
        end
    end
end
function module_upvr._setAmount(arg1, arg2, arg3) -- Line 139
    RobberyMoneyUI_upvr.SetMoney(arg2, arg3)
end
function module_upvr._setFormatter(arg1, arg2) -- Line 142
    RobberyMoneyUI_upvr.SetFormatter(assert(RobberyMoneyUI_upvr.Formatter[arg2]))
end
function module_upvr._setTime(arg1, arg2) -- Line 146
    local var54
    if var54 <= 0.001 then
        var54 = nil
    end
    RobberyMoneyUI_upvr.SetTime(var54)
end
function module_upvr._setTier(arg1, arg2, arg3) -- Line 152
    if arg2 == nil then
    else
    end
    assert(true)
    if arg3 == nil then
    else
    end
    assert(true)
    RobberyMoneyUI_upvr.SetTier(arg2, arg3)
end
function module_upvr._setMessage(arg1, arg2) -- Line 157
    RobberyMoneyUI_upvr.SetMessage(arg2)
end
function module_upvr._setRobbery(arg1, arg2) -- Line 160
    RobberyMoneyUI_upvr.SetRobbery(arg2)
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_upvr._onClientEvent(arg1, arg2) -- Line 163
    if arg2 == DuffelBagConsts_upvr.net.PLAY_AWARD_SOUND then
        Audio_upvr.ObjectLocal(script, 1988476450)
    end
end
function module_upvr.IsHeld(arg1) -- Line 168
    local any_GetOwner_result1 = arg1:GetOwner()
    if any_GetOwner_result1 then
        any_GetOwner_result1 = arg1._obj:IsDescendantOf(Players_upvr)
    end
    return any_GetOwner_result1
end
function module_upvr.GetOwner(arg1) -- Line 171
    return arg1._ownerObj.Value
end
function module_upvr.GetRobbery(arg1) -- Line 174
    return arg1._robberyEnumValue.Value
end
function module_upvr.GetRobberyChangedSignal(arg1) -- Line 177
    return arg1._robberyEnumValue.Changed
end
function module_upvr.Destroy(arg1) -- Line 180
    arg1._maid:Destroy()
    arg1._maid = nil
end
return module_upvr