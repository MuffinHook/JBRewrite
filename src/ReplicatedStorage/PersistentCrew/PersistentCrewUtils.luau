-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUGVZJRVdJTkdfQ0xBTl9JRF9BVFRSX05BTUUMU2V0QXR0cmlidXRlFnNldFBsYXllclZpZXdpbmdDbGFuSWQMR2V0QXR0cmlidXRlFmdldFBsYXllclZpZXdpbmdDbGFuSWQZR2V0QXR0cmlidXRlQ2hhbmdlZFNpZ25hbCNnZXRQbGF5ZXJWaWV3aW5nQ2xhbklkQ2hhbmdlZFNpZ25hbAZ0eXBlb2YHYm9vbGVhbjFoYXNSZWNlaXZlZFBlcnNpc3RlbnRDcmV3QWNjZXNzIG11c3QgYmUgYSBib29sZWFuBmFzc2VydC1IQVNfUkVDRUlWRURfUEVSU0lTVEVOVF9DUkVXX0FDQ0VTU19BVFRSX05BTUUoc2V0SGFzUGxheWVyUmVjZWl2ZWRQZXJzaXN0ZW50Q3Jld0FjY2VzcyhnZXRIYXNQbGF5ZXJSZWNlaXZlZFBlcnNpc3RlbnRDcmV3QWNjZXNzBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlDlBlcnNpc3RlbnRDcmV3FFBlcnNpc3RlbnRDcmV3Q29uc3RzAAYGAgEAAAAI+wQAAE0EBEwAAAAAUgUBALwCAC4BAAAAnwIEAYIAAQACAwEDAgAFAwEYAAAAAAAAAAEGAAAAAAQBAQAAAAf7AwAATQMDTAAAAAC8AQASAQAAAJ8BAwCCAQAAAgMBAwQACAUBGAAAAAAAAAAJAAAAAAQBAQAAAAf7AwAATQMDTAAAAAC8AQAWAQAAAJ8BAwCCAQAAAgMBAwYACwcBGAAAAAAAAAAMAAAAAAYCAQAAABe7LAEDUgUBAKQEAQAAAABAnwQCAvAEAgACAAAAqQMAAakDAQCBAQMEAwAAAG8EAwCkAgUAAABAQJ8CAwH7BAAATQQEdAYAAABSBQEAvAIALgcAAACfAgQBggABAAgDCAQAAABAAwkDCgMLBAAAQEADDAMCAA4NARgAAAAAAAAAAAAAAAAAAAACAAAB/gAABA8AAAAABAEBAAAAB/sDAABNAwN0AAAAALwBABIBAAAAnwEDAIIBAAACAwwDBAAVDgEYAAAAAAAAABYAAAAABAAAAQIAJaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAMUGAAAATQICqwcAAACfAQIC/wIEAAAAAADAAwgAEgABADADAq8JAAAAwAMKABIAAQAwAwKjCwAAAMADDAASAAEAMAMC5g0AAADAAw4AEgABADADAiwPAAAAwAMQABIAAQAwAwIQEQAAAIICAgASAw8EAAAAQAMQAxEDEgQAAEBAAxMDFAYAAwMGAQMFBgIDBwYDAw0GBAMOBQABAgMEAQABGAAAAAAAAAABAAAAAAAAAgABAAAAAwAAAAMAAAADAAAABwAAAAMBAAAAAAWBIv67zj+cYSKETmABRohP8Trpz7PmlLo=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:26
-- Luau version 6, Types version 3
-- Time taken: 0.001998 seconds

local PersistentCrewConsts_upvr = require(game:GetService("ReplicatedStorage").PersistentCrew.PersistentCrewConsts)
return {
    setPlayerViewingClanId = function(arg1, arg2) -- Line 5, Named "setPlayerViewingClanId"
        --[[ Upvalues[1]:
            [1]: PersistentCrewConsts_upvr (readonly)
        ]]
        arg1:SetAttribute(PersistentCrewConsts_upvr.VIEWING_CLAN_ID_ATTR_NAME, arg2)
    end;
    getPlayerViewingClanId = function(arg1) -- Line 8, Named "getPlayerViewingClanId"
        --[[ Upvalues[1]:
            [1]: PersistentCrewConsts_upvr (readonly)
        ]]
        return arg1:GetAttribute(PersistentCrewConsts_upvr.VIEWING_CLAN_ID_ATTR_NAME)
    end;
    getPlayerViewingClanIdChangedSignal = function(arg1) -- Line 11, Named "getPlayerViewingClanIdChangedSignal"
        --[[ Upvalues[1]:
            [1]: PersistentCrewConsts_upvr (readonly)
        ]]
        return arg1:GetAttributeChangedSignal(PersistentCrewConsts_upvr.VIEWING_CLAN_ID_ATTR_NAME)
    end;
    setHasPlayerReceivedPersistentCrewAccess = function(arg1, arg2) -- Line 14, Named "setHasPlayerReceivedPersistentCrewAccess"
        --[[ Upvalues[1]:
            [1]: PersistentCrewConsts_upvr (readonly)
        ]]
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
        --[[ Upvalues[1]:
            [1]: PersistentCrewConsts_upvr (readonly)
        ]]
        return arg1:GetAttribute(PersistentCrewConsts_upvr.HAS_RECEIVED_PERSISTENT_CREW_ACCESS_ATTR_NAME)
    end;
}