-- Reviewed by Claude
-- variables reassigned
local t = {
	getAll = function(itemsCollection, player)
		assert(itemsCollection ~= nil)
		assert(player ~= nil)
		local t = {}
		for i, item in ipairs(itemsCollection:GetAll()) do
			if item:GetOwner() == player then
				table.insert(t, item)
			end
		end
		return t
	end,
	getPool = function(itemsCollection, player)
		assert(itemsCollection ~= nil)
		assert(player ~= nil)
		local t = {}
		for i, item in ipairs(itemsCollection:GetAll()) do
			if item:GetOwner() == player and item:IsInPool() then
				table.insert(t, item)
			end
		end
		return t
	end
}
function t.cleanPool(itemsCollection, player)
	local poolItems = t.getPool(itemsCollection, player)
	print(("removing %d items from pool %s"):format(#poolItems, player.Name))
	for i, item in ipairs(poolItems) do
		item._obj:Destroy()
	end
end
return t
