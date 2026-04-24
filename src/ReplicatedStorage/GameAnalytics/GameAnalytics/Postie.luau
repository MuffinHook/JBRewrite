-- Reviewed by Claude
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
local v1 = RunService:IsServer()
local t = {}
local t2 = {}
local t3 = {
	invokeClient = function(p1, p2, p3, ...)
		assert(v1, "Postie.invokeClient can only be called from the server")
		local v2 = coroutine.running()
		local v3 = false
		local v4 = HttpService:GenerateGUID(false)
		t2[v4] = function(p1, p22, ...)
			if p1 == p2 then
				v3 = true
				t2[v4] = nil
				if p22 then
					task.spawn(v2, true, ...)
				else
					task.spawn(v2, false)
				end
			end
		end
		task.delay(p3, function()
			if not v3 then
				t2[v4] = nil
				task.spawn(v2, false)
			end
		end)
		PostieSent:FireClient(p2, p1, v4, ...)
		return coroutine.yield()
	end,
	invokeServer = function(p1, p2, ...)
		assert(not v1, "Postie.invokeServer can only be called from the client")
		local v2 = coroutine.running()
		local v3 = false
		local v4 = HttpService:GenerateGUID(false)
		t2[v4] = function(p1, ...)
			v3 = true
			t2[v4] = nil
			if p1 then
				task.spawn(v2, true, ...)
			else
				task.spawn(v2, false)
			end
		end
		task.delay(p2, function()
			if not v3 then
				t2[v4] = nil
				task.spawn(v2, false)
			end
		end)
		PostieSent:FireServer(p1, v4, ...)
		return coroutine.yield()
	end,
	setCallback = function(p1, p2)
		t[p1] = p2
	end,
	getCallback = function(p1)
		return t[p1]
	end
}
if v1 then
	PostieReceived.OnServerEvent:Connect(function(p1, p2, p3, ...)
		local v1 = t2[p2]
		if v1 then
			v1(p1, p3, ...)
		end
	end)
	PostieSent.OnServerEvent:Connect(function(p1, p2, p3, ...)
		local v1 = t[p2]
		if v1 then
			PostieReceived:FireClient(p1, p3, true, v1(p1, ...))
		else
			PostieReceived:FireClient(p1, p3, false)
		end
	end)
else
	PostieReceived.OnClientEvent:Connect(function(p1, p2, ...)
		local v1 = t2[p1]
		if v1 then
			v1(p2, ...)
		end
	end)
	PostieSent.OnClientEvent:Connect(function(p1, p2, ...)
		local v1 = t[p1]
		if v1 then
			PostieReceived:FireServer(p2, true, v1(...))
		else
			PostieReceived:FireServer(p2, false)
		end
	end)
end
return t3
