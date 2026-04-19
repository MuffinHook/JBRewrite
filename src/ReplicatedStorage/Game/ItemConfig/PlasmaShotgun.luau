-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMmBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVTY29wZQ5MZWZ0RWxib3dBbmdsZQ9SaWdodEVsYm93QW5nbGURTGVmdFdyaXN0Um90YXRpb24SUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZBbmdsZXMGTW90aW9uEmJ1bGxldF9pbXBhY3RfYmFzcwVTb3VuZAdNYWdTaXplEUNhbVNoYWtlTWFnbml0dWRlCEZpcmVBdXRvCEZpcmVGcmVxDkJ1bGxldHNQZXJTaG90DEJ1bGxldFNwcmVhZApSZWxvYWRUaW1lBVJhbmdlBkRhbWFnZQVQcmljZQZJbWFnZXMNUGxhc21hU2hvdGd1bgdJbWFnZUlkEkN1c3RvbURhbWFnZVJlbW90ZQlFcXVpcFRpbWUAAQgAAAECAHijAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgBiBgAAAE0CAsoHAAAAnwECAv8CBQAAAAAA4gMOAOIEEADiBRQAbwYVADAGBYARAAAAbwYWADAGBeUSAAAATDYAAqQGGQAAYHCBnwYBAjAGBY0TAAAAMAUEmA8AAAAwBAO9CAAAAOIEEADiBRQAbwYaADAGBYARAAAAbwYbADAGBeUSAAAAbwYcADAGBY0TAAAAMAUEmA8AAAAwBAP0CQAAAIwEAAAwBAPSCgAAAIwEAAAwBAOgCwAAAKQEHwAAeNCBjAUAAG8GIACMBwAAnwQEAjAEA4UMAAAApAQhAABg0IGfBAECMAQDDg0AAAAwAwKXIgAAAOIDJABvBCUAMAQDOiMAAAAwAwJuJgAAAIwDBAAwAwL3JwAAAIwDUAAwAwKjKAAAAKkDAAAwAwJNKQAAAG8DKgAwAwJAKwAAAIwDDwAwAwIjLAAAAG8DLQAwAwKqLgAAAG8DLwAwAwK8MAAAAIwDMgAwAwIGMQAAAIwDBAAwAwIPMgAAAG8DMwAwAwIkNAAAAE0DAeM1AAAATQMDYzYAAAAwAwKWNwAAAKkDAQAwAwJ2OAAAAG8DOQAwAwLXOgAAAIICAgA7AwEEAAAAQAMCAwMDBAQAAEBAAwUDBgMHAwgDCQMKAwsDDAUGCAkKCwwNAw0FAQ8DDgMPAxAFAxESEwfNzMw+ZmamPwAAAMAAAAAABwAAAAAzM7M+AAAAAAAAAAADEQMSBABgcIEHmpmZPgAAwD8AAOC/AAAAAAfNzEw+AAAAPwAAAAAAAAAAB83MzD0AAAAAzczMvQAAAAADEwMUBAB40IECUGnrMcco/j8EAGDQgQMVAxYFASMCAABgh1Ij5UEDFwMYAxkDGgKrqqqqqqr6PwMbAxwCmpmZmZmZyT8DHQIAAAAAAAD4PwMeAx8DIAIAAAAAAGroQAMhAyIDIwMkAyUCZmZmZmZm1j8DJgABAAEYAAAAAAAAAAEAAAAAAAABAAEBAQEAAAEAAAEAAAAAAP0A/wAHAQEAAAEAAAEAAP0A/wAIAAABAAACAAAAAAAAAAEAAAAA7AAWAQAA/wADAAABAAABAAABAAABAAABAAABAAABAAABAAABAAABAAAAAAABAAABAAACAQAAAAAAFwF2T5W5lXZ4iCYou3ZbfGcZYTslxRxO

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:50
-- Luau version 6, Types version 3
-- Time taken: 0.001697 seconds

return {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.40000, 1.29999, -2);
                ItemRotation = Vector3.new(0, 0.34999, 0);
                NeckRotation = Vector3.new();
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(0.30000, 1.5, -1.75);
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
        bullet_impact_bass = 2837091387;
    };
    MagSize = 4;
    CamShakeMagnitude = 80;
    FireAuto = false;
    FireFreq = 1.6666666666666667;
    BulletsPerShot = 15;
    BulletSpread = 0.2;
    ReloadTime = 1.5;
    Range = 50;
    Damage = 4;
    Price = 50000;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.PlasmaShotgun;
    CustomDamageRemote = true;
    EquipTime = 0.35;
}