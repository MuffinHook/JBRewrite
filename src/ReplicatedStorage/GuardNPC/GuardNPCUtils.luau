-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardNPCConsts = require(ReplicatedStorage.GuardNPC.GuardNPCConsts)
local NPCConsts = require(ReplicatedStorage.NPC.NPCConsts)
local t = {}
local function validateObj(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
end
function t.setBulletSpread(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	p1:SetAttribute(GuardNPCConsts.BULLET_SPREAD_ATTR_NAME, p2)
	return true
end
function t.getBulletSpread(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	return p1:GetAttribute(GuardNPCConsts.BULLET_SPREAD_ATTR_NAME)
end
function t.getTriggerPressFreq(p1)
	return p1:GetAttribute(GuardNPCConsts.TRIGGER_PRESS_FREQ_ATTR_NAME)
end
function t.getTriggerPressFreqChanged(p1)
	return p1:GetAttributeChangedSignal(GuardNPCConsts.TRIGGER_PRESS_FREQ_ATTR_NAME)
end
function t.setTriggerPressFreq(p1, p2)
	p1:SetAttribute(GuardNPCConsts.TRIGGER_PRESS_FREQ_ATTR_NAME, p2)
	return true
end
function t.getItemName(p1)
	return p1:GetAttribute(GuardNPCConsts.ITEM_NAME_ATTR_NAME)
end
function t.setItemName(p1, p2)
	p1:SetAttribute(GuardNPCConsts.ITEM_NAME_ATTR_NAME, p2)
	return true
end
function t.getItemNameChangedSignal(p1)
	return p1:GetAttributeChangedSignal(GuardNPCConsts.ITEM_NAME_ATTR_NAME)
end
function t.setDefenseTargetType(p1, p2)
	p1:SetAttribute(GuardNPCConsts.DEFENSE_TARGET_TYPE_ATTR_NAME, p2)
end
function t.getDefenseTargetType(p1)
	return p1:GetAttribute(GuardNPCConsts.DEFENSE_TARGET_TYPE_ATTR_NAME)
end
function t.setDefenseTarget(p1, p2)
	if p2:IsA("BasePart") then
		t.setDefenseTargetType(p1, NPCConsts.DEST_TYPE.OBJ)
		local v1 = p1:FindFirstChild(GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME)
		if not v1 then
			local instance2 = Instance.new("ObjectValue")
			instance2.Name = GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME
			instance2.Value = nil
			instance2.Parent = p1
			v1 = instance2
		end
		v1.Value = p2
	else
		error("Unknown target type")
	end
	return true
end
function t.getDefenseTarget(p1)
	if t.getDefenseTargetType(p1) == NPCConsts.DEST_TYPE.OBJ then
		return p1:FindFirstChild(GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME).Value
	end
end
function t.getDefenseTargetPos(p1)
	if t.getDefenseTargetType(p1) == NPCConsts.DEST_TYPE.OBJ then
		return p1:FindFirstChild(GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME).Value.Position
	end
end
function t.setIsDocile(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	p1:SetAttribute(GuardNPCConsts.IS_DOCILE_ATTR_NAME, p2)
	return true
end
function t.getIsDocile(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	return p1:GetAttribute(GuardNPCConsts.IS_DOCILE_ATTR_NAME)
end
function t.setMaxAllowedShootDistanceFromDefenseTarget(p1, p2)
	p1:SetAttribute(GuardNPCConsts.MAX_ALLOWED_SHOOT_DIST_FROM_DEFENSE_TARGET_ATTR_NAME, p2)
	return true
end
function t.getMaxAllowedShootDistanceFromDefenseTarget(p1, p2)
	return p1:GetAttribute(GuardNPCConsts.MAX_ALLOWED_SHOOT_DIST_FROM_DEFENSE_TARGET_ATTR_NAME)
end
function t.setMaxShootDist(p1, p2)
	p1:SetAttribute(GuardNPCConsts.MAX_SHOOT_DIST_ATTR_NAME, p2)
	return true
end
function t.getMaxShootDist(p1)
	return p1:GetAttribute(GuardNPCConsts.MAX_SHOOT_DIST_ATTR_NAME)
end
function t.setIsTargetingInvolvedPlayer(p1, p2)
	p1:SetAttribute(GuardNPCConsts.TARGETING_INVOLVED_PLAYER_ATTR_NAME, p2)
	return true
end
function t.getIsTargetingInvolvedPlayer(p1)
	return p1:GetAttribute(GuardNPCConsts.TARGETING_INVOLVED_PLAYER_ATTR_NAME)
end
function t.clearDamager(p1, p2)
	local v1 = p1:FindFirstChild(GuardNPCConsts.DAMAGERS_FOLDER_NAME)
	if v1 then
		local instance2 = v1:FindFirstChild((tostring(p2)))
		if instance2 then
			instance2:Destroy()
			return true
		else
			return false
		end
	else
		return false
	end
end
function t.addDamager(p1, p2, p3)
	local v1 = p1:FindFirstChild(GuardNPCConsts.DAMAGERS_FOLDER_NAME)
	if not v1 then
		local instance2 = Instance.new("Folder")
		instance2.Name = GuardNPCConsts.DAMAGERS_FOLDER_NAME
		instance2.Parent = p1
		v1 = instance2
	end
	local var3 = v1:FindFirstChild((tostring(p2)))
	if not var3 then
		local instance4 = Instance.new("NumberValue")
		instance4.Name = p2
		instance4.Parent = v1
		instance4.Value = 0
		var3 = instance4
	end
	var3.Value = var3.Value + p3
	return true
end
function t.getDamagers(p1)
	local v1 = p1:FindFirstChild(GuardNPCConsts.DAMAGERS_FOLDER_NAME)
	if v1 then
		local t = {}
		for instance2, var3 in v1:GetChildren() do
			t[tonumber(var3.Name)] = var3.Value
		end
		return t
	else
		return nil
	end
end
return t
