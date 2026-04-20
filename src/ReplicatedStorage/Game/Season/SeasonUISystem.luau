local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local LevelUtils_upvr = require(ReplicatedStorage_upvr.Game.Level2.LevelUtils)
local EzUtils_upvr = require(ReplicatedStorage_upvr.EzUi.EzUtils)
local LevelConsts_upvr = require(ReplicatedStorage_upvr.Game.Level2.LevelConsts)
local SeasonConsts_upvr = require(script.Parent.SeasonConsts)
local SeasonUtils_upvr = require(script.Parent.SeasonUtils)
local var9_upvw
local var10_upvw
local function _(arg1) -- Line 28, Named "SelectIfGamepad"
    EzUtils_upvr.selectIfGamepad(arg1)
end
local module_upvr = {}
local Window_upvr = require(ReplicatedStorage_upvr.Module.Window.Window)
local GameUtil_upvr = require(ReplicatedStorage_upvr.Game.GameUtil)
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
function module_upvr.init() -- Line 33
    var9_upvw = require(script.Parent.SeasonSystem)
    var10_upvw = require(ReplicatedStorage_upvr.Game.Contract.ContractUISystem)
    local SeasonGui = ReplicatedStorage_upvr.StarterGui:FindFirstChild("SeasonGui")
    SeasonGui.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.gui = SeasonGui
    module_upvr._seasonState = -1
    SeasonGui.Background.Title.Frame.SeasonNumWelcome.Text = "Welcome to SEASON %d":format(SeasonConsts_upvr.SEASON_NUM)
    SeasonGui.Background.Title.Frame.SeasonNumWelcome.TextLabel.Text = SeasonGui.Background.Title.Frame.SeasonNumWelcome.Text
    SeasonGui.Background.Title.Frame.SeasonTitle.Text = SeasonConsts_upvr.SEASON_TITLE
    local any_new_result1_2 = Window_upvr.new()
    any_new_result1_2:GetOnOpenedSignal():Connect(module_upvr._open)
    any_new_result1_2:GetOnClosedSignal():Connect(module_upvr._close)
    module_upvr._window = any_new_result1_2
    GameUtil_upvr.getCenterWindowGroup():Add(any_new_result1_2)
    waitForChild_upvr(ReplicatedStorage_upvr, SeasonConsts_upvr.PRIZE_PURCHASE_REMOTE_NAME, 30):andThen(function(arg1) -- Line 54
        var9_upvw._prizePurchaseRemote = arg1
    end):catch(warn)
    SeasonGui.Background.BonusAwards.Visible = SeasonConsts_upvr.SEASON_BONUS_ENABLED
end
function module_upvr._updateSeasonUi(arg1) -- Line 61
    module_upvr._seasonState = arg1
    local gui = module_upvr.gui
    if arg1 == 0 then
        gui.Background.Timer.Title.Text = "SEASON ENDS"
        gui.Background.Help.Text = SeasonConsts_upvr.SEASON_SUBTITLE
        gui.Background.Bottom.Container.ReviewButton.TextLabel.Text = "CONTRACTS"
    else
        if arg1 == 1 then
            gui.Background.Timer.Title.Text = "BUYING ENDS"
            gui.Background.Help.Text = SeasonConsts_upvr.BUY_SUBTITLE
            gui.Background.Bottom.Container.ReviewButton.TextLabel.Text = "COMING SOON"
            return
        end
        if arg1 == 2 then
            gui.Background.Timer.Title.Text = "SEASON ENDS"
            gui.Background.Help.Text = SeasonConsts_upvr.POST_SUBTITLE
            gui.Background.Bottom.Container.ReviewButton.TextLabel.Text = "COMING SOON"
            return
        end
        error("Invalid season state: %d":format(arg1))
    end
