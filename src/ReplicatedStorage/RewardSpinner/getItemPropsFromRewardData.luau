-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local RewardSpinnerConsts = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local TradeReducerUtils = require(ReplicatedStorage.Trade.TradeReducerUtils)
return function(p1)
	local tbl = {}
	if p1.RarityId then
		local v1 = RewardSpinnerConsts.RARITY_ID_TO_RARITY[p1.RarityId]
		if not v1 then
			local v2 = error
			v2("Invalid item rarity: " .. tostring(p1.RarityId))
		end
		tbl.rarityIndex = v1.index
		local count = #RewardSpinnerConsts.RARITIES
		tbl.rarityTitle = v1.name
		tbl.bubbleColor = v1.color
		if v1.index == count then
			tbl.backGlowEnabled = true
		elseif count - 2 <= v1.index then
			tbl.frontGlowEnabled = true
		end
	end
	if p1.ImageId then
		tbl.image = "rbxassetid://" .. tostring(p1.ImageId)
	end
	if p1.Type == "Cash" then
		tbl.typeTitle = "Cash"
		local var4 = if p1.Amount > 0 then "+" else ""
		tbl.title = var4 .. "$" .. String.comma(p1.Amount)
	elseif p1.Type == "Nitro" then
		tbl.typeTitle = "Nitro"
		local var5 = if p1.Amount > 0 then "+" else ""
		tbl.title = var5 .. String.comma(p1.Amount)
	elseif p1.Type == "HyperChrome" then
		tbl.typeTitle = "Color"
		tbl.title = "HyperChrome!"
		tbl.subTitle = "Level " .. tostring(p1.Level)
	elseif p1.Type == "UniqueItem" then
		local var6 = TradeReducerUtils.buildItemProps(p1)
		if not var6 then
			print(p1)
			error("No item props found for rewardData ^")
		end
		tbl.title = var6.title
		tbl.typeTitle = var6.categoryTitle
		tbl.getInst = var6.getInst
		tbl.getInstCompare = var6.getInstCompare
		tbl.updateCamera = var6.updateCamera
		tbl.image = var6.image
	end
	return tbl
end
