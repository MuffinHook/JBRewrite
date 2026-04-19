-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVTY29wZQ5MZWZ0RWxib3dBbmdsZQ9SaWdodEVsYm93QW5nbGURTGVmdFdyaXN0Um90YXRpb24SUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZBbmdsZXMGTW90aW9uH2d1bl9zZW1pX2F1dG9fcmlmbGVfZHJ5X2ZpcmVfMDEbZ3VuX3NlbWlfYXV0b19yaWZsZV9zaG90XzAxJGd1bl9zZW1pX2F1dG9fcmlmbGVfbWFnYXppbmVfbG9hZF8wMSZndW5fc2VtaV9hdXRvX3JpZmxlX21hZ2F6aW5lX3VubG9hZF8wMQVTb3VuZAdNYWdTaXplEUNhbVNoYWtlTWFnbml0dWRlC0J1bGxldFNwZWVkCEZpcmVBdXRvCEZpcmVGcmVxClJlbG9hZFRpbWUGRGFtYWdlBVByaWNlBkltYWdlcwRBSzQ3B0ltYWdlSWQAAQgAAAECAHWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgBiBgAAAE0CAsoHAAAAnwECAv8CBQAAAAAA4gMOAOIEEADiBRQAbwYVADAGBYARAAAAbwYWADAGBeUSAAAATDYAAqQGGQAAYHCBnwYBAjAGBY0TAAAAMAUEmA8AAAAwBAO9CAAAAOIEEADiBRQAbwYaADAGBYARAAAAbwYbADAGBeUSAAAAbwYcADAGBY0TAAAAMAUEmA8AAAAwBAP0CQAAAIwEAAAwBAPSCgAAAIwEAAAwBAOgCwAAAKQEHwAAeNCBjAUAAG8GIACMBwAAnwQEAjAEA4UMAAAApAQhAABg0IGfBAECMAQDDg0AAAAwAwKXIgAAAOIDJwBvBCgAMAQD4yMAAABvBCkAMAQD7SQAAABvBCoAMAQD/yUAAABvBCsAMAQDHiYAAAAwAwJuLAAAAIwDHgAwAwL3LQAAAIwDCgAwAwKjLgAAAIwDGgQwAwKlLwAAAKkDAQAwAwJNMAAAAIwDDAAwAwJAMQAAAG8DMgAwAwK8MwAAAIwDBgAwAwIPNAAAAIwDmDowAwIkNQAAAE0DAeM2AAAATQMDZTcAAAAwAwKWOAAAAIICAgA5AwEEAAAAQAMCAwMDBAQAAEBAAwUDBgMHAwgDCQMKAwsDDAUGCAkKCwwNAw0FAQ8DDgMPAxAFAxESEweamRk/ZmZmP2Zmpr8AAAAAB5qZGb6amRk/AAAAAAAAAAADEQMSBABgcIEHzczMPs3MjD/NzMy/AAAAAAeamRk+MzMzPwAAAAAAAAAABwAAAAAAAAAAzczMvgAAAAADEwMUBAB40IECUGnrMcco/j8EAGDQgQMVAxYDFwMYAxkFBCMkJSYCAACAVv6a30ECAACAvbgED0ICAADAjf6a30ECAABAyP6a30EDGgMbAxwDHQMeAx8CAAAAAAAA+D8DIAMhAyIDIwMkAyUAAQABGAAAAAAAAAABAAAAAAAAAQABAQEBAAABAAABAAAAAAD9AP8ABwEBAAABAAABAAD9AP8ACAAAAQAAAgAAAAAAAAABAAAAAOwAFgEAAAEAAAIAAAEAAPsABwAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAAAAAgEAAAAAAALm5P5dFU45B8iJ60mQNgFy/vOKMCKO/w==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:38
-- Luau version 6, Types version 3
-- Time taken: 0.001627 seconds

return {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.60000, 0.89999, -1.2999);
                ItemRotation = Vector3.new(-0.1500, 0.60000, 0);
                NeckRotation = Vector3.new();
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(0.40000, 1.10000, -1.6000);
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
        gun_semi_auto_rifle_shot_01 = 16652900272;
        gun_semi_auto_rifle_magazine_load_01 = 2121005623;
        gun_semi_auto_rifle_magazine_unload_01 = 2121005857;
    };
    MagSize = 30;
    CamShakeMagnitude = 10;
    BulletSpeed = 1050;
    FireAuto = true;
    FireFreq = 12;
    ReloadTime = 1.5;
    Damage = 6;
    Price = 15000;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.AK47;
}