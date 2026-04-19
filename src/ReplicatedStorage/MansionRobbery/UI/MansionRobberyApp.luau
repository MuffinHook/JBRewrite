-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMeA25ldwRtYWlkBGluaXQJcGN0Q2xvc2VkBXByb3BzB0V5ZWxpZHMEdGV4dA1jaGFyUGVyU2Vjb25kDGRpYWxvZ3VlVGV4dAhTdWJ0aXRsZQ5jcmVhdGVGcmFnbWVudAZyZW5kZXIIZGlkTW91bnQKRG9DbGVhbmluZwt3aWxsVW5tb3VudARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNTdGQETWFpZApSb2FjdFJvZHV4BVJvYWN0DWNyZWF0ZUVsZW1lbnQGc2NyaXB0BlBhcmVudA1QdXJlQ29tcG9uZW50A0FwcAZleHRlbmQHY29ubmVjdAAGAgEBAAAAB/sBAABNAQHvAAAAAJ8BAQIwAQAWAQAAAIIAAQACAwEDAgALAwEYAAAAAAAAAQwAAAAABgEEAAAAJv8BAgAAAAAA+wIAAPsDAQDiBAEATQUABwIAAABNBQW1AAAAADAFBLUAAAAAnwIDAjACAacDAAAA+wIAAPsDAgDiBAYATQUABwIAAABNBQUpBwAAADAFBNUEAAAATQUABwIAAABNBQWjBQAAADAFBKMFAAAAnwIDAjACAfEIAAAA+wIDAE0CAjYJAAAAUgMBAJ8CAgCCAgAACgMEBQEAAwUDBgMHAwgFAgQFAwkDCgMLAA4MARgAAAEAAAEAAAAAAP8AAAMAAAEAAAAAAAEAAAAAAP4AAAQAAAAAAA8AAAAAAQEAAAAAAYIAAQAAABkNARgAGQAAAAADAQAAAAAGTQEAFgAAAAC8AQFRAQAAAJ8BAgGCAAEAAgMCAw4AGg8BGAAAAAAAARsAAAAABAIAAAAABuICAQBNAwApAAAAADADAikAAAAAggICAAIDCQUBAAAdAAEYAAEAAAAAHgAAAAAKAAABAgBKowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgJ2BwAAAJ8BAgKkAgUAAABAQE0DAC0IAAAAnwICAqQDBQAAAEBATQQAIQkAAACfAwICTQQDygoAAACkBQUAAABAQKQGDAAAALBATQYGJA0AAABNBganDgAAAJ8FAgKkBgUAAABAQKQHDAAAALBATQcHJA0AAABNBwfxDwAAAJ8GAgJNBwP4EAAAAG8JEQC8BwecEgAAAJ8HAwLACBMAEgABADAIBxMUAAAAwAgVABIABAASAAUAEgAGABIAAwAwCAeAFgAAAMAIFwAwCAdqGAAAAMAIGQAwCAc0GgAAAE0IAucbAAAAwAkcAJ8IAgJSCQcAnwgCAIIIAAAdAxAEAAAAQAMRAxIDEwQAAEBAAxQDFQMWAxcDGAMZBAAAsEADGgMGAwoDGwMcAx0GAAMDBgEDDAYCAw0GAwMPAx4GBAUAAQIDBAEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAQAAAAABAAIAAAAAAAAAAAEAAAAAAAAAAAIAAAAAAAEAAAADAAAAAAAACwAAAQAAAwAAAAQAAAEAAAAABSqyQJ05vSV/RuYziAI0O7RaqlfpGHYqnA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:02
-- Luau version 6, Types version 3
-- Time taken: 0.001975 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("App")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 11
    --[[ Upvalues[1]:
        [1]: Maid_upvr (readonly)
    ]]
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact_upvr.createElement
local Eyelids_upvr = require(script.Parent.Eyelids)
local Subtitle_upvr = require(script.Parent.Subtitle)
function any_extend_result1.render(arg1) -- Line 14
    --[[ Upvalues[4]:
        [1]: createElement_upvr (readonly)
        [2]: Eyelids_upvr (readonly)
        [3]: Subtitle_upvr (readonly)
        [4]: Roact_upvr (readonly)
    ]]
    return Roact_upvr.createFragment({
        Eyelids = createElement_upvr(Eyelids_upvr, {
            pctClosed = arg1.props.pctClosed;
        });
        Subtitle = createElement_upvr(Subtitle_upvr, {
            text = arg1.props.dialogueText;
            charPerSecond = arg1.props.charPerSecond;
        });
    })
end
function any_extend_result1.didMount(arg1) -- Line 25
end
function any_extend_result1.willUnmount(arg1) -- Line 26
    arg1.maid:DoCleaning()
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 29
    return {
        dialogueText = arg1.dialogueText;
    }
end)(any_extend_result1)