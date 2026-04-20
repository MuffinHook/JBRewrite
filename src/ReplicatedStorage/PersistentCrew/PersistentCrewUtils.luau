local PersistentCrewConsts_upvr = require(game:GetService("ReplicatedStorage").PersistentCrew.PersistentCrewConsts)
return {
    setPlayerViewingClanId = function(arg1, arg2) -- Line 5, Named "setPlayerViewingClanId"
        arg1:SetAttribute(PersistentCrewConsts_upvr.VIEWING_CLAN_ID_ATTR_NAME, arg2)
    end;
    getPlayerViewingClanId = function(arg1) -- Line 8, Named "getPlayerViewingClanId"
        return arg1:GetAttribute(PersistentCrewConsts_upvr.VIEWING_CLAN_ID_ATTR_NAME)
    end;
    getPlayerViewingClanIdChangedSignal = function(arg1) -- Line 11, Named "getPlayerViewingClanIdChangedSignal"
        return arg1:GetAttributeChangedSignal(PersistentCrewConsts_upvr.VIEWING_CLAN_ID_ATTR_NAME)
    end;
    setHasPlayerReceivedPersistentCrewAccess = function(arg1, arg2) -- Line 14, Named "setHasPlayerReceivedPersistentCrewAccess"
        local var3
        if typeof(arg2) ~= "boolean" then
            var3 = false
        else
            var3 = true
        end
        assert(var3, "hasReceivedPersistentCrewAccess must be a boolean")
        arg1:SetAttribute(PersistentCrewConsts_upvr.HAS_RECEIVED_PERSISTENT_CREW_ACCESS_ATTR_NAME, arg2)
    end;
    getHasPlayerReceivedPersistentCrewAccess = function(arg1) -- Line 21, Named "getHasPlayerReceivedPersistentCrewAccess"
        return arg1:GetAttribute(PersistentCrewConsts_upvr.HAS_RECEIVED_PERSISTENT_CREW_ACCESS_ATTR_NAME)
    end;
}