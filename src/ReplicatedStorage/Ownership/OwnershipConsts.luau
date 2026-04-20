local module = {
    COLOR_CATEGORY_TYPES = {
        WheelColor = true;
        BodyColor = true;
        SecondBodyColor = true;
        WindowColor = true;
        HeadlightsColor = true;
        SpoilerColor = true;
        Glow = true;
        InteriorMainColor = true;
        InteriorDetailColor = true;
        SeatColor = true;
    };
    TEXTURE_CATEGORY_TYPES = {
        SecondTexture = true;
    };
    VEHICLE_CUSTOMIZATION_CATEGORY_NAMES = {"Texture", "Engine", "Rim", "SuspensionHeight", "Brakes", "Spoiler", "TireSticker", "TireMesh", "WindowTint", "Horn", "Color", "Drift"};
    VEHICLE_CUSTOMIZATION_CATEGORY_NAME_SET = {};
}
for _, v in ipairs(module.VEHICLE_CUSTOMIZATION_CATEGORY_NAMES) do
    module.VEHICLE_CUSTOMIZATION_CATEGORY_NAME_SET[v] = true
end
return require(game:GetService("ReplicatedStorage").Std.TableUtils).requireValidIndexAndFreeze(module)