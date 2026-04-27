local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local NetObjPoolItemBinder = require(ReplicatedStorage.NetObjPool.NetObjPoolItemBinder)
local NetObjPoolBinder = {}
NetObjPoolBinder.__index = NetObjPoolBinder
setmetatable(NetObjPoolBinder, BaseObject)
function NetObjPoolBinder.new(baseObject)
	local instance = BaseObject.new(baseObject)
	setmetatable(instance, NetObjPoolBinder)
	return instance
end
function NetObjPoolBinder.Get(netObject)
	local result = nil
	for _, poolItem in NetObjPoolItemBinder:GetAll() do
		if poolItem:GetPoolObj() == netObject.obj and poolItem:GetActive() == true then
			result = poolItem
			break
		end
	end
	if not result then
		error("Nothing exists in this pool...")
	end
	return result
end
return Binder.new("NetObjPool", NetObjPoolBinder)
