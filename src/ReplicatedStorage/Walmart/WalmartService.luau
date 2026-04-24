-- Reviewed by Claude
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
				Binder.new("WalmartPurchaseRegion", function(p1)
					local instance = Maid.new()
					local instance2 = Maid.new()
					local instance3 = Region.new(RegionUtils.ConditionPlayer)
					instance3:AddPart(p1)
					instance:GiveTask(instance3)
					instance:GiveTask(instance3.OnObjAdded:Connect(function(p1)
						instance2:DoCleaning()
						if not GamepassSystem.doesPlayerOwnCached(Players.LocalPlayer, GamepassUtils.EnumGamepass.Walmart) then
							WalmartGui.Enabled = true
							instance2:GiveTask(task.delay(2, function()  end))
						end
					end))
					instance:GiveTask(instance3.OnObjRemoved:Connect(function(p1)
						instance2:DoCleaning()
						WalmartGui.Enabled = false
					end))
					instance:GiveTask(Interval.every(0.3333333333333333):Connect(function()
						instance3:Update({ Players.LocalPlayer })
					end))
					return instance
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
