-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMiBHR5cGUEbGlzdBN0cmFkZUluaXRpYXRpb25zU2V0BG5hbWUGdXNlcklkBWJhZGNjCWFzaW1vMzA4ORFUV0VOVFlNT1JFTUlOVVRFUwhkaXNwYXRjaARpbml0BXByaW50BmFjY2VwdAhvbkFjY2VwdAdkZWNsaW5lCW9uRGVjbGluZQ1jcmVhdGVFbGVtZW50DVN0b3JlUHJvdmlkZXIFc3RvcmUGcmVuZGVyC3dpbGxVbm1vdW50B3VubW91bnQJQ29tcG9uZW50A0FwcAZleHRlbmQHcmVxdWlyZRBUcmFkZUluaXRpYXRpb25zBnNjcmlwdAZQYXJlbnQFbW91bnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBVJvYWN0ClJvYWN0Um9kdXgACAkBAQAAACT7AQAA4gMCAG8EAwAwBANxAAAAAP8EAAADAAAA4gUGAG8GBwAwBgVaBAAAAIwGAQAwBgWGBQAAAOIGBgBvBwgAMAcGWgQAAACMBwIAMAcGhgUAAADiBwYAbwgJADAIB1oEAAAAjAgDADAIB4YFAAAAxQQFBAEAAAAwBAMLAQAAALwBAUwKAAAAnwEDAYIAAQALAwEDAgUCAAEDAwMEAwUFAgQFAwYDBwMIAwkACQoBGAAAAQAAAQABAQAAAQAAAgEAAAEAAAIBAAABAAAAAPUA/gAAEQoAAAAABAEAAAAABqQBAQAAAABAbwICAFIDAACfAQMBggABAAMDCwQAAABAAwwAIQ0BGAAAAAAAASIAAAAABAEAAAAABqQBAQAAAABAbwICAFIDAACfAQMBggABAAMDCwQAAABAAw4AJA8BGAAAAAAAASUAAAAACQEEAAAAHPsBAABNAQHKAAAAAPsCAQBNAgK6AQAAAOIDAwD7BAIAMAQDfgIAAAD/BAAAAQAAAPsFAABNBQXKAAAAAPsGAwDiBwYAwAgHADAIByoEAAAAwAgIADAIBy0FAAAAnwUDAMUEBQABAAAAnwEEAIIBAAAJAxADEQMSBQECAw0DDwUCBAUGAQYCAgECHBMBGAAAAAAAAAABAAABAAEAAAAAAQAAAwAA/AAA/QAdAAAAAAEBAAAAAAGCAAEAAAAqFAEYACoAAAAAAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDFQAtAAEYAAAAAAABLgAAAAAHAQMAAAA0+wEAAE0BAYgAAAAAbwMBALwBAZwCAAAAnwEDAqQCBAAAADBApAQHAAAAYEBNBAQkCAAAAE0DBHUFAAAAnwICAqQDBAAAADBA+wQBAE0EBMEBAAAATQQEfgkAAACfAwIC2QQAABIAAwAwBAETCgAAANkEAQASAgAAEgICABIAAwASAAIAMAQBgAsAAADABAwAMAQBNA0AAAD7BAAATQQE5A4AAAD7BQAATQUFyg8AAABSBgEAnwUCAlIGAACfBAMC2QUDABICAAASAAQAggUCABADFgMXAxgDGQQAADBAAxoDGwQAAGBAAxwDEgMKAxMGBAMUAx0DEAQAAwQFBQABGAAAAAAAAAABAAAAAAAAAAABAAAAAAAAAAEAAAATAAAAAAAADgAAAgAAAAAAAAAAAAEAAAAGAAAAAAQAAAECABajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAhBgAAAJ8BAgKkAgUAAABAQE0DAC0HAAAAnwICAsADCAASAAEAEgAAABIAAgCCAwIACQMeBAAAAEADHwMgAxkEAABAQAMhAyIGBgEGAQABGAAAAAAAAAABAAAAAAEAAAAAAgAAAAABAAAAAAeLNtP+XD7oHqC5T1iohmMm+y7Eirnyuf8=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:43
-- Luau version 6, Types version 3
-- Time taken: 0.003560 seconds

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
        --[[ Upvalues[1]:
            [1]: store_upvr (readonly)
        ]]
        store_upvr:dispatch({
            type = "tradeInitiationsSet";
            list = {{
                name = "badcc";
                userId = 1;
            }, {
                name = "asimo3089";
                userId = 2;
            }, {
                name = "TWENTYMOREMINUTES";
                userId = 3;
            }};
        })
    end
    local TradeInitiations_upvr = require(script.Parent.TradeInitiations)
    function any_extend_result1.render(arg1_3) -- Line 28
        --[[ Upvalues[4]:
            [1]: Roact_upvr (copied, readonly)
            [2]: RoactRodux_upvr (copied, readonly)
            [3]: store_upvr (readonly)
            [4]: TradeInitiations_upvr (readonly)
        ]]
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = store_upvr;
        }, {Roact_upvr.createElement(TradeInitiations_upvr, {
            onAccept = function(arg1_4) -- Line 33, Named "onAccept"
                print("accept", arg1_4)
            end;
            onDecline = function(arg1_5) -- Line 36, Named "onDecline"
                print("decline", arg1_5)
            end;
        })})
    end
    function any_extend_result1.willUnmount(arg1_6) -- Line 42
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 45
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end