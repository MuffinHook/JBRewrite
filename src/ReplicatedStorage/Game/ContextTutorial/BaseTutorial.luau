-- Reviewed by Claude
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
		local v1 = p1.Messages[p2]
		if v1 ~= nil then
			if not ContextMessageUI.isOpen() then
				ContextMessageUI.open()
				ContextMessageUI._maid:GiveTask(ContextMessageUI.onCloseClicked:Connect(function()
					p1._remoteEvent:FireServer()
				end))
			end
			ContextMessageUI.setMessage(v1.text)
			if v1.position then
				local v2 = typeof(v1.position)
				if v2 == "Vector3" then
					ContextMessageUI.setWorldMarkerPosition(v1.position)
				elseif v2 == "Instance" and v1.position:IsA("Vector3Value") then
					local Position = v1.Position
					ContextMessageUI.setWorldMarkerPosition(Position.Value)
					p1._maid.updatePosition = Position.Changed:Connect(function()
						ContextMessageUI.setWorldMarkerPosition(Position.Value)
					end)
				elseif v2 == "function" then
					local function update()
						ContextMessageUI.setWorldMarkerPosition((v1.position()))
					end
					p1._maid.updatePosition = Interval.every(5):Connect(update)
				else
					error(("Invalid type for message `position`: %s"):format(v2))
				end
			end
			ContextMessageUI.setWorldMarkerSizes(v1.sizes)
			ContextMessageUI.setWorldMarkerEnabled(v1.position ~= nil)
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
