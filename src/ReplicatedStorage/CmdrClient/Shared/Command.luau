local RunService_upvr = game:GetService("RunService")
local any_IsServer_result1_upvr = RunService_upvr:IsServer()
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1) -- Line 22
    local module = {
        Dispatcher = arg1.Dispatcher;
        Cmdr = arg1.Dispatcher.Cmdr;
        Name = arg1.CommandObject.Name;
        RawText = arg1.Text;
        Object = arg1.CommandObject;
        Group = arg1.CommandObject.Group;
        State = {};
        Aliases = arg1.CommandObject.Aliases;
        Alias = arg1.Alias;
        Description = arg1.CommandObject.Description;
        Executor = arg1.Executor;
        ArgumentDefinitions = arg1.CommandObject.Args;
        RawArguments = arg1.Arguments;
        Arguments = {};
        Data = arg1.Data;
        Response = nil;
        Guards = arg1.Guards;
    }
    setmetatable(module, module_upvr)
    return module
end
local Argument_upvr = require(script.Parent.Argument)
function module_upvr.Parse(arg1, arg2) -- Line 51
    for i, v in ipairs(arg1.ArgumentDefinitions) do
        local var13
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            v = var13
            var13 = v(arg1)
            return v == nil
        end
        if var13 ~= "function" or decompInlinedCondition() then break end
        var13 = false
        if v.Default == nil then
            if v.Optional == true then
                var13 = false
            else
                var13 = true
            end
        end
        if var13 and false then
            error("[Cmdr] Command %q: Required arguments cannot occur after optional arguments.":format(arg1.Name))
        elseif not var13 then
        end
        if arg1.RawArguments[i] == nil and var13 and arg2 ~= true then
            return false, "Required argument #%d %s is missing.":format(i, v.Name)
        end
        if arg1.RawArguments[i] or arg2 then
            arg1.Arguments[i] = Argument_upvr.new(arg1, v, arg1.RawArguments[i] or "")
        end
    end
    return true
end
function module_upvr.Validate(arg1, arg2) -- Line 83
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    arg1._Validated = true
    local var25
    for i_2, v_2 in pairs(arg1.Arguments) do
        local any_Validate_result1, any_Validate_result2 = v_2:Validate(arg2)
        if not any_Validate_result1 then
        end
    end
    return nil, "%s; #%d %s: %s":format("", i_2, v_2.Name, any_Validate_result2 or "error"):sub(3)
end
function module_upvr.GetLastArgument(arg1) -- Line 102
    for i_3 = #arg1.Arguments, 1, -1 do
        if arg1.Arguments[i_3].RawValue then
            return arg1.Arguments[i_3]
        end
    end
