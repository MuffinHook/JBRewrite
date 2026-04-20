local tbl_upvr = {"^%a[%w_]*$", "^%$%a[%w_]*$", "^%.%a[%w_]*$", "^%$%.%a[%w_]*$"}
local Util_upvr = require(script.Parent.Parent.Shared.Util)
return function(arg1) -- Line 10
    local tbl = {
        Autocomplete = function(arg1_2) -- Line 12, Named "Autocomplete"
            local any_GetStore_result1 = arg1:GetStore("vars_used")
            if not any_GetStore_result1 then
                any_GetStore_result1 = {}
            end
            return arg1.Cmdr.Util.MakeFuzzyFinder(arg1.Cmdr.Util.DictionaryKeys(any_GetStore_result1))(arg1_2)
        end;
        Validate = function(arg1_3) -- Line 20, Named "Validate"
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