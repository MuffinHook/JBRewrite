-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMoBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVTY29wZQ5MZWZ0RWxib3dBbmdsZQ9SaWdodEVsYm93QW5nbGURTGVmdFdyaXN0Um90YXRpb24SUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZBbmdsZXMGTW90aW9uEmd1bl9waXN0b2xfc2hvdF8wNBhndW5fcGlzdG9sX3NsaWRlX2Zhc3RfMDEYZ3VuX3Bpc3RvbF9pbnNlcnRfbWFnXzAxGGd1bl9waXN0b2xfcmVtb3ZlX21hZ18wMQVTb3VuZAdNYWdTaXplEUNhbVNoYWtlTWFnbml0dWRlC0J1bGxldFNwZWVkDkZpcmVBdXRvTW9iaWxlCEZpcmVBdXRvCEZpcmVGcmVxClJlbG9hZFRpbWUGRGFtYWdlBVByaWNlDVNvcnRPcmRlclBhZ2UGSW1hZ2VzCk5lcmZQaXN0b2wHSW1hZ2VJZApTaG9wSGlkZGVuAAEIAAABAgB+owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAYgYAAABNAgLKBwAAAJ8BAgL/AgUAAAAAAOIDDgDiBBAA4gUUAG8GFQAwBgWAEQAAAG8GFgAwBgXlEgAAAEw2AAKkBhkAAGBwgZ8GAQIwBgWNEwAAADAFBJgPAAAAMAQDvQgAAADiBBAA4gUUAG8GGgAwBgWAEQAAAG8GGwAwBgXlEgAAAG8GHAAwBgWNEwAAADAFBJgPAAAAMAQD9AkAAACMBAAAMAQD0goAAACMBAAAMAQDoAsAAACkBB8AAHjQgYwFAABvBiAAjAcAAJ8EBAIwBAOFDAAAAKQEIQAAYNCBnwQBAjAEAw4NAAAAMAMClyIAAADiAycAbwQoADAEA00jAAAAbwQpADAEA4QkAAAAbwQqADAEA8klAAAAbwQrADAEA2ImAAAAMAMCbiwAAACMAwgAMAMC9y0AAACMAwoAMAMCoy4AAACMA+gDMAMCpS8AAACpAwEAMAMCPTAAAACpAwAAMAMCTTEAAACMAwUAMAMCQDIAAACMAwEAMAMCvDMAAACMAw8AMAMCDzQAAACMA+gDMAMCJDUAAACMA///MAMC6DYAAABNAwHjNwAAAE0DAzc4AAAAMAMCljkAAACpAwEAMAMCrzoAAACCAgIAOwMBBAAAAEADAgMDAwQEAABAQAMFAwYDBwMIAwkDCgMLAwwFBggJCgsMDQMNBQEPAw4DDwMQBQMREhMHzcxMPmZmpj8zM7O/AAAAAAcAAAAAMzOzPgAAAAAAAAAAAxEDEgQAYHCBB83MzD0AAMA/AADAvwAAAAAHzcxMPgAAAD8AAAAAAAAAAAfNzMw9AAAAAM3MzL0AAAAAAxMDFAQAeNCBAlBp6zHHKP4/BABg0IEDFQMWAxcDGAMZBQQjJCUmAgAAMP8BzPlBAgAAwBSP5d9BAgAAsA8CzPlBAgAAgMeP5d9BAxoDGwMcAx0DHgMfAyADIQMiAyMDJAMlAyYDJwMoAAEAARgAAAAAAAAAAQAAAAAAAAEAAQEBAQAAAQAAAQAAAAAA/QD/AAsBAQAAAQAAAQAA/QD/AAgAAAEAAAIAAAAAAAAAAQAAAADoABoBAAABAAABAAABAAD8AAYAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAAAAAEAAAIBAAAAAAAQ1emf8v2bEqod/P+LLWHrYM3+6yIRg54=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:47
-- Luau version 6, Types version 3
-- Time taken: 0.001742 seconds

return {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.20000, 1.29999, -1.3999);
                ItemRotation = Vector3.new(0, 0.34999, 0);
                NeckRotation = Vector3.new();
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(0.10000, 1.5, -1.5);
                ItemRotation = Vector3.new(0.20000, 0.5, 0);
                NeckRotation = Vector3.new(0.10000, 0, -0.1000);
            };
        };
        LeftElbowAngle = 0;
        RightElbowAngle = 0;
        LeftWristRotation = CFrame.Angles(0, 1.8849555921538759, 0);
        RightWristRotation = CFrame.new();
    };
    Sound = {
        gun_pistol_shot_04 = 6924804083;
        gun_pistol_slide_fast_01 = 2140552275;
        gun_pistol_insert_mag_01 = 6924804347;
        gun_pistol_remove_mag_01 = 2140552990;
    };
    MagSize = 8;
    CamShakeMagnitude = 10;
    BulletSpeed = 1000;
    FireAutoMobile = true;
    FireAuto = false;
    FireFreq = 5;
    ReloadTime = 1;
    Damage = 15;
    Price = 1000;
    SortOrderPage = -1;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.NerfPistol;
    ShopHidden = true;
}