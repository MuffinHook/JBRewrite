local module_upvr = {}
local Logger_upvr = require(script.Parent.Logger)
local Utilities_upvr = require(script.Parent.Utilities)
function module_upvr.validateCustomDimensions(arg1, arg2) -- Line 6
    return module_upvr:validateArrayOfStrings(20, 32, false, "custom dimensions", arg2)
end
function module_upvr.validateDimension(arg1, arg2, arg3) -- Line 10
    if Utilities_upvr:isStringNullOrEmpty(arg3) then
        return true
    end
    if not Utilities_upvr:stringArrayContainsString(arg2, arg3) then
        return false
    end
    return true
end
function module_upvr.validateResourceCurrencies(arg1, arg2) -- Line 23
    if not module_upvr:validateArrayOfStrings(20, 64, false, "resource currencies", arg2) then
        return false
    end
    for _, v in pairs(arg2) do
        if not string.find(v, "^[A-Za-z]+$") then
            Logger_upvr:w("resource currencies validation failed: a resource currency can only be A-Z, a-z. String was: "..v)
            return false
        end
    end
    return true
end
function module_upvr.validateResourceItemTypes(arg1, arg2) -- Line 39
    if not module_upvr:validateArrayOfStrings(20, 32, false, "resource item types", arg2) then
        return false
    end
    for _, v_2 in pairs(arg2) do
        if not module_upvr:validateEventPartCharacters(v_2) then
            Logger_upvr:w("resource item types validation failed: a resource item type cannot contain other characters than A-z, 0-9, -_., ()!?. String was: "..v_2)
            return false
        end
    end
    return true
end
function module_upvr.validateEventPartCharacters(arg1, arg2) -- Line 55
    if not string.find(arg2, "^[A-Za-z0-9%s%-_%.%(%)!%?]+$") then
        return false
    end
    return true
