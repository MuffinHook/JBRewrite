-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	addReceiptItem = function(state, action)
		assert(action.name ~= nil, "missing receipt item Name")
		assert(action.title ~= nil, "missing receipt item Title")
		assert(action.category ~= nil, "missing receipt item Category")
		assert(action.categoryTitle ~= nil, "missing receipt item CategoryTitle")
		local newState = {}
		for i = 1, #state do
			local receiptItem = state[i]
			if receiptItem.category ~= action.category then
				table.insert(newState, receiptItem)
			end
		end
		local newReceiptItem = {}
		for k, v in pairs(action) do
			if k ~= "type" then
				newReceiptItem[k] = v
			end
		end
		table.insert(newState, newReceiptItem)
		return newState
	end,
	removeReceiptItem = function(state, action)
		assert(action.name ~= nil, "missing receipt item Name")
		assert(action.category ~= nil, "missing receipt item Category")
		local newState = {}
		for i = 1, #state do
			local receiptItem = state[i]
			if receiptItem.name ~= action.name or receiptItem.category ~= action.category then
				table.insert(newState, receiptItem)
			end
		end
		return newState
	end,
	removeReceiptCategory = function(state, action)
		assert(action.category ~= nil, "missing receipt item Category")
		local newState = {}
		for i = 1, #state do
			local receiptItem = state[i]
			if receiptItem.category ~= action.category then
				table.insert(newState, receiptItem)
			end
		end
		return newState
	end,
	clearReceipt = function()
		return {}
	end,
	setPage = function()
		return {}
	end
})
