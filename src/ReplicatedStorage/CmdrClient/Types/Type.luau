local Util_upvr = require(script.Parent.Parent.Shared.Util)
return function(arg1) -- Line 3
    local tbl = {
        Transform = function(arg1_2) -- Line 5, Named "Transform"
            return Util_upvr.MakeFuzzyFinder(arg1:GetTypeNames())(arg1_2)
        end;
        Validate = function(arg1_3) -- Line 11, Named "Validate"
            local var4
            if 0 >= #arg1_3 then
                var4 = false
            else
                var4 = true
            end
            return var4, "No type with that name could be found."
        end;
        Autocomplete = function(arg1_4) -- Line 15, Named "Autocomplete"
            return arg1_4
        end;
        Parse = function(arg1_5) -- Line 19, Named "Parse"
            return arg1_5[1]
        end;
    }
    arg1:RegisterType("type", tbl)
    arg1:RegisterType("types", Util_upvr.MakeListableType(tbl))
end