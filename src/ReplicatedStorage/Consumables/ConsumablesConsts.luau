local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	UPDATE_CONSUMABLES_REMOTE_NAME = "UpdateConsumables"
})
