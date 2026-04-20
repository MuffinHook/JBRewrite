
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ItemDataUtils = require(ReplicatedStorage.App.ItemDataUtils)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)

local GunUtils = {}

local function getPlayerFromGun(gunOrPlayer)
	return gunOrPlayer and (gunOrPlayer.Player or gunOrPlayer)
end

-- Decomp Error: Original GunUtils bytecode was corrupted; rebuilt from constants and weapon call sites.
function GunUtils.getLastShotTime(player)
	return player:GetAttribute(GunSystemConsts.LAST_SHOT_ATTR_NAME)
end

function GunUtils.setLastShotTime(player, time)
	player:SetAttribute(GunSystemConsts.LAST_SHOT_ATTR_NAME, time)
	GunUtils.setLastShotServerTime(player, time)
end

function GunUtils.getLastShotServerTime(player)
	return player:GetAttribute(GunSystemConsts.LAST_SHOT_SERVER_TIME_ATTR_NAME)
end

function GunUtils.setLastShotServerTime(player, time)
	player:SetAttribute(GunSystemConsts.LAST_SHOT_SERVER_TIME_ATTR_NAME, time)
end

function GunUtils.getLastShotGunName(player)
	return player:GetAttribute(GunSystemConsts.LAST_SHOT_SERVER_GUN_NAME_ATTR_NAME)
end

function GunUtils.setLastShotGunName(player, gunName)
	player:SetAttribute(GunSystemConsts.LAST_SHOT_SERVER_GUN_NAME_ATTR_NAME, gunName)
end

function GunUtils.getNextShotPossible(player)
	return player:GetAttribute(GunSystemConsts.NEXT_SHOT_POSSIBLE_ATTR_NAME)
end

function GunUtils.setNextShotPossible(player, time)
	player:SetAttribute(GunSystemConsts.NEXT_SHOT_POSSIBLE_ATTR_NAME, time)
end

function GunUtils.getCustomServerEquipTime(itemValue)
	local value = itemValue and itemValue:FindFirstChild(GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME)
	return value and value.Value or nil
end

function GunUtils.setCustomServerEquipTime(itemValue, equipTime)
	assert(equipTime == nil or equipTime >= 0, "Equip time must be non-negative")
	local value = itemValue:FindFirstChild(GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME)
	if equipTime == nil then
		if value then
			value:Destroy()
		end
		return
	end
	if not value then
		value = Instance.new("NumberValue")
		value.Name = GunSystemConsts.CUSTOM_SERVER_EQUIP_TIME_OBJ_NAME
		value.Parent = itemValue
	end
	value.Value = equipTime
end

function GunUtils.getConfig(itemName)
	return ItemDataUtils.getConfig(itemName)
end

function GunUtils.getEquipTime(gunOrItemName)
	local itemValue = gunOrItemName and gunOrItemName.inventoryItemValue
	local customEquipTime = itemValue and GunUtils.getCustomServerEquipTime(itemValue)
	if customEquipTime ~= nil then
		return customEquipTime
	end
	local config = typeof(gunOrItemName) == "string" and GunUtils.getConfig(gunOrItemName) or gunOrItemName.Config
	return config and config.EquipTime or GunSystemConsts.GUN_EQUIP_TIME
end

function GunUtils.getShouldAddEquipTime(gunOrPlayer)
	local player = getPlayerFromGun(gunOrPlayer)
	if not player then
		return false
	end
	if gunOrPlayer and gunOrPlayer.Config and gunOrPlayer.Config.EquipTimeForced then
		return true
	end
	if gunOrPlayer and gunOrPlayer.Local == false then
		return false
	end
	local lastShotTime = GunUtils.getLastShotServerTime(player) or GunUtils.getLastShotTime(player)
	if not lastShotTime then
		return false
	end
	return workspace:GetServerTimeNow() - lastShotTime <= GunSystemConsts.GUN_EQUIP_TIME_COOLDOWN_SINCE_LAST_SHOT
end

function GunUtils.randomPointInCircle(radius)
	local theta = math.random() * math.pi * 2
	local r = math.sqrt(math.random()) * (radius or 1)
	return Vector3.new(math.cos(theta) * r, math.sin(theta) * r, 0)
end

function GunUtils.getBulletDirection(tipCFrame, tipDirection, spread)
	spread = spread or 0
	if spread <= 0 then
		return tipDirection.Unit
	end
	local offset = GunUtils.randomPointInCircle(spread)
	local direction = (tipDirection.Unit + tipCFrame:VectorToWorldSpace(Vector3.new(offset.X, offset.Y, 0)) * 0.01).Unit
	if direction.Magnitude ~= direction.Magnitude then
		return tipDirection.Unit
	end
	return direction
end

return GunUtils
