-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local v1 = RunUtils.isStudio()
local t = {
	TAG_NAME = "TransportJet",
	LAUNCHED_AT_ATTR_NAME = "TransportJetLaunchedAt",
	PATH_POINTS_OBJ_NAME = "TransportJetPathPoints",
	REQUEST_LAUNCH_REMOTE_NAME = "TransportJetRequestLaunch",
	DOOR_OPEN_ATTR_NAME = "TransportJetDoorOpen",
	NODE_OFFSET_START_ATTR_NAME = "TransportJetOffsetStart",
	NODE_OFFSET_END_ATTR_NAME = "TransportJetOffsetEnd",
	LAUNCH_COST_CASH = 5000
}
t.RUNWAY_LENGTH = if v1 then 30 else 4000
t.TOP_SPEED = if v1 then 50 else 700
return TableUtils.requireValidIndexAndFreeze(t)
