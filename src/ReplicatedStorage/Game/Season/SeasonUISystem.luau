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
local v1 = nil
local v2 = nil
local function SelectIfGamepad(p1) --[[ Line: 28 | Upvalues: EzUtils (copy) ]]
	EzUtils.selectIfGamepad(p1)
end
local t = {}
function t.init() --[[ Line: 33 | Upvalues: v1 (ref), v2 (ref), ReplicatedStorage (copy), LocalPlayer (copy), t (copy), SeasonConsts (copy), Window (copy), GameUtil (copy), waitForChild (copy) ]]
	v1 = require(script.Parent.SeasonSystem)
	v2 = require(ReplicatedStorage.Game.Contract.ContractUISystem)
	local SeasonGui = ReplicatedStorage.StarterGui:FindFirstChild("SeasonGui")
	SeasonGui.Parent = LocalPlayer.PlayerGui
	t.gui = SeasonGui
	t._seasonState = -1
	SeasonGui.Background.Title.Frame.SeasonNumWelcome.Text = ("Welcome to SEASON %d"):format(SeasonConsts.SEASON_NUM)
	SeasonGui.Background.Title.Frame.SeasonNumWelcome.TextLabel.Text = SeasonGui.Background.Title.Frame.SeasonNumWelcome.Text
	SeasonGui.Background.Title.Frame.SeasonTitle.Text = SeasonConsts.SEASON_TITLE
	local v12 = Window.new()
	v12:GetOnOpenedSignal():Connect(t._open)
	v12:GetOnClosedSignal():Connect(t._close)
	t._window = v12
	GameUtil.getCenterWindowGroup():Add(v12)
	waitForChild(ReplicatedStorage, SeasonConsts.PRIZE_PURCHASE_REMOTE_NAME, 30):andThen(function(p1) --[[ Line: 54 | Upvalues: v1 (ref) ]]
		v1._prizePurchaseRemote = p1
	end):catch(warn)
	SeasonGui.Background.BonusAwards.Visible = SeasonConsts.SEASON_BONUS_ENABLED
end
function t._updateSeasonUi(p1) --[[ Line: 61 | Upvalues: t (copy), SeasonConsts (copy) ]]
	t._seasonState = p1
	local gui = t.gui
	if p1 == 0 then
		gui.Background.Timer.Title.Text = "SEASON ENDS"
		gui.Background.Help.Text = SeasonConsts.SEASON_SUBTITLE
		gui.Background.Bottom.Container.ReviewButton.TextLabel.Text = "CONTRACTS"
	elseif p1 == 1 then
		gui.Background.Timer.Title.Text = "BUYING ENDS"
		gui.Background.Help.Text = SeasonConsts.BUY_SUBTITLE
		gui.Background.Bottom.Container.ReviewButton.TextLabel.Text = "COMING SOON"
	elseif p1 == 2 then
		gui.Background.Timer.Title.Text = "SEASON ENDS"
		gui.Background.Help.Text = SeasonConsts.POST_SUBTITLE
		gui.Background.Bottom.Container.ReviewButton.TextLabel.Text = "COMING SOON"
	else
		error(("Invalid season state: %d"):format(p1))
	end
end
function t._updateDeadline() --[[ Line: 80 | Upvalues: t (copy), SeasonUtils (copy), SeasonConsts (copy), ContractUtils (copy), LevelConsts (copy) ]]
	local gui = t.gui
	local v1 = SeasonUtils.getRemainingTime()
	local v3 = SeasonUtils.isBuyEnabled()
	if v3 then
		gui.Background.Timer.Time.Text = SeasonUtils.formatRemaining((SeasonUtils.getRemainingBuyTime()))
	else
		gui.Background.Timer.Time.Text = SeasonUtils.formatRemaining(v1)
	end
	local v7 = if v1 < 0 or v3 then if v3 then 1 else 2 else 0
	if t._seasonState ~= v7 then
		t._updateSeasonUi(v7)
	end
	local Container = gui.Background.Body.Line.Container
	for i = 2, SeasonConsts.MAX_REWARD_LEVEL do
		local Buy = Container:FindFirstChild(("%02d"):format(i)).Reward:FindFirstChild("Buy")
		if Buy then
			Buy.Visible = v3
		end
	end
	local v8 = ContractUtils.getQuantizedBlock(LevelConsts.DAILY_EXP_DURATION, LevelConsts.DAILY_EXP_DURATION_OFFSET)
	gui.Background.DailyExpRefreshHelp.Text = ("Daily XP reloads in <font color=\"rgb(255, 207, 0)\">%s</font>!"):format(SeasonUtils.formatRemaining(v8 - workspace:GetServerTimeNow()))
