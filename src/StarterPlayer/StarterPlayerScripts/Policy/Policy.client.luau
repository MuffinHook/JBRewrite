-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local promisePolicyInfoForPlayer = require(ReplicatedStorage.Policy.promisePolicyInfoForPlayer)
local PolicyService = require(ReplicatedStorage.Policy.PolicyService)
local LocalPlayer = Players.LocalPlayer
promisePolicyInfoForPlayer(LocalPlayer):andThen(function(p1)
	PolicyService.setCachedPlayerPolicyInfo(LocalPlayer, p1)
end)
