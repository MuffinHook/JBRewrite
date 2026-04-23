local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	BEING_TARGETED_REMOTE_NAME = "BeingTargeted"
})