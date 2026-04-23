local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "OwnedPart",
	NETWORK_OWNER_ID_VALUE_NAME = "NetworkOwnerId"
})