-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMcBGluaXQNY3JlYXRlRWxlbWVudAthc3BlY3RSYXRpbwxwYWRkaW5nUmF0aW8Jb3duZXJOYW1lCGNsYW5OYW1lCmNsYW5SYXRpbmcEc2l6ZQViYWRjYwZCYWJveXoEMTU2NQVVRGltMglmcm9tU2NhbGUGcmVuZGVyC3dpbGxVbm1vdW50B3VubW91bnQJQ29tcG9uZW50A0FwcAZleHRlbmQHcmVxdWlyZQpDbGFuUmF0aW5nBnNjcmlwdAZQYXJlbnQFbW91bnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBVJvYWN0AAYBAQAAAAABggABAAAABwEBGAAHAAAAAAcBAgAAAB37AQAATQEBygAAAAD7AgEA4gMHAIwEFAAwBAOJAQAAAG8ECAAwBAMoAgAAAG8ECQAwBAOzAwAAAG8ECgAwBAPoBAAAAG8ECwAwBAMfBQAAAKQEDgAANMCAbwUPAG8GEACfBAMCMAQDDwYAAACfAQMAggEAABEDAgMDAwQDBQMGAwcDCAUGAQIDBAUGAgAAAAAAAIA/AwkDCgMLAwwDDQQANMCAApqZmZmZmek/ApqZmZmZmbk/AAgOARgAAAAAAAEAAAEAAAEAAAEAAAEAAAEAAAAAAAD6AAkAAAAAAQEAAAAAAYIAAQAAABIPARgAEgAAAAACAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMQABUAARgAAAAAAAEWAAAAAAYBAQAAACn7AQAATQEBiAAAAABvAwEAvAEBnAIAAACfAQMCpAIEAAAAMECkBAcAAABgQE0EBCQIAAAATQME/wUAAACfAgICwAMJADADARMKAAAA2QMBABICAAASAAIAMAMBgAsAAADAAwwAMAMBNA0AAAD7AwAATQMD5A4AAAD7BAAATQQEyg8AAABSBQEAnwQCAlIFAACfAwMC2QQDABICAAASAAMAggQCABADEQMSAxMDFAQAADBAAxUDFgQAAGBAAxcGAAMBAw4GAgMPAxgDAgQAAQIDBAABGAAAAAAAAAABAAAAAAAAAAABAAABAAAAAAoAAAIAAAAAAAAAAAABAAAABQAAAAADAAABAgAPowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICwAIHABIAAQCCAgIACAMZBAAAAEADGgMbAxQEAABAQAMcBgQBBAEAARgAAAAAAAAAAQAAAAACAAABAAAAAAXW5T7SRq3xAE6rvJxZTQsWpv0ppuQhVNM=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:02
-- Luau version 6, Types version 3
-- Time taken: 0.002079 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local ClanRating_upvr = require(script.Parent.ClanRating)
    function any_extend_result1.render(arg1_3) -- Line 8
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: ClanRating_upvr (readonly)
        ]]
        return Roact_upvr.createElement(ClanRating_upvr, {
            aspectRatio = 20;
            paddingRatio = 0.0078125;
            ownerName = "badcc";
            clanName = "Baboyz";
            clanRating = "1565";
            size = UDim2.fromScale(0.8, 0.1);
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 18
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 21
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end