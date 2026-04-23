local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store = require(ReplicatedStorage.App.store)
local SaleShared = require(script.Parent.SaleShared)
return {
	init = function() --[[ Name: init | Line: 6 | Upvalues: SaleShared (copy), store (copy) ]]
		SaleShared.onSaleRefresh:Connect(function() --[[ Line: 7 | Upvalues: store (ref) ]]
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