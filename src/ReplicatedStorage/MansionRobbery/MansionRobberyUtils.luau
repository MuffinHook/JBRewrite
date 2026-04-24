-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MansionRobberyConsts = require(ReplicatedStorage.MansionRobbery.MansionRobberyConsts)
local CollectionService = game:GetService("CollectionService")
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Players = game:GetService("Players")
local t = {}
local function validateObj(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
end
function t.setNumPlayersInElevator(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	p1:SetAttribute(MansionRobberyConsts.NUM_PLAYERS_IN_ELEVATOR_ATTR_NAME, p2)
	return true
end
function t.getNumPlayersInElevator(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return p1:GetAttribute(MansionRobberyConsts.NUM_PLAYERS_IN_ELEVATOR_ATTR_NAME)
end
function t.getNumPlayersInElevatorChangedSignal(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return p1:GetAttributeChangedSignal(MansionRobberyConsts.NUM_PLAYERS_IN_ELEVATOR_ATTR_NAME)
end
function t.getIsElevatorMoving(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return t.getEntranceElevatorModel(p1):GetAttribute(MansionRobberyConsts.IS_ELEVATOR_MOVING_ATTR_NAME)
end
function t.getIsElevatorMovingChangedSignal(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return t.getEntranceElevatorModel(p1):GetAttributeChangedSignal(MansionRobberyConsts.IS_ELEVATOR_MOVING_ATTR_NAME)
end
function t.setIsElevatorMoving(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	t.getEntranceElevatorModel(p1):SetAttribute(MansionRobberyConsts.IS_ELEVATOR_MOVING_ATTR_NAME, p2)
end
function t.getEntranceElevatorModel(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return p1:FindFirstChild("Lobby"):FindFirstChild(MansionRobberyConsts.ENTRANCE_ELEVATOR_NAME)
end
function t.getEntranceElevatorFloorCFrame(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return t.getEntranceElevatorModel(p1):FindFirstChild("Floor", true).CFrame
end
function t.getArrivalElevatorModel(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return p1:FindFirstChild(MansionRobberyConsts.ARRIVAL_ELEVATOR_NAME)
end
function t.getArrivalElevatorFloorCFrame(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return t.getArrivalElevatorModel(p1):FindFirstChild("Floor", true).CFrame
end
function t.isPlayerInElevator(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	if p2 then
		local Character = p2.Character
		if Character then
			local var3 = CharacterUtils.getRootPart(Character)
			return RegionUtils.isPointInPart(t.getEntranceElevatorModel(p1).PrimaryPart, var3.Position)
		else
			return false
		end
	else
		warn("Invalid player passed")
		return false
	end
end
function t.getShieldsFolder(p1)
	return p1:FindFirstChild(MansionRobberyConsts.SHIELD_MODELS_FOLDER_NAME)
end
function t.getShields(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	local var3 = t.getShieldsFolder(p1)
	if var3 then
		return var3:GetChildren()
	else
		warn("No shield models folder")
		return {}
	end
end
function t.getProgressionState(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return p1:GetAttribute(MansionRobberyConsts.PROGRESSION_STATE_ATTR_NAME)
end
function t.setProgressionState(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	p1:SetAttribute(MansionRobberyConsts.PROGRESSION_STATE_ATTR_NAME, p2)
	return true
end
function t.getProgressionStateChangedSignal(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return p1:GetAttributeChangedSignal(MansionRobberyConsts.PROGRESSION_STATE_ATTR_NAME)
end
function t.getExitTeleportationPoints(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return p1:FindFirstChild("Lobby"):FindFirstChild(MansionRobberyConsts.EXIT_TELEPORTS_FOLDER_NAME):GetChildren()
end
function t.getRandomExitTeleportationCFrame(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	local var3 = t.getExitTeleportationPoints(p1)
	return var3[math.random(#var3)].CFrame * CFrame.new(0, 5, 0)
end
function t.getIsPlayerInRobbery(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	local var3 = p1:FindFirstChild(MansionRobberyConsts.IN_ROBBERY_FOLDER_NAME):FindFirstChild(p2.UserId)
	return var3 and var3.Value == true
end
function t.setLastClosedTime(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	p1:SetAttribute(MansionRobberyConsts.LAST_CLOSED_TIME_ATTR_NAME, workspace:GetServerTimeNow())
	return true
end
function t.getLastClosedTime(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return p1:GetAttribute(MansionRobberyConsts.LAST_CLOSED_TIME_ATTR_NAME)
end
function t.getBossRoomPlayerSpawns(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return p1:FindFirstChild(MansionRobberyConsts.BOSS_ROOM_PLAYER_SPAWNS_FOLDER_NAME):GetChildren()
end
function t.getRandomBossRoomPlayerSpawn(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	local var3 = t.getBossRoomPlayerSpawns(p1)
	return var3[math.random(#var3)]
end
function t.getPlayersInRobbery(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return TableUtils.filter(Players:GetPlayers(), function(p12)
		return t.getIsPlayerInRobbery(p1, p12)
	end)
end
function t.setShieldLastDownTime(p1, p2)
	p1:SetAttribute(MansionRobberyConsts.SHIELD_LAST_DOWN_TIME_ATTR_NAME, p2)
	return true
end
function t.getShieldLastDownTime(p1)
	return p1:GetAttribute(MansionRobberyConsts.SHIELD_LAST_DOWN_TIME_ATTR_NAME) or 0
end
function t.getFinalExitDoor(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, MansionRobberyConsts.TAG_NAME), "Obj does not have mansion robbery tag")
	return p1:FindFirstChild("ExitDoor")
end
return t
