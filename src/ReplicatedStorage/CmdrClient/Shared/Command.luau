local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Argument = require(script.Parent.Argument)
local isServer = RunService:IsServer()
local Command = {}
Command.__index = Command
function Command.new(command)
	local commandInstance = {
		Dispatcher = command.Dispatcher,
		Cmdr = command.Dispatcher.Cmdr,
		Name = command.CommandObject.Name,
		RawText = command.Text,
		Object = command.CommandObject,
		Group = command.CommandObject.Group,
		State = {},
		Aliases = command.CommandObject.Aliases,
		Alias = command.Alias,
		Description = command.CommandObject.Description,
		Executor = command.Executor,
		ArgumentDefinitions = command.CommandObject.Args,
		RawArguments = command.Arguments,
		Arguments = {},
		Data = command.Data,
		Response = nil,
		Guards = command.Guards
	}
	setmetatable(commandInstance, Command)
	return commandInstance
end
function Command.Parse(command, skipValidation)
	local hasRequiredArgument = false
	for i, v in ipairs(command.ArgumentDefinitions) do
		local isRequired
		if type(v) == "function" then
			local parsedArgument = v(command)
			if parsedArgument == nil then
				return true
			end
			v = parsedArgument
		end
		isRequired = if v.Default == nil then v.Optional ~= true else false
		if isRequired and hasRequiredArgument then
			error(("[Cmdr] Command %q: Required arguments cannot occur after optional arguments."):format(command.Name))
		elseif not isRequired then
			hasRequiredArgument = true
		end
		if command.RawArguments[i] == nil and (isRequired and skipValidation ~= true) then
			return false, ("Required argument #%d %s is missing."):format(i, v.Name)
		end
		if command.RawArguments[i] or skipValidation then
			command.Arguments[i] = Argument.new(command, v, command.RawArguments[i] or "")
		end
	end
	return true
end
function Command.Validate(command, validatorOptions)
	command._Validated = true
	local validationMessage = ""
	local isValid = true
	for k, v in pairs(command.Arguments) do
		local validationResult, errorMessage = v:Validate(validatorOptions)
		if not validationResult then
			validationMessage, isValid = ("%s; #%d %s: %s"):format(validationMessage, k, v.Name, errorMessage or "error"), false
		end
	end
	return isValid, validationMessage:sub(3)
end
function Command.GetLastArgument(command)
	for i = #command.Arguments, 1, -1 do
		if command.Arguments[i].RawValue then
			return command.Arguments[i]
		end
	end
end
function Command.GatherArgumentValues(command)
	local argumentValues = {}
	for i = 1, #command.ArgumentDefinitions do
		local currentArgument = command.Arguments[i]
		if currentArgument then
			argumentValues[i] = currentArgument:GetValue()
		else
			if type(command.ArgumentDefinitions[i]) == "table" then
				argumentValues[i] = command.ArgumentDefinitions[i].Default
			end
		end
	end
	return argumentValues, #command.ArgumentDefinitions
end
function Command.Run(command)
	if command._Validated == nil then
		error("[Cmdr] Must validate a command before running.")
	end
	local beforeRunHookResult = command.Dispatcher:RunHooks("BeforeRun", command)
	if beforeRunHookResult then
		return beforeRunHookResult
	else
		local guardResult = command.Dispatcher:RunGuards(command)
		if guardResult then
			return guardResult
		else
			if not isServer and (command.Object.Data and command.Data == nil) then
				local argumentValues, argumentCount = command:GatherArgumentValues()
				command.Data = command.Object.Data(command, unpack(argumentValues, 1, argumentCount))
			end
			if not isServer and command.Object.ClientRun then
				local argumentValues, argumentCount = command:GatherArgumentValues()
				command.Response = command.Object.ClientRun(command, unpack(argumentValues, 1, argumentCount))
			end
			if command.Response == nil then
				if command.Object.Run then
					local argumentValues, argumentCount = command:GatherArgumentValues()
					command.Response = command.Object.Run(command, unpack(argumentValues, 1, argumentCount))
				elseif isServer then
					if command.Object.ClientRun then
						warn((("[Cmdr] %* command fell back to the server because ClientRun returned nil, but there is no server implementation! Either return a string from ClientRun, or create a server implementation for this command."):format(command.Name)))
					else
						warn((("[Cmdr] %* command has no implementation!"):format(command.Name)))
					end
					command.Response = "No implementation."
				else
					command.Response = command.Dispatcher:Send(command.RawText, command.Data)
				end
			end
			local afterRunHookResult = command.Dispatcher:RunHooks("AfterRun", command)
			if afterRunHookResult then
				return afterRunHookResult
			else
				return command.Response
			end
		end
	end
end
function Command.GetArgument(command, argumentIndex)
	return command.Arguments[argumentIndex]
end
function Command.GetData(command)
	if not command.Data and (command.Object.Data and not isServer) then
		command.Data = command.Object.Data(command)
	end
	return command.Data
end
function Command.SendEvent(command, targetPlayer, eventName, ...)
	assert(if typeof(targetPlayer) == "Instance" then targetPlayer:IsA("Player") else false, "[Cmdr] Argument #1 must be a Player")
	assert(type(eventName) == "string", "[Cmdr] Argument #2 must be a string")
	if isServer then
		command.Dispatcher.Cmdr.RemoteEvent:FireClient(targetPlayer, eventName, ...)
	elseif command.Dispatcher.Cmdr.Events[eventName] then
		assert(targetPlayer == Players.LocalPlayer, "[Cmdr] Event messages can only be sent to the local player on the client.")
		command.Dispatcher.Cmdr.Events[eventName](...)
	end
end
function Command.BroadcastEvent(command, ...)
	if not isServer then
		error("[Cmdr] Can\'t broadcast event messages from the client.", 2)
	end
	command.Dispatcher.Cmdr.RemoteEvent:FireAllClients(...)
end
function Command.Reply(command, ...)
	return command:SendEvent(command.Executor, "AddLine", ...)
end
function Command.GetStore(command, ...)
	return command.Dispatcher.Cmdr.Registry:GetStore(...)
end
function Command.HasImplementation(command)
	if RunService:IsClient() and command.Object.ClientRun or command.Object.Run then
		return true
	else
		return false
	end
end
return Command
