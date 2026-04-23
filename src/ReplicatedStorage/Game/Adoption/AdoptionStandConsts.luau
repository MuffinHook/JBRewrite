local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "DogAdopt",
	BREED_ID_VALUE_NAME = "BreedId",
	DOG_NAME_VALUE_NAME = "DogName",
	ADOPT_REMOTE_NAME = "AdoptRemote",
	DOGS_OWNED_VALUE_NAME = "DogsOwned"
})