local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "HotbarItem",
	ON_HOTBAR_ATTR_NAME = "OnHotbar",
	IMAGE_SRC_ATTR_NAME = "HotbarImageSrc",
	DISPLAY_ORDER_ATTR_NAME = "DisplayOrder",
	MIN_DRAG_DURATION = 0.15
})