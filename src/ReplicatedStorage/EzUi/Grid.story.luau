-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMiCVRleHRMYWJlbBZCYWNrZ3JvdW5kVHJhbnNwYXJlbmN5EEJhY2tncm91bmRDb2xvcjMEU2l6ZQhQb3NpdGlvbgRUZXh0BWNvbG9yBHNpemUIcG9zaXRpb24FdGl0bGUNdGVzdENvbXBvbmVudAd1bm1vdW50B3JlcXVpcmUER3JpZAZzY3JpcHQGUGFyZW50BW1vdW50BUZyYW1lBVVEaW0yA25ldw1jcmVhdGVFbGVtZW50C2FzcGVjdFJhdGlvDHBhZGRpbmdSYXRpbwtyb3dzUGVyUGFnZQpjb2xzUGVyUm93CWNvbXBvbmVudAVpdGVtcwZDb2xvcjMBMQEyATMERXpVaRFGaW5kRmlyc3RBbmNlc3RvcgVSb2FjdAAEBQEBAAAAGPsBAABvAgAA4gMGAG8EBwAwBAM6AQAAAE0EAEQIAAAAMAQDnwIAAABNBAAPCQAAADAEAy8DAAAATQQA2woAAAAwBAM7BAAAAE0EAJoLAAAAMAQD9QUAAACfAQMAggEAAAwDAQMCAwMDBAMFAwYFBQECAwQFAgAAAAAAAOA/AwcDCAMJAwoABgsBGAAAAAEAAAEAAAABAAAAAQAAAAEAAAD7AAcAAAAAAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDDAAyAAEYAAAAAAABMwAAAAARAQMAAABqpAEBAAAAAECkAwQAAAAwQE0DAyQFAAAATQIDBwIAAACfAQIC+wIAAE0CAuQGAAAA+wMBAG8EBwDiBQsAbwYMADAGBToIAAAApAYPAAA40IBvBxAAjAgAAG8JEACMCgAAnwYFAjAGBS8JAAAApAYPAAA40IBvBxEAjAgAAG8JEQCMCgAAnwYFAjAGBTsKAAAA+wYAAE0GBsoSAAAAUgcBAOIIGQCMCQEAMAkIiRMAAACMCWQAMAkIKBQAAACMCQMAMAkIDxUAAACMCQMAMAkI0xYAAAD7CQIAMAkI6BcAAAD/CQAAAwAAAOIKHACkCx4AADjQgYwMAQCMDQAAjA4AAJ8LBAIwCwpEGgAAAG8LHwAwCwqaGwAAAOILHACkDB4AADjQgYwNAACMDgEAjA8AAJ8MBAIwDAtEGgAAAG8MIAAwDAuaGwAAAOIMHACkDR4AADjQgYwOAACMDwAAjBABAJ8NBAIwDQxEGgAAAG8NIQAwDQyaGwAAAMUJCgQBAAAAMAkIGBgAAACfBgMAnwMAAlIEAACfAgMC2QMAABICAAASAAIAggMCACIDDQQAAABAAw4DDwQAADBAAxADEQMSAwIDBAMFBQMICQoCAAAAAAAA4D8DEwMUBAA40IACzczMzMzM7D8CmpmZmZmZqT8DFQMWAxcDGAMZAxoDGwUGExQVFhcYAwcDCgUCGhsDHAQAONCBAx0DHgMfAQEQAAEYAAAAAAAAAAAAAQAAAQEBAQAAAQAAAAAAAAAAAQAAAAAAAAAAAgAAAAABAAABAAABAAABAAABAAABAAEBAAAAAAAAAAEAAAIBAAAAAAAAAAEAAAIBAAAAAAAAAAEAAAAA9QD6+R3iIAAAABEAAAAABQAAAQIAF6MAAACkAAEAAAAAQG8CAgC8AAB8AwAAAJ8AAwKkAQUAAABAQE0CACQGAAAATQICIQcAAACfAQICTQIByggAAADAAwkAEgACAMAECgASAAEAEgACABIAAwCCBAIACwMPBAAAAEADIAMhAw0EAABAQAMQAyIDFQYABgICAAIBAAEYAAEAAAAAAAEAAAAAAAABAAIACgAAAAABAAAAAAP7fL5P75IoaTGIofRoMMt5i2SpO8m41E4=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:41
-- Luau version 6, Types version 3
-- Time taken: 0.002070 seconds

local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement_upvr = Roact_upvr.createElement
local function testComponent_upvr(arg1) -- Line 6, Named "testComponent"
    --[[ Upvalues[1]:
        [1]: createElement_upvr (readonly)
    ]]
    return createElement_upvr("TextLabel", {
        BackgroundTransparency = 0.5;
        BackgroundColor3 = arg1.color;
        Size = arg1.size;
        Position = arg1.position;
        Text = arg1.title;
    })
end
return function(arg1) -- Line 16
    --[[ Upvalues[3]:
        [1]: Roact_upvr (readonly)
        [2]: createElement_upvr (readonly)
        [3]: testComponent_upvr (readonly)
    ]]
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr("Frame", {
        BackgroundTransparency = 0.5;
        Size = UDim2.new(0.9, 0, 0.9, 0);
        Position = UDim2.new(0.05, 0, 0.05, 0);
    }, Roact_upvr.createElement(require(script.Parent.Grid), {
        aspectRatio = 1;
        paddingRatio = 100;
        rowsPerPage = 3;
        colsPerRow = 3;
        component = testComponent_upvr;
        items = {{
            color = Color3.new(1, 0, 0);
            title = '1';
        }, {
            color = Color3.new(0, 1, 0);
            title = '2';
        }, {
            color = Color3.new(0, 0, 1);
            title = '3';
        }};
    })), arg1)
    return function() -- Line 50
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end