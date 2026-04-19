-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMmBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVSYWlzZQ5MZWZ0RWxib3dBbmdsZQ9SaWdodEVsYm93QW5nbGURTGVmdFdyaXN0Um90YXRpb24SUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZNb3Rpb24SZXhwbG9zaW9uX2xhcmdlXzAyFmd1bl9waXN0b2xfZHJ5X2ZpcmVfMDEFU291bmQHTWFnU2l6ZQtBbW1vQ3VycmVudAhGaXJlQXV0bwhGaXJlRnJlcQpSZWxvYWRUaW1lCkNvbnN1bWFibGUFUHJpY2UTRG9Ob3RGaWxsT25QdXJjaGFzZQZJbWFnZXMMU21va2VHcmVuYWRlB0ltYWdlSWQNU29ydE9yZGVyUGFnZRFDdXN0b21TaG9vdFJlbW90ZRJDdXN0b21SZWxvYWRSZW1vdGUSQ3VzdG9tRGFtYWdlUmVtb3RlAAEHAAABAgB4owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAYgYAAABNAgLKBwAAAJ8BAgL/AgUAAAAAAOIDDgDiBBAA4gUUAG8GFQAwBgWAEQAAAG8GFgAwBgXlEgAAAEw2AAKkBhkAAGBwgZ8GAQIwBgWNEwAAADAFBJgPAAAAMAQDvQgAAADiBBAA4gUUAG8GGgAwBgWAEQAAAG8GGwAwBgXlEgAAAG8GHAAwBgWNEwAAADAFBJgPAAAAMAQD9AkAAACMBAAAMAQD0goAAACMBAAAMAQDoAsAAACkBB4AAGDQgZ8EAQIwBAOFDAAAAKQEHgAAYNCBnwQBAjAEAw4NAAAAMAMClx8AAADiAyIAbwQjADAEA+IgAAAAbwQkADAEA+YhAAAAMAMCbiUAAACMAwMAMAMC9yYAAACMAwAAMAMCuScAAACpAwAAMAMCTSgAAACMAwoAMAMCQCkAAACMAwIAMAMCvCoAAACpAwEAMAMCeSsAAACMAwAAMAMCJCwAAACpAwEAMAMCXy0AAABNAwHjLgAAAE0DA5cvAAAAMAMCljAAAACMA///MAMC6DEAAACpAwEAMAMCMjIAAACpAwEAMAMCFzMAAACpAwEAMAMCdjQAAACCAgIANQMBBAAAAEADAgMDAwQEAABAQAMFAwYDBwMIAwkDCgMLAwwFBggJCgsMDQMNBQEPAw4DDwMQBQMREhMHZmamPwAAwD8AAMC/AAAAAAcAAAAAAAAAAAAAAAAAAAAAAxEDEgQAYHCBB2Zmpj+amZk/AADAvwAAAAAHzczMvgAAAAAAAAAAAAAAAAfNzMw+AAAAAAAAAAAAAAAAAxMEAGDQgQMUAxUDFgUCICECAADgLbht4EECAACAVI7l30EDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgABAAEYAAAAAAAAAAEAAAAAAAABAAEBAQEAAAEAAAEAAAAAAP0A/wAHAQEAAAEAAAEAAP0A/wAIAAABAAACAAAAAAEAAAAA7AAWAQAAAQAA/gAEAAABAAABAAABAAABAAABAAABAAABAAABAAAAAAABAAABAAABAAABAAACAQAAAAAA7+LNkRqFHxw1CmOHQAQUYJ/62uXdJqeQ

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:55
-- Luau version 6, Types version 3
-- Time taken: 0.001362 seconds

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
    MagSize = 3;
    AmmoCurrent = 0;
    FireAuto = false;
    FireFreq = 10;
    ReloadTime = 2;
    Consumable = true;
    Price = 0;
    DoNotFillOnPurchase = true;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.SmokeGrenade;
    SortOrderPage = -1;
    CustomShootRemote = true;
    CustomReloadRemote = true;
    CustomDamageRemote = true;
}