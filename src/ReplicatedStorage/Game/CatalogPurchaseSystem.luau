local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notification = require(ReplicatedStorage.Game.Notification)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local Maid = require(ReplicatedStorage.Std.Maid)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local function catalogPurchase(p1, p2) --[[ Line: 10 | Upvalues: Maid (copy), MarketplaceService (copy), Players (copy), CircleAction (copy) ]]
	local v1 = Maid.new()
	local function action(p1, p22) --[[ Line: 12 | Upvalues: MarketplaceService (ref), Players (ref), p2 (copy) ]]
		if p22 then
			MarketplaceService:PromptPurchase(Players.LocalPlayer, p2.assetIdObj.Value, true)
		end
		return true
	end
	CircleAction.Add({
		Part = p1,
		Timed = false,
		Name = ("Buy %s"):format(p2.displayNameObj.Value),
		Dist = 16,
		Callback = action
	}, p1)
	v1:GiveTask(function() --[[ Line: 26 | Upvalues: CircleAction (ref), p1 (copy) ]]
		CircleAction.Remove(p1)
	end)
	return v1
end
return {
	init = function() --[[ Name: init | Line: 33 | Upvalues: ManifestBinder (copy), catalogPurchase (copy), MarketplaceService (copy), Players (copy), Notification (copy) ]]
		ManifestBinder.new("CatalogPurchase", {
			assetIdObj = "AssetId",
			displayNameObj = "DisplayName"
		}, catalogPurchase):Start()
		MarketplaceService.PromptPurchaseFinished:Connect(function(p1, p2, p3) --[[ Line: 40 | Upvalues: Players (ref), Notification (ref) ]]
			if p1 == Players.LocalPlayer then
				if p3 then
					Notification.new({
						Text = "Go to the Roblox avatar editor to wear this item!"
					})
				end
			end
		end)
	end
}