-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClanMatchmakingConsts = require(ReplicatedStorage.ClanMatchmaking.ClanMatchmakingConsts)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
return {
	setIsClanReadiedUp = function(clanId, isReadiedUp)
		assert(typeof(clanId) == "string", "Invalid clanId passed")
		local clanReadiedUpModel = ReplicatedStorage:FindFirstChild(ClanMatchmakingConsts.CLAN_IS_READIED_UP_MODEL_NAME)
		local clanReadiedUpValue = clanReadiedUpModel:FindFirstChild(clanId)
		if isReadiedUp then
			if not clanReadiedUpValue then
				local newClanReadiedUpValue = Instance.new("BoolValue")
				newClanReadiedUpValue.Name = clanId
				newClanReadiedUpValue.Parent = clanReadiedUpModel
			end
		elseif clanReadiedUpValue then
			clanReadiedUpValue:Destroy()
		end
	end,
	getIsClanReadiedUp = function(clanId)
		assert(typeof(clanId) == "string", "Invalid clanId passed")
		local clanReadiedUpValue = ReplicatedStorage:FindFirstChild(ClanMatchmakingConsts.CLAN_IS_READIED_UP_MODEL_NAME):FindFirstChild(clanId)
		if clanReadiedUpValue then
			return clanReadiedUpValue ~= nil
		else
			return false
		end
	end,
	observeIsClanReadiedUp = function(p1, p2)
		return RxInstanceUtils.observeChildrenNamed(ReplicatedStorage:FindFirstChild(ClanMatchmakingConsts.CLAN_IS_READIED_UP_MODEL_NAME), p1, p2)
	end
}
