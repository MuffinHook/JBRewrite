local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
local ContractBinder = require(script.Parent.ContractBinder)
local ContractConsts = require(script.Parent.ContractConsts)
local ContractSystem = {}
function ContractSystem.init()
	ContractBinder:GetClassAddedSignal():Connect(function(contract)
		if contract:GetPlayer() == Players.LocalPlayer then
			contract._maid:GiveTask(contract:GetOnStateChangedSignal():Connect(function(oldState, newState)
				if (oldState == ContractConsts.enumState.ACTIVE or newState == ContractConsts.enumState.ACTIVE) and ContractSystem._onAnyContractActiveTransition then
					ContractSystem._onAnyContractActiveTransition:Fire(contract)
				end
			end))
		end
	end)
	ContractBinder:GetClassRemovingSignal():Connect(function(contract)
		if contract:GetPlayer() == Players.LocalPlayer and (contract:GetStateId() == ContractConsts.enumState.ACTIVE and ContractSystem._onAnyContractActiveTransition) then
			ContractSystem._onAnyContractActiveTransition:Fire()
		end
	end)
	ContractBinder:Start()
end
function ContractSystem.getPlayerContractDataFolder(contract)
	assert(contract ~= nil)
	return ReplicatedStorage:FindFirstChild(ContractConsts.CONTRACT_DATA_FOLDER_NAME):FindFirstChild(contract.UserId)
end
function ContractSystem.getAnyContractActiveTransitionSignal()
	if not ContractSystem._onAnyContractActiveTransition then
		ContractSystem._onAnyContractActiveTransition = Signal.new()
	end
	return ContractSystem._onAnyContractActiveTransition
end
function ContractSystem.getActiveContract(contract)
	for i, currentContract in ipairs((ContractSystem.getContracts())) do
		if currentContract:GetStateId() == ContractConsts.enumState.ACTIVE and currentContract:GetTeamId() == contract then
			return currentContract
		end
	end
end
function ContractSystem.getContracts()
	return BinderUtils.getChildren(ContractBinder, ContractSystem.getPlayerContractDataFolder(Players.LocalPlayer))
end
return ContractSystem
