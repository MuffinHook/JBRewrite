-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersistentCrewConsts = require(ReplicatedStorage.PersistentCrew.PersistentCrewConsts)
return {
	setPlayerViewingClanId = function(p1, p2)
		p1:SetAttribute(PersistentCrewConsts.VIEWING_CLAN_ID_ATTR_NAME, p2)
	end,
	getPlayerViewingClanId = function(p1)
		return p1:GetAttribute(PersistentCrewConsts.VIEWING_CLAN_ID_ATTR_NAME)
	end,
	getPlayerViewingClanIdChangedSignal = function(p1)
		return p1:GetAttributeChangedSignal(PersistentCrewConsts.VIEWING_CLAN_ID_ATTR_NAME)
	end,
	setHasPlayerReceivedPersistentCrewAccess = function(p1, p2)
		assert(typeof(p2) == "boolean", "hasReceivedPersistentCrewAccess must be a boolean")
		p1:SetAttribute(PersistentCrewConsts.HAS_RECEIVED_PERSISTENT_CREW_ACCESS_ATTR_NAME, p2)
	end,
	getHasPlayerReceivedPersistentCrewAccess = function(p1)
		return p1:GetAttribute(PersistentCrewConsts.HAS_RECEIVED_PERSISTENT_CREW_ACCESS_ATTR_NAME)
	end
}
