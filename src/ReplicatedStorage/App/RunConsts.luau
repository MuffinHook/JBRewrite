local TableUtils = require(game:GetService("ReplicatedStorage").Std.TableUtils)
local any_requireValidIndexAndFreeze_result1 = TableUtils.requireValidIndexAndFreeze({
    PROD = TableUtils.requireValidIndexAndFreeze({
        MAIN_WORLD = {
            Default = 606849621;
            VoiceChat = 17190407811;
            Hang = 17190408132;
            Pro = 108098425719662;
        };
        TRADE_WORLD = {
            Default = 9780994092;
        };
    });
    QA = TableUtils.requireValidIndexAndFreeze({
        MAIN_WORLD = {
            Default = 5141682374;
            VoiceChat = 17190473751;
            Hang = 17190314798;
            Pro = 90182288573226;
        };
        TRADE_WORLD = {
            Default = 9780997332;
        };
    });
    DEV = TableUtils.requireValidIndexAndFreeze({
        MAIN_WORLD = {
            Default = 6898041828;
            VoiceChat = 1;
            Hang = 17190557047;
            Pro = 7;
        };
        TRADE_WORLD = {
            Default = 9781001160;
        };
    });
    STUDIO = TableUtils.requireValidIndexAndFreeze({
        MAIN_WORLD = {
            Default = 708709673;
            VoiceChat = 2;
            Hang = 3;
            Pro = 6;
        };
        TRADE_WORLD = {
            Default = 4;
        };
    });
})
local tbl = {}
for i, v in any_requireValidIndexAndFreeze_result1 do
    for i_2, v_2 in v do
        for i_3, v_3 in v_2 do
            local var29
            if tbl[v_3] ~= nil then
                var29 = false
            else
                var29 = true
            end
            assert(var29, "env was already populated for this placeId.. duplicate?")
            tbl[v_3] = i
            ;({})[v_3] = i_2
            ;({})[v_3] = i_3
        end
    end
end
local module = {
    ENV_TO_WORLD_TO_PLACE_IDS_MAP = any_requireValidIndexAndFreeze_result1;
    PLACE_ID_TO_ENV_MAP = TableUtils.requireValidIndexAndFreeze(tbl);
}
-- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
module.PLACE_ID_TO_WORLD_MAP = TableUtils.requireValidIndexAndFreeze({})
-- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
module.PLACE_ID_TO_PLACE_TYPE_MAP = TableUtils.requireValidIndexAndFreeze({})
module.MAIN_WORLD_NAME = "MAIN_WORLD"
module.TRADE_WORLD_NAME = "TRADE_WORLD"
module.PROD_NAME = "PROD"
module.QA_NAME = "QA"
module.DEV_NAME = "DEV"
module.STUDIO_NAME = "STUDIO"
return TableUtils.requireValidIndexAndFreeze(module)