-- Reviewed by Claude
-- variables reassigned
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
function t.init()
	waitForChild(LocalPlayer, GunShopConsts.ITEMS_VALUE_NAME):andThen(function(itemsValueChild)
		t.itemsValue = itemsValueChild
		itemsValueChild.ChildAdded:Connect(function(child)
			t.onAnyOwned:Fire(child.Name)
		end)
	end):catch(warn)
	local GunShopUI = require(script.Parent.GunShopUI)
	local playerRegion = Region.new(RegionUtils.ConditionPlayer)
	playerRegion.OnObjAdded:Connect(function()
		if not GunShopUI.isOpen() then
			GunShopUI.open()
		end
	end)
	playerRegion.OnObjRemoved:Connect(function()
		if GunShopUI.isOpen() then
			GunShopUI.close()
		end
	end)
	local function updatePrisms()
		playerRegion.Prisms = {}
		for i, v in ipairs(CollectionService:GetTagged("GunShopRegion")) do
			playerRegion:AddPart(v)
		end
	end
	updatePrisms()
	CollectionService:GetInstanceAddedSignal("GunShopRegion"):Connect(updatePrisms)
	CollectionService:GetInstanceRemovedSignal("GunShopRegion"):Connect(updatePrisms)
	local lastUpdateTime = tick()
	RunService.Heartbeat:Connect(function()
		local currentTime = tick()
		if not (currentTime - lastUpdateTime < 0.5) then
			lastUpdateTime = currentTime
			playerRegion:Update({ LocalPlayer }, true)
		end
	end)
end
function t.doesPlayerOwn(p1)
	return LocalPlayer:WaitForChild(GunShopConsts.ITEMS_VALUE_NAME):FindFirstChild(p1) ~= nil
end
return t
