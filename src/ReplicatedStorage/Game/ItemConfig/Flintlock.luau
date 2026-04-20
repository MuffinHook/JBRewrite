local module = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(1, 1.39999, -2);
                ItemRotation = Vector3.new(0, -0.1000, 0);
                NeckRotation = Vector3.new();
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(1, 1.39999, -2.7000);
                ItemRotation = Vector3.new(0.20000, -0.4000, 0);
                NeckRotation = Vector3.new();
            };
        };
        RightElbowAngle = 0;
        RightWristRotation = CFrame.new();
    };
    Sound = {
        flintlock_shoot = 16652899011;
        flintlock_reload_open = 4801841525;
        flintlock_reload_close = 4801841881;
        flintlock_hammer = 4801842101;
    };
    MagSize = 1;
    CamShakeMagnitude = 150;
    BulletSpeed = 900;
    FireAutoMobile = true;
    FireAuto = false;
    FireFreq = 4;
    ReloadTime = 4;
}
function module.DamageFun(arg1) -- Line 40
    if arg1 <= 20 then
        return 40
    end
    if 100 <= arg1 then
        return 20
    end
    return 40 + (-20) * ((arg1 - 20) / 80)
end
module.Price = 10000
module.ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.Flintlock
module.EquipTime = 0.5
return module