end
function module_upvr.validateArrayOfStrings(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 63
    local var18
    if not var18 then
        var18 = "Array"
    end
    if not arg6 then
        Logger_upvr:w(var18.." validation failed: array cannot be nil.")
        return false
    end
    if not arg4 and #arg6 == 0 then
        Logger_upvr:w(var18.." validation failed: array cannot be empty.")
        return false
    end
    if 0 < arg2 and arg2 < #arg6 then
        Logger_upvr:w(var18.." validation failed: array cannot exceed "..tostring(arg2).." values. It has "..(#arg6).." values.")
        return false
    end
    for _, v_3 in ipairs(arg6) do
        local var22 = 0
        if v_3 then
            var22 = #v_3
        end
        if var22 == 0 then
            Logger_upvr:w(var18.." validation failed: contained an empty string.")
            return false
        end
        if 0 < arg3 and arg3 < var22 then
            Logger_upvr:w(var18.." validation failed: a string exceeded max allowed length (which is: "..tostring(arg3).."). String was: "..v_3)
            return false
        end
    end
    return true
end
function module_upvr.validateBuild(arg1, arg2) -- Line 111
    if not module_upvr:validateShortString(arg2, false) then
        return false
    end
    return true
end
function module_upvr.validateShortString(arg1, arg2, arg3) -- Line 119
    if arg3 and Utilities_upvr:isStringNullOrEmpty(arg2) then
        return true
    end
    if Utilities_upvr:isStringNullOrEmpty(arg2) or 32 < #arg2 then
        return false
    end
    return true
end
function module_upvr.validateKeys(arg1, arg2, arg3) -- Line 132
    if string.find(arg2, "^[A-Za-z0-9]+$") and #arg2 == 32 and string.find(arg3, "^[A-Za-z0-9]+$") and #arg3 == 40 then
        return true
    end
    return false
end
function module_upvr.validateAndCleanInitRequestResponse(arg1, arg2, arg3) -- Line 142
    if not arg2 then
        Logger_upvr:w("validateInitRequestResponse failed - no response dictionary.")
        return nil
    end
    local module = {}
    local var24 = arg2.server_ts or -1
    if 0 < var24 then
        module.server_ts = var24
    end
    if arg3 then
        local configs = arg2.configs
        if not configs then
            configs = {}
        end
        module.configs = configs
        module.ab_id = arg2.ab_id or ""
        module.ab_variant_id = arg2.ab_variant_id or ""
    end
    return module
end
function module_upvr.validateClientTs(arg1, arg2) -- Line 166
    if arg2 < 1000000000 or 9999999999 < arg2 then
        return false
    end
    return true
end
function module_upvr.validateCurrency(arg1, arg2) -- Line 174
    if Utilities_upvr:isStringNullOrEmpty(arg2) then
        return false
    end
    if string.find(arg2, "^[A-Z]+$") and #arg2 == 3 then
        return true
    end
    return false
end
function module_upvr.validateEventPartLength(arg1, arg2, arg3) -- Line 186
    if arg3 and Utilities_upvr:isStringNullOrEmpty(arg2) then
        return true
    end
    if Utilities_upvr:isStringNullOrEmpty(arg2) then
        return false
    end
    if #arg2 == 0 or 64 < #arg2 then
        return false
    end
    return true
end
function module_upvr.validateBusinessEvent(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 201
    if not module_upvr:validateCurrency(arg2) then
        Logger_upvr:w("Validation fail - business event - currency: Cannot be (null) and need to be A-Z, 3 characters and in the standard at openexchangerates.org. Failed currency: "..arg2)
        return false
    end
    if arg3 < 0 then
        Logger_upvr:w("Validation fail - business event - amount: Cannot be less then 0. Failed amount: "..arg3)
        return false
    end
    if not module_upvr:validateShortString(arg4, true) then
        Logger_upvr:w("Validation fail - business event - cartType. Cannot be above 32 length. String: "..arg4)
        return false
    end
    if not module_upvr:validateEventPartLength(arg5, false) then
        Logger_upvr:w("Validation fail - business event - itemType: Cannot be (null), empty or above 64 characters. String: "..arg5)
        return false
    end
    if not module_upvr:validateEventPartCharacters(arg5) then
        Logger_upvr:w("Validation fail - business event - itemType: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: "..arg5)
        return false
    end
    if not module_upvr:validateEventPartLength(arg6, false) then
        Logger_upvr:w("Validation fail - business event - itemId. Cannot be (null), empty or above 64 characters. String: "..arg6)
        return false
    end
    if not module_upvr:validateEventPartCharacters(arg6) then
        Logger_upvr:w("Validation fail - business event - itemId: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: "..arg6)
        return false
    end
    return true
end
function module_upvr.validateResourceEvent(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) -- Line 245
    if arg3 ~= arg2.Source and arg3 ~= arg2.Sink then
        Logger_upvr:w("Validation fail - resource event - flowType: Invalid flow type "..tostring(arg3))
        return false
    end
    if Utilities_upvr:isStringNullOrEmpty(arg4) then
        Logger_upvr:w("Validation fail - resource event - currency: Cannot be (null)")
        return false
    end
    if not Utilities_upvr:stringArrayContainsString(arg8, arg4) then
        Logger_upvr:w("Validation fail - resource event - currency: Not found in list of pre-defined available resource currencies. String: "..arg4)
        return false
    end
    if 0 >= arg5 then
        Logger_upvr:w("Validation fail - resource event - amount: Float amount cannot be 0 or negative. Value: "..tostring(arg5))
        return false
    end
    if Utilities_upvr:isStringNullOrEmpty(arg6) then
        Logger_upvr:w("Validation fail - resource event - itemType: Cannot be (null)")
        return false
    end
    if not module_upvr:validateEventPartLength(arg6, false) then
        Logger_upvr:w("Validation fail - resource event - itemType: Cannot be (null), empty or above 64 characters. String: "..arg6)
        return false
    end
    if not module_upvr:validateEventPartCharacters(arg6) then
        Logger_upvr:w("Validation fail - resource event - itemType: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: "..arg6)
        return false
    end
    if not Utilities_upvr:stringArrayContainsString(arg9, arg6) then
        Logger_upvr:w("Validation fail - resource event - itemType: Not found in list of pre-defined available resource itemTypes. String: "..arg6)
        return false
    end
    if not module_upvr:validateEventPartLength(arg7, false) then
        Logger_upvr:w("Validation fail - resource event - itemId: Cannot be (null), empty or above 64 characters. String: "..arg7)
        return false
    end
    if not module_upvr:validateEventPartCharacters(arg7) then
        Logger_upvr:w("Validation fail - resource event - itemId: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: "..arg7)
        return false
    end
    return true
end
function module_upvr.validateProgressionEvent(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 299
    if arg3 ~= arg2.Start and arg3 ~= arg2.Complete and arg3 ~= arg2.Fail then
        Logger_upvr:w("Validation fail - progression event: Invalid progression status "..tostring(arg3))
        return false
    end
    if not Utilities_upvr:isStringNullOrEmpty(arg6) and Utilities_upvr:isStringNullOrEmpty(arg5) and not Utilities_upvr:isStringNullOrEmpty(arg4) then
        Logger_upvr:w("Validation fail - progression event: 03 found but 01+02 are invalid. Progression must be set as either 01, 01+02 or 01+02+03.")
        return false
    end
    if not Utilities_upvr:isStringNullOrEmpty(arg5) and Utilities_upvr:isStringNullOrEmpty(arg4) then
        Logger_upvr:w("Validation fail - progression event: 02 found but not 01. Progression must be set as either 01, 01+02 or 01+02+03")
        return false
    end
    if Utilities_upvr:isStringNullOrEmpty(arg4) then
        Logger_upvr:w("Validation fail - progression event: progression01 not valid. Progressions must be set as either 01, 01+02 or 01+02+03")
        return false
    end
    if not module_upvr:validateEventPartLength(arg4, false) then
        Logger_upvr:w("Validation fail - progression event - progression01: Cannot be (null), empty or above 64 characters. String: "..arg4)
        return false
    end
    if not module_upvr:validateEventPartCharacters(arg4) then
        Logger_upvr:w("Validation fail - progression event - progression01: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: "..arg4)
        return false
    end
    if not Utilities_upvr:isStringNullOrEmpty(arg5) then
        if not module_upvr:validateEventPartLength(arg5, false) then
            Logger_upvr:w("Validation fail - progression event - progression02: Cannot be empty or above 64 characters. String: "..arg5)
            return false
        end
        if not module_upvr:validateEventPartCharacters(arg5) then
            Logger_upvr:w("Validation fail - progression event - progression02: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: "..arg5)
            return false
        end
    end
    if not Utilities_upvr:isStringNullOrEmpty(arg6) then
        if not module_upvr:validateEventPartLength(arg6, false) then
            Logger_upvr:w("Validation fail - progression event - progression03: Cannot be empty or above 64 characters. String: "..arg6)
            return false
        end
        if not module_upvr:validateEventPartCharacters(arg6) then
            Logger_upvr:w("Validation fail - progression event - progression03: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: "..arg6)
            return false
        end
    end
    return true
end
function module_upvr.validateEventIdLength(arg1, arg2) -- Line 357
    if Utilities_upvr:isStringNullOrEmpty(arg2) then
        return false
    end
    for i_4 in string.gmatch(arg2, "([^:]+)") do
        if 5 < 0 + 1 or 64 < #i_4 then
            return false
        end
    end
    return true
end
function module_upvr.validateEventIdCharacters(arg1, arg2) -- Line 373
    if Utilities_upvr:isStringNullOrEmpty(arg2) then
        return false
    end
    for i_5 in string.gmatch(arg2, "([^:]+)") do
        if 5 < 0 + 1 or not string.find(i_5, "^[A-Za-z0-9%s%-_%.%(%)!%?]+$") then
            return false
        end
    end
    return true
end
function module_upvr.validateDesignEvent(arg1, arg2) -- Line 389
    if not module_upvr:validateEventIdLength(arg2) then
        Logger_upvr:w("Validation fail - design event - eventId: Cannot be (null) or empty. Only 5 event parts allowed seperated by :. Each part need to be 32 characters or less. String: "..arg2)
        return false
    end
    if not module_upvr:validateEventIdCharacters(arg2) then
        Logger_upvr:w("Validation fail - design event - eventId: Non valid characters. Only allowed A-z, 0-9, -_., ()!?. String: "..arg2)
        return false
    end
    return true
end
function module_upvr.validateLongString(arg1, arg2, arg3) -- Line 404
    if arg3 and Utilities_upvr:isStringNullOrEmpty(arg2) then
        return true
    end
    if Utilities_upvr:isStringNullOrEmpty(arg2) or 8192 < #arg2 then
        return false
    end
    return true
end
function module_upvr.validateErrorEvent(arg1, arg2, arg3, arg4) -- Line 417
    if arg3 ~= arg2.debug and arg3 ~= arg2.info and arg3 ~= arg2.warning and arg3 ~= arg2.error and arg3 ~= arg2.critical then
        Logger_upvr:w("Validation fail - error event - severity: Severity was unsupported value "..tostring(arg3))
        return false
    end
    if not module_upvr:validateLongString(arg4, true) then
        Logger_upvr:w("Validation fail - error event - message: Message cannot be above 8192 characters.")
        return false
    end
    return true
end
return module_upvr