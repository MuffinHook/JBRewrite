-- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local var10 = 1
if require(ReplicatedStorage.App.RunUtils).getEnv() == require(ReplicatedStorage.App.RunConsts).PROD_NAME then
    var10 = 259200
end
local tbl = {{
    name = "Sky";
    color = Color3.fromRGB(41, 171, 255);
    buildingColor = Color3.fromRGB(0, 100, 177);
}, {
    name = "Mint";
    color = Color3.fromRGB(41, 255, 161);
    buildingColor = Color3.fromRGB(0, 158, 142);
}, {
    name = "Yellow";
    color = Color3.fromRGB(255, 197, 41);
    buildingColor = Color3.fromRGB(168, 149, 71);
}, {
    name = "Orange";
    color = Color3.fromRGB(250, 113, 45);
    buildingColor = Color3.fromRGB(187, 118, 58);
}, {
    name = "Red";
    color = Color3.fromRGB(255, 64, 41);
    buildingColor = Color3.fromRGB(149, 71, 62);
}, {
    name = "Purple";
    color = Color3.fromRGB(112, 41, 255);
    buildingColor = Color3.fromRGB(113, 72, 167);
}, {
    name = "Pink";
    color = Color3.fromRGB(255, 41, 235);
    buildingColor = Color3.fromRGB(173, 115, 143);
}, {
    name = "Black";
    color = Color3.fromRGB(44, 44, 44);
    buildingColor = Color3.fromRGB(70, 70, 76);
}}
local tbl_2 = {}
for _, v in tbl do
    ({})[v.name] = v
    tbl_2[v.color:ToHex()] = v.buildingColor
    local var22
end
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
    CURR_CLAN_DATA_VERSION = 3;
    CLAN_JOIN_COOLDOWN_DURATION = var10;
    MAX_MEMBERS = 25;
    MAX_CLAN_NAME_LENGTH = 24;
    PLAYER_ONLINE_MEMORY_STORE_EXPIRATION_TIME = 300;
    CLAN_CREATION_COST = 25000;
    CLAN_RENAME_COST = 25000;
    CREATE_CLAN_REMOTE_NAME = "CreateClan";
    REQUEST_JOIN_CLAN_REMOTE_NAME = "RequestJoinClan";
    ACCEPT_JOIN_REQUEST_REMOTE_NAME = "AcceptClanJoinRequest";
    DENY_JOIN_REQUEST_REMOTE_NAME = "DenyClanJoinRequest";
    LEAVE_CLAN_REMOTE_NAME = "LeaveClan";
    REMOVE_PLAYER_FROM_CLAN_REMOTE_NAME = "RemovePlayerFromClan";
    ADD_PLAYER_AS_ADMIN_REMOTE_NAME = "AddPlayerAsAdmin";
    REMOVE_PLAYER_ADMIN_REMOTE_NAME = "RemovePlayerAdmin";
    UPDATE_CLAN_FLAG_COLOR_REMOTE_NAME = "UpdateClanFlagColor";
    RENAME_CLAN_REMOTE_NAME = "RenameClan";
    NETWORK_MUTEX_LOCKED_ATTR_NAME = "ClanNetworkMutexLocked";
    MEMBERS_ONLINE_OBJECT_NAME = "ClanPlayersOnline";
    CURRENT_CLAN_ID_ATTR_NAME = "CurrentClanId";
    IS_PLAYER_CLAN_ADMIN_CACHED_ATTR_NAME = "IsPlayerClanAdminCached";
    CLAN_COLORS = tbl;
    MAP_NAME_TO_CLAN_COLOR = var22;
    MAP_CLAN_COLOR_HEX_TO_BUILDING_COLOR = tbl_2;
})