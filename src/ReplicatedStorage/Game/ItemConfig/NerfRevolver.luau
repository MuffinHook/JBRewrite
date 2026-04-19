-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMsBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVTY29wZQ5MZWZ0RWxib3dBbmdsZQ9SaWdodEVsYm93QW5nbGURTGVmdFdyaXN0Um90YXRpb24SUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZBbmdsZXMGTW90aW9uBXNob290C3JlbG9hZF9vcGVuDHJlbG9hZF9jbG9zZQ1idWxsZXRfaW5zZXJ0C2J1bGxldF9jYXNlDWN5bGluZGVyX3NwaW4FU291bmQHTWFnU2l6ZRFDYW1TaGFrZU1hZ25pdHVkZQtCdWxsZXRTcGVlZA5GaXJlQXV0b01vYmlsZQhGaXJlQXV0bwhGaXJlRnJlcRFHcmF2aXR5TXVsdGlwbGllcgpSZWxvYWRUaW1lBkRhbWFnZQVQcmljZQ1Tb3J0T3JkZXJQYWdlBkltYWdlcwxOZXJmUmV2b2x2ZXIHSW1hZ2VJZApTaG9wSGlkZGVuCUVxdWlwVGltZQABCAAAAQIAigGjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgBiBgAAAE0CAsoHAAAAnwECAv8CBQAAAAAA4gMOAOIEEADiBRQAbwYVADAGBYARAAAAbwYWADAGBeUSAAAATDYAAqQGGQAAYHCBnwYBAjAGBY0TAAAAMAUEmA8AAAAwBAO9CAAAAOIEEADiBRQAbwYaADAGBYARAAAAbwYbADAGBeUSAAAAbwYcADAGBY0TAAAAMAUEmA8AAAAwBAP0CQAAAIwEAAAwBAPSCgAAAIwEAAAwBAOgCwAAAKQEHwAAeNCBjAUAAG8GIACMBwAAnwQEAjAEA4UMAAAApAQhAABg0IGfBAECMAQDDg0AAAAwAwKXIgAAAOIDKQBvBCoAMAQDyCMAAABvBCsAMAQD/yQAAABvBCwAMAQDTiUAAABvBC0AMAQDnCYAAABvBC4AMAQDtycAAABvBC8AMAQDzygAAAAwAwJuMAAAAIwDBgAwAwL3MQAAAIwDlgAwAwKjMgAAAIwDIAMwAwKlMwAAAKkDAQAwAwI9NAAAAKkDAAAwAwJNNQAAAG8DNgAwAwJANwAAAIwDAgAwAwLQOAAAAG8DOQAwAwK8OgAAAIwDGQAwAwIPOwAAAIwD6AMwAwIkPAAAAIwD//8wAwLoPQAAAE0DAeM+AAAATQMDMD8AAAAwAwKWQAAAAKkDAQAwAwKvQQAAAG8DQgAwAwLXQwAAAIICAgBEAwEEAAAAQAMCAwMDBAQAAEBAAwUDBgMHAwgDCQMKAwsDDAUGCAkKCwwNAw0FAQ8DDgMPAxAFAxESEwcfhWs+MzOzPwAAAMAAAAAABwAAAADNzMw+AAAAAAAAAAADEQMSBABgcIEHzcxMPs3MzD+amdm/AAAAAAfNzEw+AAAAPwAAAAAAAAAAB83MzD0AAAAAmpmZvgAAAAADEwMUBAB40IECUGnrMcco/j8EAGDQgQMVAxYDFwMYAxkDGgMbBQYjJCUmJygCAAAw/wHM+UECAABAmMS88UECAACwDwLM+UECAAAAFsW88UECAADAIcW88UECAAAAXMW88UEDHAMdAx4DHwMgAyECAAAAAAAABEADIgMjAmZmZmZmZuY/AyQDJQMmAycDKAMpAyoDKwKamZmZmZnZPwMsAAEAARgAAAAAAAAAAQAAAAAAAAEAAQEBAQAAAQAAAQAAAAAA/QD/AAsBAQAAAQAAAQAA/QD/AAgAAAEAAAIAAAAAAAAAAQAAAADoABoBAAABAAABAAABAAABAAABAAD6AAgAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAAAAAEAAAEAAAIBAAAAAADu5HZoC8+O8gcO9hBXCt/CnvxhHNwgHGk=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:48
-- Luau version 6, Types version 3
-- Time taken: 0.001469 seconds

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
        shoot = 6924804083;
        reload_open = 4761340292;
        reload_close = 6924804347;
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
    Price = 1000;
    SortOrderPage = -1;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.NerfRevolver;
    ShopHidden = true;
    EquipTime = 0.4;
}