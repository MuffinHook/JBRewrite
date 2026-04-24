-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	EQUIP_ITEM_REMOTE_NAME = "GarageEquipItem",
	PURCHASE_ITEM_REMOTE_NAME = "GaragePurchaseItem",
	PURCHASE_VEHICLE_REMOTE_NAME = "GaragePurchaseVehicle",
	SLOT_SAVE_REMOTE_NAME = "GarageSlotSave",
	SLOT_DELETE_REMOTE_NAME = "GarageSlotDelete",
	SLOT_LOAD_REMOTE_NAME = "GarageSlotLoad",
	SPAWN_VEHICLE_REMOTE_NAME = "GarageSpawnVehicle",
	LOAD_LAST_SELECTION_REMOTE_NAME = "GarageLoadLastSelection",
	UPDATE_OWNED_REMOTE_NAME = "GarageUpdateOwned",
	UPDATE_EQUIPPED_REMOTE_NAME = "GarageUpdateEquipped",
	UPDATE_FAVORITED_REMOTE_NAME = "GarageUpdateFavorited",
	SET_IN_PHYSICAL_REMOTE_NAME = "GarageSetInPhysical",
	INFORM_UI_IS_OPEN_REMOTE_NAME = "GarageSetUIOpen",
	FILL_POPULAR_SORT_REMOTE_NAME = "GarageFillPopularSort",
	PIXEL_PARTICLE_EMITTER_NAME = "BetaPixelTextureParticleEmitter",
	AERIAL_SPAWN_ATTR_NAME = "AerialSpawningActive"
})
