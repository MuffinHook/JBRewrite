local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
if not ReplicatedStorage:FindFirstChild("PostieSent") then
	local PostieSent = Instance.new("RemoteEvent")
	PostieSent.Name = "PostieSent"
	PostieSent.Parent = ReplicatedStorage
end
if not ReplicatedStorage:FindFirstChild("PostieReceived") then
	local PostieReceived = Instance.new("RemoteEvent")
	PostieReceived.Name = "PostieReceived"
	PostieReceived.Parent = ReplicatedStorage
end
local PostieSent = ReplicatedStorage.PostieSent
local PostieReceived = ReplicatedStorage.PostieReceived
local isServer = RunService:IsServer()
local callbacks = {}
local responseHandlers = {}
local module = {
	invokeClient = function(callbackName, player, timeout, ...)
		assert(isServer, "Postie.invokeClient can only be called from the server")
		local currentCoroutine = coroutine.running()
		local responseReceived = false
		local guid = HttpService:GenerateGUID(false)
		responseHandlers[guid] = function(incomingGuid, success, ...)
			if incomingGuid == player then
				responseReceived = true
				responseHandlers[guid] = nil
				if success then
					task.spawn(currentCoroutine, true, ...)
				else
					task.spawn(currentCoroutine, false)
				end
			end
		end
		task.delay(timeout, function()
			if not responseReceived then
				responseHandlers[guid] = nil
				task.spawn(currentCoroutine, false)
			end
		end)
		PostieSent:FireClient(player, callbackName, guid, ...)
		return coroutine.yield()
	end,
	invokeServer = function(callbackName, timeout, ...)
		assert(not isServer, "Postie.invokeServer can only be called from the client")
		local currentCoroutine = coroutine.running()
		local responseReceived = false
		local guid = HttpService:GenerateGUID(false)
		responseHandlers[guid] = function(success, ...)
			responseReceived = true
			responseHandlers[guid] = nil
			if success then
				task.spawn(currentCoroutine, true, ...)
			else
				task.spawn(currentCoroutine, false)
			end
		end
		task.delay(timeout, function()
			if not responseReceived then
				responseHandlers[guid] = nil
				task.spawn(currentCoroutine, false)
			end
		end)
		PostieSent:FireServer(callbackName, guid, ...)
		return coroutine.yield()
	end,
	setCallback = function(callbackName, callbackFunction)
		callbacks[callbackName] = callbackFunction
	end,
	getCallback = function(callbackName)
		return callbacks[callbackName]
	end
}
if isServer then
	PostieReceived.OnServerEvent:Connect(function(player, guid, success, ...)
		local responseHandler = responseHandlers[guid]
		if responseHandler then
			responseHandler(player, success, ...)
		end
	end)
	PostieSent.OnServerEvent:Connect(function(player, callbackName, guid, ...)
		local callback = callbacks[callbackName]
		if callback then
			PostieReceived:FireClient(player, guid, true, callback(player, ...))
		else
			PostieReceived:FireClient(player, guid, false)
		end
	end)
else
	PostieReceived.OnClientEvent:Connect(function(guid, success, ...)
		local responseHandler = responseHandlers[guid]
		if responseHandler then
			responseHandler(success, ...)
		end
	end)
	PostieSent.OnClientEvent:Connect(function(callbackName, guid, ...)
		local callback = callbacks[callbackName]
		if callback then
			PostieReceived:FireServer(guid, true, callback(...))
		else
			PostieReceived:FireServer(guid, false)
		end
	end)
end
return module
