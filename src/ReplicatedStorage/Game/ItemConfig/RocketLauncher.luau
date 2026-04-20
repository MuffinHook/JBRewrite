local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.80000, 1.39999, -0.8000);
                ItemRotation = Vector3.new(0, 0.78539, 0);
                NeckRotation = Vector3.new();
            };
        };
        Scope = {
            Springs = {
                ItemOffset = Vector3.new(0.80000, 1.39999, -0.8000);
                ItemRotation = Vector3.new(0, 0.78539, 0);
                NeckRotation = Vector3.new(0, 0, 0);
            };
        };
        LeftElbowAngle = 0;
        RightElbowAngle = 0;
        LeftWristRotation = CFrame.new();
        RightWristRotation = CFrame.new();
    };
    Sound = {
        weapon_cannon_shot_04 = 2205008075;
        gun_pistol_dry_fire_01 = 2140551506;
    };
    MagSize = 10;
    AmmoCurrent = 0;
}
local var9 = false
module.FireAuto = var9
if require(ReplicatedStorage.App.RunUtils).isStudio() then
    var9 = 3
else
    var9 = 0.4
end
module.FireFreq = var9
module.ReloadTime = 1.5
module.RocketSpeed = 200
module.Damage = 70
module.Radius = 20
module.Price = 40000
module.ImageId = require(ReplicatedStorage.Resource.Settings).Images.RocketLauncher
module.CustomShootRemote = true
module.CustomDamageRemote = true
module.EquipTime = 1
module.EquipTimeForced = true
return module