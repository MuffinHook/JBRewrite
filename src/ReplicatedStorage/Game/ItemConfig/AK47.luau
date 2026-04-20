return {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.60000, 0.89999, -1.2999);
                ItemRotation = Vector3.new(-0.1500, 0.60000, 0);
                NeckRotation = Vector3.new();
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(0.40000, 1.10000, -1.6000);
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
        gun_semi_auto_rifle_dry_fire_01 = 2121005402;
        gun_semi_auto_rifle_shot_01 = 16652900272;
        gun_semi_auto_rifle_magazine_load_01 = 2121005623;
        gun_semi_auto_rifle_magazine_unload_01 = 2121005857;
    };
    MagSize = 30;
    CamShakeMagnitude = 10;
    BulletSpeed = 1050;
    FireAuto = true;
    FireFreq = 12;
    ReloadTime = 1.5;
    Damage = 6;
    Price = 15000;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.AK47;
}