end
local ContractUtils_upvr = require(ReplicatedStorage_upvr.Game.Contract.ContractUtils)
function module_upvr._updateDeadline() -- Line 80
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local gui_3 = module_upvr.gui
    local any_getRemainingTime_result1 = SeasonUtils_upvr.getRemainingTime()
    local var26
    if any_getRemainingTime_result1 >= 0 then
        var26 = false
    else
        var26 = true
    end
    local any_isBuyEnabled_result1 = SeasonUtils_upvr.isBuyEnabled()
    if any_isBuyEnabled_result1 then
        gui_3.Background.Timer.Time.Text = SeasonUtils_upvr.formatRemaining(SeasonUtils_upvr.getRemainingBuyTime())
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    gui_3.Background.Timer.Time.Text = SeasonUtils_upvr.formatRemaining(any_getRemainingTime_result1)
    local var28
    if not var26 and not any_isBuyEnabled_result1 then
        var28 = 0
    elseif any_isBuyEnabled_result1 then
        var28 = 1
    else
        var28 = 2
    end
    if module_upvr._seasonState ~= var28 then
        module_upvr._updateSeasonUi(var28)
    end
    for i = 2, SeasonConsts_upvr.MAX_REWARD_LEVEL do
        local Buy = gui_3.Background.Body.Line.Container:FindFirstChild("%02d":format(i)).Reward:FindFirstChild("Buy")
        if Buy then
            Buy.Visible = any_isBuyEnabled_result1
        end
    end
    gui_3.Background.DailyExpRefreshHelp.Text = "Daily XP reloads in <font color=\"rgb(255, 207, 0)\">%s</font>!":format(SeasonUtils_upvr.formatRemaining(ContractUtils_upvr.getQuantizedBlock(LevelConsts_upvr.DAILY_EXP_DURATION, LevelConsts_upvr.DAILY_EXP_DURATION_OFFSET) - workspace:GetServerTimeNow()))
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Utils_upvr = require(ReplicatedStorage_upvr.EzUi.Utils)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local LevelSystem_upvr = require(ReplicatedStorage_upvr.Game.Level2.LevelSystem)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local Notification_upvr = require(ReplicatedStorage_upvr.Game.Notification)
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local SeasonUIUtils_upvr = require(ReplicatedStorage_upvr.Game.Season.SeasonUIUtils)
function module_upvr._open() -- Line 125
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var48_upvr
    if module_upvr._maid ~= nil then
        var48_upvr = false
    else
        var48_upvr = true
    end
    assert(var48_upvr)
    local any_new_result1 = Maid_upvr.new()
    var48_upvr = module_upvr
    var48_upvr._maid = any_new_result1
    var48_upvr = module_upvr
    var48_upvr = var48_upvr.gui
    if Utils_upvr.isSmallScreen() then
        var48_upvr.Background.BonusAwards.Position = UDim2.new(-0.15, 0, 0, 2)
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    var48_upvr.Background.BonusAwards.Position = UDim2.new(1.01, 0, 0, 2)
    var48_upvr.Enabled = true
    any_new_result1:GiveTask(function() -- Line 140
        var48_upvr.Enabled = false
    end)
    any_new_result1:GiveTask(Interval_upvr.every(1):Connect(module_upvr._updateDeadline))
    module_upvr._updateDeadline()
    module_upvr.updateProgress(LocalPlayer_upvr)
    any_new_result1:GiveTask(LevelSystem_upvr.getOnLevelChangedSignal():Connect(module_upvr.updateProgress))
    any_new_result1:GiveTask(LevelSystem_upvr.getOnExpChangedSignal():Connect(module_upvr.updateProgress))
    any_new_result1:GiveTask(var9_upvw.getSeasonPassOwnedSignal():Connect(function(arg1) -- Line 150
        if arg1 ~= LocalPlayer_upvr then
        else
            module_upvr.updateProgress(LocalPlayer_upvr)
        end
    end))
    any_new_result1:GiveTask(var48_upvr.Background.Bottom.Container.ReviewButton.MouseButton1Down:Connect(function() -- Line 157
        if SeasonUtils_upvr.getRemainingTime() < 0 then
        else
            Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 6105461542)
            module_upvr.close()
            var10_upvw.open()
        end
    end))
    EzUtils_upvr.selectIfGamepad(var48_upvr.Background.Bottom.Container.ReviewButton)
    var48_upvr.Background.Bottom.Container.SeasonPass.Title.Text = "SEASON %d: %s":format(SeasonConsts_upvr.SEASON_NUM, SeasonConsts_upvr.SEASON_TITLE)
    any_new_result1:GiveTask(var48_upvr.Background.Bottom.Container.SeasonPass.MouseButton1Down:Connect(function() -- Line 172
        if not RunUtils_upvr.isStudio() and SeasonUtils_upvr.getRemainingTime() <= 0 then
            Notification_upvr.new({
                Text = "Season is over! Wait until next season.";
            })
        else
            local var55 = 6105461542
            Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, var55)
            local any_getFirstProductByType_result1_3 = Settings_upvr.getFirstProductByType("SeasonPass")
            if any_getFirstProductByType_result1_3 == nil then
                var55 = false
            else
                var55 = true
            end
            assert(var55)
            if not var9_upvw.doesPlayerOwnSeasonPass(LocalPlayer_upvr) then
                MarketplaceService_upvr:PromptProductPurchase(LocalPlayer_upvr, any_getFirstProductByType_result1_3.Id)
            end
        end
    end))
    SeasonUIUtils_upvr.hookGiftContainer(var48_upvr.Background.GiftContainer, any_new_result1)
    local function _() -- Line 187, Named "setOwnsSeasonPass"
        var48_upvr.Background.Bottom.Container.SeasonPass.Buy.Visible = false
        var48_upvr.Background.Bottom.Container.SeasonPass.Price.Visible = false
        var48_upvr.Background.Bottom.Container.SeasonPass.Owned.Visible = true
    end
    if var9_upvw.doesPlayerOwnSeasonPass(LocalPlayer_upvr) then
        var48_upvr.Background.Bottom.Container.SeasonPass.Buy.Visible = false
        var48_upvr.Background.Bottom.Container.SeasonPass.Price.Visible = false
        var48_upvr.Background.Bottom.Container.SeasonPass.Owned.Visible = true
    else
        any_new_result1:GiveTask(var9_upvw.getSeasonPassOwnedSignal():Connect(function(arg1) -- Line 195
            if arg1 ~= LocalPlayer_upvr then
            else
                var48_upvr.Background.Bottom.Container.SeasonPass.Buy.Visible = false
                var48_upvr.Background.Bottom.Container.SeasonPass.Price.Visible = false
                var48_upvr.Background.Bottom.Container.SeasonPass.Owned.Visible = true
            end
        end))
    end
    any_new_result1:GiveTask(var48_upvr.Background.Close.MouseButton1Down:Connect(module_upvr.close))
    local any_getFirstProductByType_result1_2 = Settings_upvr.getFirstProductByType("SeasonPass")
    if any_getFirstProductByType_result1_2 and any_getFirstProductByType_result1_2.Robux then
        var48_upvr.Background.Bottom.Container.SeasonPass.Price.Text = tostring(any_getFirstProductByType_result1_2.Robux)
    end
    Settings_upvr.OnProductsFetched:Connect(function() -- Line 206, Named "updatePrice"
        local any_getFirstProductByType_result1 = Settings_upvr.getFirstProductByType("SeasonPass")
        if any_getFirstProductByType_result1 and any_getFirstProductByType_result1.Robux then
            var48_upvr.Background.Bottom.Container.SeasonPass.Price.Text = tostring(any_getFirstProductByType_result1.Robux)
        end
    end)
    for i_2 = 2, SeasonConsts_upvr.MAX_REWARD_LEVEL do
        var48_upvr.Background.Body.Line.Container:FindFirstChild("%02d":format(i_2)).Reward.Icon.Image = "rbxassetid://%d":format(var9_upvw.getClientLevelAward(i_2).imageId)
        local _
    end
    for i_3 = 1, SeasonConsts_upvr.NUM_BONUS_AWARDS do
        local any_getClientBonusAward_result1 = var9_upvw.getClientBonusAward(i_3)
        local SOME = var48_upvr.Background.BonusAwards.Container:FindFirstChild("Bonus%02d":format(i_3))
        SOME.Icon.Image = "rbxassetid://%d":format(any_getClientBonusAward_result1.imageId)
        SOME.Desc.Text = "TOP %d%%":format(any_getClientBonusAward_result1.scoreLte * 100)
        local var63
    end
    if SeasonConsts_upvr.SEASON_BONUS_ENABLED then
        local var64 = "CHECK LATER..."
        local SeasonBonusScore = LocalPlayer_upvr:FindFirstChild("SeasonBonusScore")
        if SeasonBonusScore then
            var64 = "YOU: TOP %.2f%%":format(SeasonBonusScore.Value * 100)
        end
        var48_upvr.Background.BonusAwards.Score.Text = var64
        var48_upvr.Background.BonusAwards.Desc.Text = "Players in the top %d%% win this prize when the season ends.":format(math.max(0, any_getClientBonusAward_result1.scoreLte) * 100)
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr._close() -- Line 248
    local var66
    if module_upvr._maid == nil then
        var66 = false
    else
        var66 = true
    end
    assert(var66)
    var66 = module_upvr
    var66._maid = nil
    var66 = module_upvr._maid:Destroy
    var66()
