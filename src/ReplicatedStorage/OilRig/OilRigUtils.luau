-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OilRigConsts = require(ReplicatedStorage.OilRig.OilRigConsts)
require(ReplicatedStorage.Std.Region.RegionUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local t = {}
local function validateObj(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
end
function t.setLastClosedTime(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	p1:SetAttribute(OilRigConsts.LAST_CLOSED_TIME_ATTR_NAME, p2)
	return true
end
function t.getLastClosedTime(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return p1:GetAttribute(OilRigConsts.LAST_CLOSED_TIME_ATTR_NAME)
end
function t.setLastStartedTime(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	p1:SetAttribute(OilRigConsts.LAST_STARTED_TIME_ATTR_NAME, p2)
	return true
end
function t.getLastStartedTime(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return p1:GetAttribute(OilRigConsts.LAST_STARTED_TIME_ATTR_NAME)
end
function t.getProgressionState(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return p1:GetAttribute(OilRigConsts.PROGRESSION_STATE_ATTR_NAME)
end
function t.setProgressionState(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	p1:SetAttribute(OilRigConsts.PROGRESSION_STATE_ATTR_NAME, p2)
	return true
end
function t.getProgressionStateChangedSignal(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return p1:GetAttributeChangedSignal(OilRigConsts.PROGRESSION_STATE_ATTR_NAME)
end
function t.getNPCSpawnLocations(p1, p2, p3)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return TableUtils.filter(p1:FindFirstChild(OilRigConsts.NPC_SPAWNS_FOLDER_NAME):FindFirstChild(p2):GetChildren(), function(p1)
		return p1.Name == p3
	end)
end
function t.getFloor2GuardInRoomSpawnLocations(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return TableUtils.filter(p1:FindFirstChild("NPCSpawns"):FindFirstChild("Floor2"):GetDescendants(), function(p1)
		return p1:IsA("BasePart")
	end)
end
function t.getIsPlayerInRobbery(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	local v3 = p1:FindFirstChild(OilRigConsts.PLAYERS_IN_ROBBERY_FOLDER_NAME):FindFirstChild(p2.UserId)
	return v3 and v3.Value == true
end
function t.getTNTModel(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	local v3 = ReplicatedStorage.OilRig.Res.TNT:Clone()
	CollectionService:AddTag(v3, OilRigConsts.TNT_MODEL_TAG_NAME)
	return v3
end
function t.updateTNTTimers(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	for v3, v4 in TableUtils.filter(CollectionService:GetTagged(OilRigConsts.TNT_MODEL_TAG_NAME), function(p12)
		return p12:IsDescendantOf(p1)
	end) do
		local TextLabel = v4:FindFirstChild("Timer"):FindFirstChild("SurfaceGui"):FindFirstChild("TextLabel")
		TextLabel.TextScaled = true
		TextLabel.Text = p2
	end
end
function t.getExteriorCountdown(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	if p1:FindFirstChild("ExteriorCountdown") and (p1.ExteriorCountdown:FindFirstChild("SurfaceGui") and p1.ExteriorCountdown.SurfaceGui:FindFirstChild("TextLabel")) then
		return p1.ExteriorCountdown.SurfaceGui, p1.ExteriorCountdown.SurfaceGui.TextLabel
	end
end
function t.getActiveRobberyRegionPart(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return p1:FindFirstChild("ActiveRobberyRegion")
end
function t.getTNTPlacementParts(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, OilRigConsts.TAG_NAME), "Obj does not have oil rig robbery tag")
	return p1:FindFirstChild("TNTPlantLocations"):GetChildren()
end
return t
