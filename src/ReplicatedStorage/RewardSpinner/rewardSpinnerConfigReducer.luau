local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local getItemPropsFromRewardData = require(ReplicatedStorage.RewardSpinner.getItemPropsFromRewardData)
return Rodux.createReducer(nil, {
	setRewardSpinnerConfig = function(state, action)
		if action.items then
			local processedItems = {}
			for index, itemData in action.items do
				table.insert(processedItems, (getItemPropsFromRewardData(itemData)))
			end
			return {
				items = processedItems,
				duration = action.duration,
				winIndex = action.winIndex,
				title = action.title,
				iconImageId = action.iconImageId,
				primaryColor = action.primaryColor,
				topic = action.topic,
				extraText = action.extraText
			}
		else
			return nil
		end
	end
})
