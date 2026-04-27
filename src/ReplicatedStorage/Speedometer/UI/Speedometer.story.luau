local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
return function(storyContext)
	local instance = Maid.new()
	local distanceValue, updateDistance = Roact.createBinding(123456)
	local speedValue, updateSpeed = Roact.createBinding(878)
	local barRatioValue, updateBarRatio = Roact.createBinding(0.3)
	local accelRatioValue, updateAccelRatio = Roact.createBinding(0.5)
	instance:GiveTask(RunService.Heartbeat:Connect(function()
		local oscillationFactor = math.sin(os.clock() * 2) * 0.5 + 0.5
		updateSpeed(oscillationFactor * 500)
		updateAccelRatio(oscillationFactor)
		updateBarRatio(math.cos((os.clock())) * 0.5 + 0.5)
		updateDistance((math.cos(os.clock() * 0.1) * 0.5 + 0.5) * 1000000)
	end))
	local Speedometer = require(script.Parent.Speedometer)
	local speedometerHandle = Roact.mount(Roact.createElement(Speedometer, {
		distance = distanceValue,
		speed = speedValue,
		barRatio = barRatioValue,
		accelRatio = accelRatioValue,
		size = UDim2.new(0.5, 0, 0.5, 0),
		position = UDim2.new(0.25, 0, 0.25, 0),
		color = Color3.fromRGB(252, 40, 47),
		passengers = {
			{
				Name = "badcc"
			},
			{
				Name = "asimo3089"
			},
			{
				Name = "TWENTYMOREMINUTES"
			}
		}
	}), storyContext)
	return function()
		Roact.unmount(speedometerHandle)
		instance:DoCleaning()
	end
end
