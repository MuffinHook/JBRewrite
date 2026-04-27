local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(storyTarget)
	local AppComponent = Roact.Component:extend("App")
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
	function AppComponent.init(self)
		self.maid = Maid.new()
	end
	local initialTime = os.clock()
	function AppComponent.render(self)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(require(script.Parent.Garage), {
				disabled = false,
				attemptBuyItem = function(category, itemName)
					store:dispatch({
						type = "setCategoryItemOwned",
						category = category,
						name = itemName
					})
				end,
				getRemainingDebounce = function()
					return 10 - (os.clock() - initialTime)
				end,
				colsPerRow = 7,
				rowsPerPage = 2.5
			}) })
	end
	function AppComponent.willUnmount(self)
		self.maid:Destroy()
	end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), storyTarget)
	return function()
		Roact.unmount(mountedComponent)
	end
end
