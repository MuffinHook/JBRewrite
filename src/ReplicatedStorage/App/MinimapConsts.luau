-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunConsts = require(ReplicatedStorage.App.RunConsts)
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	ADD_WAYPOINT_REMOTE_NAME = "MinimapAddWaypoint",
	REMOVE_WAYPOINT_REMOTE_NAME = "MinimapRemoveWaypoint",
	MAP_IMAGE_ID = {
		[RunConsts.MAIN_WORLD_NAME] = 96502373705107,
		[RunConsts.TRADE_WORLD_NAME] = 108297224039760
	},
	MAP_WORLD_WIDTH = {
		[RunConsts.MAIN_WORLD_NAME] = 9984,
		[RunConsts.TRADE_WORLD_NAME] = 2816
	},
	MAP_WORLD_HEIGHT = {
		[RunConsts.MAIN_WORLD_NAME] = 9984,
		[RunConsts.TRADE_WORLD_NAME] = 2816
	},
	MAP_WORLD_CENTER_X = {
		[RunConsts.MAIN_WORLD_NAME] = 169,
		[RunConsts.TRADE_WORLD_NAME] = -1000
	},
	MAP_WORLD_CENTER_Y = {
		[RunConsts.MAIN_WORLD_NAME] = -1550,
		[RunConsts.TRADE_WORLD_NAME] = -500
	}
})