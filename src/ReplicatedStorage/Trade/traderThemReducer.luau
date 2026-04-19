-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4BnNjcmlwdAZQYXJlbnQRVHJhZGVSZWR1Y2VyVXRpbHMNY3JlYXRlUmVkdWNlcgtnZXREZWZhdWx0cxB1cGRhdGVUcmFkZXJUaGVtBnVwZGF0ZQABBwAAAQIAIaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAqQCBQAAAEBApAMIAAAAcEBNAwMkCQAAAE0DA8UKAAAAnwICAk0DAdYLAAAATQQCDQwAAACfBAEC4gUOAE0GAsYPAAAAMAYFJA0AAACfAwMAggMAABADAQQAAABAAwIDAwMEBAAAQEADBQMGBAAAcEADBwMIAwkDCgMLBQENAwwAAQABGAAAAAAAAAABAAAAAAEAAAAAAAAAAAIAAAAAAAEAAAD/AAEAAAAAAKhX4pnbO0YKUu5I9flLhM/YT/XtmpOImA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:26
-- Luau version 6, Types version 3
-- Time taken: 0.000712 seconds

local TradeReducerUtils = require(script.Parent.TradeReducerUtils)
return require(game:GetService("ReplicatedStorage").Rodux).createReducer(TradeReducerUtils.getDefaults(), {
    updateTraderThem = TradeReducerUtils.update;
})