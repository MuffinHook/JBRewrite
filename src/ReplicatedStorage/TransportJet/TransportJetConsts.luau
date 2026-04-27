local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local isStudio = RunUtils.isStudio()
local constants = {
	TAG_NAME = "TransportJet",
	LAUNCHED_AT_ATTR_NAME = "TransportJetLaunchedAt",
	PATH_POINTS_OBJ_NAME = "TransportJetPathPoints",
	REQUEST_LAUNCH_REMOTE_NAME = "TransportJetRequestLaunch",
	DOOR_OPEN_ATTR_NAME = "TransportJetDoorOpen",
	NODE_OFFSET_START_ATTR_NAME = "TransportJetOffsetStart",
	NODE_OFFSET_END_ATTR_NAME = "TransportJetOffsetEnd",
	LAUNCH_COST_CASH = 5000
}
constants.RUNWAY_LENGTH = if isStudio then 30 else 4000
constants.TOP_SPEED = if isStudio then 50 else 700
return TableUtils.requireValidIndexAndFreeze(constants)
