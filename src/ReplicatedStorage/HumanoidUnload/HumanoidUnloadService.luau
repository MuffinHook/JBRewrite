-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlA1N0ZAZTaWduYWwDbmV3D29uSHVtYW5vaWRBZGRlZBJvbkh1bWFub2lkUmVtb3ZpbmcJbWFwSG9va2VkAAEFAAABAgAfowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgIfBwAAAJ8BAgL/AgAAAAAAAP8DAwAAAAAATQQB7wgAAACfBAECMAQD9AkAAABNBAHvCAAAAJ8EAQIwBAMKCgAAADACA5cLAAAAggMCAAwDAQQAAABAAwIDAwMEBAAAQEADBQMGAwcDCAMJAwoAAQABGAAAAAAAAAABAAAAAAAAAgACAAEAAAAAAQAAAAABAAEBAAAAAAAHO7qh4vHLvauqnVUrMSSYdyOt1TX/0KA=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:34
-- Luau version 6, Types version 3
-- Time taken: 0.000603 seconds

local Signal = require(game:GetService("ReplicatedStorage").Std.Signal)
return {
    onHumanoidAdded = Signal.new();
    onHumanoidRemoving = Signal.new();
    mapHooked = {};
}