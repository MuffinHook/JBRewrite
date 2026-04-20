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