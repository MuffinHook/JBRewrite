-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndex({
	SPECTATE_REMOTE_NAME = "Spectate",
	SPECTATE_OTHER_REMOTE_NAME = "SpectateOther",
	SHOW_SPECTATE_ATTR_NAME = "ShouldShowSpectate",
	SPECTATE_TAG_NAME = "Spectatable"
})
