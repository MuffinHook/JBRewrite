local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local ContractBinder_upvr = require(script.Parent.ContractBinder)
local ContractConsts_upvr = require(script.Parent.ContractConsts)
local module_upvr = {}
function module_upvr.init() -- Line 10
    ContractBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 15
        if arg1:GetPlayer() == Players_upvr.LocalPlayer then
            arg1._maid:GiveTask(arg1:GetOnStateChangedSignal():Connect(function(arg1_2, arg2) -- Line 17
                if arg1_2 == ContractConsts_upvr.enumState.ACTIVE or arg2 == ContractConsts_upvr.enumState.ACTIVE then
                    if module_upvr._onAnyContractActiveTransition then
                        module_upvr._onAnyContractActiveTransition:Fire(arg1)
                    end
                end
            end))
        end
    end)
    ContractBinder_upvr:GetClassRemovingSignal():Connect(function(arg1) -- Line 27
        if arg1:GetPlayer() == Players_upvr.LocalPlayer and arg1:GetStateId() == ContractConsts_upvr.enumState.ACTIVE and module_upvr._onAnyContractActiveTransition then
            module_upvr._onAnyContractActiveTransition:Fire()
        end
    end)
    ContractBinder_upvr:Start()
end
function module_upvr.getPlayerContractDataFolder(arg1) -- Line 38
    if arg1 == nil then
    else
    end
    assert(true)
    return ReplicatedStorage_upvr:FindFirstChild(ContractConsts_upvr.CONTRACT_DATA_FOLDER_NAME):FindFirstChild(arg1.UserId)
end
local Signal_upvr = require(ReplicatedStorage_upvr.Std.Signal)
function module_upvr.getAnyContractActiveTransitionSignal() -- Line 44
    if not module_upvr._onAnyContractActiveTransition then
        module_upvr._onAnyContractActiveTransition = Signal_upvr.new()
    end
    return module_upvr._onAnyContractActiveTransition
end
function module_upvr.getActiveContract(arg1) -- Line 50
    for _, v in ipairs(module_upvr.getContracts()) do
        if v:GetStateId() == ContractConsts_upvr.enumState.ACTIVE and v:GetTeamId() == arg1 then
            return v
        end
    end
end
local BinderUtils_upvr = require(ReplicatedStorage_upvr.Std.Binder.BinderUtils)
function module_upvr.getContracts() -- Line 59
    return BinderUtils_upvr.getChildren(ContractBinder_upvr, module_upvr.getPlayerContractDataFolder(Players_upvr.LocalPlayer))
end
return module_upvr