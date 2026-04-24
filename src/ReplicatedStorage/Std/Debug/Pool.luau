-- Reviewed by Claude
local t = {}
t.__index = t
function t.new(p1, p2)
	local t2 = {}
	setmetatable(t2, t)
	t2._pool = {}
	t2._getInst = p1
	t2._destroyInst = p2
	return t2
end
function t.Get(p1)
	if #p1._pool > 0 then
		return table.remove(p1._pool)
	else
		return p1._getInst()
	end
end
function t.Populate(p1, p2)
	for i = 1, p2 do
		p1:Free((p1._getInst()))
	end
end
function t.Free(p1, p2)
	table.insert(p1._pool, p2)
end
function t.Destroy(p1)
	for i, v in ipairs(p1._pool) do
		p1._destroyInst(v)
	end
	p1._pool = nil
end
return t