end
function module_upvr.open() -- Line 254
    module_upvr._window:Open()
end
function module_upvr.close() -- Line 257
    module_upvr._window:Close()
end
function module_upvr.updateProgress(arg1) -- Line 260
    if arg1 == LocalPlayer_upvr then
        module_upvr.setProgress(LevelUtils_upvr.yieldLevel(arg1), LevelUtils_upvr.yieldExp(arg1))
    end
end
local function setProgressFrameScale_upvr(arg1, arg2, arg3) -- Line 267, Named "setProgressFrameScale"
    local Parent = arg1.Parent
    if Parent == nil then
    else
        local Scale = Parent.Size.X.Scale
        local var69 = (Scale - 1) * (1 / Scale) / 2
        local var70 = (arg2 - 1) / (Scale * (SeasonConsts_upvr.MAX_REWARD_LEVEL - 1)) + var69
        if arg3 then
            local var71 = (arg3 - 1) / (Scale * (SeasonConsts_upvr.MAX_REWARD_LEVEL - 1)) + var69
            var70 -= var71
            arg1.Position = UDim2.new(UDim.new(var71, arg1.Position.X.Offset), arg1.Position.Y)
        end
        arg1.Size = UDim2.new(UDim.new(var70, arg1.Size.X.Offset), arg1.Size.Y)
        arg1.Visible = true
    end
