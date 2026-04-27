local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NPCConsts = require(ReplicatedStorage.NPC.NPCConsts)
local t = {
	getTargetType = function(npcInstance)
		return npcInstance:GetAttribute(NPCConsts.DEST_TYPE_ATTR_NAME)
	end,
	setTargetType = function(npcInstance, targetType)
		npcInstance:SetAttribute(NPCConsts.DEST_TYPE_ATTR_NAME, targetType)
	end
}
function t.getTarget(npcInstance)
	local targetType = t.getTargetType(npcInstance)
	if targetType == NPCConsts.DEST_TYPE.POS or targetType == NPCConsts.DEST_TYPE.IDLE then
		return npcInstance:GetAttribute(NPCConsts.DEST_POS_ATTR_NAME)
	elseif targetType == NPCConsts.DEST_TYPE.OBJ then
		local destObjChild = npcInstance:FindFirstChild(NPCConsts.DEST_OBJ_VALUE_NAME)
		if destObjChild then
			return destObjChild.Value
		else
			return nil
		end
	else
		return nil
	end
end
function t.setTarget(npcInstance, targetValue, targetType)
	if targetType == nil and typeof(targetValue) == "Vector3" then
		targetType = NPCConsts.DEST_TYPE.POS
	elseif targetType == nil and (typeof(targetValue) == "Instance" and targetValue:IsA("BasePart") or targetValue == nil) then
		targetType = NPCConsts.DEST_TYPE.OBJ
	elseif targetType == nil then
		error("Unknown targetType")
	end
	if targetType == NPCConsts.DEST_TYPE.POS or targetType == NPCConsts.DEST_TYPE.IDLE then
		npcInstance:SetAttribute(NPCConsts.DEST_POS_ATTR_NAME, targetValue)
	elseif targetType == NPCConsts.DEST_TYPE.OBJ then
		local destObjChild = npcInstance:FindFirstChild(NPCConsts.DEST_OBJ_VALUE_NAME)
		if not destObjChild then
			error("Could not find destObj")
		end
		destObjChild.Value = targetValue
	end
	if t.getTargetType(npcInstance) ~= targetType then
		t.setTargetType(npcInstance, targetType)
	end
end
function t.setHomePosition(npcInstance, homePosition)
	npcInstance:SetAttribute(NPCConsts.HOME_POSITION_OBJ_NAME, homePosition)
end
function t.getHomePosition(npcInstance)
	return npcInstance:GetAttribute(NPCConsts.HOME_POSITION_OBJ_NAME)
end
function t.getLookAtType(npcInstance)
	return npcInstance:GetAttribute(NPCConsts.LOOK_AT_TYPE_ATTR_NAME)
end
function t.setLookAtType(npcInstance, lookAtType)
	npcInstance:SetAttribute(NPCConsts.LOOK_AT_TYPE_ATTR_NAME, lookAtType)
end
function t.getLookAt(npcInstance)
	local lookAtType = t.getLookAtType(npcInstance)
	if lookAtType == NPCConsts.DEST_TYPE.POS or lookAtType == NPCConsts.DEST_TYPE.IDLE then
		return npcInstance:GetAttribute(NPCConsts.LOOK_AT_POS_ATTR_NAME)
	elseif lookAtType == NPCConsts.DEST_TYPE.OBJ then
		local lookAtObjChild = npcInstance:FindFirstChild(NPCConsts.LOOK_AT_OBJ_VALUE_NAME)
		if lookAtObjChild then
			return lookAtObjChild.Value
		else
			return nil
		end
	else
		return nil
	end
end
function t.setLookAt(npcInstance, lookAtValue, lookAtType)
	if lookAtType == nil and typeof(lookAtValue) == "Vector3" then
		lookAtType = NPCConsts.DEST_TYPE.POS
	elseif lookAtType == nil and (typeof(lookAtValue) == "Instance" and lookAtValue:IsA("BasePart") or lookAtValue == nil) then
		lookAtType = NPCConsts.DEST_TYPE.OBJ
	elseif lookAtType == nil then
		error("Unknown targetType")
	end
	if lookAtType == NPCConsts.DEST_TYPE.POS or lookAtType == NPCConsts.DEST_TYPE.IDLE then
		npcInstance:SetAttribute(NPCConsts.LOOK_AT_POS_ATTR_NAME, lookAtValue)
	elseif lookAtType == NPCConsts.DEST_TYPE.OBJ then
		local lookAtObjChild = npcInstance:FindFirstChild(NPCConsts.LOOK_AT_OBJ_VALUE_NAME)
		if not lookAtObjChild then
			error("Could not find destObj")
		end
		lookAtObjChild.Value = lookAtValue
	end
	if t.getLookAtType(npcInstance) ~= lookAtType then
		t.setLookAtType(npcInstance, lookAtType)
	end
end
function t.getNetworkOwner(npcInstance)
	local networkOwnerId = npcInstance:GetAttribute(NPCConsts.NETWORK_OWNER_ID_ATTR_NAME)
	if networkOwnerId then
		return Players:GetPlayerByUserId(networkOwnerId)
	end
end
function t.setExtrapolateTargetMovement(npcInstance, shouldExtrapolate)
	return npcInstance:SetAttribute(NPCConsts.EXTRAPOLATE_TARGET_MOVEMENT_ATTR_NAME, shouldExtrapolate)
end
function t.getExtrapolateTargetMovement(npcInstance)
	return npcInstance:GetAttribute(NPCConsts.EXTRAPOLATE_TARGET_MOVEMENT_ATTR_NAME)
end
function t.setCustomNetworkOwnership(npcInstance, customOwnership)
	npcInstance:SetAttribute(NPCConsts.CUSTOM_NETWORK_OWNERSHIP_ATTR_NAME, customOwnership)
end
function t.getCustomNetworkOwnership(npcInstance)
	return npcInstance:GetAttribute(NPCConsts.CUSTOM_NETWORK_OWNERSHIP_ATTR_NAME)
end
return t
