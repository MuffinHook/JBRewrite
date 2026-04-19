-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaBGluaXQNY3JlYXRlRWxlbWVudA1TdG9yZVByb3ZpZGVyBXN0b3JlC2FzcGVjdFJhdGlvFHZlcnRpY2FsUGFkZGluZ1JhdGlvFUFzcGVjdFJhdGlvQ29uc3RyYWludBdVSUFzcGVjdFJhdGlvQ29uc3RyYWludAtBc3BlY3RSYXRpbwZyZW5kZXIHdW5tb3VudAlDb21wb25lbnQDQXBwBmV4dGVuZAdyZXF1aXJlDEpvaW5PckNyZWF0ZQZzY3JpcHQGUGFyZW50DlBlcnNpc3RlbnRDcmV3E3BlcnNpc3RlbnRDcmV3U3RvcmUFbW91bnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBVJvYWN0ClJvYWN0Um9kdXgABQEBAAAAAAGCAAEAAAAJAQEYAAkAAAAADQEEAAAAKPsBAABNAQHKAAAAAPsCAQBNAgK6AQAAAOIDAwD7BAIAMAQDfgIAAAD/BAAAAQAAAPsFAABNBQXKAAAAAPsGAwDiBwYAbwgHADAIB4kEAAAAjAiAADAIB8YFAAAA4ggJAPsJAABNCQnKAAAAAG8KCgDiCwwAbwwHADAMC2kLAAAAnwkDAjAJCKkIAAAAnwUEAMUEBQABAAAAnwEEAIIBAAANAwIDAwMEBQECAwUDBgUCBAUCHMdxHMdx/D8DBwUBCAMIAwkFAQsACwoBGAAAAAAAAAABAAABAAEAAAAAAQAAAQAAAQEAAAAAAQAA/wAA/AAA/QAMAAAAAAIAAgAAAAb7AAAATQAAEgAAAAD7AQEAnwACAYIAAQABAwsAGwABGAAAAAAAARwAAAAABwEDAAAAMPsBAABNAQGIAAAAAG8DAQC8AQGcAgAAAJ8BAwKkAgQAAAAwQKQEBwAAAGBATQQEJAgAAABNAwSTBQAAAJ8CAgKkAwQAAAAwQPsEAQBNBATFCQAAAE0EBFIKAAAAnwMCAsAECwAwBAETDAAAANkEAQASAgAAEgICABIAAwASAAIAMAQBgA0AAAD7BAAATQQE5A4AAAD7BQAATQUFyg8AAABSBgEAnwUCAlIGAACfBAMC2QUCABICAAASAAQAggUCABADDAMNAw4DDwQAADBAAxADEQQAAGBAAxIDEwMUBgADAQMKAxUDAgMAAQIFAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAAAAAAAAQAAAgAAAAAAAA8AAAAAAAAAAAABAAAABgAAAAAEAAABAgAWowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICpAIFAAAAQEBNAwAtBwAAAJ8CAgLAAwgAEgABABIAAAASAAIAggMCAAkDFgQAAABAAxcDGAMPBAAAQEADGQMaBgMBAwEAARgAAAAAAAAAAQAAAAABAAAAAAIAAAAAAQAAAAAERfTdCX0rkMy4pR/7Ag4glDXsyn13MLcI

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:38
-- Luau version 6, Types version 3
-- Time taken: 0.002336 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    --[[ Upvalues[3]:
        [1]: Roact_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: RoactRodux_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 9
    end
    local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
    local JoinOrCreate_upvr = require(script.Parent.JoinOrCreate)
    function any_extend_result1.render(arg1_3) -- Line 11
        --[[ Upvalues[4]:
            [1]: Roact_upvr (copied, readonly)
            [2]: RoactRodux_upvr (copied, readonly)
            [3]: persistentCrewStore_upvr (readonly)
            [4]: JoinOrCreate_upvr (readonly)
        ]]
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = persistentCrewStore_upvr;
        }, {Roact_upvr.createElement(JoinOrCreate_upvr, {
            aspectRatio = 1.7777777777777777;
            verticalPaddingRatio = 128;
        }, {
            AspectRatioConstraint = Roact_upvr.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1.7777777777777777;
            });
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 27
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end