local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardNPCConsts = require(ReplicatedStorage.GuardNPC.GuardNPCConsts)
local NPCConsts = require(ReplicatedStorage.NPC.NPCConsts)
local t = {}
local function validateObj(guardNPC)
	assert(typeof(guardNPC) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(guardNPC, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
end
function t.setBulletSpread(guardNPC, bulletSpread)
	assert(typeof(guardNPC) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(guardNPC, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	guardNPC:SetAttribute(GuardNPCConsts.BULLET_SPREAD_ATTR_NAME, bulletSpread)
	return true
end
function t.getBulletSpread(guardNPC)
	assert(typeof(guardNPC) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(guardNPC, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	return guardNPC:GetAttribute(GuardNPCConsts.BULLET_SPREAD_ATTR_NAME)
end
function t.getTriggerPressFreq(guardNPC)
	return guardNPC:GetAttribute(GuardNPCConsts.TRIGGER_PRESS_FREQ_ATTR_NAME)
end
function t.getTriggerPressFreqChanged(guardNPC)
	return guardNPC:GetAttributeChangedSignal(GuardNPCConsts.TRIGGER_PRESS_FREQ_ATTR_NAME)
end
function t.setTriggerPressFreq(guardNPC, triggerFreq)
	guardNPC:SetAttribute(GuardNPCConsts.TRIGGER_PRESS_FREQ_ATTR_NAME, triggerFreq)
	return true
end
function t.getItemName(guardNPC)
	return guardNPC:GetAttribute(GuardNPCConsts.ITEM_NAME_ATTR_NAME)
end
function t.setItemName(guardNPC, itemName)
	guardNPC:SetAttribute(GuardNPCConsts.ITEM_NAME_ATTR_NAME, itemName)
	return true
end
function t.getItemNameChangedSignal(guardNPC)
	return guardNPC:GetAttributeChangedSignal(GuardNPCConsts.ITEM_NAME_ATTR_NAME)
end
function t.setDefenseTargetType(guardNPC, targetType)
	guardNPC:SetAttribute(GuardNPCConsts.DEFENSE_TARGET_TYPE_ATTR_NAME, targetType)
end
function t.getDefenseTargetType(guardNPC)
	return guardNPC:GetAttribute(GuardNPCConsts.DEFENSE_TARGET_TYPE_ATTR_NAME)
end
function t.setDefenseTarget(guardNPC, targetPart)
	if targetPart:IsA("BasePart") then
		t.setDefenseTargetType(guardNPC, NPCConsts.DEST_TYPE.OBJ)
		local defenseObjectValue = guardNPC:FindFirstChild(GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME)
		if not defenseObjectValue then
			local newObjectValue = Instance.new("ObjectValue")
			newObjectValue.Name = GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME
			newObjectValue.Value = nil
			newObjectValue.Parent = guardNPC
			defenseObjectValue = newObjectValue
		end
		defenseObjectValue.Value = targetPart
	else
		error("Unknown target type")
	end
	return true
end
function t.getDefenseTarget(guardNPC)
	if t.getDefenseTargetType(guardNPC) == NPCConsts.DEST_TYPE.OBJ then
		return guardNPC:FindFirstChild(GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME).Value
	end
end
function t.getDefenseTargetPos(guardNPC)
	if t.getDefenseTargetType(guardNPC) == NPCConsts.DEST_TYPE.OBJ then
		return guardNPC:FindFirstChild(GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME).Value.Position
	end
end
function t.setIsDocile(guardNPC, isDocile)
	assert(typeof(guardNPC) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(guardNPC, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	guardNPC:SetAttribute(GuardNPCConsts.IS_DOCILE_ATTR_NAME, isDocile)
	return true
end
function t.getIsDocile(guardNPC)
	assert(typeof(guardNPC) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(guardNPC, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	return guardNPC:GetAttribute(GuardNPCConsts.IS_DOCILE_ATTR_NAME)
end
function t.setMaxAllowedShootDistanceFromDefenseTarget(guardNPC, maxDistance)
	guardNPC:SetAttribute(GuardNPCConsts.MAX_ALLOWED_SHOOT_DIST_FROM_DEFENSE_TARGET_ATTR_NAME, maxDistance)
	return true
end
function t.getMaxAllowedShootDistanceFromDefenseTarget(guardNPC, maxDistance)
	return guardNPC:GetAttribute(GuardNPCConsts.MAX_ALLOWED_SHOOT_DIST_FROM_DEFENSE_TARGET_ATTR_NAME)
end
function t.setMaxShootDist(guardNPC, maxShootDistance)
	guardNPC:SetAttribute(GuardNPCConsts.MAX_SHOOT_DIST_ATTR_NAME, maxShootDistance)
	return true
end
function t.getMaxShootDist(guardNPC)
	return guardNPC:GetAttribute(GuardNPCConsts.MAX_SHOOT_DIST_ATTR_NAME)
end
function t.setIsTargetingInvolvedPlayer(guardNPC, isTargetingPlayer)
	guardNPC:SetAttribute(GuardNPCConsts.TARGETING_INVOLVED_PLAYER_ATTR_NAME, isTargetingPlayer)
	return true
end
function t.getIsTargetingInvolvedPlayer(guardNPC)
	return guardNPC:GetAttribute(GuardNPCConsts.TARGETING_INVOLVED_PLAYER_ATTR_NAME)
end
function t.clearDamager(guardNPC, damagerID)
	local damagerFolder = guardNPC:FindFirstChild(GuardNPCConsts.DAMAGERS_FOLDER_NAME)
	if damagerFolder then
		local damagerValue = damagerFolder:FindFirstChild((tostring(damagerID)))
		if damagerValue then
			damagerValue:Destroy()
			return true
		else
			return false
		end
	else
		return false
	end
end
function t.addDamager(guardNPC, damagerID, damageAmount)
	local damagerFolder = guardNPC:FindFirstChild(GuardNPCConsts.DAMAGERS_FOLDER_NAME)
	if not damagerFolder then
		local newFolder = Instance.new("Folder")
		newFolder.Name = GuardNPCConsts.DAMAGERS_FOLDER_NAME
		newFolder.Parent = guardNPC
		damagerFolder = newFolder
	end
	local damagerValue = damagerFolder:FindFirstChild((tostring(damagerID)))
	if not damagerValue then
		local newDamagerValue = Instance.new("NumberValue")
		newDamagerValue.Name = damagerID
		newDamagerValue.Parent = damagerFolder
		newDamagerValue.Value = 0
		damagerValue = newDamagerValue
	end
	damagerValue.Value = damagerValue.Value + damageAmount
	return true
end
function t.getDamagers(guardNPC)
	local damagerFolder = guardNPC:FindFirstChild(GuardNPCConsts.DAMAGERS_FOLDER_NAME)
	if damagerFolder then
		local damagers = {}
		for damagerValue, damageEntry in damagerFolder:GetChildren() do
			damagers[tonumber(damageEntry.Name)] = damageEntry.Value
		end
		return damagers
	else
		return nil
	end
end
return t
