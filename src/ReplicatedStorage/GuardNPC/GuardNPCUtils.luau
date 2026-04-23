local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardNPCConsts = require(ReplicatedStorage.GuardNPC.GuardNPCConsts)
local NPCConsts = require(ReplicatedStorage.NPC.NPCConsts)
local t = {}
local function validateObj(p1) --[[ Line: 7 | Upvalues: CollectionService (copy), GuardNPCConsts (copy) ]]
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
end
function t.setBulletSpread(p1, p2) --[[ Line: 12 | Upvalues: CollectionService (copy), GuardNPCConsts (copy) ]]
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	p1:SetAttribute(GuardNPCConsts.BULLET_SPREAD_ATTR_NAME, p2)
	return true
end
function t.getBulletSpread(p1) --[[ Line: 17 | Upvalues: CollectionService (copy), GuardNPCConsts (copy) ]]
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	return p1:GetAttribute(GuardNPCConsts.BULLET_SPREAD_ATTR_NAME)
end
function t.getTriggerPressFreq(p1) --[[ Line: 21 | Upvalues: GuardNPCConsts (copy) ]]
	return p1:GetAttribute(GuardNPCConsts.TRIGGER_PRESS_FREQ_ATTR_NAME)
end
function t.getTriggerPressFreqChanged(p1) --[[ Line: 24 | Upvalues: GuardNPCConsts (copy) ]]
	return p1:GetAttributeChangedSignal(GuardNPCConsts.TRIGGER_PRESS_FREQ_ATTR_NAME)
end
function t.setTriggerPressFreq(p1, p2) --[[ Line: 27 | Upvalues: GuardNPCConsts (copy) ]]
	p1:SetAttribute(GuardNPCConsts.TRIGGER_PRESS_FREQ_ATTR_NAME, p2)
	return true
end
function t.getItemName(p1) --[[ Line: 31 | Upvalues: GuardNPCConsts (copy) ]]
	return p1:GetAttribute(GuardNPCConsts.ITEM_NAME_ATTR_NAME)
end
function t.setItemName(p1, p2) --[[ Line: 34 | Upvalues: GuardNPCConsts (copy) ]]
	p1:SetAttribute(GuardNPCConsts.ITEM_NAME_ATTR_NAME, p2)
	return true
end
function t.getItemNameChangedSignal(p1) --[[ Line: 38 | Upvalues: GuardNPCConsts (copy) ]]
	return p1:GetAttributeChangedSignal(GuardNPCConsts.ITEM_NAME_ATTR_NAME)
end
function t.setDefenseTargetType(p1, p2) --[[ Line: 41 | Upvalues: GuardNPCConsts (copy) ]]
	p1:SetAttribute(GuardNPCConsts.DEFENSE_TARGET_TYPE_ATTR_NAME, p2)
end
function t.getDefenseTargetType(p1) --[[ Line: 44 | Upvalues: GuardNPCConsts (copy) ]]
	return p1:GetAttribute(GuardNPCConsts.DEFENSE_TARGET_TYPE_ATTR_NAME)
end
function t.setDefenseTarget(p1, p2) --[[ Line: 47 | Upvalues: t (copy), NPCConsts (copy), GuardNPCConsts (copy) ]]
	if p2:IsA("BasePart") then
		t.setDefenseTargetType(p1, NPCConsts.DEST_TYPE.OBJ)
		local v1 = p1:FindFirstChild(GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME)
		if not v1 then
			local v2 = Instance.new("ObjectValue")
			v2.Name = GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME
			v2.Value = nil
			v2.Parent = p1
			v1 = v2
		end
		v1.Value = p2
	else
		error("Unknown target type")
	end
	return true
end
function t.getDefenseTarget(p1) --[[ Line: 63 | Upvalues: t (copy), NPCConsts (copy), GuardNPCConsts (copy) ]]
	if t.getDefenseTargetType(p1) == NPCConsts.DEST_TYPE.OBJ then
		return p1:FindFirstChild(GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME).Value
	end
end
function t.getDefenseTargetPos(p1) --[[ Line: 69 | Upvalues: t (copy), NPCConsts (copy), GuardNPCConsts (copy) ]]
	if t.getDefenseTargetType(p1) == NPCConsts.DEST_TYPE.OBJ then
		return p1:FindFirstChild(GuardNPCConsts.DEFENSE_OBJ_VALUE_NAME).Value.Position
	end
