-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store = require(ReplicatedStorage.App.store)
local SaleShared = require(script.Parent.SaleShared)
return {
	init = function()
		SaleShared.onSaleRefresh:Connect(function()
			local v1 = store:getState()
			store:dispatch({
				type = "setPage",
				pageName = v1.garagePage,
				categoryName = v1.garageCategory,
				sortId = v1.garageSort
			})
		end)
	end
}
