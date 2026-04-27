local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store = require(ReplicatedStorage.App.store)
local TooltipConsts = require(script.Parent.TooltipConsts)
local TooltipData = require(script.Parent.TooltipData)
local Interval = require(ReplicatedStorage.Std.Interval)
return {
	init = function()
		local tooltipCount = #TooltipData
		local currentTooltipIndex = math.random(tooltipCount)
		local function setTooltipConfig()
			store:dispatch({
				type = "setTooltipText",
				value = TooltipData[currentTooltipIndex]
			})
			currentTooltipIndex = currentTooltipIndex % tooltipCount + 1
		end
		Interval.every(TooltipConsts.TOOLTIP_CYCLE_INTERVAL):Connect(setTooltipConfig)
		store:dispatch({
			type = "setTooltipText",
			value = TooltipData[currentTooltipIndex]
		})
		currentTooltipIndex = currentTooltipIndex % tooltipCount + 1
	end
}
