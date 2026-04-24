-- Reviewed by Claude
local t = {
	getAll = function(p1, p2)
		assert(p1 ~= nil)
		assert(p2 ~= nil)
		local t = {}
		for i, v in ipairs(p1:GetAll()) do
			if v:GetOwner() == p2 then
				table.insert(t, v)
			end
		end
		return t
	end,
	getPool = function(p1, p2)
		assert(p1 ~= nil)
		assert(p2 ~= nil)
		local t = {}
		for i, v in ipairs(p1:GetAll()) do
			if v:GetOwner() == p2 and v:IsInPool() then
				table.insert(t, v)
			end
		end
		return t
	end
}
function t.cleanPool(p1, p2)
	local v1 = t.getPool(p1, p2)
	print(("removing %d items from pool %s"):format(#v1, p2.Name))
	for i, v in ipairs(v1) do
		v._obj:Destroy()
	end
end
return t
