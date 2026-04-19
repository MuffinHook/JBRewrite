-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMrBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlDUdhbWVwYXNzVXRpbHMIR2FtZXBhc3MIUmVzb3VyY2UIU2V0dGluZ3MDSGlwBVNjb3BlDkxlZnRFbGJvd0FuZ2xlD1JpZ2h0RWxib3dBbmdsZRFMZWZ0V3Jpc3RSb3RhdGlvbhJSaWdodFdyaXN0Um90YXRpb24HU3ByaW5ncwpJdGVtT2Zmc2V0DEl0ZW1Sb3RhdGlvbgxOZWNrUm90YXRpb24HVmVjdG9yMwNuZXcGQ0ZyYW1lBkFuZ2xlcwZNb3Rpb24fZ3VuX3NlbWlfYXV0b19yaWZsZV9kcnlfZmlyZV8wMRtndW5fc2VtaV9hdXRvX3JpZmxlX3Nob3RfMDEkZ3VuX3NlbWlfYXV0b19yaWZsZV9tYWdhemluZV9sb2FkXzAxJmd1bl9zZW1pX2F1dG9fcmlmbGVfbWFnYXppbmVfdW5sb2FkXzAxBVNvdW5kB01hZ1NpemURQ2FtU2hha2VNYWduaXR1ZGULQnVsbGV0U3BlZWQIRmlyZUF1dG8IRmlyZUZyZXEKUmVsb2FkVGltZQZEYW1hZ2UFUHJpY2UGSW1hZ2VzBVJpZmxlB0ltYWdlSWQMRW51bUdhbWVwYXNzBFNXQVQEQk9TUxJSZXF1aXJlQW55R2FtZXBhc3MAAQkAAAECAIoBowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQMAvQcAAABNAgM+BgAAAJ8BAgKkAgUAAABAQE0DAGIIAAAATQMDygkAAACfAgIC/wMFAAAAAADiBBAA4gUSAOIGFgBvBxcAMAcGgBMAAABvBxgAMAcG5RQAAABMNgACpAcbAABokIGfBwECMAcGjRUAAAAwBgWYEQAAADAFBL0KAAAA4gUSAOIGFgBvBxwAMAcGgBMAAABvBx0AMAcG5RQAAABvBx4AMAcGjRUAAAAwBgWYEQAAADAFBPQLAAAAjAUAADAFBNIMAAAAjAUAADAFBKANAAAApAUhAACA8IGMBgAAbwciAIwIAACfBQQCMAUEhQ4AAACkBSMAAGjwgZ8FAQIwBQQODwAAADAEA5ckAAAA4gQpAG8FKgAwBQTjJQAAAG8FKwAwBQTtJgAAAG8FLAAwBQT/JwAAAG8FLQAwBQQeKAAAADAEA24uAAAAjAQeADAEA/cvAAAAjAQKADAEA6MwAAAAjATcBTAEA6UxAAAAqQQBADAEA00yAAAAjAQNADAEA0AzAAAAbwQ0ADAEA7w1AAAAjAQFADAEAw82AAAAjAQAADAEAyQ3AAAATQQC4zgAAABNBAStOQAAADAEA5Y6AAAA/wQAAAIAAABNBQGNOwAAAE0FBTI8AAAATQYBjTsAAABNBgYVPQAAAMUEBQMBAAAAMAQDLz4AAACCAwIAPwMBBAAAAEADAgMDAwQEAABAQAMFAwYDBwMIAwkDCgMLAwwDDQMOBQYKCwwNDg8DDwUBEQMQAxEDEgUDExQVB5qZGT8AAIA/zczMvwAAAAAHmpkZvpqZGT8AAAAAAAAAAAMTAxQEAGiQgQfNzMw+ZmamPzMz878AAAAAB5qZGT4zMzM/AAAAAAAAAAAHAAAAAAAAAADNzMy+AAAAAAMVAxYEAIDwgQJQaesxxyj+PwQAaPCBAxcDGAMZAxoDGwUEJSYnKAIAAIBW/prfQQIAAOjKuAQPQgIAAMCN/prfQQIAAEDI/prfQQMcAx0DHgMfAyADIQIAAAAAAAD4PwMiAyMDJAMlAyYDJwMoAykDKgMrAAEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAACAAEBAQEAAAEAAAEAAAAAAP0A/wAHAQEAAAEAAAEAAP0A/wAIAAABAAACAAAAAAAAAAEAAAAA7AAWAQAAAQAAAgAAAQAA+wAHAAABAAABAAABAAABAAABAAABAAABAAABAAAAAAABAAEAAAABAAAAAAD+AAUBAAAAAABMynlcA+MI+RctQjV6HZOMPNJuKH4OE10=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:52
-- Luau version 6, Types version 3
-- Time taken: 0.001514 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
return {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.60000, 1, -1.6000);
                ItemRotation = Vector3.new(-0.1500, 0.60000, 0);
                NeckRotation = Vector3.new();
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(0.40000, 1.29999, -1.8999);
                ItemRotation = Vector3.new(0.15000, 0.69999, 0);
                NeckRotation = Vector3.new(0, 0, -0.4000);
            };
        };
        LeftElbowAngle = 0;
        RightElbowAngle = 0;
        LeftWristRotation = CFrame.Angles(0, 1.8849555921538759, 0);
        RightWristRotation = CFrame.new();
    };
    Sound = {
        gun_semi_auto_rifle_dry_fire_01 = 2121005402;
        gun_semi_auto_rifle_shot_01 = 16652900701;
        gun_semi_auto_rifle_magazine_load_01 = 2121005623;
        gun_semi_auto_rifle_magazine_unload_01 = 2121005857;
    };
    MagSize = 30;
    CamShakeMagnitude = 10;
    BulletSpeed = 1500;
    FireAuto = true;
    FireFreq = 13;
    ReloadTime = 1.5;
    Damage = 5;
    Price = 0;
    ImageId = require(ReplicatedStorage.Resource.Settings).Images.Rifle;
    RequireAnyGamepass = {GamepassUtils.EnumGamepass.SWAT, GamepassUtils.EnumGamepass.BOSS};
}