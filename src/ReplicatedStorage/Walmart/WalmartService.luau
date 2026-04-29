game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
require(ReplicatedStorage.Policy.PolicyService)
local Binder = require(ReplicatedStorage.Std.Binder)
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local Region = require(ReplicatedStorage.Std.Region)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
return {
	init = function()  end,
	setupModel = function()
		local WalmartBrand = ReplicatedStorage:WaitForChild("WalmartBrand", 5)
		if WalmartBrand then
			WalmartBrand.Parent = workspace
			local WalmartGui = ReplicatedStorage:FindFirstChild("StarterGui"):FindFirstChild("WalmartGui")
			if WalmartGui then
				WalmartGui.Parent = Players.LocalPlayer:FindFirstChild("PlayerGui")
				WalmartGui.Background.Close.Activated:Connect(function()
					WalmartGui.Enabled = false
				end)
				WalmartGui.Background.Buy.Activated:Connect(function()
					GamepassUtils.PromptGamepass(GamepassUtils.EnumGamepass.Walmart)
				end)
				Binder.new("WalmartPurchaseRegion", function(regionPart)
					local regionMaid = Maid.new()
					local displayStateMaid = Maid.new()
					local playerDetectionRegion = Region.new(RegionUtils.ConditionPlayer)
					playerDetectionRegion:AddPart(regionPart)
					regionMaid:GiveTask(playerDetectionRegion)
					regionMaid:GiveTask(playerDetectionRegion.OnObjAdded:Connect(function(addedObject)
						displayStateMaid:DoCleaning()
						if not GamepassSystem.doesPlayerOwnCached(Players.LocalPlayer, GamepassUtils.EnumGamepass.Walmart) then
							WalmartGui.Enabled = true
							displayStateMaid:GiveTask(task.delay(2, function()  end))
						end
					end))
					regionMaid:GiveTask(playerDetectionRegion.OnObjRemoved:Connect(function(removedObject)
						displayStateMaid:DoCleaning()
						WalmartGui.Enabled = false
					end))
					regionMaid:GiveTask(Interval.every(1/3):Connect(function()
						playerDetectionRegion:Update({ Players.LocalPlayer })
					end))
					return regionMaid
				end):Start()
				GamepassSystem.GetGamepassOwnedSignal(GamepassUtils.EnumGamepass.Walmart):Connect(function()
					WalmartGui.Enabled = false
				end)
			else
				warn("Could not find StarterGui/WalmartGui..")
			end
		else
			warn("Could not find WalmartBrand model..")
		end
	end
}
