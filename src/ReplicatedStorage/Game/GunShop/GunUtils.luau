-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemDataUtils = require(ReplicatedStorage.App.ItemDataUtils)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local t = {}
function t.getShouldAddEquipTime(p1)
	local v2 = workspace:GetServerTimeNow() - t.getLastShotTime(p1.Player) < GunSystemConsts.GUN_EQUIP_TIME_COOLDOWN_SINCE_LAST_SHOT or p1.Config.EquipTimeForced
	if v2 then
		v2 = p1.Local
	end
	return v2
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
	local v1 = ReplicatedStorage.Game.GunShop:FindFirstChild(GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME)
	if v1 then
		return v1:GetAttribute(p1)
	else
		return nil
	end
end
function t.setCustomServerEquipTime(p1, p2)
	assert(p2 >= 0, "Equip time must be non-negative")
	local v2 = ReplicatedStorage.Game.GunShop:FindFirstChild(GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME)
	if not v2 then
		local v3 = Instance.new("BoolValue")
		v3.Name = GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME
		v3.Parent = ReplicatedStorage.Game.GunShop
		v2 = v3
	end
	v2:SetAttribute(p1, p2)
end
function t.getEquipTime(p1)
	local v1 = ItemDataUtils.getConfig(p1)
	assert(v1)
	return t.getCustomServerEquipTime(p1) or (v1.EquipTime or GunSystemConsts.GUN_EQUIP_TIME)
end
function t.getNextShotPossible(p1)
	return p1:GetAttribute(GunSystemConsts.NEXT_SHOT_POSSIBLE_ATTR_NAME) or 0
end
function t.setNextShotPossible(p1, p2)
	p1:SetAttribute(GunSystemConsts.NEXT_SHOT_POSSIBLE_ATTR_NAME, p2)
end
function t.getBulletDirection(p1, p2, p3)
	local v1 = GeomUtils.randomPointInCircle() * p3
	return (p2 + p1:VectorToWorldSpace((Vector3.new(v1.X, v1.Y, 0)))).Unit
end
return t