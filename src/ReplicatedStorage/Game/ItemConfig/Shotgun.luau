-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMuBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVTY29wZRFMZWZ0V3Jpc3RSb3RhdGlvbhJSaWdodFdyaXN0Um90YXRpb24OTGVmdEVsYm93QW5nbGUPUmlnaHRFbGJvd0FuZ2xlB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uClB1bXBPZmZzZXQIUHVtcERhbXAIUHVtcEZyZXEGQ0ZyYW1lBkFuZ2xlcwNuZXcGTW90aW9uE2d1bl9zaG90Z3VuX2NvY2tfMDETZ3VuX3Nob3RndW5fc2hvdF8wMRdndW5fc2hvdGd1bl9kcnlfZmlyZV8wMQVTb3VuZAdNYWdTaXplEUNhbVNoYWtlTWFnbml0dWRlC0J1bGxldFNwZWVkCEZpcmVBdXRvDkZpcmVBdXRvTW9iaWxlCEZpcmVGcmVxFElnbm9yZVZlcmlmeUZpcmVGcmVxDkJ1bGxldHNQZXJTaG90DEJ1bGxldFNwcmVhZARQdW1wD0xlZnRBcm1SZWxhdGl2ZQpSZWxvYWRUaW1lEUxvY2FsUmVsb2FkT2Zmc2V0BkRhbWFnZQVQcmljZQZJbWFnZXMHU2hvdGd1bgdJbWFnZUlkCUVxdWlwVGltZQABCAAAAQIAjQGjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgBiBgAAAE0CAsoHAAAAnwECAv8CBgAAAAAA4gMOAOIEEADiBRcAbwYYADAGBYARAAAAbwYZADAGBeUSAAAAbwYaADAGBY0TAAAAbwYaADAGBRUUAAAAbwYbADAGBTwVAAAAjAYUADAGBUAWAAAAMAUEmA8AAAAwBAO9CAAAAOIEEADiBRwAbwYdADAGBYARAAAAbwYeADAGBeUSAAAAbwYfADAGBY0TAAAAMAUEmA8AAAAwBAP0CQAAAKQEIgAAhACCjAUAAG8GIwCMBwAAnwQEAjAEA4UKAAAApAQlAACQAIKfBAECMAQDDgsAAABvBCYAMAQD0gwAAACMBAAAMAQDoA0AAAAwAwKXJwAAAOIDKwBvBCwAMAQDsCgAAABvBC0AMAQDRykAAABvBC4AMAQDySoAAAAwAwJuLwAAAIwDBQAwAwL3MAAAAIwDUAAwAwKjMQAAAIwDtgMwAwKlMgAAAKkDAAAwAwJNMwAAAKkDAQAwAwI9NAAAAG8DNQAwAwJANgAAAKkDAQAwAwJsNwAAAIwDFAAwAwIjOAAAAG8DOQAwAwKqOgAAAG8DOwAwAwI1PAAAAG8DPQAwAwK8PgAAAG8DPwAwAwLpQAAAAIwDAwAwAwIPQQAAAIwDAAAwAwIkQgAAAE0DAeNDAAAATQMD4UQAAAAwAwKWRQAAAG8DRgAwAwLXRwAAAIICAgBIAwEEAAAAQAMCAwMDBAQAAEBAAwUDBgMHAwgDCQMKAwsDDAUGCAkKCwwNAw0FAQ8DDgMPAxADEQMSAxMFBhESExQVFgeamRk/AACAP5qZmb8AAAAAB5qZGb5mZmY/AAAAAAAAAAAHAAAAAAAAAAAAAAAAAAAAAALNzMzMzMzsPwUDERITB83MzD5mZqY/zczMvwAAAAAHmpkZPgAAgD8AAAAAAAAAAAcAAAAAAAAAAM3MDL8AAAAAAxQDFQQAhACCAsRSyYfJlwFAAxYEAJAAggIYLURU+yHpPwMXAxgDGQMaBQMoKSoCAABAoSuk30ECAAAAdy+k30ECAAAAASyk30EDGwMcAx0DHgMfAyACq6qqqqqq+j8DIQMiAyMCMzMzMzMzwz8DJAMlAyYChutRuB6F+z8DJwKamZmZmZn5PwMoAykDKgMrAywDLQJmZmZmZmbWPwMuAAEAARgAAAAAAAAAAQAAAAAAAAEAAQEBAQAAAQAAAQAAAgAAAQAAAQAA+QD/AAsBAQAAAQAAAQAA/QD/AAcAAAAAAAAAAQAAAAABAAABAADqABgBAAABAAABAAD9AAYAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAAAAAEAAAIBAAAAAAB4cWqDQhTFP8JuH3vs9d59CGl990q1AII=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:54
-- Luau version 6, Types version 3
-- Time taken: 0.001781 seconds

return {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.60000, 1, -1.2000);
                ItemRotation = Vector3.new(-0.1500, 0.89999, 0);
                NeckRotation = Vector3.new(0, 0, 0);
                PumpOffset = Vector3.new(0, 0, 0);
                PumpDamp = 0.9;
                PumpFreq = 20;
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(0.40000, 1.29999, -1.6000);
                ItemRotation = Vector3.new(0.15000, 1, 0);
                NeckRotation = Vector3.new(0, 0, -0.5500);
            };
        };
        LeftWristRotation = CFrame.Angles(0, 2.199114857512855, 0);
        RightWristRotation = CFrame.new();
        LeftElbowAngle = 0.7853981633974483;
        RightElbowAngle = 0;
    };
    Sound = {
        gun_shotgun_cock_01 = 2123411077;
        gun_shotgun_shot_01 = 2123415004;
        gun_shotgun_dry_fire_01 = 2123411460;
    };
    MagSize = 5;
    CamShakeMagnitude = 80;
    BulletSpeed = 950;
    FireAuto = false;
    FireAutoMobile = true;
    FireFreq = 1.6666666666666667;
    IgnoreVerifyFireFreq = true;
    BulletsPerShot = 20;
    BulletSpread = 0.15;
    LeftArmRelative = "Pump";
    ReloadTime = 1.7200000000000002;
    LocalReloadOffset = 1.6;
    Damage = 3;
    Price = 0;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.Shotgun;
    EquipTime = 0.35;
}