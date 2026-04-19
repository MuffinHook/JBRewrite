-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlDk1hbmlmZXN0QmluZGVyBnNjcmlwdAZQYXJlbnQKRG9vckNvbnN0cwNuZXcIVEFHX05BTUUKaW5uZXJNb2RlbBBJTk5FUl9NT0RFTF9OQU1FBERvb3IAAQgAAAECACmjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCJBgAAAJ8BAgKkAgUAAABAQKQDCAAAAHBATQMDJAkAAABNAwPfCgAAAJ8CAgJNAwHvCwAAAE0EArQMAAAA4gUOAE0GAkkPAAAAMAYF3g0AAACkBgUAAABAQKQHCAAAAHBATQcHJAkAAABNBwfvEAAAAJ8GAgCfAwAAggMAABEDAQQAAABAAwIDAwMEBAAAQEADBQMGBAAAcEADBwMIAwkDCgMLBQENAwwDDQABAAEYAAAAAAAAAAEAAAAAAQAAAAAAAAAAAgAAAAABAAAAAQAAAAAAAAAA/gABAAAAAACy/yb78ZVVk1UN6sQDjEb6wucxj4A7TPo=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:25
-- Luau version 6, Types version 3
-- Time taken: 0.000528 seconds

local DoorConsts = require(script.Parent.DoorConsts)
return require(game:GetService("ReplicatedStorage").ManifestBinder).new(DoorConsts.TAG_NAME, {
    innerModel = DoorConsts.INNER_MODEL_NAME;
}, require(script.Parent.Door))