end
function t._open() --[[ Line: 125 | Upvalues: t (copy), Maid (copy), Utils (copy), Interval (copy), LocalPlayer (copy), LevelSystem (copy), v1 (ref), SeasonUtils (copy), Audio (copy), v2 (ref), EzUtils (copy), SeasonConsts (copy), RunUtils (copy), Notification (copy), Settings (copy), MarketplaceService (copy), SeasonUIUtils (copy) ]]
	assert(t._maid == nil)
	local v12 = Maid.new()
	t._maid = v12
	local gui = t.gui
	if Utils.isSmallScreen() then
		gui.Background.BonusAwards.Position = UDim2.new(-0.15, 0, 0, 2)
	else
		gui.Background.BonusAwards.Position = UDim2.new(1.01, 0, 0, 2)
	end
	gui.Enabled = true
	v12:GiveTask(function() --[[ Line: 140 | Upvalues: gui (copy) ]]
		gui.Enabled = false
	end)
	v12:GiveTask(Interval.every(1):Connect(t._updateDeadline))
	t._updateDeadline()
	t.updateProgress(LocalPlayer)
	v12:GiveTask(LevelSystem.getOnLevelChangedSignal():Connect(t.updateProgress))
	v12:GiveTask(LevelSystem.getOnExpChangedSignal():Connect(t.updateProgress))
	v12:GiveTask(v1.getSeasonPassOwnedSignal():Connect(function(p1) --[[ Line: 150 | Upvalues: LocalPlayer (ref), t (ref) ]]
		if p1 == LocalPlayer then
			t.updateProgress(LocalPlayer)
		end
	end))
	v12:GiveTask(gui.Background.Bottom.Container.ReviewButton.MouseButton1Down:Connect(function() --[[ Line: 157 | Upvalues: SeasonUtils (ref), Audio (ref), LocalPlayer (ref), t (ref), v2 (ref) ]]
		if not (SeasonUtils.getRemainingTime() < 0) then
			Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
			t.close()
			v2.open()
		end
	end))
	EzUtils.selectIfGamepad(gui.Background.Bottom.Container.ReviewButton)
	gui.Background.Bottom.Container.SeasonPass.Title.Text = ("SEASON %d: %s"):format(SeasonConsts.SEASON_NUM, SeasonConsts.SEASON_TITLE)
	v12:GiveTask(gui.Background.Bottom.Container.SeasonPass.MouseButton1Down:Connect(function() --[[ Line: 172 | Upvalues: RunUtils (ref), SeasonUtils (ref), Notification (ref), Audio (ref), LocalPlayer (ref), Settings (ref), v1 (ref), MarketplaceService (ref) ]]
		if RunUtils.isStudio() or not (SeasonUtils.getRemainingTime() <= 0) then
			Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
			local v12 = Settings.getFirstProductByType("SeasonPass")
			assert(v12 ~= nil)
			if not v1.doesPlayerOwnSeasonPass(LocalPlayer) then
				MarketplaceService:PromptProductPurchase(LocalPlayer, v12.Id)
			end
		else
			Notification.new({
				Text = "Season is over! Wait until next season."
			})
		end
	end))
	SeasonUIUtils.hookGiftContainer(gui.Background.GiftContainer, v12)
	local function setOwnsSeasonPass() --[[ Line: 187 | Upvalues: gui (copy) ]]
		gui.Background.Bottom.Container.SeasonPass.Buy.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Price.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Owned.Visible = true
	end
	if v1.doesPlayerOwnSeasonPass(LocalPlayer) then
		gui.Background.Bottom.Container.SeasonPass.Buy.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Price.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Owned.Visible = true
	else
		v12:GiveTask(v1.getSeasonPassOwnedSignal():Connect(function(p1) --[[ Line: 195 | Upvalues: LocalPlayer (ref), gui (copy) ]]
			if p1 == LocalPlayer then
				gui.Background.Bottom.Container.SeasonPass.Buy.Visible = false
				gui.Background.Bottom.Container.SeasonPass.Price.Visible = false
				gui.Background.Bottom.Container.SeasonPass.Owned.Visible = true
			end
		end))
	end
	v12:GiveTask(gui.Background.Close.MouseButton1Down:Connect(t.close))
	local function updatePrice() --[[ Line: 206 | Upvalues: Settings (ref), gui (copy) ]]
		local v1 = Settings.getFirstProductByType("SeasonPass")
		if v1 and v1.Robux then
			gui.Background.Bottom.Container.SeasonPass.Price.Text = tostring(v1.Robux)
		end
	end
	local v22 = Settings.getFirstProductByType("SeasonPass")
	if v22 and v22.Robux then
		gui.Background.Bottom.Container.SeasonPass.Price.Text = tostring(v22.Robux)
	end
	Settings.OnProductsFetched:Connect(updatePrice)
	local Container = gui.Background.Body.Line.Container
	for i = 2, SeasonConsts.MAX_REWARD_LEVEL do
		local v3 = v1.getClientLevelAward(i)
		Container:FindFirstChild(("%02d"):format(i)).Reward.Icon.Image = ("rbxassetid://%d"):format(v3.imageId)
	end
	local Container_2 = gui.Background.BonusAwards.Container
	local v4 = 0
	for j = 1, SeasonConsts.NUM_BONUS_AWARDS do
		local v5 = v1.getClientBonusAward(j)
		local v6 = Container_2:FindFirstChild(("Bonus%02d"):format(j))
		v6.Icon.Image = ("rbxassetid://%d"):format(v5.imageId)
		v6.Desc.Text = ("TOP %d%%"):format(v5.scoreLte * 100)
		v4 = math.max(v4, v5.scoreLte)
	end
	if SeasonConsts.SEASON_BONUS_ENABLED then
		local SeasonBonusScore = LocalPlayer:FindFirstChild("SeasonBonusScore")
		gui.Background.BonusAwards.Score.Text = if SeasonBonusScore then ("YOU: TOP %.2f%%"):format(SeasonBonusScore.Value * 100) else "CHECK LATER..."
		gui.Background.BonusAwards.Desc.Text = ("Players in the top %d%% win this prize when the season ends."):format(v4 * 100)
	end
