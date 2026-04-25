-- Reviewed by Claude
-- variables reassigned
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
	invokeClient = function(p1, p2, p3, ...)
		assert(isServer, "Postie.invokeClient can only be called from the server")
		local currentCoroutine = coroutine.running()
		local responseReceived = false
		local guid = HttpService:GenerateGUID(false)
		responseHandlers[guid] = function(p1, p22, ...)
			if p1 == p2 then
				responseReceived = true
				responseHandlers[guid] = nil
				if p22 then
					task.spawn(currentCoroutine, true, ...)
				else
					task.spawn(currentCoroutine, false)
				end
			end
		end
		task.delay(p3, function()
			if not responseReceived then
				responseHandlers[guid] = nil
				task.spawn(currentCoroutine, false)
			end
		end)
		PostieSent:FireClient(p2, p1, guid, ...)
		return coroutine.yield()
	end,
	invokeServer = function(p1, p2, ...)
		assert(not isServer, "Postie.invokeServer can only be called from the client")
		local currentCoroutine = coroutine.running()
		local responseReceived = false
		local guid = HttpService:GenerateGUID(false)
		responseHandlers[guid] = function(p1, ...)
			responseReceived = true
			responseHandlers[guid] = nil
			if p1 then
				task.spawn(currentCoroutine, true, ...)
			else
				task.spawn(currentCoroutine, false)
			end
		end
		task.delay(p2, function()
			if not responseReceived then
				responseHandlers[guid] = nil
				task.spawn(currentCoroutine, false)
			end
		end)
		PostieSent:FireServer(p1, guid, ...)
		return coroutine.yield()
	end,
	setCallback = function(p1, p2)
		callbacks[p1] = p2
	end,
	getCallback = function(p1)
		return callbacks[p1]
	end
}
if isServer then
	PostieReceived.OnServerEvent:Connect(function(p1, p2, p3, ...)
		local responseHandler = responseHandlers[p2]
		if responseHandler then
			responseHandler(p1, p3, ...)
		end
	end)
	PostieSent.OnServerEvent:Connect(function(p1, p2, p3, ...)
		local callback = callbacks[p2]
		if callback then
			PostieReceived:FireClient(p1, p3, true, callback(p1, ...))
		else
			PostieReceived:FireClient(p1, p3, false)
		end
	end)
else
	PostieReceived.OnClientEvent:Connect(function(p1, p2, ...)
		local responseHandler = responseHandlers[p1]
		if responseHandler then
			responseHandler(p2, ...)
		end
	end)
	PostieSent.OnClientEvent:Connect(function(p1, p2, ...)
		local callback = callbacks[p1]
		if callback then
			PostieReceived:FireServer(p2, true, callback(...))
		else
			PostieReceived:FireServer(p2, false)
		end
	end)
end
return module
