local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
return function(p1) --[[ Line: 6 | Upvalues: Maid (copy), Roact (copy), RunService (copy) ]]
	local v1 = Maid.new()
	local v2, v3 = Roact.createBinding(123456)
	local v4, v5 = Roact.createBinding(878)
	local v6, v7 = Roact.createBinding(0.3)
	local v8, v9 = Roact.createBinding(0.5)
	v1:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 13 | Upvalues: v5 (copy), v9 (copy), v7 (copy), v3 (copy) ]]
		local v2 = math.sin(os.clock() * 2) * 0.5 + 0.5
		v5(v2 * 500)
		v9(v2)
		v7(math.cos((os.clock())) * 0.5 + 0.5)
		v3((math.cos(os.clock() * 0.1) * 0.5 + 0.5) * 1000000)
	end))
	local Speedometer = require(script.Parent.Speedometer)
	local v10 = Roact.mount(Roact.createElement(Speedometer, {
		distance = v2,
		speed = v4,
		barRatio = v6,
		accelRatio = v8,
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
	}), p1)
	return function() --[[ Line: 39 | Upvalues: Roact (ref), v10 (copy), v1 (copy) ]]
		Roact.unmount(v10)
		v1:DoCleaning()
	end
end