-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYBENtZHIEVXRpbA9NYWtlRnV6enlGaW5kZXIORGljdGlvbmFyeUtleXMJdmFyc191c2VkCEdldFN0b3JlDEF1dG9jb21wbGV0ZQZpcGFpcnMFbWF0Y2hXS2V5IG5hbWVzIG11c3Qgc3RhcnQgd2l0aCBhbiBvcHRpb25hbCBtb2RpZmllcjogLiAkIG9yICQuIGFuZCBtdXN0IGJlZ2luIHdpdGggYSBsZXR0ZXIuCFZhbGlkYXRlBVBhcnNlCXN0b3JlZEtleQxSZWdpc3RlclR5cGUKc3RvcmVkS2V5cxBNYWtlTGlzdGFibGVUeXBlB3JlcXVpcmUGc2NyaXB0BlBhcmVudAZTaGFyZWQKXiVhWyV3X10qJAxeJSQlYVsld19dKiQMXiUuJWFbJXdfXSokDl4lJCUuJWFbJXdfXSokAAUGAQEAAAAc+wEAAE0BAZ4AAAAATQEBngEAAABNAQE9AgAAAPsCAABNAgKeAAAAAE0CAp4BAAAATQIC4wMAAAD7AwAAbwUEALwDA1UFAAAAnwMDAisDAgD/AwAAAAAAAJ8CAgCfAQACUgIBAFIDAACfAgIAggIAAAYDAQMCAwMDBAMFAwYADAcBGAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA/wQAAAANAAAAAAkBAQAAABGkAQEAAAAAQPsCAACfAQIEUQEHAFIIBQC8BgDnAgAAAJ8GAwIOBgIAqQYBAIIGAgBuAfj/AgAAgKkBAABvAgMAggEDAAQDCAQAAABAAwkDCgAUCwEYAAAAAAABAAAAAAEA/gAGAAAVAAAAAAEBAAAAAAGCAAIAAAAeDAEYAB8AAAAABwECAAAAG+IBAwDZAgAAEgAAADACAasAAAAAwAIEABICAAAwAgF2AQAAAMACBQAwAgGbAgAAAG8EBgBSBQEAvAIA3QcAAACfAgQBbwQIAPsFAQBNBQUkCQAAAFIGAQCfBQIAvAIA3QcAAACfAgABggABAAoDBwMLAwwFAwABAgYBBgIDDQMOAw8DEAMAAQIKAAEYAAEAAAAIAAAACgAABAAAAAABAAAAAAAAAAABCwAAAAAGAAABAgAaowAAAKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BASQEAAAATQEBEgUAAABNAQGeBgAAAJ8AAgL/AQAABAAAAG8CBwBvAwgAbwQJAG8FCgDFAQIFAQAAAMACCwASAAEAEgAAAIICAgAMAxEEAAAAQAMSBAAAIEADEwMUAwIDFQMWAxcDGAYDAQMBAAEYAAAAAAAAAAAAAAAAAAACAAEBAQEAAAMAAAABAAAAAATbznp1jH7LQxw/NyOEy/G+q9ZtAekKEHQ=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:49
-- Luau version 6, Types version 3
-- Time taken: 0.002492 seconds

local tbl_upvr = {"^%a[%w_]*$", "^%$%a[%w_]*$", "^%.%a[%w_]*$", "^%$%.%a[%w_]*$"}
local Util_upvr = require(script.Parent.Parent.Shared.Util)
return function(arg1) -- Line 10
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: Util_upvr (readonly)
    ]]
    local tbl = {
        Autocomplete = function(arg1_2) -- Line 12, Named "Autocomplete"
            --[[ Upvalues[1]:
                [1]: arg1 (readonly)
            ]]
            local any_GetStore_result1 = arg1:GetStore("vars_used")
            if not any_GetStore_result1 then
                any_GetStore_result1 = {}
            end
            return arg1.Cmdr.Util.MakeFuzzyFinder(arg1.Cmdr.Util.DictionaryKeys(any_GetStore_result1))(arg1_2)
        end;
        Validate = function(arg1_3) -- Line 20, Named "Validate"
            --[[ Upvalues[1]:
                [1]: tbl_upvr (copied, readonly)
            ]]
            for _, v in ipairs(tbl_upvr) do
                if arg1_3:match(v) then
                    return true
                end
            end
            return false, "Key names must start with an optional modifier: . $ or $. and must begin with a letter."
        end;
        Parse = function(arg1_4) -- Line 30, Named "Parse"
            return arg1_4
        end;
    }
    arg1:RegisterType("storedKey", tbl)
    arg1:RegisterType("storedKeys", Util_upvr.MakeListableType(tbl))
end