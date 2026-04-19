-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMmBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVSYWlzZQ5MZWZ0RWxib3dBbmdsZQ9SaWdodEVsYm93QW5nbGURTGVmdFdyaXN0Um90YXRpb24SUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZNb3Rpb24SZXhwbG9zaW9uX2xhcmdlXzAyFmd1bl9waXN0b2xfZHJ5X2ZpcmVfMDEFU291bmQHTWFnU2l6ZQtBbW1vQ3VycmVudAhGaXJlQXV0bwhGaXJlRnJlcQpSZWxvYWRUaW1lCkNvbnN1bWFibGUFUHJpY2UTRG9Ob3RGaWxsT25QdXJjaGFzZQZJbWFnZXMCQzQHSW1hZ2VJZA1Tb3J0T3JkZXJQYWdlEUN1c3RvbVNob290UmVtb3RlEkN1c3RvbURhbWFnZVJlbW90ZQlFcXVpcFRpbWUAAQcAAAECAHijAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgBiBgAAAE0CAsoHAAAAnwECAv8CBQAAAAAA4gMOAOIEEADiBRQAbwYVADAGBYARAAAAbwYWADAGBeUSAAAATDYAAqQGGQAAYHCBnwYBAjAGBY0TAAAAMAUEmA8AAAAwBAO9CAAAAOIEEADiBRQAbwYaADAGBYARAAAAbwYbADAGBeUSAAAAbwYcADAGBY0TAAAAMAUEmA8AAAAwBAP0CQAAAIwEAAAwBAPSCgAAAIwEAAAwBAOgCwAAAKQEHgAAYNCBnwQBAjAEA4UMAAAApAQeAABg0IGfBAECMAQDDg0AAAAwAwKXHwAAAOIDIgBvBCMAMAQD4iAAAABvBCQAMAQD5iEAAAAwAwJuJQAAAIwDCgAwAwL3JgAAAIwDAAAwAwK5JwAAAKkDAAAwAwJNKAAAAIwDCgAwAwJAKQAAAG8DKgAwAwK8KwAAAKkDAQAwAwJ5LAAAAIwDAAAwAwIkLQAAAKkDAQAwAwJfLgAAAE0DAeMvAAAATQMDVjAAAAAwAwKWMQAAAIwD/v8wAwLoMgAAAKkDAQAwAwIyMwAAAKkDAQAwAwJ2NAAAAIwDAAAwAwLXNQAAAIICAgA2AwEEAAAAQAMCAwMDBAQAAEBAAwUDBgMHAwgDCQMKAwsDDAUGCAkKCwwNAw0FAQ8DDgMPAxAFAxESEwdmZqY/AADAPwAAwL8AAAAABwAAAAAAAAAAAAAAAAAAAAADEQMSBABgcIEHZmamP5qZmT8AAMC/AAAAAAfNzMy+AAAAAAAAAAAAAAAAB83MzD4AAAAAAAAAAAAAAAADEwQAYNCBAxQDFQMWBQIgIQIAAOAtuG3gQQIAAIBUjuXfQQMXAxgDGQMaAxsCmpmZmZmZuT8DHAMdAx4DHwMgAyEDIgMjAyQDJQMmAAEAARgAAAAAAAAAAQAAAAAAAAEAAQEBAQAAAQAAAQAAAAAA/QD/AAcBAQAAAQAAAQAA/QD/AAgAAAEAAAIAAAAAAQAAAADsABYBAAABAAD+AAQAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAAAAAEAAAEAAAEAAAEAAAIBAAAAAADEjrzxZ3CBjtjuJICPOfYctJarhfZK1vA=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:40
-- Luau version 6, Types version 3
-- Time taken: 0.001779 seconds

return {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(1.29999, 1.5, -1.5);
                ItemRotation = Vector3.new(0, 0, 0);
                NeckRotation = Vector3.new();
            };
        };
        Raise = {
            Springs = {
                ItemOffset = Vector3.new(1.29999, 1.20000, -1.5);
                ItemRotation = Vector3.new(-0.4000, 0, 0);
                NeckRotation = Vector3.new(0.40000, 0, 0);
            };
        };
        LeftElbowAngle = 0;
        RightElbowAngle = 0;
        LeftWristRotation = CFrame.new();
        RightWristRotation = CFrame.new();
    };
    Sound = {
        explosion_large_02 = 2205008239;
        gun_pistol_dry_fire_01 = 2140551506;
    };
    MagSize = 10;
    AmmoCurrent = 0;
    FireAuto = false;
    FireFreq = 10;
    ReloadTime = 0.1;
    Consumable = true;
    Price = 0;
    DoNotFillOnPurchase = true;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.C4;
    SortOrderPage = -2;
    CustomShootRemote = true;
    CustomDamageRemote = true;
    EquipTime = 0;
}