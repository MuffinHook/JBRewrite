-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdBHR5cGUFdmFsdWUKc2V0VmlzaWJsZQhkaXNwYXRjaARpbml0BXByaW50EGF0dGVtcHRQbGFjZUl0ZW0TYXR0ZW1wdFB1cmNoYXNlSXRlbQ1jcmVhdGVFbGVtZW50DVN0b3JlUHJvdmlkZXIFc3RvcmULYXNwZWN0UmF0aW8UdmVydGljYWxQYWRkaW5nUmF0aW8GcmVuZGVyB3VubW91bnQJQ29tcG9uZW50A0FwcAZleHRlbmQHcmVxdWlyZQdIb21lQXBwBEhvbWUCVUkJaG9tZVN0b3JlBW1vdW50BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdApSb2FjdFJvZHV4AAcFAQEAAAAM+wEAAOIDAgBvBAMAMAQDcQAAAACpBAEAMAQDzAEAAAC8AQFMBAAAAJ8BAwGCAAEABQMBAwIFAgABAwMDBAAJBQEYAAABAAABAAD+AAAEDwAAAAADAAABAAAHowAAAKQAAQAAAABAbwECAN0CAACfAAABggABAAMDBgQAAABAAwcAHQcBGAABAAAAAAEdAAAAAAMAAAEAAAejAAAApAABAAAAAEBvAQIA3QIAAJ8AAAGCAAEAAwMGBAAAAEADCAAgCAEYAAEAAAAAASAAAAAACQEEAAAAIvsBAABNAQHKAAAAAPsCAQBNAgK6AQAAAOIDAwD7BAIAMAQDfgIAAAD/BAAAAQAAAPsFAABNBQXKAAAAAPsGAwDiBwgAjAgDADAIB4kEAAAAjAiAADAIB8YFAAAAwAgJADAIB4AGAAAAwAgKADAIBxUHAAAAnwUDAMUEBQABAAAAnwEEAIIBAAALAwkDCgMLBQECAwwDDQMHAwgFBAQFBgcGAQYCAgECFQ4BGAAAAAAAAAABAAABAAEAAAAAAQAAAQAAAQAAAwAA+gAA/QAXAAAAAAIAAgAAAAb7AAAATQAAEgAAAAD7AQEAnwACAYIAAQABAw8AKAABGAAAAAAAASkAAAAABwEDAAAAMvsBAABNAQGIAAAAAG8DAQC8AQGcAgAAAJ8BAwKkAgQAAAAwQPsEAQBNBARqBgAAAE0EBFwHAAAATQMEWAUAAACfAgICpAMEAAAAMED7BAEATQQEagYAAABNBASCCAAAAJ8DAgLZBAAAEgADADAEARMJAAAA2QQBABICAAASAgIAEgADABIAAgAwBAGACgAAAPsEAABNBATkCwAAAPsFAABNBQXKDAAAAFIGAQCfBQICUgYAAJ8EAwLZBQIAEgIAABIABACCBQIADQMQAxEDEgMTBAAAMEADFAMVAxYDFwMFAw4DGAMJAwADBAUAARgAAAAAAAAAAQAAAAAAAAAAAAEAAAAAAAAAAQAAAAwAAAAAAAASAAAAAAAAAAAAAQAAAAYAAAAABAAAAQIAFqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAqQCBQAAAEBATQMALQcAAACfAgICwAMIABIAAQASAAAAEgACAIIDAgAJAxkEAAAAQAMaAxsDEwQAAEBAAxwDHQYFAQUBAAEYAAAAAAAAAAEAAAAAAQAAAAACAAAAAAEAAAAABkOEyyLy6AP1cNGyi9/OulgznNxWcUChIw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:25
-- Luau version 6, Types version 3
-- Time taken: 0.002515 seconds

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
    local homeStore_upvr = require(ReplicatedStorage_upvr.Home.homeStore)
    function any_extend_result1.init(arg1_2) -- Line 9
        --[[ Upvalues[1]:
            [1]: homeStore_upvr (readonly)
        ]]
        homeStore_upvr:dispatch({
            type = "setVisible";
            value = true;
        })
    end
    local HomeApp_upvr = require(ReplicatedStorage_upvr.Home.UI.HomeApp)
    function any_extend_result1.render(arg1_3) -- Line 21
        --[[ Upvalues[4]:
            [1]: Roact_upvr (copied, readonly)
            [2]: RoactRodux_upvr (copied, readonly)
            [3]: homeStore_upvr (readonly)
            [4]: HomeApp_upvr (readonly)
        ]]
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = homeStore_upvr;
        }, {Roact_upvr.createElement(HomeApp_upvr, {
            aspectRatio = 3;
            verticalPaddingRatio = 128;
            attemptPlaceItem = function(...) -- Line 29, Named "attemptPlaceItem"
                print("attemptPlaceItem", ...)
            end;
            attemptPurchaseItem = function(...) -- Line 32, Named "attemptPurchaseItem"
                print("attemptPurchaseItem", ...)
            end;
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 40
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end