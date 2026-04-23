local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store = require(ReplicatedStorage.App.store)
local TooltipConsts = require(script.Parent.TooltipConsts)
local TooltipData = require(script.Parent.TooltipData)
local Interval = require(ReplicatedStorage.Std.Interval)
return {
	init = function() --[[ Name: init | Line: 8 | Upvalues: TooltipData (copy), store (copy), Interval (copy), TooltipConsts (copy) ]]
		local v1 = #TooltipData
		local v2 = math.random(v1)
		local function setTooltipConfig() --[[ Line: 11 | Upvalues: store (ref), TooltipData (ref), v2 (ref), v1 (copy) ]]
			store:dispatch({
				type = "setTooltipText",
				value = TooltipData[v2]
			})
			v2 = v2 % v1 + 1
		end
		Interval.every(TooltipConsts.TOOLTIP_CYCLE_INTERVAL):Connect(setTooltipConfig)
		store:dispatch({
			type = "setTooltipText",
			value = TooltipData[v2]
		})
		v2 = v2 % v1 + 1
	end
}