local RunService_upvr = game:GetService("RunService")
local Util_upvr = require(script.Parent.Util)
local module_3_upvr = {
    TypeMethods = Util_upvr.MakeDictionary({"Transform", "Validate", "Autocomplete", "Parse", "DisplayName", "Listable", "ValidateOnce", "Prefixes", "Default", "ArgumentOperatorAliases"});
    CommandMethods = Util_upvr.MakeDictionary({"Name", "Aliases", "AutoExec", "Description", "Args", "Run", "ClientRun", "Data", "Group", "Guards"});
    CommandArgProps = Util_upvr.MakeDictionary({"Name", "Type", "Description", "Optional", "Default"});
    Types = {};
    TypeAliases = {};
    Commands = {};
    CommandsArray = {};
    Cmdr = nil;
    Hooks = {
        BeforeRun = {};
        AfterRun = {};
    };
    Stores = setmetatable({}, {
        __index = function(arg1, arg2) -- Line 170, Named "__index"
            arg1[arg2] = {}
            return arg1[arg2]
        end;
    });
    AutoExecBuffer = {};
}
function module_3_upvr.RegisterType(arg1, arg2, arg3) -- Line 184
    if not arg2 or typeof(arg2) ~= "string" then
        error("[Cmdr] Invalid type name provided: nil")
    end
    if not arg2:find("^[%d%l]%w*$") then
        error(`[Cmdr] Invalid type name provided: "{arg2}", type names must be alphanumeric and start with a lower-case letter or a digit.`)
    end
    for i in pairs(arg3) do
        if arg1.TypeMethods[i] == nil then
            error(`[Cmdr] Unknown key/method in type "{arg2}": {i}`)
        end
    end
    if arg1.Types[arg2] ~= nil then
        error(`[Cmdr] Type {arg2} has already been registered.`)
    end
    arg3.Name = arg2
    arg3.DisplayName = arg3.DisplayName or arg2
    arg1.Types[arg2] = arg3
    if arg3.Prefixes then
        i = arg3.Prefixes
        arg1:RegisterTypePrefix(arg2, i)
    end
end
function module_3_upvr.RegisterTypePrefix(arg1, arg2, arg3) -- Line 224
    if not arg1.TypeAliases[arg2] then
        arg1.TypeAliases[arg2] = arg2
    end
    arg1.TypeAliases[arg2] = string.format("%s %s", arg1.TypeAliases[arg2], arg3)
end
function module_3_upvr.RegisterTypeAlias(arg1, arg2, arg3) -- Line 240
    local var13
    if arg1.TypeAliases[arg2] ~= nil then
        var13 = false
    else
        var13 = true
    end
    assert(var13, `[Cmdr] Type alias {arg3} already exists!`)
    arg1.TypeAliases[arg2] = arg3
end
function module_3_upvr.RegisterTypesIn(arg1, arg2) -- Line 251
    for _, v in pairs(arg2:GetChildren()) do
        if v:IsA("ModuleScript") then
            v.Parent = arg1.Cmdr.ReplicatedRoot.Types
            require(v)(arg1)
        else
            arg1:RegisterTypesIn(v)
        end
    end
end
module_3_upvr.RegisterHooksIn = module_3_upvr.RegisterTypesIn
function module_3_upvr.RegisterCommandObject(arg1, arg2) -- Line 283
    for i_3 in pairs(arg2) do
        if arg1.CommandMethods[i_3] == nil then
            error(`[Cmdr] Unknown key/method in command "{arg2.Name or "unknown command"}": {i_3}`)
        end
    end
    if arg2.Args then
        for i_4, v_2 in pairs(arg2.Args) do
            if type(v_2) == "table" then
                for i_5 in pairs(v_2) do
                    if arg1.CommandArgProps[i_5] == nil then
                        error(`[Cmdr] Unknown property in command "{arg2.Name or "unknown"}" argument #{i_4}: {i_5}`)
                    end
                end
            end
        end
    end
    if arg2.AutoExec and RunService_upvr:IsClient() then
        table.insert(arg1.AutoExecBuffer, arg2.AutoExec)
        arg1:FlushAutoExecBufferDeferred()
    end
    local var36 = arg1.Commands[arg2.Name:lower()]
    if var36 and var36.Aliases then
        local pairs_result1, pairs_result2_5, pairs_result3_7 = pairs(var36.Aliases)
        for _, v_3 in pairs_result1, pairs_result2_5, pairs_result3_7 do
            i_5 = nil
            arg1.Commands[v_3:lower()] = i_5
        end
    elseif not var36 then
        pairs_result3_7 = arg2
        table.insert(arg1.CommandsArray, pairs_result3_7)
    end
    arg1.Commands[arg2.Name:lower()] = arg2
    if arg2.Aliases then
        for _, v_4 in pairs(arg2.Aliases) do
            arg1.Commands[v_4:lower()] = arg2
        end
    end
