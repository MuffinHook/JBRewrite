local Util_upvr = require(script.Parent.Parent.Shared.Util)
local function parseHexDigit_upvr(arg1) -- Line 21, Named "parseHexDigit"
    local var3
    if #arg1 == 1 then
        var3 = var3..var3
    end
    return tonumber(var3, 16)
end
local tbl_upvr = {
    Transform = function(arg1) -- Line 30, Named "Transform"
        local any_match_result1, any_match_result2, any_match_result3 = arg1:match("^#?(%x%x?)(%x%x?)(%x%x?)$")
        return Util_upvr.Each(parseHexDigit_upvr, any_match_result1, any_match_result2, any_match_result3)
    end;
    Validate = function(arg1, arg2, arg3) -- Line 35, Named "Validate"
        local var9 = false
        if arg1 ~= nil then
            var9 = false
            if arg2 ~= nil then
                if arg3 == nil then
                    var9 = false
                else
                    var9 = true
                end
            end
        end
        return var9, "Invalid hex color"
    end;
    Parse = function(...) -- Line 39, Named "Parse"
        return Color3.fromRGB(...)
    end;
}
local any_MakeSequenceType_result1_upvr = Util_upvr.MakeSequenceType({
    Prefixes = "# hexColor3 ! brickColor3";
    ValidateEach = function(arg1, arg2) -- Line 5, Named "ValidateEach"
        if arg1 == nil then
            return false, string.format("Invalid or missing number at position %d in Color3 type.", arg2);
        end
        if arg1 < 0 or 255 < arg1 then
            return false, string.format("Number out of acceptable range 0-255 at position %d in Color3 type.", arg2);
        end
        if arg1 % 1 ~= 0 then
            return false, string.format("Number is not an integer at position %d in Color3 type.", arg2);
        end
        return true
    end;
    TransformEach = tonumber;
    Constructor = Color3.fromRGB;
    Length = 3;
})
return function(arg1) -- Line 44
    arg1:RegisterType("color3", any_MakeSequenceType_result1_upvr)
    arg1:RegisterType("color3s", Util_upvr.MakeListableType(any_MakeSequenceType_result1_upvr, {
        Prefixes = "# hexColor3s ! brickColor3s";
    }))
    arg1:RegisterType("hexColor3", tbl_upvr)
    arg1:RegisterType("hexColor3s", Util_upvr.MakeListableType(tbl_upvr))
end