-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUCVRyYW5zZm9ybS9ObyB2YWxpZCByb2JiZXJ5IHdpdGggdGhhdCBuYW1lIGNvdWxkIGJlIGZvdW5kLghWYWxpZGF0ZQxBdXRvY29tcGxldGUFUGFyc2UHcm9iYmVyeQxSZWdpc3RlclR5cGUJcm9iYmVyaWVzEE1ha2VMaXN0YWJsZVR5cGUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUKQ21kckNsaWVudAZTaGFyZWQEVXRpbAdSb2JiZXJ5DVJvYmJlcnlDb25zdHMMTElTVF9ST0JCRVJZD01ha2VGdXp6eUZpbmRlcgAGAwEBAAAABPsBAABSAgAAnwECAIIBAAAAAAsBARgAAAAADAAAAAAEAQAAAAAIHAIAAIwDAAC3AwIAAgAAAKkBAAGpAQEAbwIAAIIBAwABAwIADwMBGAAAAAAAAAAAEAAAAAABAQAAAAABggACAAAAEwQBGAAUAAAAAAIBAAAAAAITAQAAggECAAAAFwUBGAAAGAAAAAAGAQIAAAAPbwMAAPsEAAC8AQDdAQAAAJ8BBAFvAwIA+wQBAE0EBCQDAAAA+wUAAJ8EAgC8AQDdAQAAAJ8BAAGCAAEABAMGAwcDCAMJABwAARgAAAAAAAEAAAAAAAAAAAEdAAAAAAcAAAECAC+jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAOBgAAAE0CAhIHAAAATQICnggAAACfAQICpAIFAAAAQEBNAwAECQAAAE0DA1gKAAAAnwICAk0DAowLAAAATQQBPQwAAABSBQMAnwQCAuIFEQDABhIAEgAEADAGBSENAAAAwAYTADAGBXYOAAAAwAYUADAGBasPAAAAwAYVADAGBZsQAAAAwAYWABIABQASAAEAggYCABcDCgQAAABAAwsDDAMNBAAAQEADDgMPAxADEQMSAxMDFAMBAwMDBAMFBQQNDg8QBgAGAQYCBgMGBAUAAQIDBAEAARgAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAIAAQAAAAIDAAAABAAABAAABAAABQAAAAEAAAAABUC6p4kNSw5Waa6OFYadBCMworD9cn7NiA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:00
-- Luau version 6, Types version 3
-- Time taken: 0.002328 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util)
local tbl_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = Util_upvr.MakeFuzzyFinder(require(ReplicatedStorage.Robbery.RobberyConsts).LIST_ROBBERY)
function tbl_upvr.Transform(arg1) -- Line 11
    --[[ Upvalues[1]:
        [1]: any_MakeFuzzyFinder_result1_upvr (readonly)
    ]]
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_upvr.Validate(arg1) -- Line 15
    local var5
    if 0 >= #arg1 then
        var5 = false
    else
        var5 = true
    end
    return var5, "No valid robbery with that name could be found."
end
function tbl_upvr.Autocomplete(arg1) -- Line 19
    return arg1
end
function tbl_upvr.Parse(arg1) -- Line 23
    return arg1[1]
end
return function(arg1) -- Line 28
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: Util_upvr (readonly)
    ]]
    arg1:RegisterType("robbery", tbl_upvr)
    arg1:RegisterType("robberies", Util_upvr.MakeListableType(tbl_upvr))
end