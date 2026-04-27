local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
require(ReplicatedStorage.Std.TableUtils)
local BountyConsts = require(ReplicatedStorage.Bounty.BountyConsts)
local BountyBoardService = require(ReplicatedStorage.Bounty.BountyBoardService)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(boardModel)
	local instance = BaseObject.new(boardModel)
	setmetatable(instance, t)
	local Board = boardModel:WaitForChild("Board")
	local clonedMostWantedModel = ReplicatedStorage.Bounty.Res.MostWanted:Clone()
	instance.maid:GiveTask(clonedMostWantedModel)
	clonedMostWantedModel.Parent = Board
	clonedMostWantedModel.Board:AddTag(BountyConsts.BOARD_LIST_TAG_NAME)
	BountyBoardService.updateGui(clonedMostWantedModel.Board, (BountyBoardService.getTopBounties(4)))
	return instance
end
return Binder.new(BountyConsts.BOARD_TAG_NAME, t)