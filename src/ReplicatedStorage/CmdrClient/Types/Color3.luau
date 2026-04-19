-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:42
-- Luau version 6, Types version 3
-- Time taken: 0.003991 seconds

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
        --[[ Upvalues[2]:
            [1]: Util_upvr (readonly)
            [2]: parseHexDigit_upvr (readonly)
        ]]
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
            return false, "Invalid or missing number at position %d in Color3 type.":format(arg2)
        end
        if arg1 < 0 or 255 < arg1 then
            return false, "Number out of acceptable range 0-255 at position %d in Color3 type.":format(arg2)
        end
        if arg1 % 1 ~= 0 then
            return false, "Number is not an integer at position %d in Color3 type.":format(arg2)
        end
        return true
    end;
    TransformEach = tonumber;
    Constructor = Color3.fromRGB;
    Length = 3;
})
return function(arg1) -- Line 44
    --[[ Upvalues[3]:
        [1]: any_MakeSequenceType_result1_upvr (readonly)
        [2]: Util_upvr (readonly)
        [3]: tbl_upvr (readonly)
    ]]
    arg1:RegisterType("color3", any_MakeSequenceType_result1_upvr)
    arg1:RegisterType("color3s", Util_upvr.MakeListableType(any_MakeSequenceType_result1_upvr, {
        Prefixes = "# hexColor3s ! brickColor3s";
    }))
    arg1:RegisterType("hexColor3", tbl_upvr)
    arg1:RegisterType("hexColor3s", Util_upvr.MakeListableType(tbl_upvr))
end