local CollectionService = game:GetService("CollectionService")
game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OilRigConsts = require(ReplicatedStorage.OilRig.OilRigConsts)
require(ReplicatedStorage.Std.Region.RegionUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local OilRigUtils = {}
local function validateObj(oilRig)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
end
function OilRigUtils.setLastClosedTime(oilRig, closedTime)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	oilRig:SetAttribute(OilRigConsts.LAST_CLOSED_TIME_ATTR_NAME, closedTime)
	return true
end
function OilRigUtils.getLastClosedTime(oilRig)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return oilRig:GetAttribute(OilRigConsts.LAST_CLOSED_TIME_ATTR_NAME)
end
function OilRigUtils.setLastStartedTime(oilRig, startedTime)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	oilRig:SetAttribute(OilRigConsts.LAST_STARTED_TIME_ATTR_NAME, startedTime)
	return true
end
function OilRigUtils.getLastStartedTime(oilRig)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return oilRig:GetAttribute(OilRigConsts.LAST_STARTED_TIME_ATTR_NAME)
end
function OilRigUtils.getProgressionState(oilRig)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return oilRig:GetAttribute(OilRigConsts.PROGRESSION_STATE_ATTR_NAME)
end
function OilRigUtils.setProgressionState(oilRig, progressionState)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	oilRig:SetAttribute(OilRigConsts.PROGRESSION_STATE_ATTR_NAME, progressionState)
	return true
end
function OilRigUtils.getProgressionStateChangedSignal(oilRig)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return oilRig:GetAttributeChangedSignal(OilRigConsts.PROGRESSION_STATE_ATTR_NAME)
end
function OilRigUtils.getNPCSpawnLocations(oilRig, npcType, locationName)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return TableUtils.filter(oilRig:FindFirstChild(OilRigConsts.NPC_SPAWNS_FOLDER_NAME):FindFirstChild(npcType):GetChildren(), function(spawnLocation)
		return spawnLocation.Name == locationName
	end)
end
function OilRigUtils.getFloor2GuardInRoomSpawnLocations(oilRig)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return TableUtils.filter(oilRig:FindFirstChild("NPCSpawns"):FindFirstChild("Floor2"):GetDescendants(), function(descendant)
		return descendant:IsA("BasePart")
	end)
end
function OilRigUtils.getIsPlayerInRobbery(oilRig, player)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	local playerFolder = oilRig:FindFirstChild(OilRigConsts.PLAYERS_IN_ROBBERY_FOLDER_NAME):FindFirstChild(player.UserId)
	return playerFolder and playerFolder.Value == true
end
function OilRigUtils.getTNTModel(oilRig)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	local tntModel = ReplicatedStorage.OilRig.Res.TNT:Clone()
	CollectionService:AddTag(tntModel, OilRigConsts.TNT_MODEL_TAG_NAME)
	return tntModel
end
function OilRigUtils.updateTNTTimers(oilRig, timerText)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	for var3, tntModel in TableUtils.filter(CollectionService:GetTagged(OilRigConsts.TNT_MODEL_TAG_NAME), function(tntInstance)
		return tntInstance:IsDescendantOf(oilRig)
	end) do
		local TextLabel = tntModel:FindFirstChild("Timer"):FindFirstChild("SurfaceGui"):FindFirstChild("TextLabel")
		TextLabel.TextScaled = true
		TextLabel.Text = timerText
	end
end
function OilRigUtils.getExteriorCountdown(oilRig)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	if oilRig:FindFirstChild("ExteriorCountdown") and (oilRig.ExteriorCountdown:FindFirstChild("SurfaceGui") and oilRig.ExteriorCountdown.SurfaceGui:FindFirstChild("TextLabel")) then
		return oilRig.ExteriorCountdown.SurfaceGui, oilRig.ExteriorCountdown.SurfaceGui.TextLabel
	end
end
function OilRigUtils.getActiveRobberyRegionPart(oilRig)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return oilRig:FindFirstChild("ActiveRobberyRegion")
end
function OilRigUtils.getTNTPlacementParts(oilRig)
	assert(typeof(oilRig) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(oilRig, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return oilRig:FindFirstChild("TNTPlantLocations"):GetChildren()
end
return OilRigUtils
