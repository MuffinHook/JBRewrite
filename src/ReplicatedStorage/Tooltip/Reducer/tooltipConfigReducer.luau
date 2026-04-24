-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
require(ReplicatedStorage.Tooltip.TooltipConsts)
return Rodux.createReducer(nil, {
	setTooltipText = function(p1, p2)
		local v2 = table.clone(p1 or {})
		v2.text = p2.value
		return v2
	end,
	setTooltipVisible = function(p1, p2)
		local v2 = table.clone(p1 or {})
		v2.visible = p2.value
		return v2
	end
})
