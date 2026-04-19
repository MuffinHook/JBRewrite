-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4BnNjcmlwdAZQYXJlbnQRVHJhZGVSZWR1Y2VyVXRpbHMNY3JlYXRlUmVkdWNlcgtnZXREZWZhdWx0cw51cGRhdGVUcmFkZXJNZRRhZGRUcmFkZXJNZU9mZmVySXRlbRdyZW1vdmVUcmFkZXJNZU9mZmVySXRlbR5yZW1vdmVUcmFkZXJNZU9mZmVySXRlbUJ5SW5kZXgGdXBkYXRlB2FkZEl0ZW0KcmVtb3ZlSXRlbRFyZW1vdmVJdGVtQnlJbmRleAABBwAAAQIALaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAqQCBQAAAEBApAMIAAAAcEBNAwMkCQAAAE0DA8UKAAAAnwICAk0DAdYLAAAATQQCDQwAAACfBAEC4gURAE0GAsYSAAAAMAYFPg0AAABNBgJYEwAAADAGBdgOAAAATQYCfRQAAAAwBgVuDwAAAE0GAhcVAAAAMAYFEhAAAACfAwMAggMAABYDAQQAAABAAwIDAwMEBAAAQEADBQMGBAAAcEADBwMIAwkDCgMLAwwDDQMOBQQNDg8QAw8DEAMRAxIAAQABGAAAAAAAAAABAAAAAAEAAAAAAAAAAAIAAAAAAAEAAAABAAAAAQAAAAEAAAD8AAEAAAAAAIsU5meUMsN9mDs+dOUyHcX7DPETudCMZg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:26
-- Luau version 6, Types version 3
-- Time taken: 0.000563 seconds

local TradeReducerUtils = require(script.Parent.TradeReducerUtils)
return require(game:GetService("ReplicatedStorage").Rodux).createReducer(TradeReducerUtils.getDefaults(), {
    updateTraderMe = TradeReducerUtils.update;
    addTraderMeOfferItem = TradeReducerUtils.addItem;
    removeTraderMeOfferItem = TradeReducerUtils.removeItem;
    removeTraderMeOfferItemByIndex = TradeReducerUtils.removeItemByIndex;
})