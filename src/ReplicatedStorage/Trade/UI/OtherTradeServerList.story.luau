local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Clan.ClanConsts)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 6 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local OtherTradeServerList = require(script.Parent.OtherTradeServerList)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	local OtherTradeServerUIData = require(ReplicatedStorage.Trade.Test.OtherTradeServerUIData)
	function v1.init(p1) --[[ Line: 11 | Upvalues: OtherTradeServerUIData (copy) ]]
		p1.aspectRatio = 1.5
		p1.otherTradeServerInfo = OtherTradeServerUIData.otherTradeServerInfo
	end
	function v1.render(p1) --[[ Line: 16 | Upvalues: Roact (ref), RoactRodux (ref), persistentCrewStore (copy), OtherTradeServerList (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement("Frame", {
				Size = UDim2.fromScale(1, 1)
			}, {
				x = Roact.createElement(OtherTradeServerList, {
					otherTradeServerInfo = p1.otherTradeServerInfo,
					onJoinOtherTradeServer = function(p1) --[[ Name: onJoinOtherTradeServer | Line: 25 ]]
						print("CLICK.. join server id", p1)
					end,
					aspectRatio = p1.aspectRatio,
					visible = true,
					size = UDim2.fromScale(1, 1),
					position = UDim2.fromScale(0.5, 0.5)
				}),
				Aspect = Roact.createElement("UIAspectRatioConstraint", {
					AspectRatio = p1.aspectRatio
				})
			}) })
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 41 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end