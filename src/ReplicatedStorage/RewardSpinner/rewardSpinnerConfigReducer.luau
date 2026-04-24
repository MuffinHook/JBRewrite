-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local getItemPropsFromRewardData = require(ReplicatedStorage.RewardSpinner.getItemPropsFromRewardData)
return Rodux.createReducer(nil, {
	setRewardSpinnerConfig = function(p1, p2)
		if p2.items then
			local tbl = {}
			for v1, v2 in p2.items do
				table.insert(tbl, (getItemPropsFromRewardData(v2)))
			end
			return {
				items = tbl,
				duration = p2.duration,
				winIndex = p2.winIndex,
				title = p2.title,
				iconImageId = p2.iconImageId,
				primaryColor = p2.primaryColor,
				topic = p2.topic,
				extraText = p2.extraText
			}
		else
			return nil
		end
	end
})
