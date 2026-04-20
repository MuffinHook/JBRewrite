local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local LocalizationService_upvr = game:GetService("LocalizationService")
local var3_upvw
if LocalPlayer_upvr then
    task.spawn(function() -- Line 10
        local pcall_result1, pcall_result2 = pcall(function() -- Line 11
            var3_upvw = LocalizationService_upvr:GetTranslatorForPlayerAsync(LocalPlayer_upvr)
        end)
        if pcall_result1 then
        else
            warn(pcall_result2)
            var3_upvw = nil
        end
    end)
end
local module = {}
local any_GetTranslator_result1_upvr_2 = LocalizationService_upvr.GameLocalizationTable:GetTranslator(LocalizationService_upvr.RobloxLocaleId)
local any_GetTranslator_result1_upvr = LocalizationService_upvr.GameLocalizationTable:GetTranslator("en-us")
local function _formatByKey_upvr(arg1, ...) -- Line 25, Named "_formatByKey"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local args_list_upvr = {...}
    local var13_upvw
    local var14_upvw
    if not pcall(function() -- Line 28
        var13_upvw = var3_upvw:FormatByKey(arg1, unpack(args_list_upvr))
    end) then
    end
    if not pcall(function() -- Line 32
        var14_upvw = any_GetTranslator_result1_upvr_2:FormatByKey(arg1, unpack(args_list_upvr))
    end) then
        local pcall_result1_2 = pcall(function() -- Line 37
            var14_upvw = any_GetTranslator_result1_upvr:FormatByKey(arg1, unpack(args_list_upvr))
        end)
    end
    if not pcall_result1_2 then
        var14_upvw = arg1
    end
    return pcall_result1_2, var14_upvw
end
function module.FormatByKey(arg1, ...) -- Line 46
    local _formatByKey_upvr_result1_2, _formatByKey_upvr_result2 = _formatByKey_upvr(...)
    if not _formatByKey_upvr_result1_2 then
        warn("No valid translation for: ".._formatByKey_upvr_result2)
    end
    return _formatByKey_upvr_result2
end
function module.AttemptFormatByKey(arg1, ...) -- Line 54
    local _formatByKey_upvr_result1, _formatByKey_upvr_result2_2 = _formatByKey_upvr(...)
    return _formatByKey_upvr_result1, _formatByKey_upvr_result2_2
end
return module