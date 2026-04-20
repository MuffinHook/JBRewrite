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