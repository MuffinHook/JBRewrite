-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:25
-- Luau version 6, Types version 3
-- Time taken: 0.002998 seconds

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
-- KONSTANTERROR: Expression was reused, decompilation is incorrect
module.PLACE_ID_TO_WORLD_MAP = TableUtils.requireValidIndexAndFreeze({})
-- KONSTANTERROR: Expression was reused, decompilation is incorrect
module.PLACE_ID_TO_PLACE_TYPE_MAP = TableUtils.requireValidIndexAndFreeze({})
module.MAIN_WORLD_NAME = "MAIN_WORLD"
module.TRADE_WORLD_NAME = "TRADE_WORLD"
module.PROD_NAME = "PROD"
module.QA_NAME = "QA"
module.DEV_NAME = "DEV"
module.STUDIO_NAME = "STUDIO"
return TableUtils.requireValidIndexAndFreeze(module)