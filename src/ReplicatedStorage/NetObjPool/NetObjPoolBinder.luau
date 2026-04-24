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
	local v1 = nil
	for v2, v3 in NetObjPoolItemBinder:GetAll() do
		if v3:GetPoolObj() == p1.obj and v3:GetActive() == true then
			v1 = v3
			break
		end
	end
	if not v1 then
		error("Nothing exists in this pool...")
	end
	return v1
end
return Binder.new("NetObjPool", t)
