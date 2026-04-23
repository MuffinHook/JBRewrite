local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeasonUtils = require(ReplicatedStorage.Game.Season.SeasonUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Data = script.Parent.Data
local ContractConsts = require(script.Parent.ContractConsts)
require(ReplicatedStorage.Game.Season.SeasonConsts)
require(script.Parent.ContractUtils)
local t = {}
t.__index = t
t.__ClassName = "Contract"
function t.new(p1) --[[ Line: 15 | Upvalues: t (copy), Maid (copy), ContractConsts (copy), Data (copy), SeasonUtils (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._obj = p1
	t2.obj = t2._obj
	t2._maid:GiveTask(function() --[[ Line: 22 | Upvalues: t2 (copy) ]]
		t2._obj = nil
		t2.obj = nil
	end)
	t2._stateValue = p1:WaitForChild(ContractConsts.STATE_VALUE_NAME, 5)
	local v2 = t2:GetStateId()
	t2._maid:GiveTask(t2:GetStateValue():GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 30 | Upvalues: t2 (copy), v2 (ref) ]]
		local v1 = t2:GetStateId()
		if t2._onStateChanged then
			t2._onStateChanged:Fire(v1, v2)
		end
		v2 = v1
	end))
	t2._progressValue = p1:WaitForChild(ContractConsts.PROGRESS_VALUE_NAME, 5)
	t2._goalValue = p1:WaitForChild(ContractConsts.GOAL_VALUE_NAME, 5)
	t2._lastStateUpdateValue = p1:WaitForChild(ContractConsts.LAST_STATE_UPDATE_VALUE_NAME, 5)
	t2._contractActionRemote = p1:WaitForChild(ContractConsts.CONTRACT_ACTION_REMOTE_NAME, 5)
	t2._requireSeasonPassValue = p1:WaitForChild(ContractConsts.REQUIRE_SEASON_PASS_VALUE_NAME, 5)
	t2._rerolledValue = p1:WaitForChild(ContractConsts.REROLLED_VALUE_NAME, 5)
	local v3 = t2:GetName()
	local v4 = Data:FindFirstChild(v3)
	if not v4 then
		error(("Cannot find client data module for contract: %s"):format(v3))
	end
	local v5 = require(v4)
	if not v5.teamId then
		error("Missing `clientData.teamId` value")
	end
	t2:SetTeamId(v5.teamId)
	if not v5.rewardExp then
		error("Missing `clientData.rewardExp` value")
	end
	t2:SetRewardExp(v5.rewardExp * SeasonUtils.getSeasonExpMult())
	if not v5.message then
		error("Missing `clientData.message` value")
	end
	local v7 = nil
	if type(v5.message) == "string" then
		v7 = v5.message
	else
		if type(v5.message) == "function" then
			v7 = v5.message(t2)
		end
	end
	t2:SetMessage(v7)
	return t2
end
function t.GetPlayer(p1) --[[ Line: 86 | Upvalues: Players (copy) ]]
	local v1 = Players:GetPlayerByUserId(p1._obj.Parent.Name)
	if v1 then
		local isParent = v1.Parent == game:GetService("Players")
		assert(isParent)
		return v1
	end
end
function t.GetName(p1) --[[ Line: 95 ]]
	return p1._obj.Name
end
function t.SetMessage(p1, p2) --[[ Line: 98 ]]
	assert(p2 ~= nil)
	assert(type(p2) == "string")
	p1._message = p2
end
function t.GetMessage(p1) --[[ Line: 104 ]]
	return p1._message
end
function t.GetRequireSeasonPassValue(p1) --[[ Line: 107 ]]
	return p1._requireSeasonPassValue
end
function t.GetRequireSeasonPass(p1) --[[ Line: 110 ]]
	return p1:GetRequireSeasonPassValue().Value
end
function t.GetStateValue(p1) --[[ Line: 113 ]]
	return p1._stateValue
end
function t.GetStateId(p1) --[[ Line: 116 ]]
	return p1._stateValue.Value
end
function t.GetOnStateChangedSignal(p1) --[[ Line: 119 | Upvalues: Signal (copy) ]]
	if not p1._onStateChanged then
		p1._onStateChanged = Signal.new()
		p1._maid:GiveTask(p1._onStateChanged)
	end
	return p1._onStateChanged
end
function t.GetProgressValue(p1) --[[ Line: 126 ]]
	return p1._progressValue
end
function t.GetProgress(p1) --[[ Line: 129 ]]
	return p1._progressValue.Value
end
function t.SetTeamId(p1, p2) --[[ Line: 132 ]]
	p1._teamId = p2
end
function t.GetTeamId(p1) --[[ Line: 135 ]]
	return p1._teamId
end
function t.SetGoal(p1, p2) --[[ Line: 138 ]]
	assert(p2 ~= nil)
	assert(type(p2) == "number")
	p1._goalValue.Value = p2
end
function t.GetGoal(p1) --[[ Line: 143 ]]
	return p1._goalValue.Value
end
function t.GetRewardExp(p1) --[[ Line: 146 ]]
	return p1._rewardExp
end
function t.SetRewardExp(p1, p2) --[[ Line: 149 ]]
	p1._rewardExp = p2
end
function t.GetLastStateUpdate(p1) --[[ Line: 152 ]]
	return p1._lastStateUpdateValue.Value
end
function t.Destroy(p1) --[[ Line: 155 ]]
	assert(p1._maid ~= nil)
	p1._maid:Destroy()
	p1._maid = nil
	setmetatable(p1, nil)
end
return t