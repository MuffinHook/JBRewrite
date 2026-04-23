local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local promisePolicyInfoForPlayer = require(ReplicatedStorage.Policy.promisePolicyInfoForPlayer)
local PolicyService = require(ReplicatedStorage.Policy.PolicyService)
local LocalPlayer = Players.LocalPlayer
promisePolicyInfoForPlayer(LocalPlayer):andThen(function(p1) --[[ Line: 8 | Upvalues: PolicyService (copy), LocalPlayer (copy) ]]
	PolicyService.setCachedPlayerPolicyInfo(LocalPlayer, p1)
end)