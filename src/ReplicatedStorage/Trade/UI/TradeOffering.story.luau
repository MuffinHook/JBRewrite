local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
require(ReplicatedStorage.RoactRodux)
local TradeReducerUtils = require(ReplicatedStorage.Trade.TradeReducerUtils)
return function(storybook)
	local AppComponent = Roact.Component:extend("App")
	local TradeOffering = require(script.Parent.TradeOffering)
	function AppComponent.init(self)
		self:setState({
			traderMeReady = false,
			traderThemReady = false,
			traderMeAccepted = false
		})
		self.traderMeOfferItems = { TradeReducerUtils.buildItemProps({
				Id = "a1",
				ItemType = "VehicleCustomization",
				CategoryName = "Spoiler",
				ItemName = "Deathtrap"
			}), TradeReducerUtils.buildItemProps({
				Id = "a2",
				ItemType = "Vehicle",
				Make = "Chiron"
			}), TradeReducerUtils.buildItemProps({
				Id = "a3",
				ItemType = "Vehicle",
				Make = "Sentinel"
			}) }
		self.traderThemOfferItems = { TradeReducerUtils.buildItemProps({
				Id = "b1",
				ItemType = "Vehicle",
				Make = "Torpedo"
			}) }
	end
	function AppComponent.render(self)
		return Roact.createElement(TradeOffering, {
			size = UDim2.new(0.75, 0, 0.75, 0),
			traderMe = {
				userId = 2025110,
				displayName = "badcc",
				ready = self.state.traderMeReady,
				accepted = self.state.traderMeAccepted,
				offerItems = self.traderMeOfferItems
			},
			traderThem = {
				userId = 2837719,
				displayName = "asimo3089",
				ready = self.state.traderThemReady,
				offerItems = self.traderThemOfferItems
			},
			onClickReady = function()
				self:setState({
					traderMeReady = true
				})
				task.delay(0.2 + 0.5 * math.random(), function()
					self:setState({
						traderThemReady = true
					})
				end)
			end,
			onClickUnready = function()
				self:setState({
					traderMeReady = false
				})
			end,
			onClickAccept = function()
				self:setState({
					traderMeAccepted = true
				})
			end,
			onClickExit = function()
				self:setState({
					traderMeAccepted = false,
					traderMeReady = false,
					traderThemReady = false
				})
			end
		})
	end
	function AppComponent.willUnmount(self)  end
	local roactHandle = Roact.mount(Roact.createElement(AppComponent), storybook)
	return function()
		Roact.unmount(roactHandle)
	end
end
