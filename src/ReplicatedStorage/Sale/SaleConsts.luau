local tbl = {
    year = 2023;
    month = 7;
    day = 27;
    hour = 17;
}
return require(game:GetService("ReplicatedStorage").Std.TableUtils).requireValidIndexAndFreeze({
    FIRST_SALE_START_TIMESTAMP = DateTime.fromUniversalTime(tbl.year, tbl.month, tbl.day, tbl.hour - -4).UnixTimestamp;
    SALE_DURATION_SECONDS = 604800;
    NUM_VEHICLE_CUSTOMIZATIONS = 6;
    VEHICLE_CUSTOMIZATION_PRICE_MULTIPLIER = 0.75;
    NUM_VEHICLES = 1;
    VEHICLE_PRICE_MULTIPLIER = 0.9;
    CATEGORY_NAME = "Featured";
})