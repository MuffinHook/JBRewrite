local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersistentCrewConsts = require(ReplicatedStorage.PersistentCrew.PersistentCrewConsts)
return {
	setPlayerViewingClanId = function(player, clanId)
		player:SetAttribute(PersistentCrewConsts.VIEWING_CLAN_ID_ATTR_NAME, clanId)
	end,
	getPlayerViewingClanId = function(player)
		return player:GetAttribute(PersistentCrewConsts.VIEWING_CLAN_ID_ATTR_NAME)
	end,
	getPlayerViewingClanIdChangedSignal = function(player)
		return player:GetAttributeChangedSignal(PersistentCrewConsts.VIEWING_CLAN_ID_ATTR_NAME)
	end,
	setHasPlayerReceivedPersistentCrewAccess = function(player, hasReceived)
		assert(typeof(hasReceived) == "boolean", "hasReceivedPersistentCrewAccess must be a boolean")
		player:SetAttribute(PersistentCrewConsts.HAS_RECEIVED_PERSISTENT_CREW_ACCESS_ATTR_NAME, hasReceived)
	end,
	getHasPlayerReceivedPersistentCrewAccess = function(player)
		return player:GetAttribute(PersistentCrewConsts.HAS_RECEIVED_PERSISTENT_CREW_ACCESS_ATTR_NAME)
	end
}
