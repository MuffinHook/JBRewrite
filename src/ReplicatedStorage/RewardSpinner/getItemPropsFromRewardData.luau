-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local RewardSpinnerConsts = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local TradeReducerUtils = require(ReplicatedStorage.Trade.TradeReducerUtils)
return function(p1)
	local t = {}
	if p1.RarityId then
		local v1 = RewardSpinnerConsts.RARITY_ID_TO_RARITY[p1.RarityId]
		if not v1 then
			local v2 = error
			v2("Invalid item rarity: " .. tostring(p1.RarityId))
		end
		t.rarityIndex = v1.index
		local v3 = #RewardSpinnerConsts.RARITIES
		t.rarityTitle = v1.name
		t.bubbleColor = v1.color
		if v1.index == v3 then
			t.backGlowEnabled = true
		elseif v3 - 2 <= v1.index then
			t.frontGlowEnabled = true
		end
	end
	if p1.ImageId then
		t.image = "rbxassetid://" .. tostring(p1.ImageId)
	end
	if p1.Type == "Cash" then
		t.typeTitle = "Cash"
		local v4 = if p1.Amount > 0 then "+" else ""
		t.title = v4 .. "$" .. String.comma(p1.Amount)
	elseif p1.Type == "Nitro" then
		t.typeTitle = "Nitro"
		local v5 = if p1.Amount > 0 then "+" else ""
		t.title = v5 .. String.comma(p1.Amount)
	elseif p1.Type == "HyperChrome" then
		t.typeTitle = "Color"
		t.title = "HyperChrome!"
		t.subTitle = "Level " .. tostring(p1.Level)
	elseif p1.Type == "UniqueItem" then
		local v6 = TradeReducerUtils.buildItemProps(p1)
		if not v6 then
			print(p1)
			error("No item props found for rewardData ^")
		end
		t.title = v6.title
		t.typeTitle = v6.categoryTitle
		t.getInst = v6.getInst
		t.getInstCompare = v6.getInstCompare
		t.updateCamera = v6.updateCamera
		t.image = v6.image
	end
	return t
end
