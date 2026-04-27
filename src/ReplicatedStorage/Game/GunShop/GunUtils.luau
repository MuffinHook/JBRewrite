local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemDataUtils = require(ReplicatedStorage.App.ItemDataUtils)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local t = {}
function t.getShouldAddEquipTime(gunConfig)
	local shouldForceEquipTime = workspace:GetServerTimeNow() - t.getLastShotTime(gunConfig.Player) < GunSystemConsts.GUN_EQUIP_TIME_COOLDOWN_SINCE_LAST_SHOT or gunConfig.Config.EquipTimeForced
	if shouldForceEquipTime then
		shouldForceEquipTime = gunConfig.Local
	end
	return shouldForceEquipTime
end
function t.getLastShotTime(playerOrCharacter)
	return playerOrCharacter:GetAttribute(GunSystemConsts.LAST_SHOT_ATTR_NAME) or 0
end
function t.setLastShotTime(playerOrCharacter, timestamp)
	playerOrCharacter:SetAttribute(GunSystemConsts.LAST_SHOT_ATTR_NAME, timestamp)
end
function t.getLastShotServerTime(playerOrCharacter)
	return playerOrCharacter:GetAttribute(GunSystemConsts.LAST_SHOT_SERVER_TIME_ATTR_NAME) or 0
end
function t.setLastShotServerTime(playerOrCharacter, serverTimestamp)
	playerOrCharacter:SetAttribute(GunSystemConsts.LAST_SHOT_SERVER_TIME_ATTR_NAME, serverTimestamp)
end
function t.getLastShotGunName(playerOrCharacter)
	return playerOrCharacter:GetAttribute(GunSystemConsts.LAST_SHOT_SERVER_GUN_NAME_ATTR_NAME)
end
function t.setLastShotGunName(playerOrCharacter, gunName)
	playerOrCharacter:SetAttribute(GunSystemConsts.LAST_SHOT_SERVER_GUN_NAME_ATTR_NAME, gunName)
end
function t.getCustomServerEquipTime(gunConfigName)
	local equipTimeObject = ReplicatedStorage.Game.GunShop:FindFirstChild(GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME)
	if equipTimeObject then
		return equipTimeObject:GetAttribute(gunConfigName)
	else
		return nil
	end
end
function t.setCustomServerEquipTime(gunConfigName, equipTime)
	assert(equipTime >= 0, "Equip time must be non-negative")
	local equipTimeObject = ReplicatedStorage.Game.GunShop:FindFirstChild(GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME)
	if not equipTimeObject then
		local newEquipTimeObject = Instance.new("BoolValue")
		newEquipTimeObject.Name = GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME
		newEquipTimeObject.Parent = ReplicatedStorage.Game.GunShop
		equipTimeObject = newEquipTimeObject
	end
	equipTimeObject:SetAttribute(gunConfigName, equipTime)
end
function t.getEquipTime(gunConfigName)
	local gunConfig = ItemDataUtils.getConfig(gunConfigName)
	assert(gunConfig)
	return t.getCustomServerEquipTime(gunConfigName) or (gunConfig.EquipTime or GunSystemConsts.GUN_EQUIP_TIME)
end
function t.getNextShotPossible(playerOrCharacter)
	return playerOrCharacter:GetAttribute(GunSystemConsts.NEXT_SHOT_POSSIBLE_ATTR_NAME) or 0
end
function t.setNextShotPossible(playerOrCharacter, timestamp)
	playerOrCharacter:SetAttribute(GunSystemConsts.NEXT_SHOT_POSSIBLE_ATTR_NAME, timestamp)
end
function t.getBulletDirection(gunMuzzlePosition, targetDirection, spreadRadius)
	local spreadOffset = GeomUtils.randomPointInCircle() * spreadRadius
	return (targetDirection + gunMuzzlePosition:VectorToWorldSpace((Vector3.new(spreadOffset.X, spreadOffset.Y, 0)))).Unit
end
return t
