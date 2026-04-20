local Util_upvr = require(script.Parent.Util)
local function unescapeOperators_upvr(arg1) -- Line 3, Named "unescapeOperators"
    local var10
    for _, v in ipairs({"%.", "%?", "%*", "%*%*"}) do
        var10 = var10:gsub('\\'..v, v:gsub("%%", ""))
    end
    return var10
end
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1, arg2, arg3) -- Line 113
    local module = {}
    module.Command = arg1
    module.Type = nil
    module.Name = arg2.Name
    module.Object = arg2
    local var13 = false
    if arg2.Default == nil then
        if arg2.Optional == true then
            var13 = false
        else
            var13 = true
        end
    end
    module.Required = var13
    module.Executor = arg1.Executor
    module.RawValue = arg3
    module.RawSegments = {}
    module.TransformedValues = {}
    module.Prefix = ""
    module.TextSegmentInProgress = ""
    module.RawSegmentsAreAutocomplete = false
    if type(arg2.Type) == "table" then
        module.Type = arg2.Type
    else
        local any_ParsePrefixedUnionType_result1, any_ParsePrefixedUnionType_result2, any_ParsePrefixedUnionType_result3 = Util_upvr.ParsePrefixedUnionType(arg1.Cmdr.Registry:GetTypeName(arg2.Type), arg3)
        module.Type = arg1.Dispatcher.Registry:GetType(any_ParsePrefixedUnionType_result1)
        module.RawValue = any_ParsePrefixedUnionType_result2
        module.Prefix = any_ParsePrefixedUnionType_result3
        if module.Type == nil then
            error(string.format(`[Cmdr] {module.Name or "none"} has an unregistered type %q`, any_ParsePrefixedUnionType_result1 or "<none>"))
        end
    end
    setmetatable(module, module_upvr)
    module:Transform()
    return module
end
function module_upvr.GetDefaultAutocomplete(arg1) -- Line 156
    if arg1.Type.Autocomplete then
        local any_Autocomplete_result1, any_Autocomplete_result2 = arg1.Type.Autocomplete(arg1:TransformSegment(""))
        local var19 = any_Autocomplete_result2
        if not var19 then
            var19 = {}
        end
        return any_Autocomplete_result1, var19
    end
    return {}
