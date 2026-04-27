local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local SeasonConsts = require(ReplicatedStorage.Game.Season.SeasonConsts)
local SeasonUISystem = require(ReplicatedStorage.Game.Season.SeasonUISystem)
local SeasonUtils = require(ReplicatedStorage.Game.Season.SeasonUtils)
local ContractUISystem = require(ReplicatedStorage.Game.Contract.ContractUISystem)
local SeasonSystem = require(ReplicatedStorage.Game.Season.SeasonSystem)
local LevelSystem = require(script.Parent.LevelSystem)
local LevelConsts = require(script.Parent.LevelConsts)
local LevelUtils = require(script.Parent.LevelUtils)
local LevelUIModule = {
	gui = nil,
	hidden = false
}
function LevelUIModule.init()
	local LevelGui2 = ReplicatedStorage.StarterGui:FindFirstChild("LevelGui2")
	LevelGui2.Parent = LocalPlayer.PlayerGui
	LevelUIModule.gui = LevelGui2
	LevelGui2.Enabled = not LevelUIModule.hidden
	LevelUIModule.updateProgress(LocalPlayer)
	LevelSystem.getOnLevelChangedSignal():Connect(LevelUIModule.updateProgress)
	LevelSystem.getOnExpChangedSignal():Connect(LevelUIModule.updateProgress)
	LevelGui2.Background.Body.SeasonNum.Text = ("SEASON %d"):format(SeasonConsts.SEASON_NUM)
	LevelGui2.Background.Body.InfoButton.MouseButton1Down:Connect(LevelUIModule.toggleInfo)
	LevelGui2.Background.Body.MouseButton1Down:Connect(LevelUIModule.toggleInfo)
	SeasonSystem.getSeasonPassOwnedSignal():Connect(function(player)
		if player == LocalPlayer then
			LevelUIModule.updateProgress(LocalPlayer)
		end
	end)
end
function LevelUIModule.toggleInfo()
	Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
	local hasSeenRewardsValue = LocalPlayer:FindFirstChild(SeasonConsts.HAS_SEEN_REWARDS_VALUE_NAME)
	if SeasonUISystem._window:IsOpen() then
		SeasonUISystem.close()
	elseif ContractUISystem._window:IsOpen() then
		ContractUISystem.close()
	else
		local selectedUISystem = ContractUISystem
		if not hasSeenRewardsValue.Value or SeasonUtils.getRemainingTime() <= 0 then
			selectedUISystem = SeasonUISystem
		end
		selectedUISystem.open()
	end
end
function LevelUIModule.updateProgress(player)
	if player == LocalPlayer then
		local playerLevel = LevelUtils.getLevel(player)
		local playerExp = LevelUtils.getExp(player)
		if playerLevel and playerExp then
			LevelUIModule.setProgress(playerLevel, playerExp)
		end
	end
end
local function tweenFrameFromLastFracToFrac(frame, targetFraction, shouldReset)
	if shouldReset then
		frame.Size = UDim2.fromScale(0, 1)
		frame.Position = UDim2.fromScale(0, 0)
	end
	local Scale = frame.Size.X.Scale
	local tweenDuration = (Scale < targetFraction and targetFraction - Scale or targetFraction) / 1
	frame:TweenSize(UDim2.new(targetFraction, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, tweenDuration, true)
	return tweenDuration
end
function LevelUIModule.setProgress(level, currentExp)
	local expForNextLevel = LevelUtils.calculateExpNextLevel(level)
	local progressFraction = currentExp / expForNextLevel
	local gui = LevelUIModule.gui
	local Scale = gui.Background.Body.Progress.Size.X.Scale
	if progressFraction < Scale then
		gui.Background.Body.Progress.Size = UDim2.fromScale(0, 1)
		gui.Background.Body.ProgressDaily.Size = UDim2.fromScale(0, 1)
		gui.Background.Body.ProgressDaily.Position = UDim2.fromScale(0, 0)
	end
	local tweenDuration = (Scale < progressFraction and progressFraction - Scale or progressFraction) / 1
	gui.Background.Body.Progress:TweenSize(UDim2.new(progressFraction, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, tweenDuration, true)
	gui.Background.Body.Level.Text = ("LEVEL %d"):format(level)
	gui.Background.Body.ExpProgress.Text = ("%d/%d"):format(currentExp, expForNextLevel)
	local MAX_DAILY_EXP = LevelConsts.MAX_DAILY_EXP
	if SeasonSystem.doesPlayerOwnSeasonPass(LocalPlayer) then
		MAX_DAILY_EXP = LevelConsts.MAX_DAILY_EXP_SEASON_PASS
	end
	local sum = MAX_DAILY_EXP * SeasonUtils.getSeasonExpMult()
	if SeasonUtils.getRemainingTime() < 0 then
		sum = 0
	end
	local dailyExpValue = Players.LocalPlayer:FindFirstChild(LevelConsts.DAILY_EXP_VALUE_NAME)
	if dailyExpValue then
		sum = sum - dailyExpValue.Value
	end
	if sum < 0 then
		sum = 0
	end
	gui.Background.Body.Help1.Visible = sum > 0.001
	gui.Background.Body.ProgressDaily:TweenSize(UDim2.new(math.min(1, (currentExp + sum) / expForNextLevel) - progressFraction, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, tweenDuration, true)
	gui.Background.Body.ProgressDaily:TweenPosition(UDim2.fromScale(progressFraction, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, tweenDuration, true)
end
function LevelUIModule.hideTopbar()
	LevelUIModule.hidden = true
	if LevelUIModule.gui then
		LevelUIModule.gui.Enabled = not LevelUIModule.hidden
	end
end
function LevelUIModule.showTopbar()
	LevelUIModule.hidden = false
	if LevelUIModule.gui then
		LevelUIModule.gui.Enabled = not LevelUIModule.hidden
	end
end
return LevelUIModule
