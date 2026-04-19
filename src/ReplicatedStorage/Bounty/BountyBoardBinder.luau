-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMbA25ldwxzZXRtZXRhdGFibGUFQm9hcmQMV2FpdEZvckNoaWxkBkJvdW50eQNSZXMKTW9zdFdhbnRlZAVDbG9uZQRtYWlkCEdpdmVUYXNrBlBhcmVudBNCT0FSRF9MSVNUX1RBR19OQU1FBkFkZFRhZw5nZXRUb3BCb3VudGllcwl1cGRhdGVHdWkEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkBkJpbmRlcgpCYXNlT2JqZWN0ClRhYmxlVXRpbHMMQm91bnR5Q29uc3RzEkJvdW50eUJvYXJkU2VydmljZQdfX2luZGV4DkJPQVJEX1RBR19OQU1FAAIIAQUAAAA3+wEAAE0BAe8AAAAAUgIAAJ8BAgL7BAEAnj0BBAQAAABSAwEApAICAAAAEECfAgMBbwQDALwCANMEAAAAnwIDAvsDAgBNAwMxBQAAAE0DA00GAAAATQMDmgcAAAC8AwM6CAAAAJ8DAgJNBAEWCQAAAFIGAwC8BAT9CgAAAJ8EAwEwAgMkCwAAAE0EA/MDAAAA+wYDAE0GBpkMAAAAvAQERQ0AAACfBAMB+wQEAE0EBK8OAAAAjAUEAJ8EAgL7BQQATQUFZA8AAABNBgPzAwAAAFIHBACfBQMBggECABADAQMCBAAAEEADAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4DDwAMAQEYAAAAAAABAAAAAAAAAgAAAAEAAAAAAAAAAAABAAAAAAABAAEAAAAAAAAAAQAAAAABAAAAAAAAAg0AAAAACgAAAQIARKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKEGAAAATQICfwcAAACfAQICpAIFAAAAQEBNAwChBgAAAE0DA0sIAAAAnwICAqQDBQAAAEBATQQAoQYAAABNBAQYCQAAAJ8DAgKkBAUAAABAQE0FADEKAAAATQUF6gsAAACfBAICpAUFAAAAQEBNBgAxCgAAAE0GBtkMAAAAnwUCAv8GAgAAAAAAMAYGbg0AAACePQYFAgAAAFIIBgBSCQIApAcPAAAA4ECfBwMBwAcQABIAAgASAAYAEgAAABIABAASAAUAMAcG7xEAAABNBwHvEQAAAE0IBC4SAAAAUgkGAJ8HAwCCBwAAEwMQBAAAAEADEQMSAxMEAABAQAMUAxUDFgMXAwUDGAMZAxoDAgQAAOBABgADAQMbAQABAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAgABAAEAAAAAAAACAAAAAAAAAA8AAAAAAAABAAAAAAHQKlftRctB6BuZT0nqXhmZoDJAmeLuPew=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:51
-- Luau version 6, Types version 3
-- Time taken: 0.001333 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage_upvr.Std.BaseObject)
local BountyConsts_upvr = require(ReplicatedStorage_upvr.Bounty.BountyConsts)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local BountyBoardService_upvr = require(ReplicatedStorage_upvr.Bounty.BountyBoardService)
function module_upvr.new(arg1) -- Line 12
    --[[ Upvalues[5]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: ReplicatedStorage_upvr (readonly)
        [4]: BountyConsts_upvr (readonly)
        [5]: BountyBoardService_upvr (readonly)
    ]]
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    local clone = ReplicatedStorage_upvr.Bounty.Res.MostWanted:Clone()
    any_new_result1.maid:GiveTask(clone)
    clone.Parent = arg1:WaitForChild("Board")
    clone.Board:AddTag(BountyConsts_upvr.BOARD_LIST_TAG_NAME)
    BountyBoardService_upvr.updateGui(clone.Board, BountyBoardService_upvr.getTopBounties(4))
    return any_new_result1
end
return require(ReplicatedStorage_upvr.Std.Binder).new(BountyConsts_upvr.BOARD_TAG_NAME, module_upvr)