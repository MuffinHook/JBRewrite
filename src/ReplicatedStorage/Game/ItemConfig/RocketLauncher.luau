-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMrBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQpSdW5TZXJ2aWNlB3JlcXVpcmUDQXBwCFJ1blV0aWxzCFJlc291cmNlCFNldHRpbmdzA0hpcAVTY29wZQ5MZWZ0RWxib3dBbmdsZQ9SaWdodEVsYm93QW5nbGURTGVmdFdyaXN0Um90YXRpb24SUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZNb3Rpb24Vd2VhcG9uX2Nhbm5vbl9zaG90XzA0Fmd1bl9waXN0b2xfZHJ5X2ZpcmVfMDEFU291bmQHTWFnU2l6ZQtBbW1vQ3VycmVudAhGaXJlQXV0bwhpc1N0dWRpbwhGaXJlRnJlcQpSZWxvYWRUaW1lC1JvY2tldFNwZWVkBkRhbWFnZQZSYWRpdXMFUHJpY2UGSW1hZ2VzDlJvY2tldExhdW5jaGVyB0ltYWdlSWQRQ3VzdG9tU2hvb3RSZW1vdGUSQ3VzdG9tRGFtYWdlUmVtb3RlCUVxdWlwVGltZQ9FcXVpcFRpbWVGb3JjZWQAAQkAAAECAI4BowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBAQAAAABAbwMEALwBARYDAAAAnwEDAqQCBgAAAFBATQMAwQcAAABNAwNCCAAAAJ8CAgKkAwYAAABQQE0EAGIJAAAATQQEygoAAACfAwIC/wQFAAAAAADiBREA4gYTAOIHFwBvCBgAMAgHgBQAAABvCBkAMAgH5RUAAABMNgACpAgcAABsoIGfCAECMAgHjRYAAAAwBwaYEgAAADAGBb0LAAAA4gYTAOIHFwBvCBgAMAgHgBQAAABvCBkAMAgH5RUAAABvCB0AMAgHjRYAAAAwBwaYEgAAADAGBfQMAAAAjAYAADAGBdINAAAAjAYAADAGBaAOAAAApAYfAABs4IGfBgECMAYFhQ8AAACkBh8AAGzggZ8GAQIwBgUOEAAAADAFBJcgAAAA4gUjAG8GJAAwBgVnIQAAAG8GJQAwBgXmIgAAADAFBG4mAAAAjAUKADAFBPcnAAAAjAUAADAFBLkoAAAAqQUAADAFBE0pAAAATQYC6ioAAACfBgECDgYCAIwFAwBlAAEAbwUrADAFBEAsAAAAbwUtADAFBLwuAAAAjAXIADAFBOIvAAAAjAVGADAFBA8wAAAAjAUUADAFBHExAAAAbwUyADAFBCQzAAAATQUD4zQAAABNBQXTNQAAADAFBJY2AAAAqQUBADAFBDI3AAAAqQUBADAFBHY4AAAAjAUBADAFBNc5AAAAqQUBADAFBHw6AAAAggQCADsDAQQAAABAAwIDAwMEAwUEAABQQAMGAwcDCAMJAwoDCwMMAw0DDgMPBQYLDA0ODxADEAUBEgMRAxIDEwUDFBUWB83MTD8zM7M/zcxMvwAAAAAHAAAAANsPST8AAAAAAAAAAAMUAxUEAGyggQcAAAAAAAAAAAAAAAAAAAAAAxYEAGzggQMXAxgDGQUCISICAABgGbht4EECAACAVI7l30EDGgMbAxwDHQMeApqZmZmZmdk/Ax8CAAAAAAAA+D8DIAMhAyIDIwIAAAAAAIjjQAMkAyUDJgMnAygDKQMqAysAAQABGAAAAAAAAAABAAAAAAABAAAAAAAAAQAAAAAAAAIAAQEBAQAAAQAAAQAAAAAA/QD/AAcBAQAAAQAAAQAA/QD/AAgAAAEAAAIAAAAAAQAAAADsABYBAAABAAD+AAQAAAEAAAEAAAEAAAAAAAAAAAEAAAEAAAEAAAEAAAEAAAEAAAAAAAEAAAEAAAEAAAEAAAIBAAAAAACI5F5yRDC8yV8/JTLVHyEG+PxJBrogNHM=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:53
-- Luau version 6, Types version 3
-- Time taken: 0.001947 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.80000, 1.39999, -0.8000);
                ItemRotation = Vector3.new(0, 0.78539, 0);
                NeckRotation = Vector3.new();
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(0.80000, 1.39999, -0.8000);
                ItemRotation = Vector3.new(0, 0.78539, 0);
                NeckRotation = Vector3.new(0, 0, 0);
            };
        };
        LeftElbowAngle = 0;
        RightElbowAngle = 0;
        LeftWristRotation = CFrame.new();
        RightWristRotation = CFrame.new();
    };
    Sound = {
        weapon_cannon_shot_04 = 2205008075;
        gun_pistol_dry_fire_01 = 2140551506;
    };
    MagSize = 10;
    AmmoCurrent = 0;
}
local var9 = false
module.FireAuto = var9
if require(ReplicatedStorage.App.RunUtils).isStudio() then
    var9 = 3
else
    var9 = 0.4
end
module.FireFreq = var9
module.ReloadTime = 1.5
module.RocketSpeed = 200
module.Damage = 70
module.Radius = 20
module.Price = 40000
module.ImageId = require(ReplicatedStorage.Resource.Settings).Images.RocketLauncher
module.CustomShootRemote = true
module.CustomDamageRemote = true
module.EquipTime = 1
module.EquipTimeForced = true
return module