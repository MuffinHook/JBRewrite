-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4BVRyYWRlFUludmVudG9yeVJlZHVjZXJVdGlscw1jcmVhdGVSZWR1Y2VyG3RyYWRlSW52ZW50b3J5U2V0SXRlbXNPd25lZA1zZXRJdGVtc093bmVkAAEHAAABAgAeowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIApwYAAACfAQICpAIFAAAAQEBNAwC7BwAAAE0DA7YIAAAAnwICAk0DAdYJAAAA/wQAAAAAAADiBQsATQYC5AwAAAAwBgW6CgAAAJ8DAwCCAwAADQMBBAAAAEADAgMDAwQEAABAQAMFAwYDBwMIAwkFAQoDCgABAAEYAAAAAAAAAAEAAAAAAQAAAAAAAAIAAAAAAQAAAP8AAQAAAAAANijFaXuSRVG+PJ4v3bJkOkYw0h0E7K9o

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:23
-- Luau version 6, Types version 3
-- Time taken: 0.000493 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer({}, {
    tradeInventorySetItemsOwned = require(ReplicatedStorage.Trade.InventoryReducerUtils).setItemsOwned;
})