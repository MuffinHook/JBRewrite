local Pool = {}
Pool.__index = Pool
function Pool.new(getInstanceFunction, destroyInstanceFunction)
	local poolInstance = {}
	setmetatable(poolInstance, Pool)
	poolInstance._pool = {}
	poolInstance._getInst = getInstanceFunction
	poolInstance._destroyInst = destroyInstanceFunction
	return poolInstance
end
function Pool.Get(poolInstance)
	if #poolInstance._pool > 0 then
		return table.remove(poolInstance._pool)
	else
		return poolInstance._getInst()
	end
end
function Pool.Populate(poolInstance, count)
	for i = 1, count do
		poolInstance:Free((poolInstance._getInst()))
	end
end
function Pool.Free(poolInstance, instance)
	table.insert(poolInstance._pool, instance)
end
function Pool.Destroy(poolInstance)
	for i, pooledInstance in ipairs(poolInstance._pool) do
		poolInstance._destroyInst(pooledInstance)
	end
	poolInstance._pool = nil
end
return Pool
