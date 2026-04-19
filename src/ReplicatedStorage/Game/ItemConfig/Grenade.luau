-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMqBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVSYWlzZQZMYXVuY2gOTGVmdEVsYm93QW5nbGUPUmlnaHRFbGJvd0FuZ2xlEUxlZnRXcmlzdFJvdGF0aW9uElJpZ2h0V3Jpc3RSb3RhdGlvbgdTcHJpbmdzCkl0ZW1PZmZzZXQMSXRlbVJvdGF0aW9uDE5lY2tSb3RhdGlvbgdWZWN0b3IzA25ldwZDRnJhbWUGTW90aW9uEmV4cGxvc2lvbl9sYXJnZV8wMhZndW5fcGlzdG9sX2RyeV9maXJlXzAxBVNvdW5kB01hZ1NpemULQW1tb0N1cnJlbnQIRmlyZUF1dG8IRmlyZUZyZXEKUmVsb2FkVGltZQhGdXNlVGltZQZEYW1hZ2UGUmFkaXVzBkltYWdlcwdHcmVuYWRlB0ltYWdlSWQGQ29sb3IzCkltYWdlQ29sb3IKQ29uc3VtYWJsZQVQcmljZRNEb05vdEZpbGxPblB1cmNoYXNlDVNvcnRPcmRlclBhZ2USQ3VzdG9tRGFtYWdlUmVtb3RlAAEHAAABAgCVAaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAGIGAAAATQICygcAAACfAQIC/wIGAAAAAADiAw8A4gQRAOIFFQBvBhYAMAYFgBIAAABvBhcAMAYF5RMAAABMNgACpAYaAABkgIGfBgECMAYFjRQAAAAwBQSYEAAAADAEA70IAAAA4gQRAOIFFQBvBhsAMAYFgBIAAABvBhwAMAYF5RMAAABvBh0AMAYFjRQAAAAwBQSYEAAAADAEA/QJAAAA4gQRAOIFFQBvBh4AMAYFgBIAAABvBhcAMAYF5RMAAABMNgACpAYaAABkgIGfBgECMAYFjRQAAAAwBQSYEAAAADAEA2QKAAAAjAQAADAEA9ILAAAAjAQAADAEA6AMAAAApAQgAABk8IGfBAECMAQDhQ0AAACkBCAAAGTwgZ8EAQIwBAMODgAAADADApchAAAA4gMkAG8EJQAwBAPiIgAAAG8EJgAwBAPmIwAAADADAm4nAAAAjAMKADADAvcoAAAAjAMAADADArkpAAAAqQMAADADAk0qAAAAjAMKADADAkArAAAAbwMsADADArwtAAAAjAMDADADAswuAAAAjANMADADAg8vAAAAjAMgADADAnEwAAAATQMB4zEAAABNAwNPMgAAADADApYzAAAApAM1AABkQIOMBAAAjAUAAIwGAACfAwQCMAMCOTYAAACpAwEAMAMCeTcAAACMAwAAMAMCJDgAAACpAwEAMAMCXzkAAABvAzoAMAMC6DsAAACpAwEAMAMCdjwAAACCAgIAPQMBBAAAAEADAgMDAwQEAABAQAMFAwYDBwMIAwkDCgMLAwwDDQUHCAkKCwwNDgMOBQEQAw8DEAMRBQMSExQHZmamP83MTL4AAIC/AAAAAAcAAAAAAAAAAAAAAAAAAAAAAxIDEwQAZICBB2Zmpj8AACBAmpkZPwAAAAAHzczMvgAAAAAAAAAAAAAAAAfNzMw+AAAAAAAAAAAAAAAAB2Zmpj+amRlAAACAvwAAAAADFAQAZPCBAxUDFgMXBQIiIwIAAOAtuG3gQQIAAIBUjuXfQQMYAxkDGgMbAxwCAAAAAAAA4D8DHQMeAx8DIAMhAyIDIwMkBABkQIMDJQMmAycDKAIAAAAAAADgvwMpAyoAAQABGAAAAAAAAAABAAAAAAAAAQABAQEBAAABAAABAAAAAAD9AP8ABwEBAAABAAABAAD9AP8ABwEBAAABAAABAAAAAAD9AP8ADwAAAQAAAgAAAAABAAAAAN4AJAEAAAEAAP4ABAAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAAAAAQAAAAAAAAABAAABAAABAAABAAABAAACAQAAAAAA+zfv9yqvtD63NAYdWU8y/4sv+IPJ84X2

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:45
-- Luau version 6, Types version 3
-- Time taken: 0.001554 seconds

return {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(1.29999, -0.2000, -1);
                ItemRotation = Vector3.new(0, 0, 0);
                NeckRotation = Vector3.new();
            };
        };
        Raise = {
            Springs = {
                ItemOffset = Vector3.new(1.29999, 2.5, 0.60000);
                ItemRotation = Vector3.new(-0.4000, 0, 0);
                NeckRotation = Vector3.new(0.40000, 0, 0);
            };
        };
        Launch = {
            Springs = {
                ItemOffset = Vector3.new(1.29999, 2.40000, -1);
                ItemRotation = Vector3.new(0, 0, 0);
                NeckRotation = Vector3.new();
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
    ReloadTime = 0.5;
    FuseTime = 3;
    Damage = 76;
    Radius = 32;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.Grenade;
    ImageColor = Color3.new(0, 0, 0);
    Consumable = true;
    Price = 0;
    DoNotFillOnPurchase = true;
    SortOrderPage = -0.5;
    CustomDamageRemote = true;
}