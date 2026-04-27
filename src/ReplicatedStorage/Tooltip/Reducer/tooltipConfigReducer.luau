local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
require(ReplicatedStorage.Tooltip.TooltipConsts)
return Rodux.createReducer(nil, {
	setTooltipText = function(state, action)
		local newState = table.clone(state or {})
		newState.text = action.value
		return newState
	end,
	setTooltipVisible = function(state, action)
		local newState = table.clone(state or {})
		newState.visible = action.value
		return newState
	end
})
