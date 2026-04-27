game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store = require(ReplicatedStorage.App.store)
require(ReplicatedStorage.Gamepass.GamepassSystem)
require(ReplicatedStorage.Gamepass.GamepassUtils)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local Interval = require(ReplicatedStorage.Std.Interval)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local OtherTradeServerRegionBinder = {}
OtherTradeServerRegionBinder.__index = OtherTradeServerRegionBinder
setmetatable(OtherTradeServerRegionBinder, BaseObject)
function OtherTradeServerRegionBinder.new(regionPart)
	local binderInstance = BaseObject.new(regionPart)
	setmetatable(binderInstance, OtherTradeServerRegionBinder)
	local regionPrism = RegionUtils.getPrism(regionPart.CFrame, regionPart.Size)
	regionPart.Parent = ReplicatedStorage
	local isInRegion = false
	binderInstance.maid:GiveTask(Interval.every(0.1):Connect(function()
		local Character = Players.LocalPlayer.Character
		if Character then
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart then
				local playerInRegion = RegionUtils.CastPoint(regionPrism, HumanoidRootPart.Position)
				if playerInRegion ~= isInRegion then
					isInRegion = playerInRegion
					store:dispatch({
						type = "setOtherTradeServerListVisible",
						value = playerInRegion
					})
				end
			end
		end
	end))
	return binderInstance
end
return Binder.new(TradeConsts.OTHER_TRADE_SERVER_LIST_REGION_TAG_NAME, OtherTradeServerRegionBinder)
