local RunService_upvr = game:GetService("RunService")
local TeleportService_upvr = game:GetService("TeleportService")
local Players_upvr = game:GetService("Players")
local Util_upvr = require(script.Parent.Util)
local module_2_upvr = {
    Cmdr = nil;
    Registry = nil;
}
local Command_upvr = require(script.Parent.Command)
function module_2_upvr.Evaluate(arg1, arg2, arg3, arg4, arg5) -- Line 45
    if RunService_upvr:IsClient() == true and arg3 ~= Players_upvr.LocalPlayer then
        error("[Cmdr] Can't evaluate a command that isn't sent by the local player.")
    end
    local any_SplitString_result1 = Util_upvr.SplitString(arg2)
    local popped = table.remove(any_SplitString_result1, 1)
    local any_GetCommand_result1 = arg1.Registry:GetCommand(popped)
    if any_GetCommand_result1 then
        local tbl = {}
        tbl.Dispatcher = arg1
        tbl.Text = arg2
        tbl.CommandObject = any_GetCommand_result1
        tbl.Alias = popped
        tbl.Executor = arg3
        tbl.Arguments = Util_upvr.MashExcessArguments(any_SplitString_result1, #any_GetCommand_result1.Args)
        tbl.Data = arg5
        local any_new_result1 = Command_upvr.new(tbl)
        local any_Parse_result1, any_Parse_result2 = any_new_result1:Parse(arg4)
        if any_Parse_result1 then
            return any_new_result1
        end
        return false, any_Parse_result2
    end
    return false, "%q is not a valid command name. Use the help command to see all available commands.":format(tostring(popped))
end
function module_2_upvr.EvaluateAndRun(arg1, arg2, arg3, arg4) -- Line 94
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if not arg3 then
    end
    if not arg4 then
    end
    local var20
    if RunService_upvr:IsClient() and ({}).IsHuman then
        arg1:PushHistory(arg2)
    end
    var20 = nil
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local any_Evaluate_result1_upvr, any_Evaluate_result2_2 = arg1:Evaluate(arg2, Players_upvr.LocalPlayer, var20, ({}).Data)
    if not any_Evaluate_result1_upvr then
        return any_Evaluate_result2_2
    end
    function var20(arg1_2) -- Line 123
        return debug.traceback(tostring(arg1_2))
    end
    local xpcall_result1, xpcall_result2 = xpcall(function() -- Line 115
        local any_Validate_result1, any_Validate_result2 = any_Evaluate_result1_upvr:Validate(true)
        if not any_Validate_result1 then
            return any_Validate_result2
        end
        return any_Evaluate_result1_upvr:Run() or "Command executed."
    end, var20)
    if not xpcall_result1 then
        var20 = warn
        var20(`[Cmdr] Error occurred while evaluating command string %q\n{tostring(xpcall_result2)}`:format(arg2))
    end
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var20 = xpcall_result2
        return var20
    end
    if not xpcall_result1 or not decompInlinedCondition() then
        var20 = "An error occurred while running this command. Check the console for more information."
    end
    return var20
end
function module_2_upvr.Send(arg1, arg2, arg3) -- Line 144
    if RunService_upvr:IsClient() == false then
        error("[Cmdr] Dispatcher:Send can only be called from the client.")
    end
    local module = {}
    module.Data = arg3
    return arg1.Cmdr.RemoteFunction:InvokeServer(arg2, module)
end
function module_2_upvr.Run(arg1, ...) -- Line 164
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var28
    if not Players_upvr.LocalPlayer then
        var28 = "[Cmdr] Dispatcher:Run can only be called from the client."
        error(var28)
    end
    local tbl_2 = {}
    var28 = ...
    tbl_2[1] = var28
    var28 = tbl_2[1]
    for i = 2, #tbl_2 do
        var28 = var28..' '..tostring(tbl_2[i])
    end
    local any_Evaluate_result1, any_Evaluate_result2 = arg1:Evaluate(var28, Players_upvr.LocalPlayer)
    if not any_Evaluate_result1 then
        error(any_Evaluate_result2)
    end
    local any_Validate_result1_2, any_Validate_result2_2 = any_Evaluate_result1:Validate(true)
    if not any_Validate_result1_2 then
        error(any_Validate_result2_2)
    end
    return any_Evaluate_result1:Run()
end
function module_2_upvr.RunGuards(arg1, arg2, ...) -- Line 200
    local Guards = arg2.Object.Guards
    local var39
    if Guards == nil then
    else
        local typeof_result1_2 = typeof(Guards)
        if typeof_result1_2 ~= "table" then
            var39 = false
        else
            var39 = true
        end
        assert(var39, `expected a table for Command.Guards, got {typeof_result1_2}`)
        var39 = Guards
        for _, v_2 in pairs(var39) do
            local typeof_result1 = typeof(v_2)
            local var45
            if typeof_result1 ~= "function" then
                var45 = false
            else
                var45 = true
            end
            assert(var45, `expected a function for a value in Command.Guards, got {typeof_result1}`)
            var45 = arg2
            local v_2_result1 = v_2(var45, ...)
            if v_2_result1 ~= nil then
                var45 = tostring(v_2_result1)
                return var45
            end
        end
    end
end
local var47_upvw = false
function module_2_upvr.RunHooks(arg1, arg2, arg3, ...) -- Line 236
    if not arg1.Registry.Hooks[arg2] then
        error("[Cmdr] Invalid hook name: %q":format(arg2), 2)
    end
    if arg2 == "BeforeRun" and #arg1.Registry.Hooks[arg2] == 0 and arg3.Group ~= "DefaultUtil" and arg3.Group ~= "UserAlias" and arg3:HasImplementation() then
        if RunService_upvr:IsStudio() then
            local var52
            if var47_upvw == false then
                if RunService_upvr:IsServer() then
                    var52 = "<Server>"
                else
                    var52 = "<Client>"
                end
                var52 = Color3.fromRGB(255, 228, 26)
                arg3:Reply(var52.." Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html", var52)
                var47_upvw = true
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        else
            return "Command blocked for security as no BeforeRun hook is configured."
        end
    end
    for _, v in ipairs(arg1.Registry.Hooks[arg2]) do
        local any_callback_result1 = v.callback(arg3, ...)
        if any_callback_result1 ~= nil then
            return tostring(any_callback_result1)
        end
    end
end
function module_2_upvr.PushHistory(arg1, arg2) -- Line 278
    assert(RunService_upvr:IsClient(), "[Cmdr] PushHistory may only be used from the client.")
    local any_GetHistory_result1 = arg1:GetHistory()
    if Util_upvr.TrimString(arg2) == "" or arg2 == any_GetHistory_result1[#any_GetHistory_result1] then
    else
        any_GetHistory_result1[#any_GetHistory_result1 + 1] = arg2
        TeleportService_upvr:SetTeleportSetting("CmdrCommandHistory", any_GetHistory_result1)
    end
end
function module_2_upvr.GetHistory(arg1) -- Line 299
    assert(RunService_upvr:IsClient(), "[Cmdr] GetHistory may only be used from the client.")
    local any_GetTeleportSetting_result1 = TeleportService_upvr:GetTeleportSetting("CmdrCommandHistory")
    if not any_GetTeleportSetting_result1 then
        any_GetTeleportSetting_result1 = {}
    end
    return any_GetTeleportSetting_result1
end
return function(arg1) -- Line 305
    module_2_upvr.Cmdr = arg1
    module_2_upvr.Registry = arg1.Registry
    return module_2_upvr
end