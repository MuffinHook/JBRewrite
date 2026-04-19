-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTBXN0b3JlTkVycm9yIGluaXRpYWxpemluZyBTdG9yZVByb3ZpZGVyLiBFeHBlY3RlZCBhIGBzdG9yZWAgcHJvcCB0byBiZSBhIFJvZHV4IHN0b3JlLg12YWxpZGF0ZVByb3BzBGluaXQNY3JlYXRlRWxlbWVudAhQcm92aWRlcgV2YWx1ZQhvbmVDaGlsZAVwcm9wcwhDaGlsZHJlbgZyZW5kZXIHcmVxdWlyZQZzY3JpcHQGUGFyZW50BVJvYWN0DFN0b3JlQ29udGV4dAlDb21wb25lbnQNU3RvcmVQcm92aWRlcgZleHRlbmQABAQBAAAAAAlNAQB+AAAAAEcBBAAAAACAqQIAAG8DAQCCAgMAqQIBAIICAgACAwEDAgAHAwEYAAABAAEAAAIACAAAAAADAgAAAAAFTQIBfgAAAAAwAgB+AAAAAIIAAQABAwEADwQBGAAAAAABEAAAAAAIAQIAAAAX+wEAAE0BAcoAAAAA+wIBAE0CAmwBAAAA4gMDAE0EAH4EAAAAMAQDzAIAAAD7BAAATQQEBgUAAABNBgAHBgAAAPsHAABNBwfOBwAAAIcFBgefBAIAnwEAAIIBAAAIAwUDBgMHBQECAwEDCAMJAwoAEwsBGAAAAAAAAAABAAAAAQAAAQAAAAAA//4AFAAAAAAFAAABAgAnowAAAKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BASQEAAAATQEBIQUAAACfAAICpAEBAAAAAECkAgMAAAAgQE0CAiQEAAAATQIC8QYAAACfAQICTQIAiAcAAABvBAgAvAICnAkAAACfAgMCwAMKADADAvgLAAAAwAMMADADAhMNAAAAwAMOABIAAAASAAEAMAMCgA8AAACCAgIAEAMMBAAAAEADDQQAACBAAw4DDwMQAxEDEgMTBgADAwYBAwQGAgMLAwABAgEAARgAAAAAAAAAAAAAAAACAAAAAAAAAAACAAAAAAACAAAIAAAEAAAAAAgBAAAAAANjbw+zeL+4uIE/y1jtiHB0E3cYx1GrZbI=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:31:37
-- Luau version 6, Types version 3
-- Time taken: 0.001478 seconds

local Roact_upvr = require(script.Parent.Parent.Roact)
local any_extend_result1 = Roact_upvr.Component:extend("StoreProvider")
function any_extend_result1.validateProps(arg1) -- Line 7
    if arg1.store == nil then
        return false, "Error initializing StoreProvider. Expected a `store` prop to be a Rodux store."
    end
    return true
end
function any_extend_result1.init(arg1, arg2) -- Line 15
    arg1.store = arg2.store
end
local StoreContext_upvr = require(script.Parent.StoreContext)
function any_extend_result1.render(arg1) -- Line 19
    --[[ Upvalues[2]:
        [1]: Roact_upvr (readonly)
        [2]: StoreContext_upvr (readonly)
    ]]
    return Roact_upvr.createElement(StoreContext_upvr.Provider, {
        value = arg1.store;
    }, Roact_upvr.oneChild(arg1.props[Roact_upvr.Children]))
end
return any_extend_result1