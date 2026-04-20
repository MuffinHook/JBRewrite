local Util_upvr = require(script.Parent.Parent.Shared.Util)
local Enum_UserInputType_GetEnumItems_result1_upvr = Enum.UserInputType:GetEnumItems()
for _, v in pairs(Enum.KeyCode:GetEnumItems()) do
    Enum_UserInputType_GetEnumItems_result1_upvr[#Enum_UserInputType_GetEnumItems_result1_upvr + 1] = v
end
local tbl_upvr = {
    Transform = function(arg1) -- Line 10, Named "Transform"
        return Util_upvr.MakeFuzzyFinder(Enum_UserInputType_GetEnumItems_result1_upvr)(arg1)
    end;
    Validate = function(arg1) -- Line 16, Named "Validate"
        local var11
        if 0 >= #arg1 then
            var11 = false
        else
            var11 = true
        end
        return var11
    end;
    Autocomplete = function(arg1) -- Line 20, Named "Autocomplete"
        return Util_upvr.GetNames(arg1)
    end;
    Parse = function(arg1) -- Line 24, Named "Parse"
        return arg1[1]
    end;
}
return function(arg1) -- Line 29
    arg1:RegisterType("userInput", tbl_upvr)
    arg1:RegisterType("userInputs", Util_upvr.MakeListableType(tbl_upvr))
end