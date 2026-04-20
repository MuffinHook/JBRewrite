local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
return function(arg1) -- Line 6
    local Util_upvr = arg1.Util
    local module_4_upvr = require(script:WaitForChild("Window"))
    module_4_upvr.Cmdr = arg1
    local var5_upvr = require(script:WaitForChild("AutoComplete"))(arg1)
    module_4_upvr.AutoComplete = var5_upvr
    function module_4_upvr.ProcessEntry(arg1_2) -- Line 16
        local any_TrimString_result1 = Util_upvr.TrimString(arg1_2)
        if #any_TrimString_result1 == 0 then
        else
            module_4_upvr:AddLine(module_4_upvr:GetLabel()..' '..any_TrimString_result1, Color3.fromRGB(255, 223, 93))
            module_4_upvr:AddLine(arg1.Dispatcher:EvaluateAndRun(any_TrimString_result1, LocalPlayer_upvr, {
                IsHuman = true;
            }))
        end
    end
    function module_4_upvr.OnTextChanged(arg1_3) -- Line 31
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local any_Evaluate_result1 = arg1.Dispatcher:Evaluate(arg1_3, LocalPlayer_upvr, true)
        local popped_2 = table.remove(Util_upvr.SplitString(arg1_3), 1)
        local var94
        if any_Evaluate_result1 then
            var94 = Util_upvr.MashExcessArguments(var94, #any_Evaluate_result1.Object.Args)
            if #var94 ~= #any_Evaluate_result1.Object.Args then
                local _ = false
                -- KONSTANTWARNING: Skipped task `defvar` above
            else
            end
        end
        if popped_2 then
            if 0 >= #var94 then
            else
            end
        end
        local var96
        if arg1_3:sub(#arg1_3, #arg1_3):match("%s") and not true then
            var96 = true
            var94[#var94 + 1] = ""
        end
        if any_Evaluate_result1 and var96 then
            local any_Validate_result1_4, any_Validate_result2 = any_Evaluate_result1:Validate()
            module_4_upvr:SetIsValidInput(any_Validate_result1_4, "Validation errors: %s":format(any_Validate_result2 or ""))
            local any_GetArgument_result1 = any_Evaluate_result1:GetArgument(#var94)
            local var100
            if any_GetArgument_result1 then
                var100 = any_GetArgument_result1.RawSegmentsAreAutocomplete
                if var100 then
                    var100 = ipairs(any_GetArgument_result1.RawSegments)
                    local ipairs_result1_2, ipairs_result2, ipairs_result3 = ipairs(any_GetArgument_result1.RawSegments)
                    for i, v in ipairs_result1_2, ipairs_result2, ipairs_result3 do
                        ({})[1] = v
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        ;({})[2] = v
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        ;({})[i] = {}
                        local var105
                    end
                else
                    ipairs_result1_2 = any_GetArgument_result1:GetAutocomplete()
                    local any_GetAutocomplete_result1_2, any_GetAutocomplete_result2_2 = any_GetArgument_result1:GetAutocomplete()
                    ipairs_result3 = any_GetAutocomplete_result2_2
                    local var108 = ipairs_result3
                    if not var108 then
                        var108 = {}
                    end
                    i = any_GetAutocomplete_result1_2
                    for i_2, v_2 in pairs(i) do
                        var105[i_2] = {any_GetArgument_result1.TextSegmentInProgress, v_2}
                        local var113
                    end
                end
                any_GetAutocomplete_result1_2 = true
                if 0 < #var113 then
                    local any_Validate_result1_3, any_Validate_result2_2 = any_GetArgument_result1:Validate()
                    any_GetAutocomplete_result1_2 = any_Validate_result1_3
                end
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                if not true and any_GetAutocomplete_result1_2 then
                    module_4_upvr:HideInvalidState()
                end
                local module = {}
                i_2 = true
                if i_2 then
                    v_2 = #arg1_3 - #var113
                    if arg1_3:sub(#arg1_3, #arg1_3):match("%s") then
                    else
                    end
                    i_2 = v_2 + 0
                end
                module.at = i_2
                if #any_GetArgument_result1.RawSegments ~= 1 or not any_GetArgument_result1.Prefix then
                end
                module.prefix = ""
                if #any_Evaluate_result1.Arguments == #any_Evaluate_result1.ArgumentDefinitions then
                    if 0 >= #var113 then
                    else
                    end
                end
                module.isLast = true
                module.numArgs = #var94
                module.command = any_Evaluate_result1
                module.arg = any_GetArgument_result1
                if any_GetArgument_result1.Required then
                else
                end
                module.name = any_GetArgument_result1.Name..'?'
                module.type = any_GetArgument_result1.Type.DisplayName
                if any_GetAutocomplete_result1_2 ~= false or not any_Validate_result2_2 then
                end
                module.description = any_GetArgument_result1.Object.Description
                module.invalid = not any_GetAutocomplete_result1_2
                module.isPartial = var108.IsPartial or false
                do
                    return var5_upvr:Show(var105, module)
                end
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        elseif popped_2 then
            local var117
            if #var94 == 0 then
                module_4_upvr:SetIsValidInput(true)
                local any_GetCommand_result1_4 = arg1.Registry:GetCommand(popped_2)
                var117 = nil
                local var119
                if any_GetCommand_result1_4 then
                    var119 = {}
                    var119[1] = any_GetCommand_result1_4.Name
                    var119[2] = any_GetCommand_result1_4.Name
                    local tbl_4 = {}
                    any_GetAutocomplete_result1_2 = any_GetCommand_result1_4.Name
                    tbl_4.name = any_GetAutocomplete_result1_2
                    any_GetAutocomplete_result1_2 = any_GetCommand_result1_4.Description
                    tbl_4.description = any_GetAutocomplete_result1_2
                    var119.options = tbl_4
                    var117 = var119
                    var119 = any_GetCommand_result1_4.Args
                    if var119 then
                        var119 = any_GetCommand_result1_4.Args[1]
                    end
                    if type(var119) == "function" then
                    end
                    if var119(any_Evaluate_result1) then
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        if not var119(any_Evaluate_result1).Optional and var119(any_Evaluate_result1).Default == nil then
                            any_GetAutocomplete_result1_2 = "This command has required arguments."
                            module_4_upvr:SetIsValidInput(false, any_GetAutocomplete_result1_2)
                            module_4_upvr:HideInvalidState()
                            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                        end
                        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                    end
                else
                    module_4_upvr:SetIsValidInput(false, "%q is not a valid command name. Use the help command to see all available commands.":format(popped_2))
                end
                local module_5 = {var117}
                for _, v_3 in pairs(arg1.Registry:GetCommandNames()) do
                    if popped_2:lower() == v_3:lower():sub(1, #popped_2) and (var117 == nil or var117[1] ~= popped_2) then
                        local any_GetCommand_result1_2 = arg1.Registry:GetCommand(v_3)
                        module_5[#module_5 + 1] = {
                            options = {
                                name = any_GetCommand_result1_2.Name;
                                description = any_GetCommand_result1_2.Description;
                            };
                            popped_2, v_3
                        }
                    end
                end
                return var5_upvr:Show(module_5)
            end
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        module_4_upvr:SetIsValidInput(false, "Use the help command to see all available commands.")
        var5_upvr:Hide()
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    module_4_upvr:UpdateLabel()
    module_4_upvr:UpdateWindowHeight()
    return {
        Window = module_4_upvr;
        AutoComplete = var5_upvr;
    }
end