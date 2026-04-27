local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	PLAY_REMOTE_NAME = "PlayRemote",
	SONG_ID_ATTR_NAME = "SongId",
	STARTED_AT_ATTR_NAME = "StartedAt"
})
