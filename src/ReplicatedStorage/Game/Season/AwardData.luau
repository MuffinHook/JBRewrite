-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeasonConsts = require(ReplicatedStorage.Game.Season.SeasonConsts)
local t = {}
local t2 = {}
t.Level = t2
local t3 = {}
t.Bonus = t3
local function gatherStoreData(p1, p2)
	for v3, v4 in p2 do
		local v1, v2
		if v4.Season and v4.Season == SeasonConsts.SEASON_NUM then
			if not v4.SeasonIconId then
				print(v4)
				error(("Missing SeasonIconId for: %s:^"):format(p1))
			end
			v1 = v4.SeasonIconId > 0
			assert(v1, "missing SeasonIconId value")
			local t = {
				type = p1
			}
			t.name = v4.Name or v4.Make
			t.imageId = v4.SeasonIconId
			if v4.Level then
				t2[v4.Level] = t
			elseif v4.TopPct then
				assert(#t3 == 0, "a bonus already exists")
				t.scoreLte = v4.TopPct / 100
				v2 = if t.scoreLte > 0 then t.scoreLte <= 1 else false
				assert(v2, "invalid TopPct")
				t3[1] = t
			else
				warn(v4)
				error("Missing Level or TopPct")
			end
		end
	end
end
local function gatherModelData(p1, p2)
	for v3, v4 in p2:GetChildren() do
		local v1, v2
		local Season = v4:FindFirstChild("Season")
		local Level = v4:FindFirstChild("Level")
		local TopPct = v4:FindFirstChild("TopPct")
		local SeasonIconId = v4:FindFirstChild("SeasonIconId")
		if Season and Season.Value == SeasonConsts.SEASON_NUM then
			if not SeasonIconId then
				error(("Missing SeasonIconId for %s:%s"):format(p1, v4.Name))
			end
			v1 = SeasonIconId.Value > 0
			assert(v1, "missing SeasonIconId value")
			local t = {
				type = p1,
				name = v4.Name,
				imageId = SeasonIconId.Value
			}
			if Level then
				t2[Level.Value] = t
			elseif TopPct then
				assert(#t3 == 0, "a bonus already exists")
				t.scoreLte = TopPct.Value / 100
				v2 = if t.scoreLte > 0 then t.scoreLte <= 1 else false
				assert(v2, "invalid TopPct")
				t3[1] = t
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
	if t2[i] == nil then
		error("Missing reward for Level: " .. tostring(i))
	end
end
for j = 1, SeasonConsts.NUM_BONUS_AWARDS do
	if t3[j] == nil then
		error("Missing reward for Bonus: " .. tostring(j))
	end
end
return t
