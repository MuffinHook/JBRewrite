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