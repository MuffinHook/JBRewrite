local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClanMatchmakingConsts = require(ReplicatedStorage.ClanMatchmaking.ClanMatchmakingConsts)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
return {
	setIsClanReadiedUp = function(p1, p2) --[[ Name: setIsClanReadiedUp | Line: 7 | Upvalues: ReplicatedStorage (copy), ClanMatchmakingConsts (copy) ]]
		assert(typeof(p1) == "string", "Invalid clanId passed")
		local v2 = ReplicatedStorage:FindFirstChild(ClanMatchmakingConsts.CLAN_IS_READIED_UP_MODEL_NAME)
		local v3 = v2:FindFirstChild(p1)
		if p2 then
			if not v3 then
				local v4 = Instance.new("BoolValue")
				v4.Name = p1
				v4.Parent = v2
			end
		elseif v3 then
			v3:Destroy()
		end
	end,
	getIsClanReadiedUp = function(p1) --[[ Name: getIsClanReadiedUp | Line: 25 | Upvalues: ReplicatedStorage (copy), ClanMatchmakingConsts (copy) ]]
		assert(typeof(p1) == "string", "Invalid clanId passed")
		local v2 = ReplicatedStorage:FindFirstChild(ClanMatchmakingConsts.CLAN_IS_READIED_UP_MODEL_NAME):FindFirstChild(p1)
		if v2 then
			return v2 ~= nil
		else
			return false
		end
	end,
	observeIsClanReadiedUp = function(p1, p2) --[[ Name: observeIsClanReadiedUp | Line: 34 | Upvalues: ReplicatedStorage (copy), ClanMatchmakingConsts (copy), RxInstanceUtils (copy) ]]
		return RxInstanceUtils.observeChildrenNamed(ReplicatedStorage:FindFirstChild(ClanMatchmakingConsts.CLAN_IS_READIED_UP_MODEL_NAME), p1, p2)
	end
}