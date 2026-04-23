local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
require(ReplicatedStorage.RoactRodux)
local TradeReducerUtils = require(ReplicatedStorage.Trade.TradeReducerUtils)
return function(p1) --[[ Line: 6 | Upvalues: Roact (copy), TradeReducerUtils (copy) ]]
	local v1 = Roact.Component:extend("App")
	local TradeOffering = require(script.Parent.TradeOffering)
	function v1.init(p1) --[[ Line: 9 | Upvalues: TradeReducerUtils (ref) ]]
		p1:setState({
			traderMeReady = false,
			traderThemReady = false,
			traderMeAccepted = false
		})
		p1.traderMeOfferItems = { TradeReducerUtils.buildItemProps({
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
		p1.traderThemOfferItems = { TradeReducerUtils.buildItemProps({
				Id = "b1",
				ItemType = "Vehicle",
				Make = "Torpedo"
			}) }
	end
	function v1.render(p1) --[[ Line: 41 | Upvalues: Roact (ref), TradeOffering (copy) ]]
		return Roact.createElement(TradeOffering, {
			size = UDim2.new(0.75, 0, 0.75, 0),
			traderMe = {
				userId = 2025110,
				displayName = "badcc",
				ready = p1.state.traderMeReady,
				accepted = p1.state.traderMeAccepted,
				offerItems = p1.traderMeOfferItems
			},
			traderThem = {
				userId = 2837719,
				displayName = "asimo3089",
				ready = p1.state.traderThemReady,
				offerItems = p1.traderThemOfferItems
			},
			onClickReady = function() --[[ Name: onClickReady | Line: 57 | Upvalues: p1 (copy) ]]
				p1:setState({
					traderMeReady = true
				})
				task.delay(0.2 + 0.5 * math.random(), function() --[[ Line: 61 | Upvalues: p1 (ref) ]]
					p1:setState({
						traderThemReady = true
					})
				end)
			end,
			onClickUnready = function() --[[ Name: onClickUnready | Line: 67 | Upvalues: p1 (copy) ]]
				p1:setState({
					traderMeReady = false
				})
			end,
			onClickAccept = function() --[[ Name: onClickAccept | Line: 72 | Upvalues: p1 (copy) ]]
				p1:setState({
					traderMeAccepted = true
				})
			end,
			onClickExit = function() --[[ Name: onClickExit | Line: 77 | Upvalues: p1 (copy) ]]
				p1:setState({
					traderMeAccepted = false,
					traderMeReady = false,
					traderThemReady = false
				})
			end
		})
	end
	function v1.willUnmount(p1) --[[ Line: 86 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 89 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end