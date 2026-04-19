-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNGk1BWF9ESVNUX1RPX0xPQURfQVRUUl9OQU1FDEdldEF0dHJpYnV0ZRBNQVhfRElTVF9UT19MT0FEEGdldE1heERpc3RUb0xvYWQMU2V0QXR0cmlidXRlEHNldE1heERpc3RUb0xvYWQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUER2FtZQxEZXN0cnVjdGlibGUSRGVzdHJ1Y3RpYmxlQ29uc3RzAAMDAAIAAAAM+wAAAPsCAQBNAgLyAAAAALwAABIBAAAAnwADAisAAwD7AAEATQAAYAIAAACCAAIAAwMBAwIDAwAFBAEYAAAAAAAAAAABAAAABgAAAAAFAQIAAAAJ+wEAAPsDAQBNAwPyAAAAAFIEAAC8AQEuAQAAAJ8BBAGCAAEAAgMBAwUACQYBGAAAAAAAAAAAAQoAAAAABAAAAQIAHaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAL0GAAAATQICqwcAAABNAgJwCAAAAJ8BAgL/AgIAAAAAAMADCQASAAAAEgABADADArAKAAAAwAMLABIAAAASAAEAMAMCTAwAAACCAgIADQMHBAAAAEADCAMJAwoEAABAQAMLAwwDDQYAAwQGAQMGAgABAQABGAAAAAAAAAABAAAAAAAAAAABAAIAAAAABAAAAAADAQAAAAACLAGvNo21D+qkxtNesefPplwZuEIexcU3

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:49
-- Luau version 6, Types version 3
-- Time taken: 0.001769 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local DestructibleConsts_upvr = require(ReplicatedStorage_upvr.Game.Destructible.DestructibleConsts)
return {
    getMaxDistToLoad = function() -- Line 5, Named "getMaxDistToLoad"
        --[[ Upvalues[2]:
            [1]: ReplicatedStorage_upvr (readonly)
            [2]: DestructibleConsts_upvr (readonly)
        ]]
        local attribute = ReplicatedStorage_upvr:GetAttribute(DestructibleConsts_upvr.MAX_DIST_TO_LOAD_ATTR_NAME)
        if not attribute then
            attribute = DestructibleConsts_upvr
            attribute = attribute.MAX_DIST_TO_LOAD
        end
        return attribute
    end;
    setMaxDistToLoad = function(arg1) -- Line 9, Named "setMaxDistToLoad"
        --[[ Upvalues[2]:
            [1]: ReplicatedStorage_upvr (readonly)
            [2]: DestructibleConsts_upvr (readonly)
        ]]
        ReplicatedStorage_upvr:SetAttribute(DestructibleConsts_upvr.MAX_DIST_TO_LOAD_ATTR_NAME, arg1)
    end;
}