local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Argument = require(script.Parent.Argument)
local v1 = RunService:IsServer()
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 22 | Upvalues: t (copy) ]]
	local t2 = {
		Dispatcher = p1.Dispatcher,
		Cmdr = p1.Dispatcher.Cmdr,
		Name = p1.CommandObject.Name,
		RawText = p1.Text,
		Object = p1.CommandObject,
		Group = p1.CommandObject.Group,
		State = {},
		Aliases = p1.CommandObject.Aliases,
		Alias = p1.Alias,
		Description = p1.CommandObject.Description,
		Executor = p1.Executor,
		ArgumentDefinitions = p1.CommandObject.Args,
		RawArguments = p1.Arguments,
		Arguments = {},
		Data = p1.Data,
		Response = nil,
		Guards = p1.Guards
	}
	setmetatable(t2, t)
	return t2
end
function t.Parse(p1, p2) --[[ Line: 51 | Upvalues: Argument (copy) ]]
	local v1 = false
	for i, v in ipairs(p1.ArgumentDefinitions) do
		local v2
		if type(v) == "function" then
			local v3 = v(p1)
			if v3 == nil then
				return true
			end
			v = v3
		end
		v2 = if v.Default == nil then v.Optional ~= true else false
		if v2 and v1 then
			error(("[Cmdr] Command %q: Required arguments cannot occur after optional arguments."):format(p1.Name))
		elseif not v2 then
			v1 = true
		end
		if p1.RawArguments[i] == nil and (v2 and p2 ~= true) then
			return false, ("Required argument #%d %s is missing."):format(i, v.Name)
		end
		if p1.RawArguments[i] or p2 then
			p1.Arguments[i] = Argument.new(p1, v, p1.RawArguments[i] or "")
		end
	end
	return true
end
function t.Validate(p1, p2) --[[ Line: 83 ]]
	p1._Validated = true
	local v1 = ""
	local v2 = true
	for k, v in pairs(p1.Arguments) do
		local v3, v4 = v:Validate(p2)
		if not v3 then
			v1, v2 = ("%s; #%d %s: %s"):format(v1, k, v.Name, v4 or "error"), false
		end
	end
	return v2, v1:sub(3)
end
function t.GetLastArgument(p1) --[[ Line: 102 ]]
	for i = #p1.Arguments, 1, -1 do
		if p1.Arguments[i].RawValue then
			return p1.Arguments[i]
		end
	end
end
function t.GatherArgumentValues(p1) --[[ Line: 111 ]]
	local t = {}
	for i = 1, #p1.ArgumentDefinitions do
		local v1 = p1.Arguments[i]
		if v1 then
			t[i] = v1:GetValue()
		else
			if type(p1.ArgumentDefinitions[i]) == "table" then
				t[i] = p1.ArgumentDefinitions[i].Default
			end
		end
	end
	return t, #p1.ArgumentDefinitions
end
function t.Run(p1) --[[ Line: 128 | Upvalues: v1 (copy) ]]
	if p1._Validated == nil then
		error("[Cmdr] Must validate a command before running.")
	end
	local v12 = p1.Dispatcher:RunHooks("BeforeRun", p1)
	if v12 then
		return v12
	else
		local v2 = p1.Dispatcher:RunGuards(p1)
		if v2 then
			return v2
		else
			if not v1 and (p1.Object.Data and p1.Data == nil) then
				local v3, v4 = p1:GatherArgumentValues()
				p1.Data = p1.Object.Data(p1, unpack(v3, 1, v4))
			end
			if not v1 and p1.Object.ClientRun then
				local v5, v6 = p1:GatherArgumentValues()
				p1.Response = p1.Object.ClientRun(p1, unpack(v5, 1, v6))
			end
			if p1.Response == nil then
				if p1.Object.Run then
					local v7, v8 = p1:GatherArgumentValues()
					p1.Response = p1.Object.Run(p1, unpack(v7, 1, v8))
				elseif v1 then
					if p1.Object.ClientRun then
						warn((("[Cmdr] %* command fell back to the server because ClientRun returned nil, but there is no server implementation! Either return a string from ClientRun, or create a server implementation for this command."):format(p1.Name)))
					else
						warn((("[Cmdr] %* command has no implementation!"):format(p1.Name)))
					end
					p1.Response = "No implementation."
				else
					p1.Response = p1.Dispatcher:Send(p1.RawText, p1.Data)
				end
			end
			local v9 = p1.Dispatcher:RunHooks("AfterRun", p1)
			if v9 then
				return v9
			else
				return p1.Response
			end
		end
	end
end
function t.GetArgument(p1, p2) --[[ Line: 181 ]]
	return p1.Arguments[p2]
end
function t.GetData(p1) --[[ Line: 189 | Upvalues: v1 (copy) ]]
	if not p1.Data and (p1.Object.Data and not v1) then
		p1.Data = p1.Object.Data(p1)
	end
	return p1.Data
end
function t.SendEvent(p1, p2, p3, ...) --[[ Line: 202 | Upvalues: v1 (copy), Players (copy) ]]
	assert(if typeof(p2) == "Instance" then p2:IsA("Player") else false, "[Cmdr] Argument #1 must be a Player")
	assert(type(p3) == "string", "[Cmdr] Argument #2 must be a string")
	if v1 then
		p1.Dispatcher.Cmdr.RemoteEvent:FireClient(p2, p3, ...)
	elseif p1.Dispatcher.Cmdr.Events[p3] then
		assert(p2 == Players.LocalPlayer, "[Cmdr] Event messages can only be sent to the local player on the client.")
		p1.Dispatcher.Cmdr.Events[p3](...)
	end
end
function t.BroadcastEvent(p1, ...) --[[ Line: 218 | Upvalues: v1 (copy) ]]
	if not v1 then
		error("[Cmdr] Can\'t broadcast event messages from the client.", 2)
	end
	p1.Dispatcher.Cmdr.RemoteEvent:FireAllClients(...)
end
function t.Reply(p1, ...) --[[ Line: 227 ]]
	return p1:SendEvent(p1.Executor, "AddLine", ...)
end
function t.GetStore(p1, ...) --[[ Line: 232 ]]
	return p1.Dispatcher.Cmdr.Registry:GetStore(...)
end
function t.HasImplementation(p1) --[[ Line: 237 | Upvalues: RunService (copy) ]]
	if RunService:IsClient() and p1.Object.ClientRun or p1.Object.Run then
		return true
	else
		return false
	end
end
return t