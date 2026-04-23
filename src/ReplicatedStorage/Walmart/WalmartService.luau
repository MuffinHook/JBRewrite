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
	init = function() --[[ Name: init | Line: 13 ]] end,
	setupModel = function() --[[ Name: setupModel | Line: 23 | Upvalues: ReplicatedStorage (copy), Players (copy), GamepassUtils (copy), Binder (copy), Maid (copy), Region (copy), RegionUtils (copy), GamepassSystem (copy), Interval (copy) ]]
		local WalmartBrand = ReplicatedStorage:WaitForChild("WalmartBrand", 5)
		if WalmartBrand then
			WalmartBrand.Parent = workspace
			local WalmartGui = ReplicatedStorage:FindFirstChild("StarterGui"):FindFirstChild("WalmartGui")
			if WalmartGui then
				WalmartGui.Parent = Players.LocalPlayer:FindFirstChild("PlayerGui")
				WalmartGui.Background.Close.Activated:Connect(function() --[[ Line: 43 | Upvalues: WalmartGui (copy) ]]
					WalmartGui.Enabled = false
				end)
				WalmartGui.Background.Buy.Activated:Connect(function() --[[ Line: 47 | Upvalues: GamepassUtils (ref) ]]
					GamepassUtils.PromptGamepass(GamepassUtils.EnumGamepass.Walmart)
				end)
				Binder.new("WalmartPurchaseRegion", function(p1) --[[ Line: 51 | Upvalues: Maid (ref), Region (ref), RegionUtils (ref), GamepassSystem (ref), Players (ref), GamepassUtils (ref), WalmartGui (copy), Interval (ref) ]]
					local v1 = Maid.new()
					local v2 = Maid.new()
					local v3 = Region.new(RegionUtils.ConditionPlayer)
					v3:AddPart(p1)
					v1:GiveTask(v3)
					v1:GiveTask(v3.OnObjAdded:Connect(function(p1) --[[ Line: 58 | Upvalues: v2 (copy), GamepassSystem (ref), Players (ref), GamepassUtils (ref), WalmartGui (ref) ]]
						v2:DoCleaning()
						if not GamepassSystem.doesPlayerOwnCached(Players.LocalPlayer, GamepassUtils.EnumGamepass.Walmart) then
							WalmartGui.Enabled = true
							v2:GiveTask(task.delay(2, function() --[[ Line: 66 ]] end))
						end
					end))
					v1:GiveTask(v3.OnObjRemoved:Connect(function(p1) --[[ Line: 70 | Upvalues: v2 (copy), WalmartGui (ref) ]]
						v2:DoCleaning()
						WalmartGui.Enabled = false
					end))
					v1:GiveTask(Interval.every(0.3333333333333333):Connect(function() --[[ Line: 75 | Upvalues: v3 (copy), Players (ref) ]]
						v3:Update({ Players.LocalPlayer })
					end))
					return v1
				end):Start()
				GamepassSystem.GetGamepassOwnedSignal(GamepassUtils.EnumGamepass.Walmart):Connect(function() --[[ Line: 83 | Upvalues: WalmartGui (copy) ]]
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