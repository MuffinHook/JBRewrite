-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local NetObjPoolItemBinder = require(ReplicatedStorage.NetObjPool.NetObjPoolItemBinder)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	return v1
end
function t.Get(p1)
	local result = nil
	for _, poolItem in NetObjPoolItemBinder:GetAll() do
		if poolItem:GetPoolObj() == p1.obj and poolItem:GetActive() == true then
			result = poolItem
			break
		end
	end
	if not result then
		error("Nothing exists in this pool...")
	end
	return result
end
return Binder.new("NetObjPool", t)