end
function module_upvr.Transform(arg1) -- Line 173
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var81
    if var81 ~= 0 then
    else
        var81 = arg1.RawValue
        if arg1.Type.ArgumentOperatorAliases then
            var81 = arg1.Type.ArgumentOperatorAliases[var81] or var81
        end
        if var81 == '.' and arg1.Type.Default then
            var81 = arg1.Type.Default(arg1.Executor) or ""
            arg1.RawSegmentsAreAutocomplete = true
        end
        if var81 == '?' and arg1.Type.Autocomplete then
            local any_GetDefaultAutocomplete_result1_3, any_GetDefaultAutocomplete_result2_6 = arg1:GetDefaultAutocomplete()
            if not any_GetDefaultAutocomplete_result2_6.IsPartial and 0 < #any_GetDefaultAutocomplete_result1_3 then
                var81 = any_GetDefaultAutocomplete_result1_3[math.random(1, #any_GetDefaultAutocomplete_result1_3)]
                arg1.RawSegmentsAreAutocomplete = true
            end
        end
        if arg1.Type.Listable and 0 < #arg1.RawValue then
            local any_match_result1 = var81:match("^%?(%d+)$")
            if any_match_result1 then
                local tonumber_result1_2 = tonumber(any_match_result1)
                if tonumber_result1_2 and 0 < tonumber_result1_2 then
                    local tbl_5 = {}
                    local any_GetDefaultAutocomplete_result1_4, any_GetDefaultAutocomplete_result2_5 = arg1:GetDefaultAutocomplete()
                    if not any_GetDefaultAutocomplete_result2_5.IsPartial and 0 < #any_GetDefaultAutocomplete_result1_4 then
                        for _ = 1, math.min(tonumber_result1_2, #any_GetDefaultAutocomplete_result1_4) do
                            table.insert(tbl_5, table.remove(any_GetDefaultAutocomplete_result1_4, math.random(1, #any_GetDefaultAutocomplete_result1_4)))
                        end
                        var81 = table.concat(tbl_5, ',')
                        arg1.RawSegmentsAreAutocomplete = true
                        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                    end
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
            else
                local any_GetDefaultAutocomplete_result1_6, any_GetDefaultAutocomplete_result2_2 = arg1:GetDefaultAutocomplete()
                local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    return any_GetDefaultAutocomplete_result2_2.IsPartial
                end
                if var81 == '*' or var81 == "**" or not decompInlinedCondition_3() and 0 < #any_GetDefaultAutocomplete_result1_6 then
                    if var81 == "**" then
                        if arg1.Type.Default then
                            for i_7, v_3 in ipairs(any_GetDefaultAutocomplete_result1_6) do
                                if v_3 == (arg1.Type.Default(arg1.Executor) or "") then
                                    table.remove(any_GetDefaultAutocomplete_result1_6, i_7)
                                end
                            end
                        end
                    end
                    var81 = table.concat(any_GetDefaultAutocomplete_result1_6, ',')
                    arg1.RawSegmentsAreAutocomplete = true
                end
            end
            var81 = unescapeOperators_upvr(var81)
            local any_SplitStringSimple_result1_2 = Util_upvr.SplitStringSimple(var81, ',')
            if #any_SplitStringSimple_result1_2 == 0 then
                any_SplitStringSimple_result1_2 = {""}
            end
            if var81:sub(#var81, #var81) == ',' then
                any_SplitStringSimple_result1_2[#any_SplitStringSimple_result1_2 + 1] = ""
            end
            for i_8, v_4 in ipairs(any_SplitStringSimple_result1_2) do
                arg1.RawSegments[i_8] = v_4
                arg1.TransformedValues[i_8] = {arg1:TransformSegment(v_4)}
            end
            arg1.TextSegmentInProgress = any_SplitStringSimple_result1_2[#any_SplitStringSimple_result1_2]
            return
        end
        arg1.RawSegments[1] = unescapeOperators_upvr(unescapeOperators_upvr(var81))
        local tbl_3 = {}
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        tbl_3[1] = arg1:TransformSegment(unescapeOperators_upvr(var81))
        arg1.TransformedValues[1] = tbl_3
        arg1.TextSegmentInProgress = arg1.RawValue
    end
end
function module_upvr.TransformSegment(arg1, arg2) -- Line 266
    if arg1.Type.Transform then
        return arg1.Type.Transform(arg2, arg1.Executor)
    end
    return arg2
end
function module_upvr.GetTransformedValue(arg1, arg2) -- Line 278
    return unpack(arg1.TransformedValues[arg2])
end
function module_upvr.Validate(arg1, arg2) -- Line 289
    if arg1.RawValue == nil or #arg1.RawValue == 0 and arg1.Required == false then
        return true
    end
    if arg1.Required and (arg1.RawSegments[1] == nil or #arg1.RawSegments[1] == 0) then
        return false, "This argument is required."
    end
    if arg1.Type.Validate or arg1.Type.ValidateOnce then
        for i_2 = 1, #arg1.TransformedValues do
            if arg1.Type.Validate then
                local any_Validate_result1, any_Validate_result2 = arg1.Type.Validate(arg1:GetTransformedValue(i_2))
                if not any_Validate_result1 then
                    return any_Validate_result1, any_Validate_result2 or "Invalid value"
                end
            end
            if arg2 then
                if arg1.Type.ValidateOnce then
                    local any_ValidateOnce_result1_2, any_ValidateOnce_result2_2 = arg1.Type.ValidateOnce(arg1:GetTransformedValue(i_2))
                    if not any_ValidateOnce_result1_2 then
                        return any_ValidateOnce_result1_2, any_ValidateOnce_result2_2
                    end
                end
            end
        end
        return true
    end
    return true
end
function module_upvr.GetAutocomplete(arg1) -- Line 330
    if arg1.Type.Autocomplete then
        return arg1.Type.Autocomplete(arg1:GetTransformedValue(#arg1.TransformedValues))
    end
    return {}
end
function module_upvr.ParseValue(arg1, arg2) -- Line 343
    if arg1.Type.Parse then
        return arg1.Type.Parse(arg1:GetTransformedValue(arg2))
    end
    return arg1:GetTransformedValue(arg2)
end
function module_upvr.GetValue(arg1) -- Line 356
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if #arg1.RawValue == 0 and not arg1.Required and arg1.Object.Default ~= nil then
        return arg1.Object.Default
    end
    if not arg1.Type.Listable then
        return arg1:ParseValue(1)
    end
    local var133 = {}
    for i_3 = 1, #arg1.TransformedValues do
        local any_ParseValue_result1 = arg1:ParseValue(i_3)
        if type(any_ParseValue_result1) ~= "table" then
            error(`[Cmdr] Listable types must return a table from Parse {arg1.Type.Name}`)
        end
        for _, v_2 in pairs(any_ParseValue_result1) do
            var133[v_2] = true
        end
    end
    local tbl_4 = {}
    for i_5 in pairs(var133) do
        tbl_4[#tbl_4 + 1] = i_5
    end
    return tbl_4
end
return module_upvr
