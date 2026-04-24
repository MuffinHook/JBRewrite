-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local SaleConsts = require(ReplicatedStorage.Sale.SaleConsts)
return Rodux.createReducer(SaleConsts.CATEGORY_NAME, {
	setCategory = function(p1, p2)
		assert(p2.categoryName ~= nil, "missing category Name")
		return p2.categoryName
	end,
	setPage = function(p1, p2)
		if p2.categoryName then
			return p2.categoryName
		else
			return p1
		end
	end
})
