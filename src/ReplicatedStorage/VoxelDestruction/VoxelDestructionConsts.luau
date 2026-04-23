local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	VOXEL_INDESTRUCTIBLE_TAG_NAME = "VoxelIndestructible",
	VOXEL_SIZE_ATTR_NAME = "MinVoxelSize"
})