local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local MarketplaceService = game:GetService("MarketplaceService")
local SeasonConsts = require(script.Parent.SeasonConsts)
local t = {
	getRemainingTime = function() --[[ Name: getRemainingTime | Line: 8 | Upvalues: SeasonConsts (copy) ]]
		local UnixTimestamp = DateTime.now().UnixTimestamp
		return SeasonConsts.SEASON_END_UNIX - UnixTimestamp
	end,
	getRemainingBuyTime = function() --[[ Name: getRemainingBuyTime | Line: 13 | Upvalues: SeasonConsts (copy) ]]
		local UnixTimestamp = DateTime.now().UnixTimestamp
		return SeasonConsts.BUY_END_UNIX - UnixTimestamp
	end,
	getSeasonExpMult = function() --[[ Name: getSeasonExpMult | Line: 18 | Upvalues: SeasonConsts (copy) ]]
		if SeasonConsts.AUTOMATE_SEASON_XP_MULT then
			if DateTime.now().UnixTimestamp > SeasonConsts.SEASON_XP_MULT_START_UNIX then
				return SeasonConsts.SEASON_XP_MULT
			else
				return 1
			end
		else
			return SeasonConsts.SEASON_XP_MULT
		end
	end
}
function t.isBuyEnabled() --[[ Line: 32 | Upvalues: t (copy) ]]
	return if t.getRemainingTime() < 0 then t.getRemainingBuyTime() >= 0 else false
end
local t2 = {}
function t.getProductPrice(p1) --[[ Line: 36 | Upvalues: t2 (copy), Promise (copy), MarketplaceService (copy) ]]
	if t2[p1] then
		return Promise.resolve(t2[p1])
	else
		return Promise.defer(function(p12) --[[ Line: 40 | Upvalues: MarketplaceService (ref), p1 (copy), t2 (ref) ]]
			local PriceInRobux = MarketplaceService:GetProductInfo(p1, Enum.InfoType.Product).PriceInRobux
			t2[p1] = PriceInRobux
			p12(PriceInRobux)
		end)
	end
end
function t.serializeLevelsAwarded(p1) --[[ Line: 47 | Upvalues: HttpService (copy) ]]
	assert(type(p1) == "table")
	return HttpService:JSONEncode(p1)
end
function t.deserializeLevelsAwarded(p1) --[[ Line: 51 | Upvalues: HttpService (copy) ]]
	assert(type(p1) == "string")
	return HttpService:JSONDecode(p1)
end
function t.formatRemaining(p1) --[[ Line: 55 ]]
	local v1 = math.max(0, p1)
	local v2 = math.floor(v1 / 86400)
	local v3 = math.floor(v1 % 86400 / 3600)
	local v4 = math.floor(v1 % 3600 / 60)
	local v5 = math.floor(v1 % 60)
	if v2 > 0 then
		return ("%dd %dh"):format(v2, v3)
	elseif v3 > 0 then
		return ("%dh %dm"):format(v3, v4)
	elseif v4 > 0 then
		return ("%dm %ds"):format(v4, v5)
	else
		return ("%ds"):format(v5)
	end
end
return t