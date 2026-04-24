-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NPCConsts = require(ReplicatedStorage.NPC.NPCConsts)
local t = {
	getTargetType = function(p1)
		return p1:GetAttribute(NPCConsts.DEST_TYPE_ATTR_NAME)
	end,
	setTargetType = function(p1, p2)
		p1:SetAttribute(NPCConsts.DEST_TYPE_ATTR_NAME, p2)
	end
}
function t.getTarget(p1)
	local targetType = t.getTargetType(p1)
	if targetType == NPCConsts.DEST_TYPE.POS or targetType == NPCConsts.DEST_TYPE.IDLE then
		return p1:GetAttribute(NPCConsts.DEST_POS_ATTR_NAME)
	elseif targetType == NPCConsts.DEST_TYPE.OBJ then
		local destObjValue = p1:FindFirstChild(NPCConsts.DEST_OBJ_VALUE_NAME)
		if destObjValue then
			return destObjValue.Value
		else
			return nil
		end
	else
		return nil
	end
end
function t.setTarget(p1, p2, p3)
	if p3 == nil and typeof(p2) == "Vector3" then
		p3 = NPCConsts.DEST_TYPE.POS
	elseif p3 == nil and (typeof(p2) == "Instance" and p2:IsA("BasePart") or p2 == nil) then
		p3 = NPCConsts.DEST_TYPE.OBJ
	elseif p3 == nil then
		error("Unknown targetType")
	end
	if p3 == NPCConsts.DEST_TYPE.POS or p3 == NPCConsts.DEST_TYPE.IDLE then
		p1:SetAttribute(NPCConsts.DEST_POS_ATTR_NAME, p2)
	elseif p3 == NPCConsts.DEST_TYPE.OBJ then
		local v1 = p1:FindFirstChild(NPCConsts.DEST_OBJ_VALUE_NAME)
		if not v1 then
			error("Could not find destObj")
		end
		v1.Value = p2
	end
	if t.getTargetType(p1) ~= p3 then
		t.setTargetType(p1, p3)
	end
end
function t.setHomePosition(p1, p2)
	p1:SetAttribute(NPCConsts.HOME_POSITION_OBJ_NAME, p2)
end
function t.getHomePosition(p1)
	return p1:GetAttribute(NPCConsts.HOME_POSITION_OBJ_NAME)
end
function t.getLookAtType(p1)
	return p1:GetAttribute(NPCConsts.LOOK_AT_TYPE_ATTR_NAME)
end
function t.setLookAtType(p1, p2)
	p1:SetAttribute(NPCConsts.LOOK_AT_TYPE_ATTR_NAME, p2)
end
function t.getLookAt(p1)
	local lookAtType = t.getLookAtType(p1)
	if lookAtType == NPCConsts.DEST_TYPE.POS or lookAtType == NPCConsts.DEST_TYPE.IDLE then
		return p1:GetAttribute(NPCConsts.LOOK_AT_POS_ATTR_NAME)
	elseif lookAtType == NPCConsts.DEST_TYPE.OBJ then
		local lookAtObjValue = p1:FindFirstChild(NPCConsts.LOOK_AT_OBJ_VALUE_NAME)
		if lookAtObjValue then
			return lookAtObjValue.Value
		else
			return nil
		end
	else
		return nil
	end
end
function t.setLookAt(p1, p2, p3)
	if p3 == nil and typeof(p2) == "Vector3" then
		p3 = NPCConsts.DEST_TYPE.POS
	elseif p3 == nil and (typeof(p2) == "Instance" and p2:IsA("BasePart") or p2 == nil) then
		p3 = NPCConsts.DEST_TYPE.OBJ
	elseif p3 == nil then
		error("Unknown targetType")
	end
	if p3 == NPCConsts.DEST_TYPE.POS or p3 == NPCConsts.DEST_TYPE.IDLE then
		p1:SetAttribute(NPCConsts.LOOK_AT_POS_ATTR_NAME, p2)
	elseif p3 == NPCConsts.DEST_TYPE.OBJ then
		local v1 = p1:FindFirstChild(NPCConsts.LOOK_AT_OBJ_VALUE_NAME)
		if not v1 then
			error("Could not find destObj")
		end
		v1.Value = p2
	end
	if t.getLookAtType(p1) ~= p3 then
		t.setLookAtType(p1, p3)
	end
end
function t.getNetworkOwner(p1)
	local networkOwnerId = p1:GetAttribute(NPCConsts.NETWORK_OWNER_ID_ATTR_NAME)
	if networkOwnerId then
		return Players:GetPlayerByUserId(networkOwnerId)
	end
end
function t.setExtrapolateTargetMovement(p1, p2)
	return p1:SetAttribute(NPCConsts.EXTRAPOLATE_TARGET_MOVEMENT_ATTR_NAME, p2)
end
function t.getExtrapolateTargetMovement(p1)
	return p1:GetAttribute(NPCConsts.EXTRAPOLATE_TARGET_MOVEMENT_ATTR_NAME)
end
function t.setCustomNetworkOwnership(p1, p2)
	p1:SetAttribute(NPCConsts.CUSTOM_NETWORK_OWNERSHIP_ATTR_NAME, p2)
end
function t.getCustomNetworkOwnership(p1)
	return p1:GetAttribute(NPCConsts.CUSTOM_NETWORK_OWNERSHIP_ATTR_NAME)
end
return t
