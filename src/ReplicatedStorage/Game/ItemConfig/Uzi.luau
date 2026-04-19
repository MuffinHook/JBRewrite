-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVTY29wZQ5MZWZ0RWxib3dBbmdsZQ9SaWdodEVsYm93QW5nbGURTGVmdFdyaXN0Um90YXRpb24SUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZBbmdsZXMGTW90aW9uCmRyeV9maXJlMDEHc2hvdF8wMSRndW5fc2VtaV9hdXRvX3JpZmxlX21hZ2F6aW5lX2xvYWRfMDEmZ3VuX3NlbWlfYXV0b19yaWZsZV9tYWdhemluZV91bmxvYWRfMDEFU291bmQHTWFnU2l6ZRFDYW1TaGFrZU1hZ25pdHVkZQtCdWxsZXRTcGVlZAhGaXJlQXV0bwhGaXJlRnJlcQpSZWxvYWRUaW1lBkRhbWFnZQVQcmljZQZJbWFnZXMDVXppB0ltYWdlSWQAAQgAAAECAHWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgBiBgAAAE0CAsoHAAAAnwECAv8CBQAAAAAA4gMOAOIEEADiBRQAbwYVADAGBYARAAAAbwYWADAGBeUSAAAATDYAAqQGGQAAYHCBnwYBAjAGBY0TAAAAMAUEmA8AAAAwBAO9CAAAAOIEEADiBRQAbwYaADAGBYARAAAAbwYbADAGBeUSAAAAbwYcADAGBY0TAAAAMAUEmA8AAAAwBAP0CQAAAIwEAAAwBAPSCgAAAIwEAAAwBAOgCwAAAKQEHwAAeNCBjAUAAG8GIACMBwAAnwQEAjAEA4UMAAAApAQhAABg0IGfBAECMAQDDg0AAAAwAwKXIgAAAOIDJwBvBCgAMAQD6SMAAABvBCkAMAQDiCQAAABvBCoAMAQD/yUAAABvBCsAMAQDHiYAAAAwAwJuLAAAAIwDDwAwAwL3LQAAAIwDDwAwAwKjLgAAAIwD6AMwAwKlLwAAAKkDAQAwAwJNMAAAAIwDDQAwAwJAMQAAAG8DMgAwAwK8MwAAAIwDBwAwAwIPNAAAAIwDqGEwAwIkNQAAAE0DAeM2AAAATQMDeDcAAAAwAwKWOAAAAIICAgA5AwEEAAAAQAMCAwMDBAQAAEBAAwUDBgMHAwgDCQMKAwsDDAUGCAkKCwwNAw0FAQ8DDgMPAxAFAxESEweamRk/AACAP83MzL8AAAAAB5qZGb6amRk/AAAAAAAAAAADEQMSBABgcIEHzczMPmZmpj8zM/O/AAAAAAeamRk+MzMzPwAAAAAAAAAABwAAAAAAAAAAzczMvgAAAAADEwMUBAB40IECUGnrMcco/j8EAGDQgQMVAxYDFwMYAxkFBCMkJSYCAADgGR6y5UECAADoArkED0ICAADAjf6a30ECAABAyP6a30EDGgMbAxwDHQMeAx8CMzMzMzMz8z8DIAMhAyIDIwMkAyUAAQABGAAAAAAAAAABAAAAAAAAAQABAQEBAAABAAABAAAAAAD9AP8ABwEBAAABAAABAAD9AP8ACAAAAQAAAgAAAAAAAAABAAAAAOwAFgEAAAEAAAEAAAEAAPwABgAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAAAAAgEAAAAAAAlVUVifBphwkUrTXnncIWR5TUYsO5E7WQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:38:00
-- Luau version 6, Types version 3
-- Time taken: 0.001694 seconds

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
        dry_fire01 = 2911957199;
        shot_01 = 16652902493;
        gun_semi_auto_rifle_magazine_load_01 = 2121005623;
        gun_semi_auto_rifle_magazine_unload_01 = 2121005857;
    };
    MagSize = 15;
    CamShakeMagnitude = 15;
    BulletSpeed = 1000;
    FireAuto = true;
    FireFreq = 13;
    ReloadTime = 1.2;
    Damage = 7;
    Price = 25000;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.Uzi;
}