-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ForcefieldConsts = require(ReplicatedStorage.Forcefield.ForcefieldConsts)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local Region = require(ReplicatedStorage.Std.Region)
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local nextUniqueId = 0
local function GetUID()
	nextUniqueId = nextUniqueId + 1
	return nextUniqueId
end
local ForcefieldService = {
	ListShields = {}
}
function ForcefieldService.init()
	ForcefieldService.disallowedRegion = Region.new(RegionUtils.NilCondition)
	Binder.new(ForcefieldConsts.FORCEFIELD_DISALLOWED_PART_TAG, function(part)
		local maid = Maid.new()
		maid:GiveTask((ForcefieldService.disallowedRegion:AddPrism((RegionUtils.getPrism(part.CFrame, (Vector3.new(part.Size.X, 10000, part.Size.Z)))))))
		return maid
	end):Start()
	return true
end
function ForcefieldService.add(position, radius, id)
	if ForcefieldService.disallowedRegion:CastPoint(position) then
		return nil
	else
		local shield = {
			Position = position,
			Radius = radius,
			Id = id
		}
		table.insert(ForcefieldService.ListShields, shield)
		return id, shield
	end
end
function ForcefieldService.removeById(shieldId)
	local ListShields = ForcefieldService.ListShields
	for i = #ListShields, 1, -1 do
		if ListShields[i].Id == shieldId then
			table.remove(ListShields, i)
			return true
		end
	end
	return false
end
function ForcefieldService.getIsPositionAllowed(position)
	return not ForcefieldService.disallowedRegion:CastPoint(position)
end
return ForcefieldService