end
function t._close() --[[ Line: 248 | Upvalues: t (copy) ]]
	assert(t._maid ~= nil)
	local _maid = t._maid
	t._maid = nil
	_maid:Destroy()
end
function t.open() --[[ Line: 254 | Upvalues: t (copy) ]]
	t._window:Open()
end
function t.close() --[[ Line: 257 | Upvalues: t (copy) ]]
	t._window:Close()
end
function t.updateProgress(p1) --[[ Line: 260 | Upvalues: LocalPlayer (copy), LevelUtils (copy), t (copy) ]]
	if p1 == LocalPlayer then
		local v1 = LevelUtils.yieldLevel(p1)
		t.setProgress(v1, (LevelUtils.yieldExp(p1)))
	end
end
local function setProgressFrameScale(p1, p2, p3) --[[ Line: 267 | Upvalues: SeasonConsts (copy) ]]
	local v1 = p1.Parent
	if v1 ~= nil then
		local Scale = v1.Size.X.Scale
		local v2 = (Scale - 1) * (1 / Scale) / 2
		local sum = (p2 - 1) / (Scale * (SeasonConsts.MAX_REWARD_LEVEL - 1)) + v2
		if p3 then
			local v3 = (p3 - 1) / (Scale * (SeasonConsts.MAX_REWARD_LEVEL - 1)) + v2
			p1.Position = UDim2.new(UDim.new(v3, p1.Position.X.Offset), p1.Position.Y)
			sum = sum - v3
		end
		p1.Size = UDim2.new(UDim.new(sum, p1.Size.X.Offset), p1.Size.Y)
		p1.Visible = true
	end
end
function t.setProgress(p1, p2) --[[ Line: 284 | Upvalues: LevelConsts (copy), v1 (ref), LocalPlayer (copy), SeasonUtils (copy), Players (copy), SeasonConsts (copy), t (copy), LevelUtils (copy), setProgressFrameScale (copy) ]]
	local MAX_DAILY_EXP = LevelConsts.MAX_DAILY_EXP
	if v1.doesPlayerOwnSeasonPass(LocalPlayer) then
		MAX_DAILY_EXP = LevelConsts.MAX_DAILY_EXP_SEASON_PASS
	end
	local sum = MAX_DAILY_EXP * SeasonUtils.getSeasonExpMult()
	local v12 = Players.LocalPlayer:FindFirstChild(LevelConsts.DAILY_EXP_VALUE_NAME)
	if v12 then
		sum = sum - v12.Value
	end
	if SeasonUtils.getRemainingTime() < 0 then
		sum = 0
	end
	if SeasonConsts.MAX_REWARD_LEVEL <= p1 then
		p1 = SeasonConsts.MAX_REWARD_LEVEL
		p2 = 0
	end
	local gui = t.gui
	local v2 = p1 + p2 / LevelUtils.calculateExpNextLevel(p1)
	local v3, v4 = LevelUtils.calculateLevelFromExp(LevelUtils.calculateExpOfLevel(p1) + p2 + sum)
	if SeasonConsts.MAX_REWARD_LEVEL <= v3 then
		v3 = SeasonConsts.MAX_REWARD_LEVEL
		v4 = 0
	end
	local v5 = v3 + v4 / LevelUtils.calculateExpNextLevel(v3)
	local Progress1 = gui.Background.Body.Line.Bg.Progress1
	local v6 = Progress1.Parent
	if v6 ~= nil then
		local Scale = v6.Size.X.Scale
		Progress1.Size = UDim2.new(UDim.new((v2 - 1) / (Scale * (SeasonConsts.MAX_REWARD_LEVEL - 1)) + (Scale - 1) * (1 / Scale) / 2, Progress1.Size.X.Offset), Progress1.Size.Y)
		Progress1.Visible = true
	end
	setProgressFrameScale(gui.Background.Body.Line.Bg.Progress2, v5, v2)
end
return t