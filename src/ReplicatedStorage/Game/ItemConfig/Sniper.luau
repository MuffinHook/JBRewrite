local module = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.60000, 1.5, -1.7999);
                ItemRotation = Vector3.new(-0.1500, 0.89999, 0);
                NeckRotation = Vector3.new();
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(0.40000, 1.70000, -1.7000);
                ItemRotation = Vector3.new(0.15000, 1, 0);
                NeckRotation = Vector3.new(0, 0, -0.4000);
            };
            FOV = 10;
        };
        LeftElbowAngle = 0;
        RightElbowAngle = 0;
        LeftWristRotation = CFrame.Angles(0, 1.8849555921538759, 0);
        RightWristRotation = CFrame.new();
    };
    Sound = {
        shoot = 16652898664;
        scope = 4761314135;
        cock = 4761314769;
        mag_in = 4761315290;
        mag_out = 4761315536;
    };
    MagSize = 1;
    CamShakeMagnitude = 80;
    BulletSpeed = 5000;
    FireAuto = false;
    FireFreq = 1;
    ReloadTime = 1.3;
    MobileMouseHeightScalar = 0.5;
    MaxDamageDist = 3072;
    EquipTime = 0.5;
}
function module.DamageFun(arg1) -- Line 48
    local clamped = math.clamp(arg1 / 500, 0, 1)
    return (1 - clamped) * 22 + clamped * 80
end
module.Price = 50000
module.ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.Sniper
return module