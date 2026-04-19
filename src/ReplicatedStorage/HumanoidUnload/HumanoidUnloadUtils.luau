-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMGk1BWF9ESVNUX1RPX0xPQURfQVRUUl9OQU1FDEdldEF0dHJpYnV0ZRBNQVhfRElTVF9UT19MT0FEEGdldE1heERpc3RUb0xvYWQMU2V0QXR0cmlidXRlEHNldE1heERpc3RUb0xvYWQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUOSHVtYW5vaWRVbmxvYWQUSHVtYW5vaWRVbmxvYWRDb25zdHMAAwMAAgAAAAz7AAAA+wIBAE0CAvIAAAAAvAAAEgEAAACfAAMCKwADAPsAAQBNAABgAgAAAIIAAgADAwEDAgMDAAYEARgAAAAAAAAAAAEAAAEHAAAAAAUBAgAAAAn7AQAA+wMBAE0DA/IAAAAAUgQAALwBAS4BAAAAnwEEAYIAAQACAwEDBQALBgEYAAAAAAAAAAABDAAAAAAEAAABAgAbowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAHwYAAABNAgJvBwAAAJ8BAgL/AgIAAAAAAMADCAASAAAAEgABADADArAJAAAAwAMKABIAAAASAAEAMAMCTAsAAACCAgIADAMHBAAAAEADCAMJAwoEAABAQAMLAwwGAAMEBgEDBgIAAQEAARgAAAAAAAAAAQAAAAAAAAIAAgAAAAAFAAAAAAMBAAAAAALXeob+Vm5bNg4CiK4kEZnAp2KRiuW+7P8=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:35
-- Luau version 6, Types version 3
-- Time taken: 0.001465 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local HumanoidUnloadConsts_upvr = require(ReplicatedStorage_upvr.HumanoidUnload.HumanoidUnloadConsts)
return {
    getMaxDistToLoad = function() -- Line 6, Named "getMaxDistToLoad"
        --[[ Upvalues[2]:
            [1]: ReplicatedStorage_upvr (readonly)
            [2]: HumanoidUnloadConsts_upvr (readonly)
        ]]
        local attribute = ReplicatedStorage_upvr:GetAttribute(HumanoidUnloadConsts_upvr.MAX_DIST_TO_LOAD_ATTR_NAME)
        if not attribute then
            attribute = HumanoidUnloadConsts_upvr
            attribute = attribute.MAX_DIST_TO_LOAD
        end
        return attribute
    end;
    setMaxDistToLoad = function(arg1) -- Line 11, Named "setMaxDistToLoad"
        --[[ Upvalues[2]:
            [1]: ReplicatedStorage_upvr (readonly)
            [2]: HumanoidUnloadConsts_upvr (readonly)
        ]]
        ReplicatedStorage_upvr:SetAttribute(HumanoidUnloadConsts_upvr.MAX_DIST_TO_LOAD_ATTR_NAME, arg1)
    end;
}