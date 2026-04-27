local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(rootParent)
	local AppComponent = Roact.Component:extend("App")
	local TradeCard = require(script.Parent.TradeCard)
	function AppComponent.init(self)  end
	function AppComponent.render(self)
		return Roact.createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}, {
			Card = createElement(TradeCard, {
				aspectRatio = 0.8,
				season = 3,
				level = 5,
				itemType = "VehicleCustomization",
				title = "winter camo",
				categoryTitle = "Texture",
				info = {
					{
						title = "Original Owner",
						value = "badcc"
					},
					{
						title = "Times Traded",
						value = "15"
					},
					{
						title = "Created At",
						value = DateTime.now():FormatLocalTime("ll", "en-us")
					}
				},
				onCardFlipped = function()
					print("flipped!")
				end
			}),
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 0.8
			})
		})
	end
	function AppComponent.willUnmount(self)  end
	local mountedInstance = Roact.mount(Roact.createElement(AppComponent), rootParent)
	return function()
		Roact.unmount(mountedInstance)
	end
end
