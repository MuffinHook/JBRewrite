-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Util = require(script.Parent.Util)
local Command = require(script.Parent.Command)
local hookWarningShown = false
local dispatcher = {
	Cmdr = nil,
	Registry = nil,
	Evaluate = function(self, commandText, executor, options, customData)
		if RunService:IsClient() == true and executor ~= Players.LocalPlayer then
			error("[Cmdr] Can\'t evaluate a command that isn\'t sent by the local player.")
		end
		local splitCommand = Util.SplitString(commandText)
		local commandName = table.remove(splitCommand, 1)
		local commandObject = self.Registry:GetCommand(commandName)
		if commandObject then
			local newCommand = Command.new({
				Dispatcher = self,
				Text = commandText,
				CommandObject = commandObject,
				Alias = commandName,
				Executor = executor,
				Arguments = Util.MashExcessArguments(splitCommand, #commandObject.Args),
				Data = customData
			})
			local isValid, parseError = newCommand:Parse(options)
			if isValid then
				return newCommand
			else
				return false, parseError
			end
		else
			return false, ("%q is not a valid command name. Use the help command to see all available commands."):format((tostring(commandName)))
		end
	end,
	EvaluateAndRun = function(self, commandText, executor, options)
		local optionsTable = options or {}
		if RunService:IsClient() and optionsTable.IsHuman then
			self:PushHistory(commandText)
		end
		local command, evaluateError = self:Evaluate(commandText, executor or Players.LocalPlayer, nil, optionsTable.Data)
		if command then
			local success, result = xpcall(function()
				local isValid, validationError = command:Validate(true)
				if isValid then
					return command:Run() or "Command executed."
				else
					return validationError
				end
			end, function(errorValue)
				return debug.traceback((tostring(errorValue)))
			end)
			if not success then
				warn(("[Cmdr] Error occurred while evaluating command string %%q\n%*"):format((tostring(result))):format(commandText))
			end
			return if success and result then result else "An error occurred while running this command. Check the console for more information."
		else
			return evaluateError
		end
	end,
	Send = function(self, commandText, customData)
		if RunService:IsClient() == false then
			error("[Cmdr] Dispatcher:Send can only be called from the client.")
		end
		return self.Cmdr.RemoteFunction:InvokeServer(commandText, {
			Data = customData
		})
	end,
	Run = function(self, ...)
		if not Players.LocalPlayer then
			error("[Cmdr] Dispatcher:Run can only be called from the client.")
		end
		local argsTable = { ... }
		local commandString = argsTable[1]
		for i = 2, #argsTable do
			commandString = commandString .. " " .. tostring(argsTable[i])
		end
		local command, evaluateError = self:Evaluate(commandString, Players.LocalPlayer)
		if not command then
			error(evaluateError)
		end
		local isValid, validationError = command:Validate(true)
		if not isValid then
			error(validationError)
		end
		return command:Run()
	end,
	RunGuards = function(self, commandInfo, ...)
		local Guards = commandInfo.Object.Guards
		if Guards ~= nil then
			local guardType = typeof(Guards)
			assert(guardType == "table", (("expected a table for Command.Guards, got %*"):format(guardType)))
			for k, v in pairs(Guards) do
				local isFunction
				local valueType = typeof(v)
				isFunction = valueType == "function"
				assert(isFunction, (("expected a function for a value in Command.Guards, got %*"):format(valueType)))
				local guardResult = v(commandInfo, ...)
				if guardResult ~= nil then
					return tostring(guardResult)
				end
			end
		end
	end,
	RunHooks = function(self, hookName, commandObject, ...)
		if not self.Registry.Hooks[hookName] then
			error(("[Cmdr] Invalid hook name: %q"):format(hookName), 2)
		end
		if hookName == "BeforeRun" and (#self.Registry.Hooks[hookName] == 0 and (commandObject.Group ~= "DefaultUtil" and (commandObject.Group ~= "UserAlias" and commandObject:HasImplementation()))) then
			if RunService:IsStudio() then
				if hookWarningShown == false then
					commandObject:Reply(if RunService:IsServer() then "<Server>" else "<Client>" .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html", Color3.fromRGB(255, 228, 26))
					hookWarningShown = true
				end
			else
				return "Command blocked for security as no BeforeRun hook is configured."
			end
		end
		for i, v in ipairs(self.Registry.Hooks[hookName]) do
			local hookResult = v.callback(commandObject, ...)
			if hookResult ~= nil then
				return tostring(hookResult)
			end
		end
	end,
	PushHistory = function(self, commandText)
		assert(RunService:IsClient(), "[Cmdr] PushHistory may only be used from the client.")
		local history = self:GetHistory()
		if Util.TrimString(commandText) ~= "" and commandText ~= history[#history] then
			history[#history + 1] = commandText
			TeleportService:SetTeleportSetting("CmdrCommandHistory", history)
		end
	end,
	GetHistory = function(self)
		assert(RunService:IsClient(), "[Cmdr] GetHistory may only be used from the client.")
		return TeleportService:GetTeleportSetting("CmdrCommandHistory") or {}
	end
}
return function(cmdrInstance)
	dispatcher.Cmdr = cmdrInstance
	dispatcher.Registry = cmdrInstance.Registry
	return dispatcher
end
