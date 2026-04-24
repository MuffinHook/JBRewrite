-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BountyBoardBinder = require(ReplicatedStorage.Bounty.BountyBoardBinder)
local BountyBoardService = require(ReplicatedStorage.Bounty.BountyBoardService)
BountyBoardBinder:Start()
BountyBoardService.init()
