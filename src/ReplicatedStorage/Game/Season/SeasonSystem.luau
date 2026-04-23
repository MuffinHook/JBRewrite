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
local v1 = nil
local AwardData = require(script.Parent.AwardData)
local SeasonConsts = require(script.Parent.SeasonConsts)
local SeasonUtils = require(script.Parent.SeasonUtils)
local function SelectIfGamepad(p1) --[[ Line: 18 | Upvalues: EzUtils (copy) ]]
	EzUtils.selectIfGamepad(p1)
end
local t = {
	_maid = Maid.new(),
	_mapLevelsAwarded = {},
	onLevelsAwardedChanged = Signal.new()
}
function t.init() --[[ Line: 26 | Upvalues: v1 (ref), ReplicatedStorage (copy), SeasonConsts (copy), t (copy), Players (copy), waitForChild (copy), LocalPlayer (copy), SeasonUtils (copy), RunUtils (copy), Region (copy), RegionUtils (copy), Interval (copy) ]]
	v1 = require(ReplicatedStorage.Game.Level2.LevelUISystem)
	local SeasonUISystem = require(script.Parent.SeasonUISystem)
	local function playerAdded(p1) --[[ Line: 30 | Upvalues: SeasonConsts (ref), t (ref) ]]
		p1:WaitForChild(SeasonConsts.HAS_SEASON_PASS_VALUE_NAME).Changed:Connect(function(p12) --[[ Line: 32 | Upvalues: t (ref), p1 (copy) ]]
			if p12 and t._onSeasonPassOwned then
				t._onSeasonPassOwned:Fire(p1)
			end
		end)
	end
	for i, v in ipairs(Players:GetPlayers()) do
		v:WaitForChild(SeasonConsts.HAS_SEASON_PASS_VALUE_NAME).Changed:Connect(function(p1) --[[ Line: 32 | Upvalues: t (ref), v (copy) ]]
			if p1 and t._onSeasonPassOwned then
				t._onSeasonPassOwned:Fire(v)
			end
		end)
	end
	Players.PlayerAdded:Connect(playerAdded)
	waitForChild(ReplicatedStorage, SeasonConsts.OPENED_SEASON_REMOTE_NAME, 30):andThen(function(p1) --[[ Line: 46 | Upvalues: SeasonUISystem (copy) ]]
		SeasonUISystem._window:GetOnOpenedSignal():Connect(function() --[[ Line: 47 | Upvalues: p1 (copy) ]]
			p1:FireServer()
		end)
	end):catch(warn)
	waitForChild(ReplicatedStorage, SeasonConsts.REDEEM_REMOTE_NAME, 30):andThen(function(p1) --[[ Line: 54 | Upvalues: t (ref) ]]
		t._redeemRemote = p1
		p1.OnClientEvent:Connect(function(p1, p2) --[[ Line: 56 | Upvalues: t (ref) ]]
			t._unrewardedLevels = p1
			t._unrewardedBonus = p2
			t.displayReward()
		end)
	end):catch(warn)
	waitForChild(LocalPlayer, SeasonConsts.LEVELS_AWARDED_VALUE_NAME, 30):andThen(function(p1) --[[ Line: 65 | Upvalues: SeasonUtils (ref), t (ref) ]]
		local function handle() --[[ Line: 66 | Upvalues: SeasonUtils (ref), p1 (copy), t (ref) ]]
			t._mapLevelsAwarded = SeasonUtils.deserializeLevelsAwarded(p1.Value)
			t.onLevelsAwardedChanged:Fire()
		end
		p1.Changed:Connect(handle)
		t._mapLevelsAwarded = SeasonUtils.deserializeLevelsAwarded(p1.Value)
		t.onLevelsAwardedChanged:Fire()
	end):catch(warn)
	if RunUtils.isMainWorld() and not RunUtils.isStudio() then
		waitForChild(workspace, "SeasonPrompts", 30):andThen(function(p1) --[[ Line: 78 | Upvalues: Region (ref), RegionUtils (ref), SeasonUISystem (copy), Interval (ref), Players (ref) ]]
			task.wait(1)
			local v1 = Region.new(RegionUtils.ConditionPlayer)
			for i, v in ipairs(p1:GetChildren()) do
				v1:AddPart(v)
			end
			v1.OnObjAdded:Connect(function() --[[ Line: 84 | Upvalues: SeasonUISystem (ref) ]]
				if not SeasonUISystem._window:IsOpen() then
					SeasonUISystem.open()
				end
			end)
			v1.OnObjRemoved:Connect(function() --[[ Line: 89 | Upvalues: SeasonUISystem (ref) ]]
				if SeasonUISystem._window:IsOpen() then
					SeasonUISystem.close()
				end
			end)
			Interval.every(0.2):Connect(function() --[[ Line: 94 | Upvalues: v1 (copy), Players (ref) ]]
				v1:Update({ Players.LocalPlayer })
			end)
		end):catch(warn)
	end
end
function t.getLevelsAwarded() --[[ Line: 101 | Upvalues: t (copy) ]]
	return t._mapLevelsAwarded
end
function t.getLevelAwarded(p1) --[[ Line: 104 | Upvalues: t (copy) ]]
	return t._mapLevelsAwarded[tostring(p1)]
end
function t.displayReward() --[[ Line: 107 | Upvalues: v1 (ref), t (copy), EzUtils (copy) ]]
	local Redeem = v1.gui.Background.Body.InfoButton.Redeem
	local v12 = false
	local v2
	if #t._unrewardedBonus > 0 then
		v2 = table.remove(t._unrewardedBonus, 1)
		v12 = true
	else
		v2 = table.remove(t._unrewardedLevels, 1)
	end
	if v2 then
		Redeem.Visible = true
		local v3 = v12 and t.getClientBonusAward(v2) or t.getClientLevelAward(v2)
		if not v3.imageId then
			error(("Missing `imageId` for client level award: %d"):format(v2))
		end
		Redeem.Container.Icon.Image = ("rbxassetid://%d"):format(v3.imageId)
		local function redeem() --[[ Line: 132 | Upvalues: t (ref), Redeem (copy), v2 (ref), v12 (ref) ]]
			t._maid.clickRedeem = nil
			Redeem.Visible = false
			t._redeemRemote:FireServer(v2, v12)
			t.displayReward()
		end
		t._maid.clickRedeem = Redeem.MouseButton1Down:Connect(redeem)
		EzUtils.selectIfGamepad(Redeem)
	end
end
function t.getSeasonPassOwnedSignal() --[[ Line: 142 | Upvalues: t (copy), Signal (copy) ]]
	if not t._onSeasonPassOwned then
		t._onSeasonPassOwned = Signal.new()
	end
	return t._onSeasonPassOwned
end
function t.doesPlayerOwnSeasonPass(p1) --[[ Line: 148 | Upvalues: SeasonConsts (copy) ]]
	assert(p1 ~= nil)
	local v2 = p1:FindFirstChild(SeasonConsts.HAS_SEASON_PASS_VALUE_NAME)
	if v2 then
		return v2.Value
	else
		return false
	end
end
function t.getClientLevelAward(p1) --[[ Line: 156 | Upvalues: AwardData (copy) ]]
	assert(p1 ~= nil)
	assert(type(p1) == "number")
	local v3 = AwardData.Level[p1]
	assert(v3, "missing level award")
	return v3
end
function t.getClientBonusAward(p1) --[[ Line: 163 | Upvalues: AwardData (copy) ]]
	assert(p1 ~= nil)
	assert(type(p1) == "number")
	local v3 = AwardData.Bonus[p1]
	assert(v3, "missing bonus award")
	return v3
end
return t