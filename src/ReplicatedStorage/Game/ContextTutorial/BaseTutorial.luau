-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local ContextMessageUI = require(ReplicatedStorage.Game.ContextMessage.ContextMessageUI)
local t = {}
t.__index = t
t.__ClassName = "BaseTutorial"
function t.new(p1, p2)
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._remoteEvent = p1:WaitForChild("RemoteEvent")
	t2.Messages = p2
	t2._maid:GiveTask(t2._remoteEvent.OnClientEvent:Connect(function(...)
		t2:_onClientEvent(...)
	end))
	t2._runningValue = p1:WaitForChild("Running")
	t2._maid:GiveTask(t2._runningValue:GetPropertyChangedSignal("Value"):Connect(function()
		if t2._runningValue.Value then
			t2:SetEdge(t2._edgeValue.Value)
		else
			if ContextMessageUI.isOpen() then
				ContextMessageUI.close()
			end
			t2._maid.updatePosition = nil
		end
	end))
	t2._edgeValue = p1:WaitForChild("Edge")
	t2:SetEdge(t2._edgeValue.Value)
	t2._maid:GiveTask(t2._edgeValue:GetPropertyChangedSignal("Value"):Connect(function()
		t2:SetEdge(t2._edgeValue.Value)
	end))
	return t2
end
function t.SetEdge(p1, p2)
	if p1:GetRunning() then
		p1._maid.updatePosition = nil
		local message = p1.Messages[p2]
		if message ~= nil then
			if not ContextMessageUI.isOpen() then
				ContextMessageUI.open()
				ContextMessageUI._maid:GiveTask(ContextMessageUI.onCloseClicked:Connect(function()
					p1._remoteEvent:FireServer()
				end))
			end
			ContextMessageUI.setMessage(message.text)
			if message.position then
				local positionType = typeof(message.position)
				if positionType == "Vector3" then
					ContextMessageUI.setWorldMarkerPosition(message.position)
				elseif positionType == "Instance" and message.position:IsA("Vector3Value") then
					local Position = message.Position
					ContextMessageUI.setWorldMarkerPosition(Position.Value)
					p1._maid.updatePosition = Position.Changed:Connect(function()
						ContextMessageUI.setWorldMarkerPosition(Position.Value)
					end)
				elseif positionType == "function" then
					local function update()
						ContextMessageUI.setWorldMarkerPosition((message.position()))
					end
					p1._maid.updatePosition = Interval.every(5):Connect(update)
				else
					error(("Invalid type for message `position`: %s"):format(positionType))
				end
			end
			ContextMessageUI.setWorldMarkerSizes(message.sizes)
			ContextMessageUI.setWorldMarkerEnabled(message.position ~= nil)
		end
	end
end
function t.GetRunning(p1)
	return p1._runningValue.Value
end
function t._onClientEvent(p1)  end
function t.Destroy(p1)
	assert(p1._maid)
	p1._maid:Destroy()
	p1._maid = nil
end
return t
