-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemDataUtils = require(ReplicatedStorage.App.ItemDataUtils)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local t = {}
function t.getShouldAddEquipTime(p1)
	local shouldForceEquipTime = workspace:GetServerTimeNow() - t.getLastShotTime(p1.Player) < GunSystemConsts.GUN_EQUIP_TIME_COOLDOWN_SINCE_LAST_SHOT or p1.Config.EquipTimeForced
	if shouldForceEquipTime then
		shouldForceEquipTime = p1.Local
	end
	return shouldForceEquipTime
end
function t.getLastShotTime(p1)
	return p1:GetAttribute(GunSystemConsts.LAST_SHOT_ATTR_NAME) or 0
end
function t.setLastShotTime(p1, p2)
	p1:SetAttribute(GunSystemConsts.LAST_SHOT_ATTR_NAME, p2)
end
function t.getLastShotServerTime(p1)
	return p1:GetAttribute(GunSystemConsts.LAST_SHOT_SERVER_TIME_ATTR_NAME) or 0
end
function t.setLastShotServerTime(p1, p2)
	p1:SetAttribute(GunSystemConsts.LAST_SHOT_SERVER_TIME_ATTR_NAME, p2)
end
function t.getLastShotGunName(p1)
	return p1:GetAttribute(GunSystemConsts.LAST_SHOT_SERVER_GUN_NAME_ATTR_NAME)
end
function t.setLastShotGunName(p1, p2)
	p1:SetAttribute(GunSystemConsts.LAST_SHOT_SERVER_GUN_NAME_ATTR_NAME, p2)
end
function t.getCustomServerEquipTime(p1)
	local equipTimeObject = ReplicatedStorage.Game.GunShop:FindFirstChild(GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME)
	if equipTimeObject then
		return equipTimeObject:GetAttribute(p1)
	else
		return nil
	end
end
function t.setCustomServerEquipTime(p1, p2)
	assert(p2 >= 0, "Equip time must be non-negative")
	local equipTimeObject = ReplicatedStorage.Game.GunShop:FindFirstChild(GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME)
	if not equipTimeObject then
		local newEquipTimeObject = Instance.new("BoolValue")
		newEquipTimeObject.Name = GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME
		newEquipTimeObject.Parent = ReplicatedStorage.Game.GunShop
		equipTimeObject = newEquipTimeObject
	end
	equipTimeObject:SetAttribute(p1, p2)
end
function t.getEquipTime(p1)
	local gunConfig = ItemDataUtils.getConfig(p1)
	assert(gunConfig)
	return t.getCustomServerEquipTime(p1) or (gunConfig.EquipTime or GunSystemConsts.GUN_EQUIP_TIME)
end
function t.getNextShotPossible(p1)
	return p1:GetAttribute(GunSystemConsts.NEXT_SHOT_POSSIBLE_ATTR_NAME) or 0
end
function t.setNextShotPossible(p1, p2)
	p1:SetAttribute(GunSystemConsts.NEXT_SHOT_POSSIBLE_ATTR_NAME, p2)
end
function t.getBulletDirection(p1, p2, p3)
	local spreadOffset = GeomUtils.randomPointInCircle() * p3
	return (p2 + p1:VectorToWorldSpace((Vector3.new(spreadOffset.X, spreadOffset.Y, 0)))).Unit
end
return t