end
function t.setIsDocile(p1, p2) --[[ Line: 75 | Upvalues: CollectionService (copy), GuardNPCConsts (copy) ]]
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	p1:SetAttribute(GuardNPCConsts.IS_DOCILE_ATTR_NAME, p2)
	return true
end
function t.getIsDocile(p1) --[[ Line: 80 | Upvalues: CollectionService (copy), GuardNPCConsts (copy) ]]
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, GuardNPCConsts.TAG_NAME), "Obj does not have guard npc tag")
	return p1:GetAttribute(GuardNPCConsts.IS_DOCILE_ATTR_NAME)
end
function t.setMaxAllowedShootDistanceFromDefenseTarget(p1, p2) --[[ Line: 84 | Upvalues: GuardNPCConsts (copy) ]]
	p1:SetAttribute(GuardNPCConsts.MAX_ALLOWED_SHOOT_DIST_FROM_DEFENSE_TARGET_ATTR_NAME, p2)
	return true
end
function t.getMaxAllowedShootDistanceFromDefenseTarget(p1, p2) --[[ Line: 88 | Upvalues: GuardNPCConsts (copy) ]]
	return p1:GetAttribute(GuardNPCConsts.MAX_ALLOWED_SHOOT_DIST_FROM_DEFENSE_TARGET_ATTR_NAME)
end
function t.setMaxShootDist(p1, p2) --[[ Line: 91 | Upvalues: GuardNPCConsts (copy) ]]
	p1:SetAttribute(GuardNPCConsts.MAX_SHOOT_DIST_ATTR_NAME, p2)
	return true
end
function t.getMaxShootDist(p1) --[[ Line: 95 | Upvalues: GuardNPCConsts (copy) ]]
	return p1:GetAttribute(GuardNPCConsts.MAX_SHOOT_DIST_ATTR_NAME)
end
function t.setIsTargetingInvolvedPlayer(p1, p2) --[[ Line: 98 | Upvalues: GuardNPCConsts (copy) ]]
	p1:SetAttribute(GuardNPCConsts.TARGETING_INVOLVED_PLAYER_ATTR_NAME, p2)
	return true
end
function t.getIsTargetingInvolvedPlayer(p1) --[[ Line: 102 | Upvalues: GuardNPCConsts (copy) ]]
	return p1:GetAttribute(GuardNPCConsts.TARGETING_INVOLVED_PLAYER_ATTR_NAME)
end
function t.clearDamager(p1, p2) --[[ Line: 105 | Upvalues: GuardNPCConsts (copy) ]]
	local v1 = p1:FindFirstChild(GuardNPCConsts.DAMAGERS_FOLDER_NAME)
	if v1 then
		local v2 = v1:FindFirstChild((tostring(p2)))
		if v2 then
			v2:Destroy()
			return true
		else
			return false
		end
	else
		return false
	end
end
function t.addDamager(p1, p2, p3) --[[ Line: 116 | Upvalues: GuardNPCConsts (copy) ]]
	local v1 = p1:FindFirstChild(GuardNPCConsts.DAMAGERS_FOLDER_NAME)
	if not v1 then
		local v2 = Instance.new("Folder")
		v2.Name = GuardNPCConsts.DAMAGERS_FOLDER_NAME
		v2.Parent = p1
		v1 = v2
	end
	local v3 = v1:FindFirstChild((tostring(p2)))
	if not v3 then
		local v4 = Instance.new("NumberValue")
		v4.Name = p2
		v4.Parent = v1
		v4.Value = 0
		v3 = v4
	end
	v3.Value = v3.Value + p3
	return true
end
function t.getDamagers(p1) --[[ Line: 133 | Upvalues: GuardNPCConsts (copy) ]]
	local v1 = p1:FindFirstChild(GuardNPCConsts.DAMAGERS_FOLDER_NAME)
	if v1 then
		local t = {}
		for v2, v3 in v1:GetChildren() do
			t[tonumber(v3.Name)] = v3.Value
		end
		return t
	else
		return nil
	end
end
return t