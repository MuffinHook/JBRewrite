-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local Safes = require(script.Parent.Safes)
	function v1.init(p1)
		store:dispatch({
			type = "setSafesInventoryItems",
			itemsOwned = {
				{
					Id = "a1",
					ItemType = "Safe",
					TypeEnum = 1
				},
				{
					Id = "a2",
					ItemType = "Safe",
					TypeEnum = 1
				},
				{
					Id = "a3",
					ItemType = "Safe",
					TypeEnum = 1
				},
				{
					Id = "a4",
					ItemType = "Safe",
					TypeEnum = 2
				},
				{
					Id = "a5",
					ItemType = "Safe",
					TypeEnum = 1
				},
				{
					Id = "a6",
					ItemType = "Safe",
					TypeEnum = 2
				},
				{
					Id = "a7",
					ItemType = "Safe",
					TypeEnum = 1
				},
				{
					Id = "a8",
					ItemType = "Safe",
					TypeEnum = 1
				},
				{
					Id = "a9",
					ItemType = "Safe",
					TypeEnum = 1
				}
			}
		})
		store:dispatch({
			type = "setSafesOpen",
			value = true
		})
	end
	function v1.render(p1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(Safes, {
				size = UDim2.new(0.9, 0, 0.9, 0),
				position = UDim2.new(0.5, 0, 0.5, 0),
				anchorPoint = Vector2.new(0.5, 0.5),
				policyCashAvailable = 100000000
			}) })
	end
	function v1.willUnmount(p1)  end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
