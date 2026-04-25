-- Reviewed by Claude
-- variables reassigned
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
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._obj = p1
	t2.obj = t2._obj
	t2._maid:GiveTask(function()
		t2._obj = nil
		t2.obj = nil
	end)
	t2._stateValue = p1:WaitForChild(ContractConsts.STATE_VALUE_NAME, 5)
	local previousStateId = t2:GetStateId()
	t2._maid:GiveTask(t2:GetStateValue():GetPropertyChangedSignal("Value"):Connect(function()
		local stateId = t2:GetStateId()
		if t2._onStateChanged then
			t2._onStateChanged:Fire(stateId, previousStateId)
		end
		previousStateId = stateId
	end))
	t2._progressValue = p1:WaitForChild(ContractConsts.PROGRESS_VALUE_NAME, 5)
	t2._goalValue = p1:WaitForChild(ContractConsts.GOAL_VALUE_NAME, 5)
	t2._lastStateUpdateValue = p1:WaitForChild(ContractConsts.LAST_STATE_UPDATE_VALUE_NAME, 5)
	t2._contractActionRemote = p1:WaitForChild(ContractConsts.CONTRACT_ACTION_REMOTE_NAME, 5)
	t2._requireSeasonPassValue = p1:WaitForChild(ContractConsts.REQUIRE_SEASON_PASS_VALUE_NAME, 5)
	t2._rerolledValue = p1:WaitForChild(ContractConsts.REROLLED_VALUE_NAME, 5)
	local contractName = t2:GetName()
	local dataModule = Data:FindFirstChild(contractName)
	if not dataModule then
		error(("Cannot find client data module for contract: %s"):format(contractName))
	end
	local clientData = require(dataModule)
	if not clientData.teamId then
		error("Missing `clientData.teamId` value")
	end
	t2:SetTeamId(clientData.teamId)
	if not clientData.rewardExp then
		error("Missing `clientData.rewardExp` value")
	end
	t2:SetRewardExp(clientData.rewardExp * SeasonUtils.getSeasonExpMult())
	if not clientData.message then
		error("Missing `clientData.message` value")
	end
	local messageText = nil
	if type(clientData.message) == "string" then
		messageText = clientData.message
	else
		if type(clientData.message) == "function" then
			messageText = clientData.message(t2)
		end
	end
	t2:SetMessage(messageText)
	return t2
end
function t.GetPlayer(p1)
	local player = Players:GetPlayerByUserId(p1._obj.Parent.Name)
	if player then
		local isParent = player.Parent == game:GetService("Players")
		assert(isParent)
		return player
	end
end
function t.GetName(p1)
	return p1._obj.Name
end
function t.SetMessage(p1, p2)
	assert(p2 ~= nil)
	assert(type(p2) == "string")
	p1._message = p2
end
function t.GetMessage(p1)
	return p1._message
end
function t.GetRequireSeasonPassValue(p1)
	return p1._requireSeasonPassValue
end
function t.GetRequireSeasonPass(p1)
	return p1:GetRequireSeasonPassValue().Value
end
function t.GetStateValue(p1)
	return p1._stateValue
end
function t.GetStateId(p1)
	return p1._stateValue.Value
end
function t.GetOnStateChangedSignal(p1)
	if not p1._onStateChanged then
		p1._onStateChanged = Signal.new()
		p1._maid:GiveTask(p1._onStateChanged)
	end
	return p1._onStateChanged
end
function t.GetProgressValue(p1)
	return p1._progressValue
end
function t.GetProgress(p1)
	return p1._progressValue.Value
end
function t.SetTeamId(p1, p2)
	p1._teamId = p2
end
function t.GetTeamId(p1)
	return p1._teamId
end
function t.SetGoal(p1, p2)
	assert(p2 ~= nil)
	assert(type(p2) == "number")
	p1._goalValue.Value = p2
end
function t.GetGoal(p1)
	return p1._goalValue.Value
end
function t.GetRewardExp(p1)
	return p1._rewardExp
end
function t.SetRewardExp(p1, p2)
	p1._rewardExp = p2
end
function t.GetLastStateUpdate(p1)
	return p1._lastStateUpdateValue.Value
end
function t.Destroy(p1)
	assert(p1._maid ~= nil)
	p1._maid:Destroy()
	p1._maid = nil
	setmetatable(p1, nil)
end
return t
