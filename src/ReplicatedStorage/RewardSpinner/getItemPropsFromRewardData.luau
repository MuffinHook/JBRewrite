local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local RewardSpinnerConsts = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local TradeReducerUtils = require(ReplicatedStorage.Trade.TradeReducerUtils)
return function(rewardData)
	local tbl = {}
	if rewardData.RarityId then
		local rarityInfo = RewardSpinnerConsts.RARITY_ID_TO_RARITY[rewardData.RarityId]
		if not rarityInfo then
			local errorFunc = error
			errorFunc("Invalid item rarity: " .. tostring(rewardData.RarityId))
		end
		tbl.rarityIndex = rarityInfo.index
		local count = #RewardSpinnerConsts.RARITIES
		tbl.rarityTitle = rarityInfo.name
		tbl.bubbleColor = rarityInfo.color
		if rarityInfo.index == count then
			tbl.backGlowEnabled = true
		elseif count - 2 <= rarityInfo.index then
			tbl.frontGlowEnabled = true
		end
	end
	if rewardData.ImageId then
		tbl.image = "rbxassetid://" .. tostring(rewardData.ImageId)
	end
	if rewardData.Type == "Cash" then
		tbl.typeTitle = "Cash"
		local amountPrefix = if rewardData.Amount > 0 then "+" else ""
		tbl.title = amountPrefix .. "$" .. String.comma(rewardData.Amount)
	elseif rewardData.Type == "Nitro" then
		tbl.typeTitle = "Nitro"
		local amountPrefix = if rewardData.Amount > 0 then "+" else ""
		tbl.title = amountPrefix .. String.comma(rewardData.Amount)
	elseif rewardData.Type == "HyperChrome" then
		tbl.typeTitle = "Color"
		tbl.title = "HyperChrome!"
		tbl.subTitle = "Level " .. tostring(rewardData.Level)
	elseif rewardData.Type == "UniqueItem" then
		local itemProps = TradeReducerUtils.buildItemProps(rewardData)
		if not itemProps then
			print(rewardData)
			error("No item props found for rewardData ^")
		end
		tbl.title = itemProps.title
		tbl.typeTitle = itemProps.categoryTitle
		tbl.getInst = itemProps.getInst
		tbl.getInstCompare = itemProps.getInstCompare
		tbl.updateCamera = itemProps.updateCamera
		tbl.image = itemProps.image
	end
	return tbl
end
