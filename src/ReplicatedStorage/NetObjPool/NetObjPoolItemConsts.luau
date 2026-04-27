local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	POOL_OBJ_PTR_NAME = "NetObjPoolItemPoolObjPtr",
	ACTIVE_OBJ_NAME = "NetObjActive"
})
