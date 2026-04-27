local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local BossNPCConsts = require(ReplicatedStorage.MansionRobbery.BossNPCConsts)
local BossNPCUtils = {}
local function validateObj(bossNPCInstance)
	assert(typeof(bossNPCInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(bossNPCInstance, BossNPCConsts.TAG_NAME), "Obj does not have tag")
end
function BossNPCUtils.setMovementState(bossNPCInstance, stateValue)
	assert(typeof(bossNPCInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(bossNPCInstance, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	bossNPCInstance:SetAttribute(BossNPCConsts.MOVEMENT_STATE_ATTR_NAME, stateValue)
	return true
end
function BossNPCUtils.getMovementState(bossNPCInstance)
	assert(typeof(bossNPCInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(bossNPCInstance, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	return bossNPCInstance:GetAttribute(BossNPCConsts.MOVEMENT_STATE_ATTR_NAME)
end
function BossNPCUtils.getMovementStateChangedSignal(bossNPCInstance)
	assert(typeof(bossNPCInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(bossNPCInstance, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	return bossNPCInstance:GetAttributeChangedSignal(BossNPCConsts.MOVEMENT_STATE_ATTR_NAME)
end
function BossNPCUtils.setAttackState(bossNPCInstance, stateValue)
	assert(typeof(bossNPCInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(bossNPCInstance, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	bossNPCInstance:SetAttribute(BossNPCConsts.ATTACK_STATE_ATTR_NAME, stateValue)
end
function BossNPCUtils.getAttackState(bossNPCInstance)
	assert(typeof(bossNPCInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(bossNPCInstance, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	return bossNPCInstance:GetAttribute(BossNPCConsts.ATTACK_STATE_ATTR_NAME)
end
function BossNPCUtils.getAttackStateChangedSignal(bossNPCInstance)
	assert(typeof(bossNPCInstance) == "Instance", "Invalid obj passed")
	assert(CollectionService:HasTag(bossNPCInstance, BossNPCConsts.TAG_NAME), "Obj does not have tag")
	return bossNPCInstance:GetAttributeChangedSignal(BossNPCConsts.ATTACK_STATE_ATTR_NAME)
end
return BossNPCUtils
