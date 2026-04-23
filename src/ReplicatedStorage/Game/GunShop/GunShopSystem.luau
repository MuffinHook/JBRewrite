local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Region = require(ReplicatedStorage.Std.Region)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local GunShopConsts = require(script.Parent.GunShopConsts)
local t = {
	onAnyOwned = Signal.new(),
	itemsValue = nil
}
function t.init() --[[ Line: 23 | Upvalues: waitForChild (copy), LocalPlayer (copy), GunShopConsts (copy), t (copy), Region (copy), RegionUtils (copy), CollectionService (copy), RunService (copy) ]]
	waitForChild(LocalPlayer, GunShopConsts.ITEMS_VALUE_NAME):andThen(function(p1) --[[ Line: 25 | Upvalues: t (ref) ]]
		t.itemsValue = p1
		p1.ChildAdded:Connect(function(p1) --[[ Line: 28 | Upvalues: t (ref) ]]
			t.onAnyOwned:Fire(p1.Name)
		end)
	end):catch(warn)
	local GunShopUI = require(script.Parent.GunShopUI)
	local v1 = Region.new(RegionUtils.ConditionPlayer)
	v1.OnObjAdded:Connect(function() --[[ Line: 37 | Upvalues: GunShopUI (copy) ]]
		if not GunShopUI.isOpen() then
			GunShopUI.open()
		end
	end)
	v1.OnObjRemoved:Connect(function() --[[ Line: 42 | Upvalues: GunShopUI (copy) ]]
		if GunShopUI.isOpen() then
			GunShopUI.close()
		end
	end)
	local function updatePrisms() --[[ Line: 49 | Upvalues: v1 (copy), CollectionService (ref) ]]
		v1.Prisms = {}
		for i, v in ipairs(CollectionService:GetTagged("GunShopRegion")) do
			v1:AddPart(v)
		end
	end
	updatePrisms()
	CollectionService:GetInstanceAddedSignal("GunShopRegion"):Connect(updatePrisms)
	CollectionService:GetInstanceRemovedSignal("GunShopRegion"):Connect(updatePrisms)
	local v2 = tick()
	RunService.Heartbeat:Connect(function() --[[ Line: 62 | Upvalues: v2 (ref), v1 (copy), LocalPlayer (ref) ]]
		local v12 = tick()
		if not (v12 - v2 < 0.5) then
			v2 = v12
			v1:Update({ LocalPlayer }, true)
		end
	end)
end
function t.doesPlayerOwn(p1) --[[ Line: 71 | Upvalues: LocalPlayer (copy), GunShopConsts (copy) ]]
	return LocalPlayer:WaitForChild(GunShopConsts.ITEMS_VALUE_NAME):FindFirstChild(p1) ~= nil
end
return t