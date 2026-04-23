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
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1) --[[ Line: 17 | Upvalues: BaseObject (copy), t (copy), RegionUtils (copy), ReplicatedStorage (copy), Interval (copy), Players (copy), store (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	local v3 = RegionUtils.getPrism(p1.CFrame, p1.Size)
	p1.Parent = ReplicatedStorage
	local v4 = false
	v1.maid:GiveTask(Interval.every(0.1):Connect(function() --[[ Line: 24 | Upvalues: Players (ref), RegionUtils (ref), v3 (copy), v4 (ref), store (ref) ]]
		local Character = Players.LocalPlayer.Character
		if Character then
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart then
				local v1 = RegionUtils.CastPoint(v3, HumanoidRootPart.Position)
				if v1 ~= v4 then
					v4 = v1
					store:dispatch({
						type = "setOtherTradeServerListVisible",
						value = v1
					})
				end
			end
		end
	end))
	return v1
end
return Binder.new(TradeConsts.OTHER_TRADE_SERVER_LIST_REGION_TAG_NAME, t)