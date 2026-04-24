-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local BossNPCConsts = require(ReplicatedStorage.MansionRobbery.BossNPCConsts)
local t = {}
local function validateObj(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, BossNPCConsts.TAG_NAME), "Obj does not have tag")
end
function t.setMovementState(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	p1:SetAttribute(BossNPCConsts.MOVEMENT_STATE_ATTR_NAME, p2)
	return true
end
function t.getMovementState(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	return p1:GetAttribute(BossNPCConsts.MOVEMENT_STATE_ATTR_NAME)
end
function t.getMovementStateChangedSignal(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	return p1:GetAttributeChangedSignal(BossNPCConsts.MOVEMENT_STATE_ATTR_NAME)
end
function t.setAttackState(p1, p2)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	p1:SetAttribute(BossNPCConsts.ATTACK_STATE_ATTR_NAME, p2)
end
function t.getAttackState(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	return p1:GetAttribute(BossNPCConsts.ATTACK_STATE_ATTR_NAME)
end
function t.getAttackStateChangedSignal(p1)
	assert(typeof(p1) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(p1, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	return p1:GetAttributeChangedSignal(BossNPCConsts.ATTACK_STATE_ATTR_NAME)
end
return t
