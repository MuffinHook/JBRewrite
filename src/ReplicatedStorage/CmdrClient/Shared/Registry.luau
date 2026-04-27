local RunService = game:GetService("RunService")
local Util = require(script.Parent.Util)
local Registry = {
	TypeMethods = Util.MakeDictionary({
		"Transform",
		"Validate",
		"Autocomplete",
		"Parse",
		"DisplayName",
		"Listable",
		"ValidateOnce",
		"Prefixes",
		"Default",
		"ArgumentOperatorAliases"
	}),
	CommandMethods = Util.MakeDictionary({
		"Name",
		"Aliases",
		"AutoExec",
		"Description",
		"Args",
		"Run",
		"ClientRun",
		"Data",
		"Group",
		"Guards"
	}),
	CommandArgProps = Util.MakeDictionary({ "Name", "Type", "Description", "Optional", "Default" }),
	Types = {},
	TypeAliases = {},
	Commands = {},
	CommandsArray = {},
	Cmdr = nil,
	Hooks = {
		BeforeRun = {},
		AfterRun = {}
	}
}
Registry.Stores = setmetatable({}, {
	__index = function(self, key)
		self[key] = {}
		return self[key]
	end
})
Registry.AutoExecBuffer = {}
function Registry.RegisterType(self, typeName, typeMethods)
	if not typeName or typeof(typeName) ~= "string" then
		error("[Cmdr] Invalid type name provided: nil")
	end
	if not typeName:find("^[%d%l]%w*$") then
		error((("[Cmdr] Invalid type name provided: \"%*\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(typeName)))
	end
	for k in pairs(typeMethods) do
		if self.TypeMethods[k] == nil then
			error((("[Cmdr] Unknown key/method in type \"%*\": %*"):format(typeName, k)))
		end
	end
	if self.Types[typeName] ~= nil then
		error((("[Cmdr] Type %* has already been registered."):format(typeName)))
	end
	typeMethods.Name = typeName
	typeMethods.DisplayName = typeMethods.DisplayName or typeName
	self.Types[typeName] = typeMethods
	if typeMethods.Prefixes then
		self:RegisterTypePrefix(typeName, typeMethods.Prefixes)
	end
end
function Registry.RegisterTypePrefix(self, typeName, prefixes)
	if not self.TypeAliases[typeName] then
		self.TypeAliases[typeName] = typeName
	end
	self.TypeAliases[typeName] = ("%s %s"):format(self.TypeAliases[typeName], prefixes)
end
function Registry.RegisterTypeAlias(self, aliasName, alias)
	assert(self.TypeAliases[aliasName] == nil, (("[Cmdr] Type alias %* already exists!"):format(alias)))
	self.TypeAliases[aliasName] = alias
end
function Registry.RegisterTypesIn(self, folder)
	for k, v in pairs(folder:GetChildren()) do
		if v:IsA("ModuleScript") then
			v.Parent = self.Cmdr.ReplicatedRoot.Types
			require(v)(self)
		else
			self:RegisterTypesIn(v)
		end
	end
end
Registry.RegisterHooksIn = Registry.RegisterTypesIn
function Registry.RegisterCommandObject(self, command)
	for k in pairs(command) do
		if self.CommandMethods[k] == nil then
			error((("[Cmdr] Unknown key/method in command \"%*\": %*"):format(command.Name or "unknown command", k)))
		end
	end
	if command.Args then
		for k, v in pairs(command.Args) do
			if type(v) == "table" then
				for k2 in pairs(v) do
					if self.CommandArgProps[k2] == nil then
						error((("[Cmdr] Unknown property in command \"%*\" argument #%*: %*"):format(command.Name or "unknown", k, k2)))
					end
				end
			end
		end
	end
	if command.AutoExec and RunService:IsClient() then
		table.insert(self.AutoExecBuffer, command.AutoExec)
		self:FlushAutoExecBufferDeferred()
	end
	local existingCommand = self.Commands[command.Name:lower()]
	if existingCommand and existingCommand.Aliases then
		for k, v in pairs(existingCommand.Aliases) do
			self.Commands[v:lower()] = nil
		end
	elseif not existingCommand then
		table.insert(self.CommandsArray, command)
	end
	self.Commands[command.Name:lower()] = command
	if command.Aliases then
		for k, v in pairs(command.Aliases) do
			self.Commands[v:lower()] = command
		end
	end
end
function Registry.RegisterCommand(self, commandModule, serverScript, validator)
	local commandDef = require(commandModule)
	assert(typeof(commandDef) == "table", (("[Cmdr] Invalid return value from command script \"%*\" (CommandDefinition expected, got %*)"):format(commandModule.Name, (typeof(commandDef)))))
	if serverScript then
		assert(RunService:IsServer(), "[Cmdr] The commandServerScript parameter is not valid for client usage.")
		commandDef.Run = require(serverScript)
	end
	if not validator or validator(commandDef) then
		self:RegisterCommandObject(commandDef)
		commandModule.Parent = self.Cmdr.ReplicatedRoot.Commands
	end
end
function Registry.RegisterCommandsIn(self, folder, groupFilter)
	local serverScripts = {}
	local sharedCommands = {}
	for k, v in pairs(folder:GetChildren()) do
		if v:IsA("ModuleScript") then
			if v.Name:find("Server") then
				serverScripts[v] = true
			else
				local serverScript = folder:FindFirstChild(v.Name .. "Server")
				if serverScript then
					sharedCommands[serverScript] = true
				end
				self:RegisterCommand(v, serverScript, groupFilter)
			end
		else
			self:RegisterCommandsIn(v, groupFilter)
		end
	end
	for k in pairs(serverScripts) do
		if not sharedCommands[k] then
			warn((("[Cmdr] Command script %* was skipped because it has \'Server\' in its name, and has no equivalent shared script."):format(k.Name)))
		end
	end
end
function Registry.RegisterDefaultCommands(self, groupNames)
	assert(RunService:IsServer(), "[Cmdr] RegisterDefaultCommands cannot be called from the client.")
	local groupFilter = if type(groupNames) == "table" then Util.MakeDictionary(groupNames) else nil
	self:RegisterCommandsIn(self.Cmdr.DefaultCommandsFolder, if groupFilter == nil then groupNames else function(self)
	return groupFilter[self.Group] or false
end or groupNames)
end
function Registry.GetCommand(self, commandName)
	return self.Commands[(commandName or ""):lower()]
end
function Registry.GetCommands(self)
	return self.CommandsArray
end
function Registry.GetCommandNames(self)
	local commandNames = {}
	for k, v in pairs(self.CommandsArray) do
		table.insert(commandNames, v.Name)
	end
	return commandNames
end
Registry.GetCommandsAsStrings = Registry.GetCommandNames
function Registry.GetTypeNames(self)
	local typeNames = {}
	for k in pairs(self.Types) do
		table.insert(typeNames, k)
	end
	return typeNames
end
function Registry.GetType(self, typeName)
	return self.Types[typeName]
end
function Registry.GetTypeName(self, typeName)
	return self.TypeAliases[typeName] or typeName
end
function Registry.RegisterHook(self, hookName, callback, priority)
	if not self.Hooks[hookName] then
		error(("[Cmdr] Invalid hook name: %q"):format(hookName), 2)
	end
	table.insert(self.Hooks[hookName], {
		callback = callback,
		priority = priority or 0
	})
	table.sort(self.Hooks[hookName], function(hookA, hookB)
		return hookA.priority < hookB.priority
	end)
end
Registry.AddHook = Registry.RegisterHook
function Registry.GetStore(self, storeName)
	return self.Stores[storeName]
end
function Registry.FlushAutoExecBufferDeferred(self)
	if not self.AutoExecFlushConnection then
		self.AutoExecFlushConnection = RunService.Heartbeat:Connect(function()
			self.AutoExecFlushConnection:Disconnect()
			self.AutoExecFlushConnection = nil
			self:FlushAutoExecBuffer()
		end)
	end
end
function Registry.FlushAutoExecBuffer(self)
	for i, v in ipairs(self.AutoExecBuffer) do
		for i2, v2 in ipairs(v) do
			self.Cmdr.Dispatcher:EvaluateAndRun(v2)
		end
	end
	self.AutoExecBuffer = {}
end
return function(self)
	Registry.Cmdr = self
	return Registry
end
