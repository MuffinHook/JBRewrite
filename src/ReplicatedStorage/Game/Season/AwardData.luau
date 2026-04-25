-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeasonConsts = require(ReplicatedStorage.Game.Season.SeasonConsts)
local levelRewards = {}
local levelRewardsByLevel = {}
levelRewards.Level = levelRewardsByLevel
local bonusRewards = {}
levelRewards.Bonus = bonusRewards
local function gatherStoreData(rewardType, itemsData)
	for index, item in itemsData do
		local isValidIconId, isValidScoreLte
		if item.Season and item.Season == SeasonConsts.SEASON_NUM then
			if not item.SeasonIconId then
				print(item)
				error(("Missing SeasonIconId for: %s:^"):format(rewardType))
			end
			isValidIconId = item.SeasonIconId > 0
			assert(isValidIconId, "missing SeasonIconId value")
			local rewardEntry = {
				type = rewardType
			}
			rewardEntry.name = item.Name or item.Make
			rewardEntry.imageId = item.SeasonIconId
			if item.Level then
				levelRewardsByLevel[item.Level] = rewardEntry
			elseif item.TopPct then
				assert(#bonusRewards == 0, "a bonus already exists")
				rewardEntry.scoreLte = item.TopPct / 100
				isValidScoreLte = if rewardEntry.scoreLte > 0 then rewardEntry.scoreLte <= 1 else false
				assert(isValidScoreLte, "invalid TopPct")
				bonusRewards[1] = rewardEntry
			else
				warn(item)
				error("Missing Level or TopPct")
			end
		end
	end
end
local function gatherModelData(rewardType, parentFolder)
	for index, child in parentFolder:GetChildren() do
		local isValidIconId, isValidScoreLte
		local Season = child:FindFirstChild("Season")
		local Level = child:FindFirstChild("Level")
		local TopPct = child:FindFirstChild("TopPct")
		local SeasonIconId = child:FindFirstChild("SeasonIconId")
		if Season and Season.Value == SeasonConsts.SEASON_NUM then
			if not SeasonIconId then
				error(("Missing SeasonIconId for %s:%s"):format(rewardType, child.Name))
			end
			isValidIconId = SeasonIconId.Value > 0
			assert(isValidIconId, "missing SeasonIconId value")
			local rewardEntry = {
				type = rewardType,
				name = child.Name,
				imageId = SeasonIconId.Value
			}
			if Level then
				levelRewardsByLevel[Level.Value] = rewardEntry
			elseif TopPct then
				assert(#bonusRewards == 0, "a bonus already exists")
				rewardEntry.scoreLte = TopPct.Value / 100
				isValidScoreLte = if rewardEntry.scoreLte > 0 then rewardEntry.scoreLte <= 1 else false
				assert(isValidScoreLte, "invalid TopPct")
				bonusRewards[1] = rewardEntry
			else
				error("Missing Level or TopPct")
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
gatherModelData("HomeItem", ReplicatedStorage.Resource.HomeItem)
for i = 2, SeasonConsts.MAX_REWARD_LEVEL do
	if levelRewardsByLevel[i] == nil then
		error("Missing reward for Level: " .. tostring(i))
	end
end
for j = 1, SeasonConsts.NUM_BONUS_AWARDS do
	if bonusRewards[j] == nil then
		error("Missing reward for Bonus: " .. tostring(j))
	end
end
return levelRewards
