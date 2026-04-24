-- Reviewed by Claude
local RunService = game:GetService("RunService")
local Util = require(script.Parent.Util)
local t = {
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
t.Stores = setmetatable({}, {
	__index = function(p1, p2)
		p1[p2] = {}
		return p1[p2]
	end
})
t.AutoExecBuffer = {}
function t.RegisterType(p1, p2, p3)
	if not p2 or typeof(p2) ~= "string" then
		error("[Cmdr] Invalid type name provided: nil")
	end
	if not p2:find("^[%d%l]%w*$") then
		error((("[Cmdr] Invalid type name provided: \"%*\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(p2)))
	end
	for k in pairs(p3) do
		if p1.TypeMethods[k] == nil then
			error((("[Cmdr] Unknown key/method in type \"%*\": %*"):format(p2, k)))
		end
	end
	if p1.Types[p2] ~= nil then
		error((("[Cmdr] Type %* has already been registered."):format(p2)))
	end
	p3.Name = p2
	p3.DisplayName = p3.DisplayName or p2
	p1.Types[p2] = p3
	if p3.Prefixes then
		p1:RegisterTypePrefix(p2, p3.Prefixes)
	end
end
function t.RegisterTypePrefix(p1, p2, p3)
	if not p1.TypeAliases[p2] then
		p1.TypeAliases[p2] = p2
	end
	p1.TypeAliases[p2] = ("%s %s"):format(p1.TypeAliases[p2], p3)
end
function t.RegisterTypeAlias(p1, p2, p3)
	assert(p1.TypeAliases[p2] == nil, (("[Cmdr] Type alias %* already exists!"):format(p3)))
	p1.TypeAliases[p2] = p3
end
function t.RegisterTypesIn(p1, p2)
	for k, v in pairs(p2:GetChildren()) do
		if v:IsA("ModuleScript") then
			v.Parent = p1.Cmdr.ReplicatedRoot.Types
			require(v)(p1)
		else
			p1:RegisterTypesIn(v)
		end
	end
end
t.RegisterHooksIn = t.RegisterTypesIn
function t.RegisterCommandObject(p1, p2)
	for k in pairs(p2) do
		if p1.CommandMethods[k] == nil then
			error((("[Cmdr] Unknown key/method in command \"%*\": %*"):format(p2.Name or "unknown command", k)))
		end
	end
	if p2.Args then
		for k, v in pairs(p2.Args) do
			if type(v) == "table" then
				for k2 in pairs(v) do
					if p1.CommandArgProps[k2] == nil then
						error((("[Cmdr] Unknown property in command \"%*\" argument #%*: %*"):format(p2.Name or "unknown", k, k2)))
					end
				end
			end
		end
	end
	if p2.AutoExec and RunService:IsClient() then
		table.insert(p1.AutoExecBuffer, p2.AutoExec)
		p1:FlushAutoExecBufferDeferred()
	end
	local v1 = p1.Commands[p2.Name:lower()]
	if v1 and v1.Aliases then
		for k, v in pairs(v1.Aliases) do
			p1.Commands[v:lower()] = nil
		end
	elseif not v1 then
		table.insert(p1.CommandsArray, p2)
	end
	p1.Commands[p2.Name:lower()] = p2
	if p2.Aliases then
		for k, v in pairs(p2.Aliases) do
			p1.Commands[v:lower()] = p2
		end
	end
end
function t.RegisterCommand(p1, p2, p3, p4)
	local v1 = require(p2)
	assert(typeof(v1) == "table", (("[Cmdr] Invalid return value from command script \"%*\" (CommandDefinition expected, got %*)"):format(p2.Name, (typeof(v1)))))
	if p3 then
		assert(RunService:IsServer(), "[Cmdr] The commandServerScript parameter is not valid for client usage.")
		v1.Run = require(p3)
	end
	if not p4 or p4(v1) then
		p1:RegisterCommandObject(v1)
		p2.Parent = p1.Cmdr.ReplicatedRoot.Commands
	end
end
function t.RegisterCommandsIn(p1, p2, p3)
	local tbl = {}
	local t = {}
	for k, v in pairs(p2:GetChildren()) do
		if v:IsA("ModuleScript") then
			if v.Name:find("Server") then
				tbl[v] = true
			else
				local v1 = p2:FindFirstChild(v.Name .. "Server")
				if v1 then
					t[v1] = true
				end
				p1:RegisterCommand(v, v1, p3)
			end
		else
			p1:RegisterCommandsIn(v, p3)
		end
	end
	for k in pairs(tbl) do
		if not t[k] then
			warn((("[Cmdr] Command script %* was skipped because it has \'Server\' in its name, and has no equivalent shared script."):format(k.Name)))
		end
	end
end
function t.RegisterDefaultCommands(p1, p2)
	assert(RunService:IsServer(), "[Cmdr] RegisterDefaultCommands cannot be called from the client.")
	local v2 = if type(p2) == "table" then Util.MakeDictionary(p2) else nil
	p1:RegisterCommandsIn(p1.Cmdr.DefaultCommandsFolder, if v2 == nil then p2 else function(p1)
	return v2[p1.Group] or false
end or p2)
end
function t.GetCommand(p1, p2)
	return p1.Commands[(p2 or ""):lower()]
end
function t.GetCommands(p1)
	return p1.CommandsArray
end
function t.GetCommandNames(p1)
	local t = {}
	for k, v in pairs(p1.CommandsArray) do
		table.insert(t, v.Name)
	end
	return t
end
t.GetCommandsAsStrings = t.GetCommandNames
function t.GetTypeNames(p1)
	local t = {}
	for k in pairs(p1.Types) do
		table.insert(t, k)
	end
	return t
end
function t.GetType(p1, p2)
	return p1.Types[p2]
end
function t.GetTypeName(p1, p2)
	return p1.TypeAliases[p2] or p2
end
function t.RegisterHook(p1, p2, p3, p4)
	if not p1.Hooks[p2] then
		error(("[Cmdr] Invalid hook name: %q"):format(p2), 2)
	end
	table.insert(p1.Hooks[p2], {
		callback = p3,
		priority = p4 or 0
	})
	table.sort(p1.Hooks[p2], function(p1, p2)
		return p1.priority < p2.priority
	end)
end
t.AddHook = t.RegisterHook
function t.GetStore(p1, p2)
	return p1.Stores[p2]
end
function t.FlushAutoExecBufferDeferred(p1)
	if not p1.AutoExecFlushConnection then
		p1.AutoExecFlushConnection = RunService.Heartbeat:Connect(function()
			p1.AutoExecFlushConnection:Disconnect()
			p1.AutoExecFlushConnection = nil
			p1:FlushAutoExecBuffer()
		end)
	end
end
function t.FlushAutoExecBuffer(p1)
	for i, v in ipairs(p1.AutoExecBuffer) do
		for i2, v2 in ipairs(v) do
			p1.Cmdr.Dispatcher:EvaluateAndRun(v2)
		end
	end
	p1.AutoExecBuffer = {}
end
return function(p1)
	t.Cmdr = p1
	return t
end
