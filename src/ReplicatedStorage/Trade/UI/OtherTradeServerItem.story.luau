local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local OtherTradeServerUIData = require(ReplicatedStorage.Trade.Test.OtherTradeServerUIData)
return function(mountTarget)
	local App = Roact.Component:extend("App")
	local OtherTradeServerItem = require(script.Parent.OtherTradeServerItem)
	function App.init(self)  end
	function App.render(self)
		local tradeItemData = OtherTradeServerUIData.otherTradeServerInfo[1]
		tradeItemData.size = UDim2.fromScale(0.8, 0.1)
		tradeItemData.verticalPaddingRatio = 128
		tradeItemData.aspectRatio = 16/9
		return Roact.createElement(OtherTradeServerItem, tradeItemData, {
			Aspect = Roact.createElement("UIAspectRatioConstraint", {
				AspectRatio = 8
			})
		})
	end
	function App.willUnmount(self)  end
	local mountedInstance = Roact.mount(Roact.createElement(App), mountTarget)
	return function()
		Roact.unmount(mountedInstance)
	end
end
