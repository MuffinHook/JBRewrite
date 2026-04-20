local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local EzUtils_upvr = require(ReplicatedStorage_upvr.EzUi.EzUtils)
local Signal_upvr = require(ReplicatedStorage_upvr.Std.Signal)
local var5_upvw
local AwardData_upvr = require(script.Parent.AwardData)
local SeasonConsts_upvr = require(script.Parent.SeasonConsts)
local function _(arg1) -- Line 18, Named "SelectIfGamepad"
    EzUtils_upvr.selectIfGamepad(arg1)
end
local module_upvr = {
    _maid = require(ReplicatedStorage_upvr.Std.Maid).new();
    _mapLevelsAwarded = {};
    onLevelsAwardedChanged = Signal_upvr.new();
}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local SeasonUtils_upvr = require(script.Parent.SeasonUtils)
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local Region_upvr = require(ReplicatedStorage_upvr.Std.Region)
local RegionUtils_upvr = require(ReplicatedStorage_upvr.Std.Region.RegionUtils)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
function module_upvr.init() -- Line 26
    var5_upvw = require(ReplicatedStorage_upvr.Game.Level2.LevelUISystem)
    local SeasonUISystem_upvr = require(script.Parent.SeasonUISystem)
    for i, v_upvr in ipairs(Players_upvr:GetPlayers()) do
        v_upvr:WaitForChild(SeasonConsts_upvr.HAS_SEASON_PASS_VALUE_NAME).Changed:Connect(function(arg1) -- Line 32
            if arg1 and module_upvr._onSeasonPassOwned then
                module_upvr._onSeasonPassOwned:Fire(v_upvr)
            end
        end)
    end
    Players_upvr.PlayerAdded:Connect(function(arg1) -- Line 30, Named "playerAdded"
        arg1:WaitForChild(SeasonConsts_upvr.HAS_SEASON_PASS_VALUE_NAME).Changed:Connect(function(arg1_2) -- Line 32
            if arg1_2 and module_upvr._onSeasonPassOwned then
                module_upvr._onSeasonPassOwned:Fire(arg1)
            end
        end)
    end)
    i = 30
    waitForChild_upvr(ReplicatedStorage_upvr, SeasonConsts_upvr.OPENED_SEASON_REMOTE_NAME, i):andThen(function(arg1) -- Line 46
        SeasonUISystem_upvr._window:GetOnOpenedSignal():Connect(function() -- Line 47
            arg1:FireServer()
        end)
    end):catch(warn)
    i = 30
    waitForChild_upvr(ReplicatedStorage_upvr, SeasonConsts_upvr.REDEEM_REMOTE_NAME, i):andThen(function(arg1) -- Line 54
        module_upvr._redeemRemote = arg1
        arg1.OnClientEvent:Connect(function(arg1_3, arg2) -- Line 56
            module_upvr._unrewardedLevels = arg1_3
            module_upvr._unrewardedBonus = arg2
            module_upvr.displayReward()
        end)
    end):catch(warn)
    i = 30
    waitForChild_upvr(LocalPlayer_upvr, SeasonConsts_upvr.LEVELS_AWARDED_VALUE_NAME, i):andThen(function(arg1) -- Line 65
        arg1.Changed:Connect(function() -- Line 66, Named "handle"
            module_upvr._mapLevelsAwarded = SeasonUtils_upvr.deserializeLevelsAwarded(arg1.Value)
            module_upvr.onLevelsAwardedChanged:Fire()
        end)
        module_upvr._mapLevelsAwarded = SeasonUtils_upvr.deserializeLevelsAwarded(arg1.Value)
        module_upvr.onLevelsAwardedChanged:Fire()
    end):catch(warn)
    if RunUtils_upvr.isMainWorld() and not RunUtils_upvr.isStudio() then
        i = 30
        waitForChild_upvr(workspace, "SeasonPrompts", i):andThen(function(arg1) -- Line 78
            task.wait(1)
            local any_new_result1_upvr = Region_upvr.new(RegionUtils_upvr.ConditionPlayer)
            for _, v_2 in ipairs(arg1:GetChildren()) do
                any_new_result1_upvr:AddPart(v_2)
            end
            any_new_result1_upvr.OnObjAdded:Connect(function() -- Line 84
                if not SeasonUISystem_upvr._window:IsOpen() then
                    SeasonUISystem_upvr.open()
                end
            end)
            any_new_result1_upvr.OnObjRemoved:Connect(function() -- Line 89
                if SeasonUISystem_upvr._window:IsOpen() then
                    SeasonUISystem_upvr.close()
                end
            end)
            Interval_upvr.every(0.2):Connect(function() -- Line 94
                any_new_result1_upvr:Update({Players_upvr.LocalPlayer})
            end)
        end):catch(warn)
    end
end
function module_upvr.getLevelsAwarded() -- Line 101
    return module_upvr._mapLevelsAwarded
end
function module_upvr.getLevelAwarded(arg1) -- Line 104
    return module_upvr._mapLevelsAwarded[tostring(arg1)]
end
function module_upvr.displayReward() -- Line 107
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Redeem_upvr = var5_upvw.gui.Background.Body.InfoButton.Redeem
    local var43_upvw = false
    local var44_upvw
    if 0 < #module_upvr._unrewardedBonus then
        var43_upvw = true
        var44_upvw = table.remove(module_upvr._unrewardedBonus, 1)
    else
        var44_upvw = table.remove(module_upvr._unrewardedLevels, 1)
    end
    if not var44_upvw then
    else
        Redeem_upvr.Visible = true
        if not var43_upvw or not module_upvr.getClientBonusAward(var44_upvw) then
            local any_getClientLevelAward_result1 = module_upvr.getClientLevelAward(var44_upvw)
        end
        if not any_getClientLevelAward_result1.imageId then
            error("Missing `imageId` for client level award: %d":format(var44_upvw))
        end
        Redeem_upvr.Container.Icon.Image = "rbxassetid://%d":format(any_getClientLevelAward_result1.imageId)
        module_upvr._maid.clickRedeem = Redeem_upvr.MouseButton1Down:Connect(function() -- Line 132, Named "redeem"
            module_upvr._maid.clickRedeem = nil
            Redeem_upvr.Visible = false
            module_upvr._redeemRemote:FireServer(var44_upvw, var43_upvw)
            module_upvr.displayReward()
        end)
        EzUtils_upvr.selectIfGamepad(Redeem_upvr)
    end
end
function module_upvr.getSeasonPassOwnedSignal() -- Line 142
    if not module_upvr._onSeasonPassOwned then
        module_upvr._onSeasonPassOwned = Signal_upvr.new()
    end
    return module_upvr._onSeasonPassOwned
end
function module_upvr.doesPlayerOwnSeasonPass(arg1) -- Line 148
    if arg1 == nil then
    else
    end
    assert(true)
    local SOME = arg1:FindFirstChild(SeasonConsts_upvr.HAS_SEASON_PASS_VALUE_NAME)
    if SOME then
        return SOME.Value
    end
    return false
end
function module_upvr.getClientLevelAward(arg1) -- Line 156
    if arg1 == nil then
    else
    end
    assert(true)
    if type(arg1) ~= "number" then
    else
    end
    assert(true)
    local var47 = AwardData_upvr.Level[arg1]
    assert(var47, "missing level award")
    return var47
end
function module_upvr.getClientBonusAward(arg1) -- Line 163
    if arg1 == nil then
    else
    end
    assert(true)
    if type(arg1) ~= "number" then
    else
    end
    assert(true)
    local var48 = AwardData_upvr.Bonus[arg1]
    assert(var48, "missing bonus award")
    return var48
end
return module_upvr