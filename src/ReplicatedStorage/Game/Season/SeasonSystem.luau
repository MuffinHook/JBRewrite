local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local Region = require(ReplicatedStorage.Std.Region)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local levelUISystem = nil
local AwardData = require(script.Parent.AwardData)
local SeasonConsts = require(script.Parent.SeasonConsts)
local SeasonUtils = require(script.Parent.SeasonUtils)
local function SelectIfGamepad(guiElement)
	EzUtils.selectIfGamepad(guiElement)
end
local t = {
	_maid = Maid.new(),
	_mapLevelsAwarded = {},
	onLevelsAwardedChanged = Signal.new()
}
function t.init()
	levelUISystem = require(ReplicatedStorage.Game.Level2.LevelUISystem)
	local SeasonUISystem = require(script.Parent.SeasonUISystem)
	local function playerAdded(player)
		player:WaitForChild(SeasonConsts.HAS_SEASON_PASS_VALUE_NAME).Changed:Connect(function(newValue)
			if newValue and t._onSeasonPassOwned then
				t._onSeasonPassOwned:Fire(player)
			end
		end)
	end
	for i, player in ipairs(Players:GetPlayers()) do
		player:WaitForChild(SeasonConsts.HAS_SEASON_PASS_VALUE_NAME).Changed:Connect(function(newValue)
			if newValue and t._onSeasonPassOwned then
				t._onSeasonPassOwned:Fire(player)
			end
		end)
	end
	Players.PlayerAdded:Connect(playerAdded)
	waitForChild(ReplicatedStorage, SeasonConsts.OPENED_SEASON_REMOTE_NAME, 30):andThen(function(openedSeasonRemote)
		SeasonUISystem._window:GetOnOpenedSignal():Connect(function()
			openedSeasonRemote:FireServer()
		end)
	end):catch(warn)
	waitForChild(ReplicatedStorage, SeasonConsts.REDEEM_REMOTE_NAME, 30):andThen(function(redeemRemote)
		t._redeemRemote = redeemRemote
		redeemRemote.OnClientEvent:Connect(function(unrewardedLevels, unrewardedBonus)
			t._unrewardedLevels = unrewardedLevels
			t._unrewardedBonus = unrewardedBonus
			t.displayReward()
		end)
	end):catch(warn)
	waitForChild(LocalPlayer, SeasonConsts.LEVELS_AWARDED_VALUE_NAME, 30):andThen(function(levelsAwardedValue)
		local function handle()
			t._mapLevelsAwarded = SeasonUtils.deserializeLevelsAwarded(levelsAwardedValue.Value)
			t.onLevelsAwardedChanged:Fire()
		end
		levelsAwardedValue.Changed:Connect(handle)
		t._mapLevelsAwarded = SeasonUtils.deserializeLevelsAwarded(levelsAwardedValue.Value)
		t.onLevelsAwardedChanged:Fire()
	end):catch(warn)
	if RunUtils.isMainWorld() and not RunUtils.isStudio() then
		waitForChild(workspace, "SeasonPrompts", 30):andThen(function(seasonPromptsFolder)
			task.wait(1)
			local seasonPromptRegion = Region.new(RegionUtils.ConditionPlayer)
			for i, prompt in ipairs(seasonPromptsFolder:GetChildren()) do
				seasonPromptRegion:AddPart(prompt)
			end
			seasonPromptRegion.OnObjAdded:Connect(function()
				if not SeasonUISystem._window:IsOpen() then
					SeasonUISystem.open()
				end
			end)
			seasonPromptRegion.OnObjRemoved:Connect(function()
				if SeasonUISystem._window:IsOpen() then
					SeasonUISystem.close()
				end
			end)
			Interval.every(0.2):Connect(function()
				seasonPromptRegion:Update({ Players.LocalPlayer })
			end)
		end):catch(warn)
	end
end
function t.getLevelsAwarded()
	return t._mapLevelsAwarded
end
function t.getLevelAwarded(levelId)
	return t._mapLevelsAwarded[tostring(levelId)]
end
function t.displayReward()
	local Redeem = levelUISystem.gui.Background.Body.InfoButton.Redeem
	local isBonusAward = false
	local awardId
	if #t._unrewardedBonus > 0 then
		awardId = table.remove(t._unrewardedBonus, 1)
		isBonusAward = true
	else
		awardId = table.remove(t._unrewardedLevels, 1)
	end
	if awardId then
		Redeem.Visible = true
		local awardData = isBonusAward and t.getClientBonusAward(awardId) or t.getClientLevelAward(awardId)
		if not awardData.imageId then
			error(("Missing `imageId` for client level award: %d"):format(awardId))
		end
		Redeem.Container.Icon.Image = ("rbxassetid://%d"):format(awardData.imageId)
		local function redeem()
			t._maid.clickRedeem = nil
			Redeem.Visible = false
			t._redeemRemote:FireServer(awardId, isBonusAward)
			t.displayReward()
		end
		t._maid.clickRedeem = Redeem.MouseButton1Down:Connect(redeem)
		EzUtils.selectIfGamepad(Redeem)
	end
end
function t.getSeasonPassOwnedSignal()
	if not t._onSeasonPassOwned then
		t._onSeasonPassOwned = Signal.new()
	end
	return t._onSeasonPassOwned
end
function t.doesPlayerOwnSeasonPass(player)
	assert(player ~= nil)
	local hasSeasonPassValue = player:FindFirstChild(SeasonConsts.HAS_SEASON_PASS_VALUE_NAME)
	if hasSeasonPassValue then
		return hasSeasonPassValue.Value
	else
		return false
	end
end
function t.getClientLevelAward(awardId)
	assert(awardId ~= nil)
	assert(type(awardId) == "number")
	local levelAwardData = AwardData.Level[awardId]
	assert(levelAwardData, "missing level award")
	return levelAwardData
end
function t.getClientBonusAward(awardId)
	assert(awardId ~= nil)
	assert(type(awardId) == "number")
	local bonusAwardData = AwardData.Bonus[awardId]
	assert(bonusAwardData, "missing bonus award")
	return bonusAwardData
end
return t
