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
local t = {
	gui = nil,
	hidden = false
}
function t.init() --[[ Line: 18 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), t (copy), LevelSystem (copy), SeasonConsts (copy), SeasonSystem (copy) ]]
	local LevelGui2 = ReplicatedStorage.StarterGui:FindFirstChild("LevelGui2")
	LevelGui2.Parent = LocalPlayer.PlayerGui
	t.gui = LevelGui2
	LevelGui2.Enabled = not t.hidden
	t.updateProgress(LocalPlayer)
	LevelSystem.getOnLevelChangedSignal():Connect(t.updateProgress)
	LevelSystem.getOnExpChangedSignal():Connect(t.updateProgress)
	LevelGui2.Background.Body.SeasonNum.Text = ("SEASON %d"):format(SeasonConsts.SEASON_NUM)
	LevelGui2.Background.Body.InfoButton.MouseButton1Down:Connect(t.toggleInfo)
	LevelGui2.Background.Body.MouseButton1Down:Connect(t.toggleInfo)
	SeasonSystem.getSeasonPassOwnedSignal():Connect(function(p1) --[[ Line: 37 | Upvalues: LocalPlayer (ref), t (ref) ]]
		if p1 == LocalPlayer then
			t.updateProgress(LocalPlayer)
		end
	end)
end
function t.toggleInfo() --[[ Line: 44 | Upvalues: Audio (copy), LocalPlayer (copy), SeasonConsts (copy), SeasonUISystem (copy), ContractUISystem (copy), SeasonUtils (copy) ]]
	Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
	local v1 = LocalPlayer:FindFirstChild(SeasonConsts.HAS_SEEN_REWARDS_VALUE_NAME)
	if SeasonUISystem._window:IsOpen() then
		SeasonUISystem.close()
	elseif ContractUISystem._window:IsOpen() then
		ContractUISystem.close()
	else
		local v2 = ContractUISystem
		if not v1.Value or SeasonUtils.getRemainingTime() <= 0 then
			v2 = SeasonUISystem
		end
		v2.open()
	end
end
function t.updateProgress(p1) --[[ Line: 61 | Upvalues: LocalPlayer (copy), LevelUtils (copy), t (copy) ]]
	if p1 == LocalPlayer then
		local v1 = LevelUtils.getLevel(p1)
		local v2 = LevelUtils.getExp(p1)
		if v1 and v2 then
			t.setProgress(v1, v2)
		end
	end
end
local function tweenFrameFromLastFracToFrac(p1, p2, p3) --[[ Line: 70 ]]
	if p3 then
		p1.Size = UDim2.fromScale(0, 1)
		p1.Position = UDim2.fromScale(0, 0)
	end
	local Scale = p1.Size.X.Scale
	local v2 = (Scale < p2 and p2 - Scale or p2) / 1
	p1:TweenSize(UDim2.new(p2, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, v2, true)
	return v2
end
function t.setProgress(p1, p2) --[[ Line: 82 | Upvalues: LevelUtils (copy), t (copy), LevelConsts (copy), SeasonSystem (copy), LocalPlayer (copy), SeasonUtils (copy), Players (copy) ]]
	local v1 = LevelUtils.calculateExpNextLevel(p1)
	local v2 = p2 / v1
	local gui = t.gui
	local Scale = gui.Background.Body.Progress.Size.X.Scale
	if v2 < Scale then
		gui.Background.Body.Progress.Size = UDim2.fromScale(0, 1)
		gui.Background.Body.ProgressDaily.Size = UDim2.fromScale(0, 1)
		gui.Background.Body.ProgressDaily.Position = UDim2.fromScale(0, 0)
	end
	local v4 = (Scale < v2 and v2 - Scale or v2) / 1
	gui.Background.Body.Progress:TweenSize(UDim2.new(v2, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, v4, true)
	gui.Background.Body.Level.Text = ("LEVEL %d"):format(p1)
	gui.Background.Body.ExpProgress.Text = ("%d/%d"):format(p2, v1)
	local MAX_DAILY_EXP = LevelConsts.MAX_DAILY_EXP
	if SeasonSystem.doesPlayerOwnSeasonPass(LocalPlayer) then
		MAX_DAILY_EXP = LevelConsts.MAX_DAILY_EXP_SEASON_PASS
	end
	local sum = MAX_DAILY_EXP * SeasonUtils.getSeasonExpMult()
	if SeasonUtils.getRemainingTime() < 0 then
		sum = 0
	end
	local v5 = Players.LocalPlayer:FindFirstChild(LevelConsts.DAILY_EXP_VALUE_NAME)
	if v5 then
		sum = sum - v5.Value
	end
	if sum < 0 then
		sum = 0
	end
	gui.Background.Body.Help1.Visible = sum > 0.001
	gui.Background.Body.ProgressDaily:TweenSize(UDim2.new(math.min(1, (p2 + sum) / v1) - v2, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, v4, true)
	gui.Background.Body.ProgressDaily:TweenPosition(UDim2.fromScale(v2, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, v4, true)
end
function t.hideTopbar() --[[ Line: 139 | Upvalues: t (copy) ]]
	t.hidden = true
	if t.gui then
		t.gui.Enabled = not t.hidden
	end
end
function t.showTopbar() --[[ Line: 145 | Upvalues: t (copy) ]]
	t.hidden = false
	if t.gui then
		t.gui.Enabled = not t.hidden
	end
end
return t