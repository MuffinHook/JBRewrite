local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Maid = require(ReplicatedStorage.Std.Maid)
local Notification = require(ReplicatedStorage.Game.Notification)
local Interval = require(ReplicatedStorage.Std.Interval)
local LevelSystem = require(ReplicatedStorage.Game.Level2.LevelSystem)
local LevelUtils = require(ReplicatedStorage.Game.Level2.LevelUtils)
local Window = require(ReplicatedStorage.Module.Window.Window)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local Utils = require(ReplicatedStorage.EzUi.Utils)
local ContractUtils = require(ReplicatedStorage.Game.Contract.ContractUtils)
local LevelConsts = require(ReplicatedStorage.Game.Level2.LevelConsts)
local SeasonUIUtils = require(ReplicatedStorage.Game.Season.SeasonUIUtils)
local SeasonConsts = require(script.Parent.SeasonConsts)
local SeasonUtils = require(script.Parent.SeasonUtils)
local SeasonSystem = nil
local ContractUISystem = nil
local function SelectIfGamepad(buttonElement)
	EzUtils.selectIfGamepad(buttonElement)
end
local t = {}
function t.init()
	SeasonSystem = require(script.Parent.SeasonSystem)
	ContractUISystem = require(ReplicatedStorage.Game.Contract.ContractUISystem)
	local SeasonGui = ReplicatedStorage.StarterGui:FindFirstChild("SeasonGui")
	SeasonGui.Parent = LocalPlayer.PlayerGui
	t.gui = SeasonGui
	t._seasonState = -1
	SeasonGui.Background.Title.Frame.SeasonNumWelcome.Text = ("Welcome to SEASON %d"):format(SeasonConsts.SEASON_NUM)
	SeasonGui.Background.Title.Frame.SeasonNumWelcome.TextLabel.Text = SeasonGui.Background.Title.Frame.SeasonNumWelcome.Text
	SeasonGui.Background.Title.Frame.SeasonTitle.Text = SeasonConsts.SEASON_TITLE
	local seasonWindow = Window.new()
	seasonWindow:GetOnOpenedSignal():Connect(t._open)
	seasonWindow:GetOnClosedSignal():Connect(t._close)
	t._window = seasonWindow
	GameUtil.getCenterWindowGroup():Add(seasonWindow)
	waitForChild(ReplicatedStorage, SeasonConsts.PRIZE_PURCHASE_REMOTE_NAME, 30):andThen(function(remoteFunction)
		SeasonSystem._prizePurchaseRemote = remoteFunction
	end):catch(warn)
	SeasonGui.Background.BonusAwards.Visible = SeasonConsts.SEASON_BONUS_ENABLED
end
function t._updateSeasonUi(seasonState)
	t._seasonState = seasonState
	local gui = t.gui
	if seasonState == 0 then
		gui.Background.Timer.Title.Text = "SEASON ENDS"
		gui.Background.Help.Text = SeasonConsts.SEASON_SUBTITLE
		gui.Background.Bottom.Container.ReviewButton.TextLabel.Text = "CONTRACTS"
	elseif seasonState == 1 then
		gui.Background.Timer.Title.Text = "BUYING ENDS"
		gui.Background.Help.Text = SeasonConsts.BUY_SUBTITLE
		gui.Background.Bottom.Container.ReviewButton.TextLabel.Text = "COMING SOON"
	elseif seasonState == 2 then
		gui.Background.Timer.Title.Text = "SEASON ENDS"
		gui.Background.Help.Text = SeasonConsts.POST_SUBTITLE
		gui.Background.Bottom.Container.ReviewButton.TextLabel.Text = "COMING SOON"
	else
		error(("Invalid season state: %d"):format(seasonState))
	end
end
function t._updateDeadline()
	local gui = t.gui
	local remainingTime = SeasonUtils.getRemainingTime()
	local isBuyEnabled = SeasonUtils.isBuyEnabled()
	if isBuyEnabled then
		gui.Background.Timer.Time.Text = SeasonUtils.formatRemaining((SeasonUtils.getRemainingBuyTime()))
	else
		gui.Background.Timer.Time.Text = SeasonUtils.formatRemaining(remainingTime)
	end
	local calculatedSeasonState = if remainingTime < 0 or isBuyEnabled then if isBuyEnabled then 1 else 2 else 0
	if t._seasonState ~= calculatedSeasonState then
		t._updateSeasonUi(calculatedSeasonState)
	end
	local Container = gui.Background.Body.Line.Container
	for i = 2, SeasonConsts.MAX_REWARD_LEVEL do
		local Buy = Container:FindFirstChild(("%02d"):format(i)).Reward:FindFirstChild("Buy")
		if Buy then
			Buy.Visible = isBuyEnabled
		end
	end
	local dailyExpRefreshTime = ContractUtils.getQuantizedBlock(LevelConsts.DAILY_EXP_DURATION, LevelConsts.DAILY_EXP_DURATION_OFFSET)
	gui.Background.DailyExpRefreshHelp.Text = ("Daily XP reloads in <font color=\"rgb(255, 207, 0)\">%s</font>!"):format(SeasonUtils.formatRemaining(dailyExpRefreshTime - workspace:GetServerTimeNow()))
