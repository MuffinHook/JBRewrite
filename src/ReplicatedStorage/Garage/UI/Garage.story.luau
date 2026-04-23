local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 6 | Upvalues: Roact (copy), ReplicatedStorage (copy), Maid (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	store:dispatch({
		type = "setLocalVehiclePacket",
		packet = {
			Model = ReplicatedStorage.Resource.Vehicles.Chiron:Clone(),
			Make = "Chiron",
			Type = "Chassis"
		}
	})
	store:dispatch({
		type = "setSort",
		id = 3
	})
	store:dispatch({
		type = "setPage",
		pageName = "Customize",
		categoryName = "Texture",
		sortId = store:getState().garageSort
	})
	store:dispatch({
		type = "setInVehicle",
		inVehicle = true
	})
	store:dispatch({
		type = "setInPhysical",
		inPhysical = true
	})
	for i = 1, 11 do
		store:dispatch({
			type = "addReceiptItem",
			name = "name" .. tostring(i),
			title = "title" .. tostring(i),
			category = "category" .. tostring(i),
			categoryTitle = "categoryTitle" .. tostring(i)
		})
	end
	function v1.init(p1) --[[ Line: 49 | Upvalues: Maid (ref) ]]
		p1.maid = Maid.new()
	end
	local v2 = os.clock()
	function v1.render(p1) --[[ Line: 53 | Upvalues: Roact (ref), RoactRodux (ref), store (copy), v2 (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(require(script.Parent.Garage), {
				disabled = false,
				attemptBuyItem = function(p1, p2) --[[ Name: attemptBuyItem | Line: 59 | Upvalues: store (ref) ]]
					store:dispatch({
						type = "setCategoryItemOwned",
						category = p1,
						name = p2
					})
				end,
				getRemainingDebounce = function() --[[ Name: getRemainingDebounce | Line: 66 | Upvalues: v2 (ref) ]]
					return 10 - (os.clock() - v2)
				end,
				colsPerRow = 7,
				rowsPerPage = 2.5
			}) })
	end
	function v1.willUnmount(p1) --[[ Line: 74 ]]
		p1.maid:Destroy()
	end
	local v3 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 79 | Upvalues: Roact (ref), v3 (copy) ]]
		Roact.unmount(v3)
	end
end