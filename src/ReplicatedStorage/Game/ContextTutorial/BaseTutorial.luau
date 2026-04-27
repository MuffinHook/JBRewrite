local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local ContextMessageUI = require(ReplicatedStorage.Game.ContextMessage.ContextMessageUI)
local BaseTutorial = {}
BaseTutorial.__index = BaseTutorial
BaseTutorial.__ClassName = "BaseTutorial"
function BaseTutorial.new(tutorialContainer, messages)
	local self = {}
	setmetatable(self, BaseTutorial)
	self._maid = Maid.new()
	self._remoteEvent = tutorialContainer:WaitForChild("RemoteEvent")
	self.Messages = messages
	self._maid:GiveTask(self._remoteEvent.OnClientEvent:Connect(function(...)
		self:_onClientEvent(...)
	end))
	self._runningValue = tutorialContainer:WaitForChild("Running")
	self._maid:GiveTask(self._runningValue:GetPropertyChangedSignal("Value"):Connect(function()
		if self._runningValue.Value then
			self:SetEdge(self._edgeValue.Value)
		else
			if ContextMessageUI.isOpen() then
				ContextMessageUI.close()
			end
			self._maid.updatePosition = nil
		end
	end))
	self._edgeValue = tutorialContainer:WaitForChild("Edge")
	self:SetEdge(self._edgeValue.Value)
	self._maid:GiveTask(self._edgeValue:GetPropertyChangedSignal("Value"):Connect(function()
		self:SetEdge(self._edgeValue.Value)
	end))
	return self
end
function BaseTutorial.SetEdge(self, edgeValue)
	if self:GetRunning() then
		self._maid.updatePosition = nil
		local message = self.Messages[edgeValue]
		if message ~= nil then
			if not ContextMessageUI.isOpen() then
				ContextMessageUI.open()
				ContextMessageUI._maid:GiveTask(ContextMessageUI.onCloseClicked:Connect(function()
					self._remoteEvent:FireServer()
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
					self._maid.updatePosition = Position.Changed:Connect(function()
						ContextMessageUI.setWorldMarkerPosition(Position.Value)
					end)
				elseif positionType == "function" then
					local function update()
						ContextMessageUI.setWorldMarkerPosition((message.position()))
					end
					self._maid.updatePosition = Interval.every(5):Connect(update)
				else
					error(("Invalid type for message `position`: %s"):format(positionType))
				end
			end
			ContextMessageUI.setWorldMarkerSizes(message.sizes)
			ContextMessageUI.setWorldMarkerEnabled(message.position ~= nil)
		end
	end
end
function BaseTutorial.GetRunning(self)
	return self._runningValue.Value
end
function BaseTutorial._onClientEvent(self)  end
function BaseTutorial.Destroy(self)
	assert(self._maid)
	self._maid:Destroy()
	self._maid = nil
end
return BaseTutorial