end
function t._open()
	assert(t._maid == nil)
	local maidInstance = Maid.new()
	t._maid = maidInstance
	local gui = t.gui
	if Utils.isSmallScreen() then
		gui.Background.BonusAwards.Position = UDim2.new(-0.15, 0, 0, 2)
	else
		gui.Background.BonusAwards.Position = UDim2.new(1.01, 0, 0, 2)
	end
	gui.Enabled = true
	maidInstance:GiveTask(function()
		gui.Enabled = false
	end)
	maidInstance:GiveTask(Interval.every(1):Connect(t._updateDeadline))
	t._updateDeadline()
	t.updateProgress(LocalPlayer)
	maidInstance:GiveTask(LevelSystem.getOnLevelChangedSignal():Connect(t.updateProgress))
	maidInstance:GiveTask(LevelSystem.getOnExpChangedSignal():Connect(t.updateProgress))
	maidInstance:GiveTask(SeasonSystem.getSeasonPassOwnedSignal():Connect(function(seasonPassOwner)
		if seasonPassOwner == LocalPlayer then
			t.updateProgress(LocalPlayer)
		end
	end))
	maidInstance:GiveTask(gui.Background.Bottom.Container.ReviewButton.MouseButton1Down:Connect(function()
		if not (SeasonUtils.getRemainingTime() < 0) then
			Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
			t.close()
			ContractUISystem.open()
		end
	end))
	EzUtils.selectIfGamepad(gui.Background.Bottom.Container.ReviewButton)
	gui.Background.Bottom.Container.SeasonPass.Title.Text = ("SEASON %d: %s"):format(SeasonConsts.SEASON_NUM, SeasonConsts.SEASON_TITLE)
	maidInstance:GiveTask(gui.Background.Bottom.Container.SeasonPass.MouseButton1Down:Connect(function()
		if RunUtils.isStudio() or not (SeasonUtils.getRemainingTime() <= 0) then
			Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
			local seasonPassProduct = Settings.getFirstProductByType("SeasonPass")
			assert(seasonPassProduct ~= nil)
			if not SeasonSystem.doesPlayerOwnSeasonPass(LocalPlayer) then
				MarketplaceService:PromptProductPurchase(LocalPlayer, seasonPassProduct.Id)
			end
		else
			Notification.new({
				Text = "Season is over! Wait until next season."
			})
		end
	end))
	SeasonUIUtils.hookGiftContainer(gui.Background.GiftContainer, maidInstance)
	local function setOwnsSeasonPass()
		gui.Background.Bottom.Container.SeasonPass.Buy.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Price.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Owned.Visible = true
	end
	if SeasonSystem.doesPlayerOwnSeasonPass(LocalPlayer) then
		gui.Background.Bottom.Container.SeasonPass.Buy.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Price.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Owned.Visible = true
	else
		maidInstance:GiveTask(SeasonSystem.getSeasonPassOwnedSignal():Connect(function(seasonPassOwner)
			if seasonPassOwner == LocalPlayer then
				gui.Background.Bottom.Container.SeasonPass.Buy.Visible = false
				gui.Background.Bottom.Container.SeasonPass.Price.Visible = false
				gui.Background.Bottom.Container.SeasonPass.Owned.Visible = true
			end
		end))
	end
	maidInstance:GiveTask(gui.Background.Close.MouseButton1Down:Connect(t.close))
	local function updatePrice()
		local seasonPassProduct = Settings.getFirstProductByType("SeasonPass")
		if seasonPassProduct and seasonPassProduct.Robux then
			gui.Background.Bottom.Container.SeasonPass.Price.Text = tostring(seasonPassProduct.Robux)
		end
	end
	local initialSeasonPassProduct = Settings.getFirstProductByType("SeasonPass")
	if initialSeasonPassProduct and initialSeasonPassProduct.Robux then
		gui.Background.Bottom.Container.SeasonPass.Price.Text = tostring(initialSeasonPassProduct.Robux)
	end
	Settings.OnProductsFetched:Connect(updatePrice)
	local Container = gui.Background.Body.Line.Container
	for i = 2, SeasonConsts.MAX_REWARD_LEVEL do
		local levelAward = SeasonSystem.getClientLevelAward(i)
		Container:FindFirstChild(("%02d"):format(i)).Reward.Icon.Image = ("rbxassetid://%d"):format(levelAward.imageId)
	end
	local Container_2 = gui.Background.BonusAwards.Container
	local maxBonusScore = 0
	for j = 1, SeasonConsts.NUM_BONUS_AWARDS do
		local bonusAward = SeasonSystem.getClientBonusAward(j)
		local bonusRewardFrame = Container_2:FindFirstChild(("Bonus%02d"):format(j))
		bonusRewardFrame.Icon.Image = ("rbxassetid://%d"):format(bonusAward.imageId)
		bonusRewardFrame.Desc.Text = ("TOP %d%%"):format(bonusAward.scoreLte * 100)
		maxBonusScore = math.max(maxBonusScore, bonusAward.scoreLte)
	end
	if SeasonConsts.SEASON_BONUS_ENABLED then
		local SeasonBonusScore = LocalPlayer:FindFirstChild("SeasonBonusScore")
		gui.Background.BonusAwards.Score.Text = if SeasonBonusScore then ("YOU: TOP %.2f%%"):format(SeasonBonusScore.Value * 100) else "CHECK LATER..."
		gui.Background.BonusAwards.Desc.Text = ("Players in the top %d%% win this prize when the season ends."):format(maxBonusScore * 100)
	end
