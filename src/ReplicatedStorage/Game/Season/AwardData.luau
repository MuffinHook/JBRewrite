local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeasonConsts_upvr = require(ReplicatedStorage.Game.Season.SeasonConsts)
local module = {}
local tbl_5_upvr = {}
module.Level = tbl_5_upvr
local tbl_6_upvr = {}
module.Bonus = tbl_6_upvr
local function gatherStoreData(arg1, arg2) -- Line 10
    for _, v in arg2 do
        if v.Season then
            local SEASON_NUM_3 = SeasonConsts_upvr.SEASON_NUM
            if v.Season == SEASON_NUM_3 then
                if not v.SeasonIconId then
                    SEASON_NUM_3 = v
                    print(SEASON_NUM_3)
                    SEASON_NUM_3 = "Missing SeasonIconId for: %s:^":format(arg1)
                    error(SEASON_NUM_3)
                end
                if 0 >= v.SeasonIconId then
                    SEASON_NUM_3 = false
                else
                    SEASON_NUM_3 = true
                end
                assert(SEASON_NUM_3, "missing SeasonIconId value")
                local tbl = {}
                tbl.type = arg1
                SEASON_NUM_3 = v.Name
                if not SEASON_NUM_3 then
                    SEASON_NUM_3 = v.Make
                end
                tbl.name = SEASON_NUM_3
                SEASON_NUM_3 = v.SeasonIconId
                tbl.imageId = SEASON_NUM_3
                SEASON_NUM_3 = v.Level
                if SEASON_NUM_3 then
                    SEASON_NUM_3 = tbl_5_upvr
                    SEASON_NUM_3[v.Level] = tbl
                else
                    SEASON_NUM_3 = v.TopPct
                    local var21
                    if SEASON_NUM_3 then
                        if #tbl_6_upvr ~= 0 then
                            var21 = false
                        else
                            var21 = true
                        end
                        SEASON_NUM_3 = assert
                        SEASON_NUM_3(var21, "a bonus already exists")
                        var21 = v.TopPct
                        SEASON_NUM_3 = var21 / 100
                        tbl.scoreLte = SEASON_NUM_3
                        var21 = false
                        if 0 < tbl.scoreLte then
                            if tbl.scoreLte > 1 then
                                var21 = false
                            else
                                var21 = true
                            end
                        end
                        SEASON_NUM_3 = assert
                        SEASON_NUM_3(var21, "invalid TopPct")
                        SEASON_NUM_3 = tbl_6_upvr
                        SEASON_NUM_3[1] = tbl
                    else
                        SEASON_NUM_3 = warn
                        var21 = v
                        SEASON_NUM_3(var21)
                        SEASON_NUM_3 = error
                        var21 = "Missing Level or TopPct"
                        SEASON_NUM_3(var21)
                    end
                end
            end
        end
    end
end
gatherStoreData("Spoiler", require(ReplicatedStorage.Game.Garage.StoreData.Spoiler).Items)
gatherStoreData("Rim", require(ReplicatedStorage.Game.Garage.StoreData.Rim).Items)
gatherStoreData("VehicleTexture", require(ReplicatedStorage.Game.Garage.StoreData.Texture).Items)
gatherStoreData("TireSticker", require(ReplicatedStorage.Game.Garage.StoreData.TireSticker).Items)
gatherStoreData("TireMesh", require(ReplicatedStorage.Game.Garage.StoreData.TireMesh).Items)
gatherStoreData("Vehicle", require(ReplicatedStorage.Game.Garage.VehicleData))
gatherStoreData("ItemSkin", require(ReplicatedStorage.Game.ItemSkin.ItemSkinList))
gatherStoreData("Horn", require(ReplicatedStorage.Game.Garage.StoreData.Horn).Items)
gatherStoreData("Color", require(ReplicatedStorage.Game.Garage.StoreData.Color).Items)
gatherStoreData("Drift", require(ReplicatedStorage.Game.Garage.StoreData.Drift).Items)
;(function(arg1, arg2) -- Line 37, Named "gatherModelData"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    for _, v_2 in arg2:GetChildren() do
        local Season_2 = v_2:FindFirstChild("Season")
        local Level = v_2:FindFirstChild("Level")
        local TopPct_2 = v_2:FindFirstChild("TopPct")
        local SeasonIconId = v_2:FindFirstChild("SeasonIconId")
        if Season_2 then
            local SEASON_NUM_2 = SeasonConsts_upvr.SEASON_NUM
            if Season_2.Value == SEASON_NUM_2 then
                if not SeasonIconId then
                    SEASON_NUM_2 = "Missing SeasonIconId for %s:%s":format(arg1, v_2.Name)
                    error(SEASON_NUM_2)
                end
                if 0 >= SeasonIconId.Value then
                    SEASON_NUM_2 = false
                else
                    SEASON_NUM_2 = true
                end
                assert(SEASON_NUM_2, "missing SeasonIconId value")
                local tbl_3 = {}
                tbl_3.type = arg1
                SEASON_NUM_2 = v_2.Name
                tbl_3.name = SEASON_NUM_2
                SEASON_NUM_2 = SeasonIconId.Value
                tbl_3.imageId = SEASON_NUM_2
                if Level then
                    SEASON_NUM_2 = tbl_5_upvr
                    SEASON_NUM_2[Level.Value] = tbl_3
                    local var57
                elseif TopPct_2 then
                    if #tbl_6_upvr ~= 0 then
                        var57 = false
                    else
                        var57 = true
                    end
                    SEASON_NUM_2 = assert
                    SEASON_NUM_2(var57, "a bonus already exists")
                    var57 = TopPct_2.Value
                    SEASON_NUM_2 = var57 / 100
                    tbl_3.scoreLte = SEASON_NUM_2
                    var57 = false
                    if 0 < tbl_3.scoreLte then
                        if tbl_3.scoreLte > 1 then
                            var57 = false
                        else
                            var57 = true
                        end
                    end
                    SEASON_NUM_2 = assert
                    SEASON_NUM_2(var57, "invalid TopPct")
                    SEASON_NUM_2 = tbl_6_upvr
                    SEASON_NUM_2[1] = tbl_3
                else
                    SEASON_NUM_2 = error
                    var57 = "Missing Level or TopPct"
                    SEASON_NUM_2(var57)
                end
            end
        end
    end
end)("HomeItem", ReplicatedStorage.Resource.HomeItem)
for i_3 = 2, SeasonConsts_upvr.MAX_REWARD_LEVEL do
    if tbl_5_upvr[i_3] == nil then
        error("Missing reward for Level: "..tostring(i_3))
    end
end
for i_4 = 1, SeasonConsts_upvr.NUM_BONUS_AWARDS do
    if tbl_6_upvr[i_4] == nil then
        error("Missing reward for Bonus: "..tostring(i_4))
    end
end
return module