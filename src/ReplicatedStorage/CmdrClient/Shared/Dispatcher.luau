-- Reviewed by Claude
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Util = require(script.Parent.Util)
local Command = require(script.Parent.Command)
local v1 = false
local t = {
	Cmdr = nil,
	Registry = nil,
	Evaluate = function(p1, p2, p3, p4, p5)
		if RunService:IsClient() == true and p3 ~= Players.LocalPlayer then
			error("[Cmdr] Can\'t evaluate a command that isn\'t sent by the local player.")
		end
		local v1 = Util.SplitString(p2)
		local v2 = table.remove(v1, 1)
		local v3 = p1.Registry:GetCommand(v2)
		if v3 then
			local v5 = Command.new({
				Dispatcher = p1,
				Text = p2,
				CommandObject = v3,
				Alias = v2,
				Executor = p3,
				Arguments = Util.MashExcessArguments(v1, #v3.Args),
				Data = p5
			})
			local v6, v7 = v5:Parse(p4)
			if v6 then
				return v5
			else
				return false, v7
			end
		else
			return false, ("%q is not a valid command name. Use the help command to see all available commands."):format((tostring(v2)))
		end
	end,
	EvaluateAndRun = function(p1, p2, p3, p4)
		local v2 = p4 or {}
		if RunService:IsClient() and v2.IsHuman then
			p1:PushHistory(p2)
		end
		local v4, v5 = p1:Evaluate(p2, p3 or Players.LocalPlayer, nil, v2.Data)
		if v4 then
			local v6, v7 = xpcall(function()
				local v1, v2 = v4:Validate(true)
				if v1 then
					return v4:Run() or "Command executed."
				else
					return v2
				end
			end, function(p1)
				return debug.traceback((tostring(p1)))
			end)
			if not v6 then
				warn(("[Cmdr] Error occurred while evaluating command string %%q\n%*"):format((tostring(v7))):format(p2))
			end
			return if v6 and v7 then v7 else "An error occurred while running this command. Check the console for more information."
		else
			return v5
		end
	end,
	Send = function(p1, p2, p3)
		if RunService:IsClient() == false then
			error("[Cmdr] Dispatcher:Send can only be called from the client.")
		end
		return p1.Cmdr.RemoteFunction:InvokeServer(p2, {
			Data = p3
		})
	end,
	Run = function(p1, ...)
		if not Players.LocalPlayer then
			error("[Cmdr] Dispatcher:Run can only be called from the client.")
		end
		local t = { ... }
		local v1 = t[1]
		for i = 2, #t do
			v1 = v1 .. " " .. tostring(t[i])
		end
		local v3, v4 = p1:Evaluate(v1, Players.LocalPlayer)
		if not v3 then
			error(v4)
		end
		local v5, v6 = v3:Validate(true)
		if not v5 then
			error(v6)
		end
		return v3:Run()
	end,
	RunGuards = function(p1, p2, ...)
		local Guards = p2.Object.Guards
		if Guards ~= nil then
			local v1 = typeof(Guards)
			assert(v1 == "table", (("expected a table for Command.Guards, got %*"):format(v1)))
			for k, v in pairs(Guards) do
				local v4
				local v5 = typeof(v)
				v4 = v5 == "function"
				assert(v4, (("expected a function for a value in Command.Guards, got %*"):format(v5)))
				local v7 = v(p2, ...)
				if v7 ~= nil then
					return tostring(v7)
				end
			end
		end
	end,
	RunHooks = function(p1, p2, p3, ...)
		if not p1.Registry.Hooks[p2] then
			error(("[Cmdr] Invalid hook name: %q"):format(p2), 2)
		end
		if p2 == "BeforeRun" and (#p1.Registry.Hooks[p2] == 0 and (p3.Group ~= "DefaultUtil" and (p3.Group ~= "UserAlias" and p3:HasImplementation()))) then
			if RunService:IsStudio() then
				if v1 == false then
					p3:Reply(if RunService:IsServer() then "<Server>" else "<Client>" .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html", Color3.fromRGB(255, 228, 26))
					v1 = true
				end
			else
				return "Command blocked for security as no BeforeRun hook is configured."
			end
		end
		for i, v in ipairs(p1.Registry.Hooks[p2]) do
			local v2 = v.callback(p3, ...)
			if v2 ~= nil then
				return tostring(v2)
			end
		end
	end,
	PushHistory = function(p1, p2)
		assert(RunService:IsClient(), "[Cmdr] PushHistory may only be used from the client.")
		local v2 = p1:GetHistory()
		if Util.TrimString(p2) ~= "" and p2 ~= v2[#v2] then
			v2[#v2 + 1] = p2
			TeleportService:SetTeleportSetting("CmdrCommandHistory", v2)
		end
	end,
	GetHistory = function(p1)
		assert(RunService:IsClient(), "[Cmdr] GetHistory may only be used from the client.")
		return TeleportService:GetTeleportSetting("CmdrCommandHistory") or {}
	end
}
return function(p1)
	t.Cmdr = p1
	t.Registry = p1.Registry
	return t
end
