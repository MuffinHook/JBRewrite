-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notification = require(ReplicatedStorage.Game.Notification)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local Maid = require(ReplicatedStorage.Std.Maid)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local function catalogPurchase(part, config)
	local maid = Maid.new()
	local function action(part, shouldPurchase)
		if shouldPurchase then
			MarketplaceService:PromptPurchase(Players.LocalPlayer, config.assetIdObj.Value, true)
		end
		return true
	end
	CircleAction.Add({
		Part = part,
		Timed = false,
		Name = ("Buy %s"):format(config.displayNameObj.Value),
		Dist = 16,
		Callback = action
	}, part)
	maid:GiveTask(function()
		CircleAction.Remove(part)
	end)
	return maid
end
return {
	init = function()
		ManifestBinder.new("CatalogPurchase", {
			assetIdObj = "AssetId",
			displayNameObj = "DisplayName"
		}, catalogPurchase):Start()
		MarketplaceService.PromptPurchaseFinished:Connect(function(player, assetId, isPurchased)
			if player == Players.LocalPlayer then
				if isPurchased then
					Notification.new({
						Text = "Go to the Roblox avatar editor to wear this item!"
					})
				end
			end
		end)
	end
}
