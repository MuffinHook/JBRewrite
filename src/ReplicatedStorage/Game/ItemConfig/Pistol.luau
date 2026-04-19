-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMpBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVTY29wZQ5MZWZ0RWxib3dBbmdsZQ9SaWdodEVsYm93QW5nbGURTGVmdFdyaXN0Um90YXRpb24SUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZBbmdsZXMGTW90aW9uEmd1bl9waXN0b2xfc2hvdF8wNBRwaXN0b2xfc2hvdF9zaWxlbmNlZBZndW5fcGlzdG9sX2RyeV9maXJlXzAxGGd1bl9waXN0b2xfc2xpZGVfZmFzdF8wMRJndW5fcGlzdG9sX2NvY2tfMDEYZ3VuX3Bpc3RvbF9pbnNlcnRfbWFnXzAxGGd1bl9waXN0b2xfcmVtb3ZlX21hZ18wMQVTb3VuZAdNYWdTaXplEUNhbVNoYWtlTWFnbml0dWRlC0J1bGxldFNwZWVkDkZpcmVBdXRvTW9iaWxlCEZpcmVBdXRvCEZpcmVGcmVxClJlbG9hZFRpbWUGRGFtYWdlBVByaWNlBkltYWdlcwZQaXN0b2wHSW1hZ2VJZAABCAAAAQIAgQGjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgBiBgAAAE0CAsoHAAAAnwECAv8CBQAAAAAA4gMOAOIEEADiBRQAbwYVADAGBYARAAAAbwYWADAGBeUSAAAATDYAAqQGGQAAYHCBnwYBAjAGBY0TAAAAMAUEmA8AAAAwBAO9CAAAAOIEEADiBRQAbwYaADAGBYARAAAAbwYbADAGBeUSAAAAbwYcADAGBY0TAAAAMAUEmA8AAAAwBAP0CQAAAIwEAAAwBAPSCgAAAIwEAAAwBAOgCwAAAKQEHwAAeNCBjAUAAG8GIACMBwAAnwQEAjAEA4UMAAAApAQhAABg0IGfBAECMAQDDg0AAAAwAwKXIgAAAOIDKgBvBCsAMAQDTSMAAABvBCwAMAQDCSQAAABvBC0AMAQD5iUAAABvBC4AMAQDhCYAAABvBC8AMAQD0icAAABvBDAAMAQDySgAAABvBDEAMAQDYikAAAAwAwJuMgAAAIwDCAAwAwL3MwAAAIwDCgAwAwKjNAAAAIwD6AMwAwKlNQAAAKkDAQAwAwI9NgAAAKkDAAAwAwJNNwAAAIwDBQAwAwJAOAAAAIwDAQAwAwK8OQAAAIwDDwAwAwIPOgAAAIwDAAAwAwIkOwAAAE0DAeM8AAAATQMDlz0AAAAwAwKWPgAAAIICAgA/AwEEAAAAQAMCAwMDBAQAAEBAAwUDBgMHAwgDCQMKAwsDDAUGCAkKCwwNAw0FAQ8DDgMPAxAFAxESEwfNzEw+ZmamPzMzs78AAAAABwAAAAAzM7M+AAAAAAAAAAADEQMSBABgcIEHzczMPQAAwD8AAMC/AAAAAAfNzEw+AAAAPwAAAAAAAAAAB83MzD0AAAAAzczMvQAAAAADEwMUBAB40IECUGnrMcco/j8EAGDQgQMVAxYDFwMYAxkDGgMbAxwFByMkJSYnKCkCAACAzJDl30ECAABgDuEJD0ICAACAVI7l30ECAADAFI/l30ECAAAACY3l30ECAABAh4/l30ECAACAx4/l30EDHQMeAx8DIAMhAyIDIwMkAyUDJgMnAygDKQABAAEYAAAAAAAAAAEAAAAAAAABAAEBAQEAAAEAAAEAAAAAAP0A/wALAQEAAAEAAAEAAP0A/wAIAAABAAACAAAAAAAAAAEAAAAA6AAaAQAAAQAAAQAAAQAAAQAAAQAAAQAA+QAJAAABAAABAAABAAABAAABAAABAAABAAABAAABAAAAAAACAQAAAAAA/1Nc5mn4Za87CAfh7DjTeY9LS5LNlzbn

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:49
-- Luau version 6, Types version 3
-- Time taken: 0.001776 seconds

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
        gun_pistol_shot_04 = 2140554034;
        pistol_shot_silenced = 16663716300;
        gun_pistol_dry_fire_01 = 2140551506;
        gun_pistol_slide_fast_01 = 2140552275;
        gun_pistol_cock_01 = 2140550180;
        gun_pistol_insert_mag_01 = 2140552733;
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
    Price = 0;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.Pistol;
}