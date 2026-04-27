local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	NO_MOVEMENT_ATTR_NAME = "NoMovement"
})
