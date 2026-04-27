local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local SaleConsts = require(ReplicatedStorage.Sale.SaleConsts)
return Rodux.createReducer(SaleConsts.CATEGORY_NAME, {
	setCategory = function(state, action)
		assert(action.categoryName ~= nil, "missing category Name")
		return action.categoryName
	end,
	setPage = function(state, action)
		if action.categoryName then
			return action.categoryName
		else
			return state
		end
	end
})