end
function module_3_upvr.RegisterCommand(arg1, arg2, arg3, arg4) -- Line 336
    local arg2_3 = require(arg2)
    local var46
    if typeof(arg2_3) ~= "table" then
        var46 = false
    else
        var46 = true
    end
    assert(var46, `[Cmdr] Invalid return value from command script "{arg2.Name}" (CommandDefinition expected, got {typeof(arg2_3)})`)
    if arg3 then
        var46 = RunService_upvr:IsServer()
        assert(var46, "[Cmdr] The commandServerScript parameter is not valid for client usage.")
        var46 = arg3
        arg2_3.Run = require(var46)
    end
    if arg4 then
        var46 = arg2_3
        if not arg4(var46) then return end
    end
    arg1:RegisterCommandObject(arg2_3)
    arg2.Parent = arg1.Cmdr.ReplicatedRoot.Commands
end
function module_3_upvr.RegisterCommandsIn(arg1, arg2, arg3) -- Line 371
    for _, v_5 in pairs(arg2:GetChildren()) do
        if v_5:IsA("ModuleScript") then
            if not v_5.Name:find("Server") then
                local SOME = arg2:FindFirstChild(v_5.Name.."Server")
                if SOME then
                    ({})[SOME] = true
                end
                arg1:RegisterCommand(v_5, SOME, arg3)
            else
                ({})[v_5] = true
            end
        else
            arg1:RegisterCommandsIn(v_5, arg3)
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    for i_9 in pairs({}) do
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if not ({})[i_9] then
            warn(`[Cmdr] Command script {i_9.Name} was skipped because it has 'Server' in its name, and has no equivalent shared script.`)
        end
    end
end
function module_3_upvr.RegisterDefaultCommands(arg1, arg2) -- Line 415
    local assert_upvr = assert
    assert_upvr(RunService_upvr:IsServer(), "[Cmdr] RegisterDefaultCommands cannot be called from the client.")
    local var59
    if type(arg2) == "table" then
        assert_upvr = Util_upvr
        assert_upvr = assert_upvr.MakeDictionary(arg2)
    else
        assert_upvr = nil
    end
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        function var59(arg1_2) -- Line 420
            return assert_upvr[arg1_2.Group] or false
        end
        return var59
    end
    if assert_upvr == nil or not decompInlinedCondition() then
        var59 = arg2
    end
    arg1:RegisterCommandsIn(arg1.Cmdr.DefaultCommandsFolder, var59)
end
function module_3_upvr.GetCommand(arg1, arg2) -- Line 430
    return arg1.Commands[arg2 or "":lower()]
end
function module_3_upvr.GetCommands(arg1) -- Line 440
    return arg1.CommandsArray
end
function module_3_upvr.GetCommandNames(arg1) -- Line 448
    local module = {}
    for _, v_6 in pairs(arg1.CommandsArray) do
        table.insert(module, v_6.Name)
    end
    return module
end
module_3_upvr.GetCommandsAsStrings = module_3_upvr.GetCommandNames
function module_3_upvr.GetTypeNames(arg1) -- Line 469
    local module_2 = {}
    for i_11 in pairs(arg1.Types) do
        table.insert(module_2, i_11)
    end
    return module_2
end
function module_3_upvr.GetType(arg1, arg2) -- Line 484
    return arg1.Types[arg2]
end
function module_3_upvr.GetTypeName(arg1, arg2) -- Line 493
    return arg1.TypeAliases[arg2] or arg2
end
function module_3_upvr.RegisterHook(arg1, arg2, arg3, arg4) -- Line 507
    if not arg1.Hooks[arg2] then
        error(string.format("[Cmdr] Invalid hook name: %q", arg2), 2)
    end
    local tbl = {}
    tbl.callback = arg3
    tbl.priority = arg4 or 0
    table.insert(arg1.Hooks[arg2], tbl)
    table.sort(arg1.Hooks[arg2], function(arg1_3, arg2_2) -- Line 513
        local var76
        if arg1_3.priority >= arg2_2.priority then
            var76 = false
        else
            var76 = true
        end
        return var76
    end)
end
module_3_upvr.AddHook = module_3_upvr.RegisterHook
function module_3_upvr.GetStore(arg1, arg2) -- Line 534
    return arg1.Stores[arg2]
end
function module_3_upvr.FlushAutoExecBufferDeferred(arg1) -- Line 543
    if arg1.AutoExecFlushConnection then
    else
        arg1.AutoExecFlushConnection = RunService_upvr.Heartbeat:Connect(function() -- Line 548
            arg1.AutoExecFlushConnection:Disconnect()
            arg1.AutoExecFlushConnection = nil
            arg1:FlushAutoExecBuffer()
        end)
    end
end
function module_3_upvr.FlushAutoExecBuffer(arg1) -- Line 560
    for _, v_7 in ipairs(arg1.AutoExecBuffer) do
        for _, v_8 in ipairs(v_7) do
            arg1.Cmdr.Dispatcher:EvaluateAndRun(v_8)
        end
    end
    arg1.AutoExecBuffer = {}
end
return function(arg1) -- Line 570
    module_3_upvr.Cmdr = arg1
    return module_3_upvr
end