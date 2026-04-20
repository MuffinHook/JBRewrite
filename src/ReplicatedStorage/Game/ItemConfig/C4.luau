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
    MagSize = 10;
    AmmoCurrent = 0;
    FireAuto = false;
    FireFreq = 10;
    ReloadTime = 0.1;
    Consumable = true;
    Price = 0;
    DoNotFillOnPurchase = true;
    ImageId = require(game:GetService("ReplicatedStorage").Resource.Settings).Images.C4;
    SortOrderPage = -2;
    CustomShootRemote = true;
    CustomDamageRemote = true;
    EquipTime = 0;
}