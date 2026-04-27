local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store = require(ReplicatedStorage.App.store)
local SaleShared = require(script.Parent.SaleShared)
return {
	init = function()
		SaleShared.onSaleRefresh:Connect(function()
			local currentState = store:getState()
			store:dispatch({
				type = "setPage",
				pageName = currentState.garagePage,
				categoryName = currentState.garageCategory,
				sortId = currentState.garageSort
			})
		end)
	end
}
