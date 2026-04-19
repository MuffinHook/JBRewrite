-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMcBGluaXQNY3JlYXRlRWxlbWVudA1TdG9yZVByb3ZpZGVyBXN0b3JlBnJlbmRlcgt3aWxsVW5tb3VudAd1bm1vdW50CUNvbXBvbmVudANBcHAGZXh0ZW5kB3JlcXVpcmUGc2NyaXB0BlBhcmVudAtDaG9vc2VTcGF3bgR0eXBlB3Zpc2libGUdc2V0U3Bhd25TZWxlY3Rpb25PZmZlclZpc2libGUIZGlzcGF0Y2gKbGFzdERpZWRBdA1zZXRMYXN0RGllZEF0CXdvcmtzcGFjZRBHZXRTZXJ2ZXJUaW1lTm93BW1vdW50BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdApSb2FjdFJvZHV4AAYBAQAAAAABggABAAAACQEBGAAJAAAAAAgBBAAAABf7AQAATQEBygAAAAD7AgEATQICugEAAADiAwMA+wQCADAEA34CAAAA/wQAAAEAAAD7BQAATQUFygAAAAD7BgMA/wcAAAAAAACfBQMAxQQFAAEAAACfAQQAggEAAAQDAgMDAwQFAQIAEgUBGAAAAAAAAAABAAABAAEAAAAAAAAAAP0AEwAAAAABAQAAAAABggABAAAAGQYBGAAZAAAAAAIAAgAAAAb7AAAATQAAEgAAAAD7AQEAnwACAYIAAQABAwcAHAABGAAAAAAAAR0AAAAACQEDAAAAS/sBAABNAQGIAAAAAG8DAQC8AQGcAgAAAJ8BAwKkAgQAAAAwQPsDAQBNAwPBAQAAAE0DA34FAAAAnwICAqQDBAAAADBApAQHAAAAYEBNBAQkCAAAAE0EBL4JAAAAnwMCAsAECgAwBAETCwAAAOIGDgBvBw8AMAcGcQwAAACpBwEAMAcGoA0AAAC8BAJMEAAAAJ8EAwHiBhIAbwcTADAHBnEMAAAApAcVAAAAQEG8Bwe3FgAAAJ8HAgIwBwa+EQAAALwEAkwQAAAAnwQDAdkEAQASAgAAEgICABIAAgASAAMAMAQBgBcAAADABBgAMAQBNBkAAAD7BAAATQQE5BoAAAD7BQAATQUFyhsAAABSBgEAnwUCAlIGAACfBAMC2QUDABICAAASAAQAggUCABwDCAMJAwoDCwQAADBAAwQDDAQAAGBAAw0DDgYAAwEDDwMQBQIMDQMRAxIDEwUCDBEDFAMVBAAAQEEDFgMFBgIDBgMXAwIEAAECAwUAARgAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAABAAABAQAAAQAA/gAABAEAAAEAAAAAAAD+AAAEAAAAAAAABwAAAgAAAAAAAAAAAAEAAAAGAAAAAAQAAAECABajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAhBgAAAJ8BAgKkAgUAAABAQE0DAC0HAAAAnwICAsADCAASAAEAEgAAABIAAgCCAwIACQMYBAAAAEADGQMaAwsEAABAQAMbAxwGBAEEAQABGAAAAAAAAAABAAAAAAEAAAAAAgAAAAABAAAAAAV1HGeWAxgNmPHeSuMzY29QBQRw4kfYDZc=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:46:01
-- Luau version 6, Types version 3
-- Time taken: 0.001951 seconds

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
    local store_upvr = require(ReplicatedStorage_upvr.App.store)
    function any_extend_result1.init(arg1_2) -- Line 9
    end
    store_upvr:dispatch({
        type = "setSpawnSelectionOfferVisible";
        visible = true;
    })
    store_upvr:dispatch({
        type = "setLastDiedAt";
        lastDiedAt = workspace:GetServerTimeNow();
    })
    local ChooseSpawn_upvr = require(script.Parent.ChooseSpawn)
    function any_extend_result1.render(arg1_3) -- Line 18
        --[[ Upvalues[4]:
            [1]: Roact_upvr (copied, readonly)
            [2]: RoactRodux_upvr (copied, readonly)
            [3]: store_upvr (readonly)
            [4]: ChooseSpawn_upvr (readonly)
        ]]
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = store_upvr;
        }, {Roact_upvr.createElement(ChooseSpawn_upvr, {})})
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 25
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 28
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end