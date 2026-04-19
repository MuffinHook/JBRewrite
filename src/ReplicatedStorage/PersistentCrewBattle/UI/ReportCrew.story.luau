-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVBGluaXQFcHJpbnQIb25TdWJtaXQOd2FudHMgdG8gY2xvc2UHb25DbG9zZQ1jcmVhdGVFbGVtZW50BnJlbmRlcgt3aWxsVW5tb3VudAd1bm1vdW50CUNvbXBvbmVudANBcHAGZXh0ZW5kB3JlcXVpcmUKUmVwb3J0Q3JldwZzY3JpcHQGUGFyZW50BW1vdW50BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdAAIAQEAAAAAAYIAAQAAAAcBARgABwAAAAAEAgAAAAAJpAIBAAAAAEBSAwAAnwICAaQCAQAAAABAUgMBAJ8CAgGCAAEAAgMCBAAAAEAACgMBGAAAAAABAAAAAQsAAAAAAgAAAAAABaQAAQAAAABAbwECAJ8AAgGCAAEAAwMCBAAAAEADBAAOBQEYAAAAAAEPAAAAAAUBAgAAAA37AQAATQEBygAAAAD7AgEA4gMDAMAEBAAwBAMGAQAAAMAEBQAwBAN7AgAAAJ8BAwCCAQAABgMGAwMDBQUCAQIGAQYCAgECCAcBGAAAAAAAAQAABAAA+wAJAAAAAAEBAAAAAAGCAAEAAAATCAEYABMAAAAAAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDCQAWAAEYAAAAAAABFwAAAAAGAQEAAAAp+wEAAE0BAYgAAAAAbwMBALwBAZwCAAAAnwEDAqQCBAAAADBApAQHAAAAYEBNBAQkCAAAAE0DBL0FAAAAnwICAsADCQAwAwETCgAAANkDAQASAgAAEgACADADAYALAAAAwAMMADADATQNAAAA+wMAAE0DA+QOAAAA+wQAAE0EBMoPAAAAUgUBAJ8EAgJSBQAAnwMDAtkEAwASAgAAEgADAIIEAgAQAwoDCwMMAw0EAAAwQAMOAw8EAABgQAMQBgADAQMHBgQDCAMRAwYEAAMEBQQAARgAAAAAAAAAAQAAAAAAAAAAAQAAAQAAAAALAAACAAAAAAAAAAAAAQAAAAUAAAAAAwAAAQIAD6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAsACBwASAAEAggICAAgDEgQAAABAAxMDFAMNBAAAQEADFQYGAQYBAAEYAAAAAAAAAAEAAAAAAgAAAQAAAAAHUvje/DMklpMxqHhDG247kCLgyYhgPLT9

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:06
-- Luau version 6, Types version 3
-- Time taken: 0.001825 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local ReportCrew_upvr = require(script.Parent.ReportCrew)
    function any_extend_result1.render(arg1_3) -- Line 8
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: ReportCrew_upvr (readonly)
        ]]
        return Roact_upvr.createElement(ReportCrew_upvr, {
            onSubmit = function(arg1_4, arg2) -- Line 10, Named "onSubmit"
                print(arg1_4)
                print(arg2)
            end;
            onClose = function() -- Line 14, Named "onClose"
                print("wants to close")
            end;
        })
    end
    function any_extend_result1.willUnmount(arg1_5) -- Line 19
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 22
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end