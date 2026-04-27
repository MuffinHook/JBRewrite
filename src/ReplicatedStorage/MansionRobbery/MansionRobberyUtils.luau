local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MansionRobberyConsts = require(ReplicatedStorage.MansionRobbery.MansionRobberyConsts)
local CollectionService = game:GetService("CollectionService")
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Players = game:GetService("Players")
local t = {}
local function validateObj(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
end
function t.setNumPlayersInElevator(mansionInstance, playerCount)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	mansionInstance:SetAttribute(MansionRobberyConsts.NUM_PLAYERS_IN_ELEVATOR_ATTR_NAME, playerCount)
	return true
end
function t.getNumPlayersInElevator(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return mansionInstance:GetAttribute(MansionRobberyConsts.NUM_PLAYERS_IN_ELEVATOR_ATTR_NAME)
end
function t.getNumPlayersInElevatorChangedSignal(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return mansionInstance:GetAttributeChangedSignal(MansionRobberyConsts.NUM_PLAYERS_IN_ELEVATOR_ATTR_NAME)
end
function t.getIsElevatorMoving(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return t.getEntranceElevatorModel(mansionInstance):GetAttribute(MansionRobberyConsts.IS_ELEVATOR_MOVING_ATTR_NAME)
end
function t.getIsElevatorMovingChangedSignal(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return t.getEntranceElevatorModel(mansionInstance):GetAttributeChangedSignal(MansionRobberyConsts.IS_ELEVATOR_MOVING_ATTR_NAME)
end
function t.setIsElevatorMoving(mansionInstance, isMoving)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	t.getEntranceElevatorModel(mansionInstance):SetAttribute(MansionRobberyConsts.IS_ELEVATOR_MOVING_ATTR_NAME, isMoving)
end
function t.getEntranceElevatorModel(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return mansionInstance:FindFirstChild("Lobby"):FindFirstChild(MansionRobberyConsts.ENTRANCE_ELEVATOR_NAME)
end
function t.getEntranceElevatorFloorCFrame(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return t.getEntranceElevatorModel(mansionInstance):FindFirstChild("Floor", true).CFrame
end
function t.getArrivalElevatorModel(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return mansionInstance:FindFirstChild(MansionRobberyConsts.ARRIVAL_ELEVATOR_NAME)
end
function t.getArrivalElevatorFloorCFrame(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return t.getArrivalElevatorModel(mansionInstance):FindFirstChild("Floor", true).CFrame
end
function t.isPlayerInElevator(mansionInstance, player)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	if player then
		local Character = player.Character
		if Character then
			local rootPart = CharacterUtils.getRootPart(Character)
			return RegionUtils.isPointInPart(t.getEntranceElevatorModel(mansionInstance).PrimaryPart, rootPart.Position)
		else
			return false
		end
	else
		warn("Invalid player passed")
		return false
	end
end
function t.getShieldsFolder(mansionInstance)
	return mansionInstance:FindFirstChild(MansionRobberyConsts.SHIELD_MODELS_FOLDER_NAME)
end
function t.getShields(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	local shieldsFolder = t.getShieldsFolder(mansionInstance)
	if shieldsFolder then
		return shieldsFolder:GetChildren()
	else
		warn("No shield models folder")
		return {}
	end
end
function t.getProgressionState(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return mansionInstance:GetAttribute(MansionRobberyConsts.PROGRESSION_STATE_ATTR_NAME)
end
function t.setProgressionState(mansionInstance, progressionState)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	mansionInstance:SetAttribute(MansionRobberyConsts.PROGRESSION_STATE_ATTR_NAME, progressionState)
	return true
end
function t.getProgressionStateChangedSignal(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return mansionInstance:GetAttributeChangedSignal(MansionRobberyConsts.PROGRESSION_STATE_ATTR_NAME)
end
function t.getExitTeleportationPoints(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return mansionInstance:FindFirstChild("Lobby"):FindFirstChild(MansionRobberyConsts.EXIT_TELEPORTS_FOLDER_NAME):GetChildren()
end
function t.getRandomExitTeleportationCFrame(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	local exitTeleports = t.getExitTeleportationPoints(mansionInstance)
	return exitTeleports[math.random(#exitTeleports)].CFrame * CFrame.new(0, 5, 0)
end
function t.getIsPlayerInRobbery(mansionInstance, player)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	local inRobberyFolder = mansionInstance:FindFirstChild(MansionRobberyConsts.IN_ROBBERY_FOLDER_NAME):FindFirstChild(player.UserId)
	return inRobberyFolder and inRobberyFolder.Value == true
end
function t.setLastClosedTime(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	mansionInstance:SetAttribute(MansionRobberyConsts.LAST_CLOSED_TIME_ATTR_NAME, workspace:GetServerTimeNow())
	return true
end
function t.getLastClosedTime(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return mansionInstance:GetAttribute(MansionRobberyConsts.LAST_CLOSED_TIME_ATTR_NAME)
end
function t.getBossRoomPlayerSpawns(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return mansionInstance:FindFirstChild(MansionRobberyConsts.BOSS_ROOM_PLAYER_SPAWNS_FOLDER_NAME):GetChildren()
end
function t.getRandomBossRoomPlayerSpawn(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	local bossRoomSpawns = t.getBossRoomPlayerSpawns(mansionInstance)
	return bossRoomSpawns[math.random(#bossRoomSpawns)]
end
function t.getPlayersInRobbery(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return TableUtils.filter(Players:GetPlayers(), function(filteredPlayer)
		return t.getIsPlayerInRobbery(mansionInstance, filteredPlayer)
	end)
end
function t.setShieldLastDownTime(shield, lastDownTime)
	shield:SetAttribute(MansionRobberyConsts.SHIELD_LAST_DOWN_TIME_ATTR_NAME, lastDownTime)
	return true
end
function t.getShieldLastDownTime(shield)
	return shield:GetAttribute(MansionRobberyConsts.SHIELD_LAST_DOWN_TIME_ATTR_NAME) or 0
end
function t.getFinalExitDoor(mansionInstance)
	assert(typeof(mansionInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(mansionInstance, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return mansionInstance:FindFirstChild("ExitDoor")
end
return t
