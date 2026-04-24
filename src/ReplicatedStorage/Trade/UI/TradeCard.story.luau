-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(p1)
	local v1 = Roact.Component:extend("App")
	local TradeCard = require(script.Parent.TradeCard)
	function v1.init(p1)  end
	function v1.render(p1)
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
	function v1.willUnmount(p1)  end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
