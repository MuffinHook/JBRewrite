-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
local ContractBinder = require(script.Parent.ContractBinder)
local ContractConsts = require(script.Parent.ContractConsts)
local t = {}
function t.init()
	ContractBinder:GetClassAddedSignal():Connect(function(contract)
		if contract:GetPlayer() == Players.LocalPlayer then
			contract._maid:GiveTask(contract:GetOnStateChangedSignal():Connect(function(oldState, newState)
				if (oldState == ContractConsts.enumState.ACTIVE or newState == ContractConsts.enumState.ACTIVE) and t._onAnyContractActiveTransition then
					t._onAnyContractActiveTransition:Fire(contract)
				end
			end))
		end
	end)
	ContractBinder:GetClassRemovingSignal():Connect(function(contract)
		if contract:GetPlayer() == Players.LocalPlayer and (contract:GetStateId() == ContractConsts.enumState.ACTIVE and t._onAnyContractActiveTransition) then
			t._onAnyContractActiveTransition:Fire()
		end
	end)
	ContractBinder:Start()
end
function t.getPlayerContractDataFolder(contract)
	assert(contract ~= nil)
	return ReplicatedStorage:FindFirstChild(ContractConsts.CONTRACT_DATA_FOLDER_NAME):FindFirstChild(contract.UserId)
end
function t.getAnyContractActiveTransitionSignal()
	if not t._onAnyContractActiveTransition then
		t._onAnyContractActiveTransition = Signal.new()
	end
	return t._onAnyContractActiveTransition
end
function t.getActiveContract(contract)
	for i, v in ipairs((t.getContracts())) do
		if v:GetStateId() == ContractConsts.enumState.ACTIVE and v:GetTeamId() == contract then
			return v
		end
	end
end
function t.getContracts()
	return BinderUtils.getChildren(ContractBinder, t.getPlayerContractDataFolder(Players.LocalPlayer))
end
return t
