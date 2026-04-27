local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeasonUtils = require(ReplicatedStorage.Game.Season.SeasonUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local Data = script.Parent.Data
local ContractConsts = require(script.Parent.ContractConsts)
require(ReplicatedStorage.Game.Season.SeasonConsts)
require(script.Parent.ContractUtils)
local ContractClass = {}
ContractClass.__index = ContractClass
ContractClass.__ClassName = "Contract"
function ContractClass.new(contractInstance)
	local self = {}
	setmetatable(self, ContractClass)
	self._maid = Maid.new()
	self._obj = contractInstance
	self.obj = self._obj
	self._maid:GiveTask(function()
		self._obj = nil
		self.obj = nil
	end)
	self._stateValue = contractInstance:WaitForChild(ContractConsts.STATE_VALUE_NAME, 5)
	local previousStateId = self:GetStateId()
	self._maid:GiveTask(self:GetStateValue():GetPropertyChangedSignal("Value"):Connect(function()
		local stateId = self:GetStateId()
		if self._onStateChanged then
			self._onStateChanged:Fire(stateId, previousStateId)
		end
		previousStateId = stateId
	end))
	self._progressValue = contractInstance:WaitForChild(ContractConsts.PROGRESS_VALUE_NAME, 5)
	self._goalValue = contractInstance:WaitForChild(ContractConsts.GOAL_VALUE_NAME, 5)
	self._lastStateUpdateValue = contractInstance:WaitForChild(ContractConsts.LAST_STATE_UPDATE_VALUE_NAME, 5)
	self._contractActionRemote = contractInstance:WaitForChild(ContractConsts.CONTRACT_ACTION_REMOTE_NAME, 5)
	self._requireSeasonPassValue = contractInstance:WaitForChild(ContractConsts.REQUIRE_SEASON_PASS_VALUE_NAME, 5)
	self._rerolledValue = contractInstance:WaitForChild(ContractConsts.REROLLED_VALUE_NAME, 5)
	local contractName = self:GetName()
	local dataModule = Data:FindFirstChild(contractName)
	if not dataModule then
		error(("Cannot find client data module for contract: %s"):format(contractName))
	end
	local clientData = require(dataModule)
	if not clientData.teamId then
		error("Missing `clientData.teamId` value")
	end
	self:SetTeamId(clientData.teamId)
	if not clientData.rewardExp then
		error("Missing `clientData.rewardExp` value")
	end
	self:SetRewardExp(clientData.rewardExp * SeasonUtils.getSeasonExpMult())
	if not clientData.message then
		error("Missing `clientData.message` value")
	end
	local messageText = nil
	if type(clientData.message) == "string" then
		messageText = clientData.message
	else
		if type(clientData.message) == "function" then
			messageText = clientData.message(self)
		end
	end
	self:SetMessage(messageText)
	return self
end
function ContractClass.GetPlayer(self)
	local player = Players:GetPlayerByUserId(self._obj.Parent.Name)
	if player then
		local isParent = player.Parent == game:GetService("Players")
		assert(isParent)
		return player
	end
end
function ContractClass.GetName(self)
	return self._obj.Name
end
function ContractClass.SetMessage(self, messageText)
	assert(messageText ~= nil)
	assert(type(messageText) == "string")
	self._message = messageText
end
function ContractClass.GetMessage(self)
	return self._message
end
function ContractClass.GetRequireSeasonPassValue(self)
	return self._requireSeasonPassValue
end
function ContractClass.GetRequireSeasonPass(self)
	return self:GetRequireSeasonPassValue().Value
end
function ContractClass.GetStateValue(self)
	return self._stateValue
end
function ContractClass.GetStateId(self)
	return self._stateValue.Value
end
function ContractClass.GetOnStateChangedSignal(self)
	if not self._onStateChanged then
		self._onStateChanged = Signal.new()
		self._maid:GiveTask(self._onStateChanged)
	end
	return self._onStateChanged
end
function ContractClass.GetProgressValue(self)
	return self._progressValue
end
function ContractClass.GetProgress(self)
	return self._progressValue.Value
end
function ContractClass.SetTeamId(self, teamId)
	self._teamId = teamId
end
function ContractClass.GetTeamId(self)
	return self._teamId
end
function ContractClass.SetGoal(self, goalValue)
	assert(goalValue ~= nil)
	assert(type(goalValue) == "number")
	self._goalValue.Value = goalValue
end
function ContractClass.GetGoal(self)
	return self._goalValue.Value
end
function ContractClass.GetRewardExp(self)
	return self._rewardExp
end
function ContractClass.SetRewardExp(self, rewardExp)
	self._rewardExp = rewardExp
end
function ContractClass.GetLastStateUpdate(self)
	return self._lastStateUpdateValue.Value
end
function ContractClass.Destroy(self)
	assert(self._maid ~= nil)
	self._maid:Destroy()
	self._maid = nil
	setmetatable(self, nil)
end
return ContractClass
