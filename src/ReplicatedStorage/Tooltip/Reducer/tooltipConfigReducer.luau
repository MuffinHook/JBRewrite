-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
require(ReplicatedStorage.Tooltip.TooltipConsts)
return Rodux.createReducer(nil, {
	setTooltipText = function(p1, p2)
		local table2 = table.clone(p1 or {})
		table2.text = p2.value
		return table2
	end,
	setTooltipVisible = function(p1, p2)
		local table2 = table.clone(p1 or {})
		table2.visible = p2.value
		return table2
	end
})
