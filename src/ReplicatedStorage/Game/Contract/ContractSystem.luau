local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
local ContractBinder = require(script.Parent.ContractBinder)
local ContractConsts = require(script.Parent.ContractConsts)
local t = {}
function t.init() --[[ Line: 10 | Upvalues: ContractBinder (copy), Players (copy), ContractConsts (copy), t (copy) ]]
	ContractBinder:GetClassAddedSignal():Connect(function(p1) --[[ Line: 15 | Upvalues: Players (ref), ContractConsts (ref), t (ref) ]]
		if p1:GetPlayer() == Players.LocalPlayer then
			p1._maid:GiveTask(p1:GetOnStateChangedSignal():Connect(function(p12, p2) --[[ Line: 17 | Upvalues: ContractConsts (ref), t (ref), p1 (copy) ]]
				if (p12 == ContractConsts.enumState.ACTIVE or p2 == ContractConsts.enumState.ACTIVE) and t._onAnyContractActiveTransition then
					t._onAnyContractActiveTransition:Fire(p1)
				end
			end))
		end
	end)
	ContractBinder:GetClassRemovingSignal():Connect(function(p1) --[[ Line: 27 | Upvalues: Players (ref), ContractConsts (ref), t (ref) ]]
		if p1:GetPlayer() == Players.LocalPlayer and (p1:GetStateId() == ContractConsts.enumState.ACTIVE and t._onAnyContractActiveTransition) then
			t._onAnyContractActiveTransition:Fire()
		end
	end)
	ContractBinder:Start()
end
function t.getPlayerContractDataFolder(p1) --[[ Line: 38 | Upvalues: ReplicatedStorage (copy), ContractConsts (copy) ]]
	assert(p1 ~= nil)
	return ReplicatedStorage:FindFirstChild(ContractConsts.CONTRACT_DATA_FOLDER_NAME):FindFirstChild(p1.UserId)
end
function t.getAnyContractActiveTransitionSignal() --[[ Line: 44 | Upvalues: t (copy), Signal (copy) ]]
	if not t._onAnyContractActiveTransition then
		t._onAnyContractActiveTransition = Signal.new()
	end
	return t._onAnyContractActiveTransition
end
function t.getActiveContract(p1) --[[ Line: 50 | Upvalues: t (copy), ContractConsts (copy) ]]
	for i, v in ipairs((t.getContracts())) do
		if v:GetStateId() == ContractConsts.enumState.ACTIVE and v:GetTeamId() == p1 then
			return v
		end
	end
end
function t.getContracts() --[[ Line: 59 | Upvalues: BinderUtils (copy), ContractBinder (copy), t (copy), Players (copy) ]]
	return BinderUtils.getChildren(ContractBinder, t.getPlayerContractDataFolder(Players.LocalPlayer))
end
return t