end
function module_upvr.GatherArgumentValues(arg1) -- Line 111
    for i_4 = 1, #arg1.ArgumentDefinitions do
        local var30 = arg1.Arguments[i_4]
        if var30 then
            ({})[i_4] = var30:GetValue()
        elseif type(arg1.ArgumentDefinitions[i_4]) == "table" then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            ;({})[i_4] = arg1.ArgumentDefinitions[i_4].Default
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return {}, #arg1.ArgumentDefinitions
end
function module_upvr.Run(arg1) -- Line 128
    if arg1._Validated == nil then
        error("[Cmdr] Must validate a command before running.")
    end
    local any_RunHooks_result1 = arg1.Dispatcher:RunHooks("BeforeRun", arg1)
    if any_RunHooks_result1 then
        return any_RunHooks_result1
    end
    local any_RunGuards_result1 = arg1.Dispatcher:RunGuards(arg1)
    if any_RunGuards_result1 then
        return any_RunGuards_result1
    end
    if not any_IsServer_result1_upvr and arg1.Object.Data and arg1.Data == nil then
        local any_GatherArgumentValues_result1, any_GatherArgumentValues_result2_3 = arg1:GatherArgumentValues()
        arg1.Data = arg1.Object.Data(arg1, unpack(any_GatherArgumentValues_result1, 1, any_GatherArgumentValues_result2_3))
    end
    if not any_IsServer_result1_upvr and arg1.Object.ClientRun then
        local any_GatherArgumentValues_result1_3, any_GatherArgumentValues_result2_2 = arg1:GatherArgumentValues()
        arg1.Response = arg1.Object.ClientRun(arg1, unpack(any_GatherArgumentValues_result1_3, 1, any_GatherArgumentValues_result2_2))
    end
    if arg1.Response == nil then
        if arg1.Object.Run then
            local any_GatherArgumentValues_result1_2, any_GatherArgumentValues_result2 = arg1:GatherArgumentValues()
            arg1.Response = arg1.Object.Run(arg1, unpack(any_GatherArgumentValues_result1_2, 1, any_GatherArgumentValues_result2))
        elseif any_IsServer_result1_upvr then
            if arg1.Object.ClientRun then
                warn(`[Cmdr] {arg1.Name} command fell back to the server because ClientRun returned nil, but there is no server implementation! Either return a string from ClientRun, or create a server implementation for this command.`)
            else
                warn(`[Cmdr] {arg1.Name} command has no implementation!`)
            end
            arg1.Response = "No implementation."
        else
            arg1.Response = arg1.Dispatcher:Send(arg1.RawText, arg1.Data)
        end
    end
    local any_RunHooks_result1_2 = arg1.Dispatcher:RunHooks("AfterRun", arg1)
    if any_RunHooks_result1_2 then
        return any_RunHooks_result1_2
    end
    return arg1.Response
end
function module_upvr.GetArgument(arg1, arg2) -- Line 181
    return arg1.Arguments[arg2]
end
function module_upvr.GetData(arg1) -- Line 189
    if arg1.Data then
        return arg1.Data
    end
    if arg1.Object.Data and not any_IsServer_result1_upvr then
        arg1.Data = arg1.Object.Data(arg1)
    end
    return arg1.Data
end
local Players_upvr = game:GetService("Players")
function module_upvr.SendEvent(arg1, arg2, arg3, ...) -- Line 202
    local var41 = false
    if typeof(arg2) == "Instance" then
        var41 = arg2:IsA("Player")
    end
    assert(var41, "[Cmdr] Argument #1 must be a Player")
    if type(arg3) ~= "string" then
        var41 = false
    else
        var41 = true
    end
    assert(var41, "[Cmdr] Argument #2 must be a string")
    if any_IsServer_result1_upvr then
        arg1.Dispatcher.Cmdr.RemoteEvent:FireClient(arg2, arg3, ...)
    else
        var41 = arg1.Dispatcher
        var41 = var41.Cmdr
        var41 = var41.Events
        if var41[arg3] then
            if arg2 ~= Players_upvr.LocalPlayer then
                var41 = false
            else
                var41 = true
            end
            assert(var41, "[Cmdr] Event messages can only be sent to the local player on the client.")
            var41 = arg1.Dispatcher
            var41 = var41.Cmdr
            var41 = var41.Events
            var41 = ...
            var41[arg3](var41)
        end
    end
end
function module_upvr.BroadcastEvent(arg1, ...) -- Line 218
    if not any_IsServer_result1_upvr then
        error("[Cmdr] Can't broadcast event messages from the client.", 2)
    end
    arg1.Dispatcher.Cmdr.RemoteEvent:FireAllClients(...)
end
function module_upvr.Reply(arg1, ...) -- Line 227
    return arg1:SendEvent(arg1.Executor, "AddLine", ...)
end
function module_upvr.GetStore(arg1, ...) -- Line 232
    return arg1.Dispatcher.Cmdr.Registry:GetStore(...)
end
function module_upvr.HasImplementation(arg1) -- Line 237
    if RunService_upvr:IsClient() and arg1.Object.ClientRun or arg1.Object.Run then
        return true
    end
    return false
end
return module_upvr