return require(game:GetService("ReplicatedStorage").Std.TableUtils).requireValidIndexAndFreeze({
    UPDATE_PERSISTENT_CREW_REMOTE_NAME = "UpdatePersistentCrewRemote";
    VIEWING_CLAN_ID_ATTR_NAME = "ViewingClanId";
    CURRENT_CLAN_ID_ATTR_NAME = "CurrentClanId";
    VIEW_CLAN_REMOTE_NAME = "PersistentCrewViewClan";
    INFORM_UI_IS_OPEN_REMOTE_NAME = "PersistentCrewInformUIIsOpenRemote";
    HAS_RECEIVED_PERSISTENT_CREW_ACCESS_ATTR_NAME = "HasReceivedPersistentCrewAccess";
    HAS_RECEIVED_PERSISTENT_CREW_ACCESS_FLAG = "ReceivedPersistentCrewAccess";
})