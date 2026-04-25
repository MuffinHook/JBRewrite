-- Reviewed by Claude
-- variables reassigned
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local MarketplaceService = game:GetService("MarketplaceService")
local SeasonConsts = require(script.Parent.SeasonConsts)
local seasonUtils = {
	getRemainingTime = function()
		local UnixTimestamp = DateTime.now().UnixTimestamp
		return SeasonConsts.SEASON_END_UNIX - UnixTimestamp
	end,
	getRemainingBuyTime = function()
		local UnixTimestamp = DateTime.now().UnixTimestamp
		return SeasonConsts.BUY_END_UNIX - UnixTimestamp
	end,
	getSeasonExpMult = function()
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
function seasonUtils.isBuyEnabled()
	return if seasonUtils.getRemainingTime() < 0 then seasonUtils.getRemainingBuyTime() >= 0 else false
end
local productPriceCache = {}
function seasonUtils.getProductPrice(productId)
	if productPriceCache[productId] then
		return Promise.resolve(productPriceCache[productId])
	else
		return Promise.defer(function(resolve)
			local PriceInRobux = MarketplaceService:GetProductInfo(productId, Enum.InfoType.Product).PriceInRobux
			productPriceCache[productId] = PriceInRobux
			resolve(PriceInRobux)
		end)
	end
end
function seasonUtils.serializeLevelsAwarded(levelsTable)
	assert(type(levelsTable) == "table")
	return HttpService:JSONEncode(levelsTable)
end
function seasonUtils.deserializeLevelsAwarded(levelsJson)
	assert(type(levelsJson) == "string")
	return HttpService:JSONDecode(levelsJson)
end
function seasonUtils.formatRemaining(totalSeconds)
	local remainingSeconds = math.max(0, totalSeconds)
	local days = math.floor(remainingSeconds / 86400)
	local hours = math.floor(remainingSeconds % 86400 / 3600)
	local minutes = math.floor(remainingSeconds % 3600 / 60)
	local seconds = math.floor(remainingSeconds % 60)
	if days > 0 then
		return ("%dd %dh"):format(days, hours)
	elseif hours > 0 then
		return ("%dh %dm"):format(hours, minutes)
	elseif minutes > 0 then
		return ("%dm %ds"):format(minutes, seconds)
	else
		return ("%ds"):format(seconds)
	end
end
return seasonUtils
