local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ForcefieldConsts = require(ReplicatedStorage.Forcefield.ForcefieldConsts)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local Region = require(ReplicatedStorage.Std.Region)
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local v1 = 0
local function GetUID() --[[ Line: 11 | Upvalues: v1 (ref) ]]
	v1 = v1 + 1
	return v1
end
local t = {
	ListShields = {}
}
function t.init() --[[ Line: 19 | Upvalues: t (copy), Region (copy), RegionUtils (copy), Binder (copy), ForcefieldConsts (copy), Maid (copy) ]]
	t.disallowedRegion = Region.new(RegionUtils.NilCondition)
	Binder.new(ForcefieldConsts.FORCEFIELD_DISALLOWED_PART_TAG, function(p1) --[[ Line: 21 | Upvalues: Maid (ref), RegionUtils (ref), t (ref) ]]
		local v1 = Maid.new()
		v1:GiveTask((t.disallowedRegion:AddPrism((RegionUtils.getPrism(p1.CFrame, (Vector3.new(p1.Size.X, 10000, p1.Size.Z)))))))
		return v1
	end):Start()
	return true
end
function t.add(p1, p2, p3) --[[ Line: 32 | Upvalues: t (copy) ]]
	if t.disallowedRegion:CastPoint(p1) then
		return nil
	else
		local t2 = {
			Position = p1,
			Radius = p2,
			Id = p3
		}
		table.insert(t.ListShields, t2)
		return p3, t2
	end
end
function t.removeById(p1) --[[ Line: 40 | Upvalues: t (copy) ]]
	local ListShields = t.ListShields
	for i = #ListShields, 1, -1 do
		if ListShields[i].Id == p1 then
			table.remove(ListShields, i)
			return true
		end
	end
	return false
end
function t.getIsPositionAllowed(p1) --[[ Line: 50 | Upvalues: t (copy) ]]
	return not t.disallowedRegion:CastPoint(p1)
end
return t