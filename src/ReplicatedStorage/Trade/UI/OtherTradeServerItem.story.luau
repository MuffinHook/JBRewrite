-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local OtherTradeServerUIData = require(ReplicatedStorage.Trade.Test.OtherTradeServerUIData)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local OtherTradeServerItem = require(script.Parent.OtherTradeServerItem)
	function v1.init(p1)  end
	function v1.render(p1)
		local v1 = OtherTradeServerUIData.otherTradeServerInfo[1]
		v1.size = UDim2.fromScale(0.8, 0.1)
		v1.verticalPaddingRatio = 128
		v1.aspectRatio = 1.7777777777777777
		return Roact.createElement(OtherTradeServerItem, v1, {
			Aspect = Roact.createElement("UIAspectRatioConstraint", {
				AspectRatio = 8
			})
		})
	end
	function v1.willUnmount(p1)  end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