end
function module_upvr.setProgress(arg1, arg2) -- Line 284
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local MAX_DAILY_EXP = LevelConsts_upvr.MAX_DAILY_EXP
    local var73
    if var9_upvw.doesPlayerOwnSeasonPass(LocalPlayer_upvr) then
        MAX_DAILY_EXP = LevelConsts_upvr.MAX_DAILY_EXP_SEASON_PASS
    end
    if Players_upvr.LocalPlayer:FindFirstChild(LevelConsts_upvr.DAILY_EXP_VALUE_NAME) then
    end
    if SeasonUtils_upvr.getRemainingTime() < 0 then
    end
    if SeasonConsts_upvr.MAX_REWARD_LEVEL <= var73 then
        var73 = SeasonConsts_upvr.MAX_REWARD_LEVEL
        local const_number = 0
    end
    local gui_2 = module_upvr.gui
    local var77 = var73 + const_number / LevelUtils_upvr.calculateExpNextLevel(var73)
    local any_calculateLevelFromExp_result1, _ = LevelUtils_upvr.calculateLevelFromExp(LevelUtils_upvr.calculateExpOfLevel(var73) + const_number + 0)
    if SeasonConsts_upvr.MAX_REWARD_LEVEL <= any_calculateLevelFromExp_result1 then
        any_calculateLevelFromExp_result1 = SeasonConsts_upvr.MAX_REWARD_LEVEL
    end
    local Progress1 = gui_2.Background.Body.Line.Bg.Progress1
    local Parent_2 = Progress1.Parent
    if Parent_2 == nil then
    else
        local Scale_2 = Parent_2.Size.X.Scale
        Progress1.Size = UDim2.new(UDim.new((var77 - 1) / (Scale_2 * (SeasonConsts_upvr.MAX_REWARD_LEVEL - 1)) + (Scale_2 - 1) * (1 / Scale_2) / 2, Progress1.Size.X.Offset), Progress1.Size.Y)
        Progress1.Visible = true
    end
    setProgressFrameScale_upvr(gui_2.Background.Body.Line.Bg.Progress2, any_calculateLevelFromExp_result1 + 0 / LevelUtils_upvr.calculateExpNextLevel(any_calculateLevelFromExp_result1), var77)
end
return module_upvr