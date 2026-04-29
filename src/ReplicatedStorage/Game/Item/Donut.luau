local Basic = require(script.Parent.Basic)
local motionConfig = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0, 0.8, -1.5),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		Eat = {
			Springs = {
				ItemOffset = Vector3.new(0, 1.2, -1.3),
				ItemRotation = Vector3.new(0.9424778, 0, 0),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local event = nil
local DonutClass = {
	__ClassName = "Donut"
}
DonutClass.__index = DonutClass
setmetatable(DonutClass, Basic)
function DonutClass.Init(self)
	event = self.Event
end
function DonutClass.new(self, p2, config)
	local newInstance = Basic.new(self, p2, motionConfig, config)
	setmetatable(newInstance, DonutClass)
	newInstance:DefaultDisableCamLock()
	return newInstance
end
function DonutClass.InputBegan(self, userInputData, p3)
	if if userInputData.UserInputType == Enum.UserInputType.MouseButton1 then true elseif userInputData.UserInputType == Enum.UserInputType.Gamepad1 then userInputData.KeyCode == Enum.KeyCode.ButtonR2 else false then
		self.SpringItemRotation:SetTarget(self.Config.Motion.Eat.Springs.ItemRotation)
		task.delay(0.3, function()
			self.SpringItemRotation:SetTarget(self.Config.Motion.Hip.Springs.ItemRotation)
			if self.Local then
				local currentTime = tick()
				local lastConsumedTime = self.LastConsumed or 0
				self.LastConsumed = currentTime
				if currentTime - lastConsumedTime < 5 then
					return false
				end
				event:FireServer("ojccdr13")
			end
		end)
		if self.Local then
			self:BroadcastInputBegan(userInputData)
		end
	end
	Basic.InputBegan(self, userInputData, p3)
end
function DonutClass.InputEnded(self)  end
return DonutClass
