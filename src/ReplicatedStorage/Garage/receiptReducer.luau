-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
	addReceiptItem = function(p1, p2)
		assert(p2.name ~= nil, "missing receipt item Name")
		assert(p2.title ~= nil, "missing receipt item Title")
		assert(p2.category ~= nil, "missing receipt item Category")
		assert(p2.categoryTitle ~= nil, "missing receipt item CategoryTitle")
		local t = {}
		for i = 1, #p1 do
			local v5 = p1[i]
			if v5.category ~= p2.category then
				table.insert(t, v5)
			end
		end
		local t2 = {}
		for k, v in pairs(p2) do
			if k ~= "type" then
				t2[k] = v
			end
		end
		table.insert(t, t2)
		return t
	end,
	removeReceiptItem = function(p1, p2)
		assert(p2.name ~= nil, "missing receipt item Name")
		assert(p2.category ~= nil, "missing receipt item Category")
		local t = {}
		for i = 1, #p1 do
			local v3 = p1[i]
			if v3.name ~= p2.name or v3.category ~= p2.category then
				table.insert(t, v3)
			end
		end
		return t
	end,
	removeReceiptCategory = function(p1, p2)
		assert(p2.category ~= nil, "missing receipt item Category")
		local t = {}
		for i = 1, #p1 do
			local v2 = p1[i]
			if v2.category ~= p2.category then
				table.insert(t, v2)
			end
		end
		return t
	end,
	clearReceipt = function()
		return {}
	end,
	setPage = function()
		return {}
	end
})
