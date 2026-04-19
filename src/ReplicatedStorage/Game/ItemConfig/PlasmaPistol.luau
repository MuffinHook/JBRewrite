-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMjBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFJlc291cmNlCFNldHRpbmdzA0hpcAVTY29wZQ5MZWZ0RWxib3dBbmdsZQ9SaWdodEVsYm93QW5nbGURTGVmdFdyaXN0Um90YXRpb24SUmlnaHRXcmlzdFJvdGF0aW9uB1NwcmluZ3MKSXRlbU9mZnNldAxJdGVtUm90YXRpb24MTmVja1JvdGF0aW9uB1ZlY3RvcjMDbmV3BkNGcmFtZQZBbmdsZXMGTW90aW9uEmJ1bGxldF9pbXBhY3RfYmFzcwVTb3VuZAdNYWdTaXplEUNhbVNoYWtlTWFnbml0dWRlCEZpcmVBdXRvCEZpcmVGcmVxClJlbG9hZFRpbWUFUmFuZ2UGRGFtYWdlBVByaWNlBkltYWdlcwxQbGFzbWFQaXN0b2wHSW1hZ2VJZBJDdXN0b21EYW1hZ2VSZW1vdGUAAQgAAAECAG+jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgBiBgAAAE0CAsoHAAAAnwECAv8CBQAAAAAA4gMOAOIEEADiBRQAbwYVADAGBYARAAAAbwYWADAGBeUSAAAATDYAAqQGGQAAYHCBnwYBAjAGBY0TAAAAMAUEmA8AAAAwBAO9CAAAAOIEEADiBRQAbwYaADAGBYARAAAAbwYbADAGBeUSAAAAbwYcADAGBY0TAAAAMAUEmA8AAAAwBAP0CQAAAIwEAAAwBAPSCgAAAIwEAAAwBAOgCwAAAKQEHwAAeNCBjAUAAG8GIACMBwAAnwQEAjAEA4UMAAAApAQhAABg0IGfBAECMAQDDg0AAAAwAwKXIgAAAOIDJABvBCUAMAQDOiMAAAAwAwJuJgAAAIwDFAAwAwL3JwAAAIwDDwAwAwKjKAAAAKkDAQAwAwJNKQAAAIwDDQAwAwJAKgAAAIwDAQAwAwK8KwAAAIwDyAAwAwIGLAAAAIwDBgAwAwIPLQAAAG8DLgAwAwIkLwAAAE0DAeMwAAAATQMDdDEAAAAwAwKWMgAAAKkDAQAwAwJ2MwAAAIICAgA0AwEEAAAAQAMCAwMDBAQAAEBAAwUDBgMHAwgDCQMKAwsDDAUGCAkKCwwNAw0FAQ8DDgMPAxAFAxESEwfNzMw+ZmamPwAAAMAAAAAABwAAAAAzM7M+AAAAAAAAAAADEQMSBABgcIEHmpmZPgAAwD8AAOC/AAAAAAfNzEw+AAAAPwAAAAAAAAAAB83MzD0AAAAAzczMvQAAAAADEwMUBAB40IECUGnrMcco/j8EAGDQgQMVAxYFASMCAABgh1Ij5UEDFwMYAxkDGgMbAxwDHQMeAgAAAAAAauhAAx8DIAMhAyIDIwABAAEYAAAAAAAAAAEAAAAAAAABAAEBAQEAAAEAAAEAAAAAAP0A/wAHAQEAAAEAAAEAAP0A/wAIAAABAAACAAAAAAAAAAEAAAAA7AAWAQAA/wADAAABAAABAAABAAABAAABAAABAAABAAABAAAAAAABAAACAQAAAAAA0KD+OP7AvOhvYm17x1ETIKC46UziZJQ5

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:49
-- Luau version 6, Types version 3
-- Time taken: 0.001792 seconds

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
    MagSize = 20;
    CamShakeMagnitude = 15;
    FireAuto = true;
    FireFreq = 13;
    ReloadTime = 1;
    Range = 200;
    Damage = 6;
    Price = 50000;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.PlasmaPistol;
    CustomDamageRemote = true;
}