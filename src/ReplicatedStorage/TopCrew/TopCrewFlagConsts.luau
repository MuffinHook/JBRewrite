return require(game:GetService("ReplicatedStorage").Std.TableUtils).requireValidIndexAndFreeze({
    TAG_NAME = "TopCrewFlag";
    RANK_ATTR_NAME = "CrewRank";
    UPDATE_FREQUENCY = 30;
})