end
function t._close()
	assert(t._maid ~= nil)
	local _maid = t._maid
	t._maid = nil
	_maid:Destroy()
end
function t.open()
	t._window:Open()
end
function t.close()
	t._window:Close()
end
function t.updateProgress(player)
	if player == LocalPlayer then
		local playerLevel = LevelUtils.yieldLevel(player)
		t.setProgress(playerLevel, (LevelUtils.yieldExp(player)))
	end
end
local function setProgressFrameScale(frameElement, targetProgress, currentProgress)
	local parentFrame = frameElement.Parent
	if parentFrame ~= nil then
		local Scale = parentFrame.Size.X.Scale
		local centerOffset = (Scale - 1) * (1 / Scale) / 2
		local targetPositionScale = (targetProgress - 1) / (Scale * (SeasonConsts.MAX_REWARD_LEVEL - 1)) + centerOffset
		if currentProgress then
			local currentPositionScale = (currentProgress - 1) / (Scale * (SeasonConsts.MAX_REWARD_LEVEL - 1)) + centerOffset
			frameElement.Position = UDim2.new(UDim.new(currentPositionScale, frameElement.Position.X.Offset), frameElement.Position.Y)
			targetPositionScale = targetPositionScale - currentPositionScale
		end
		frameElement.Size = UDim2.new(UDim.new(targetPositionScale, frameElement.Size.X.Offset), frameElement.Size.Y)
		frameElement.Visible = true
	end
end
function t.setProgress(currentLevel, currentExp)
	local MAX_DAILY_EXP = LevelConsts.MAX_DAILY_EXP
	if SeasonSystem.doesPlayerOwnSeasonPass(LocalPlayer) then
		MAX_DAILY_EXP = LevelConsts.MAX_DAILY_EXP_SEASON_PASS
	end
	local remainingDailyExp = MAX_DAILY_EXP * SeasonUtils.getSeasonExpMult()
	local playerDailyExp = Players.LocalPlayer:FindFirstChild(LevelConsts.DAILY_EXP_VALUE_NAME)
	if playerDailyExp then
		remainingDailyExp = remainingDailyExp - playerDailyExp.Value
	end
	if SeasonUtils.getRemainingTime() < 0 then
		remainingDailyExp = 0
	end
	if SeasonConsts.MAX_REWARD_LEVEL <= currentLevel then
		currentLevel = SeasonConsts.MAX_REWARD_LEVEL
		currentExp = 0
	end
	local gui = t.gui
	local currentProgress = currentLevel + currentExp / LevelUtils.calculateExpNextLevel(currentLevel)
	local nextLevel, nextExp = LevelUtils.calculateLevelFromExp(LevelUtils.calculateExpOfLevel(currentLevel) + currentExp + remainingDailyExp)
	if SeasonConsts.MAX_REWARD_LEVEL <= nextLevel then
		nextLevel = SeasonConsts.MAX_REWARD_LEVEL
		nextExp = 0
	end
	local projectedProgress = nextLevel + nextExp / LevelUtils.calculateExpNextLevel(nextLevel)
	local Progress1 = gui.Background.Body.Line.Bg.Progress1
	local progressParent = Progress1.Parent
	if progressParent ~= nil then
		local Scale = progressParent.Size.X.Scale
		Progress1.Size = UDim2.new(UDim.new((currentProgress - 1) / (Scale * (SeasonConsts.MAX_REWARD_LEVEL - 1)) + (Scale - 1) * (1 / Scale) / 2, Progress1.Size.X.Offset), Progress1.Size.Y)
		Progress1.Visible = true
	end
	setProgressFrameScale(gui.Background.Body.Line.Bg.Progress2, projectedProgress, currentProgress)
end
return t
