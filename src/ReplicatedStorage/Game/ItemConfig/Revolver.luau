-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMqBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVTY29wZQ5MZWZ0RWxib3dBbmdsZQ9SaWdodEVsYm93QW5nbGURTGVmdFdyaXN0Um90YXRpb24SUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZBbmdsZXMGTW90aW9uBXNob290C3JlbG9hZF9vcGVuDHJlbG9hZF9jbG9zZQ1idWxsZXRfaW5zZXJ0C2J1bGxldF9jYXNlDWN5bGluZGVyX3NwaW4FU291bmQHTWFnU2l6ZRFDYW1TaGFrZU1hZ25pdHVkZQtCdWxsZXRTcGVlZA5GaXJlQXV0b01vYmlsZQhGaXJlQXV0bwhGaXJlRnJlcRFHcmF2aXR5TXVsdGlwbGllcgpSZWxvYWRUaW1lBkRhbWFnZQVQcmljZQZJbWFnZXMIUmV2b2x2ZXIHSW1hZ2VJZAlFcXVpcFRpbWUAAQgAAAECAIQBowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAYgYAAABNAgLKBwAAAJ8BAgL/AgUAAAAAAOIDDgDiBBAA4gUUAG8GFQAwBgWAEQAAAG8GFgAwBgXlEgAAAEw2AAKkBhkAAGBwgZ8GAQIwBgWNEwAAADAFBJgPAAAAMAQDvQgAAADiBBAA4gUUAG8GGgAwBgWAEQAAAG8GGwAwBgXlEgAAAG8GHAAwBgWNEwAAADAFBJgPAAAAMAQD9AkAAACMBAAAMAQD0goAAACMBAAAMAQDoAsAAACkBB8AAHjQgYwFAABvBiAAjAcAAJ8EBAIwBAOFDAAAAKQEIQAAYNCBnwQBAjAEAw4NAAAAMAMClyIAAADiAykAbwQqADAEA8gjAAAAbwQrADAEA/8kAAAAbwQsADAEA04lAAAAbwQtADAEA5wmAAAAbwQuADAEA7cnAAAAbwQvADAEA88oAAAAMAMCbjAAAACMAwYAMAMC9zEAAACMA5YAMAMCozIAAACMAyADMAMCpTMAAACpAwEAMAMCPTQAAACpAwAAMAMCTTUAAABvAzYAMAMCQDcAAACMAwIAMAMC0DgAAABvAzkAMAMCvDoAAACMAxkAMAMCDzsAAACMAxAnMAMCJDwAAABNAwHjPQAAAE0DA84+AAAAMAMClj8AAABvA0AAMAMC10EAAACCAgIAQgMBBAAAAEADAgMDAwQEAABAQAMFAwYDBwMIAwkDCgMLAwwFBggJCgsMDQMNBQEPAw4DDwMQBQMREhMHH4VrPjMzsz8AAADAAAAAAAcAAAAAzczMPgAAAAAAAAAAAxEDEgQAYHCBB83MTD7NzMw/mpnZvwAAAAAHzcxMPgAAAD8AAAAAAAAAAAfNzMw9AAAAAJqZmb4AAAAAAxMDFAQAeNCBAlBp6zHHKP4/BABg0IEDFQMWAxcDGAMZAxoDGwUGIyQlJicoAgAAqNrgCQ9CAgAAQJjEvPFBAgAAIAPFvPFBAgAAABbFvPFBAgAAwCHFvPFBAgAAAFzFvPFBAxwDHQMeAx8DIAMhAgAAAAAAAARAAyIDIwJmZmZmZmbmPwMkAyUDJgMnAygDKQKamZmZmZnZPwMqAAEAARgAAAAAAAAAAQAAAAAAAAEAAQEBAQAAAQAAAQAAAAAA/QD/AAsBAQAAAQAAAQAA/QD/AAgAAAEAAAIAAAAAAAAAAQAAAADoABoBAAABAAABAAABAAABAAABAAD6AAgAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAAAAAEAAAIBAAAAAABrJYBKDtYZpQnnnRnz6UmWGz2XPlnh6ks=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:51
-- Luau version 6, Types version 3
-- Time taken: 0.001798 seconds

return {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.23000, 1.39999, -2);
                ItemRotation = Vector3.new(0, 0.40000, 0);
                NeckRotation = Vector3.new();
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(0.20000, 1.60000, -1.7000);
                ItemRotation = Vector3.new(0.20000, 0.5, 0);
                NeckRotation = Vector3.new(0.10000, 0, -0.3000);
            };
        };
        LeftElbowAngle = 0;
        RightElbowAngle = 0;
        LeftWristRotation = CFrame.Angles(0, 1.8849555921538759, 0);
        RightWristRotation = CFrame.new();
    };
    Sound = {
        shoot = 16663714645;
        reload_open = 4761340292;
        reload_close = 4761342002;
        bullet_insert = 4761342304;
        bullet_case = 4761342492;
        cylinder_spin = 4761343424;
    };
    MagSize = 6;
    CamShakeMagnitude = 150;
    BulletSpeed = 800;
    FireAutoMobile = true;
    FireAuto = false;
    FireFreq = 2.5;
    GravityMultiplier = 2;
    ReloadTime = 0.7;
    Damage = 25;
    Price = 10000;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.Revolver;
    EquipTime = 0.4;
}