-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersistentCrewConsts = require(ReplicatedStorage.PersistentCrew.PersistentCrewConsts)
return {
	setPlayerViewingClanId = function(arg1, arg2)
		arg1:SetAttribute(PersistentCrewConsts.VIEWING_CLAN_ID_ATTR_NAME, arg2)
	end,
	getPlayerViewingClanId = function(arg1)
		return arg1:GetAttribute(PersistentCrewConsts.VIEWING_CLAN_ID_ATTR_NAME)
	end,
	getPlayerViewingClanIdChangedSignal = function(arg1)
		return arg1:GetAttributeChangedSignal(PersistentCrewConsts.VIEWING_CLAN_ID_ATTR_NAME)
	end,
	setHasPlayerReceivedPersistentCrewAccess = function(arg1, arg2)
		assert(typeof(arg2) == "boolean", "hasReceivedPersistentCrewAccess must be a boolean")
		arg1:SetAttribute(PersistentCrewConsts.HAS_RECEIVED_PERSISTENT_CREW_ACCESS_ATTR_NAME, arg2)
	end,
	getHasPlayerReceivedPersistentCrewAccess = function(arg1)
		return arg1:GetAttribute(PersistentCrewConsts.HAS_RECEIVED_PERSISTENT_CREW_ACCESS_ATTR_NAME)
	end
}
