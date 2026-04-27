local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "TopCrewBuilding",
	RANK_ATTR_NAME = "CrewRank",
	UPDATE_FREQUENCY = 30
})
