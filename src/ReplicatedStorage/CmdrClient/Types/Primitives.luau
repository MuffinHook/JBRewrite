local Util_upvr = require(script.Parent.Parent.Shared.Util)
local tbl_upvr_6 = {}
local function Validate(arg1) -- Line 4
    if arg1 == nil then
    else
    end
    return true
end
tbl_upvr_6.Validate = Validate
local function Parse(arg1) -- Line 8
    return tostring(arg1)
end
tbl_upvr_6.Parse = Parse
local tbl_upvr_3 = {}
local function Transform(arg1) -- Line 14
    return tonumber(arg1)
end
tbl_upvr_3.Transform = Transform
local function Validate(arg1) -- Line 18
    if arg1 == nil then
    else
    end
    return true
end
tbl_upvr_3.Validate = Validate
local function Parse(arg1) -- Line 22
    return arg1
end
tbl_upvr_3.Parse = Parse
local tbl_upvr_2 = {}
local function Transform(arg1) -- Line 28
    return tonumber(arg1)
end
tbl_upvr_2.Transform = Transform
local function Validate(arg1) -- Line 32
    local var5 = false
    if arg1 ~= nil then
        if arg1 ~= math.floor(arg1) then
            var5 = false
        else
            var5 = true
        end
    end
    return var5, "Only whole numbers are valid."
end
tbl_upvr_2.Validate = Validate
local function Parse(arg1) -- Line 36
    return arg1
end
tbl_upvr_2.Parse = Parse
local tbl_upvr_7 = {}
local function Transform(arg1) -- Line 42
    return tonumber(arg1)
end
tbl_upvr_7.Transform = Transform
local function Validate(arg1) -- Line 46
    local var8 = false
    if arg1 ~= nil then
        var8 = false
        if arg1 == math.floor(arg1) then
            if 0 >= arg1 then
                var8 = false
            else
                var8 = true
            end
        end
    end
    return var8, "Only positive whole numbers are valid."
end
tbl_upvr_7.Validate = Validate
local function Parse(arg1) -- Line 50
    return arg1
end
tbl_upvr_7.Parse = Parse
local tbl_upvr_4 = {}
local function Transform(arg1) -- Line 56
    return tonumber(arg1)
end
tbl_upvr_4.Transform = Transform
local function Validate(arg1) -- Line 60
    local var10 = false
    if arg1 ~= nil then
        var10 = false
        if arg1 == math.floor(arg1) then
            if 0 > arg1 then
                var10 = false
            else
                var10 = true
            end
        end
    end
    return var10, "Only non-negative whole numbers are valid."
end
tbl_upvr_4.Validate = Validate
local function Parse(arg1) -- Line 64
    return arg1
end
tbl_upvr_4.Parse = Parse
local tbl_upvr = {}
local function Transform(arg1) -- Line 70
    return tonumber(arg1)
end
tbl_upvr.Transform = Transform
local function Validate(arg1) -- Line 74
    local var13 = false
    if arg1 ~= nil then
        var13 = false
        if arg1 == math.floor(arg1) then
            var13 = false
            if 0 <= arg1 then
                if arg1 > 255 then
                    var13 = false
                else
                    var13 = true
                end
            end
        end
    end
    return var13, "Only bytes are valid."
end
tbl_upvr.Validate = Validate
local function Parse(arg1) -- Line 78
    return arg1
end
tbl_upvr.Parse = Parse
local tbl_upvr_5 = {}
local function Transform(arg1) -- Line 84
    return tonumber(arg1)
end
tbl_upvr_5.Transform = Transform
local function Validate(arg1) -- Line 88
    local var15 = false
    if arg1 ~= nil then
        var15 = false
        if arg1 == math.floor(arg1) then
            var15 = false
            if 0 <= arg1 then
                if arg1 > 9 then
                    var15 = false
                else
                    var15 = true
                end
            end
        end
    end
    return var15, "Only digits are valid."
end
tbl_upvr_5.Validate = Validate
local function Parse(arg1) -- Line 92
    return arg1
end
tbl_upvr_5.Parse = Parse
local any_MakeDictionary_result1_upvr = Util_upvr.MakeDictionary({"true", 't', "yes", 'y', "on", "enable", "enabled", '1', '+'})
local any_MakeDictionary_result1_upvr_2 = Util_upvr.MakeDictionary({"false", 'f', "no", 'n', "off", "disable", "disabled", '0', '-'})
local tbl_upvw = {
    Transform = function(arg1) -- Line 103, Named "Transform"
        return arg1:lower()
    end;
    Validate = function(arg1) -- Line 107, Named "Validate"
        local var21 = true
        if any_MakeDictionary_result1_upvr[arg1] == nil then
            if any_MakeDictionary_result1_upvr_2[arg1] == nil then
                var21 = false
            else
                var21 = true
            end
        end
        return var21, "Please use true/yes/on or false/no/off."
    end;
    Parse = function(arg1) -- Line 111, Named "Parse"
        if any_MakeDictionary_result1_upvr[arg1] then
            return true
        end
        if any_MakeDictionary_result1_upvr_2[arg1] then
            return false
        end
        return nil
    end;
}
function any_MakeDictionary_result1_upvr(arg1) -- Line 123
    arg1:RegisterType("string", tbl_upvr_6)
    arg1:RegisterType("number", tbl_upvr_3)
    arg1:RegisterType("integer", tbl_upvr_2)
    arg1:RegisterType("positiveInteger", tbl_upvr_7)
    arg1:RegisterType("nonNegativeInteger", tbl_upvr_4)
    arg1:RegisterType("byte", tbl_upvr)
    arg1:RegisterType("digit", tbl_upvr_5)
    arg1:RegisterType("boolean", tbl_upvw)
    arg1:RegisterType("strings", Util_upvr.MakeListableType(tbl_upvr_6))
    arg1:RegisterType("numbers", Util_upvr.MakeListableType(tbl_upvr_3))
    arg1:RegisterType("integers", Util_upvr.MakeListableType(tbl_upvr_2))
    arg1:RegisterType("positiveIntegers", Util_upvr.MakeListableType(tbl_upvr_7))
    arg1:RegisterType("nonNegativeIntegers", Util_upvr.MakeListableType(tbl_upvr_4))
    arg1:RegisterType("bytes", Util_upvr.MakeListableType(tbl_upvr))
    arg1:RegisterType("digits", Util_upvr.MakeListableType(tbl_upvr_5))
    arg1:RegisterType("booleans", Util_upvr.MakeListableType(tbl_upvw))
end
return any_MakeDictionary_result1_upvr