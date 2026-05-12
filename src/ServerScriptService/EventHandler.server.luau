local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Em = require(script.Parent:WaitForChild("Em"))

local genericRemote = ReplicatedStorage:FindFirstChild("GenericRemoteEvent")
if genericRemote == nil then
	genericRemote = Instance.new("RemoteEvent")
	genericRemote.Name = "GenericRemoteEvent"
	genericRemote.Parent = ReplicatedStorage
end

assert(genericRemote:IsA("RemoteEvent"), "GenericRemoteEvent must be a RemoteEvent")
Em.bind(genericRemote)
