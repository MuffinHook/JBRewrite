-- Reviewed by Claude
local RunService = game:GetService("RunService")
local t = {}
t.__index = t
function t.new(p1)
	local table2 = setmetatable({}, t)
	assert(p1.Duration)
	local Duration_2 = p1.Duration
	table2.OnUpdate = p1.OnUpdate
	table2.OnComplete = p1.OnComplete
	table2.OnCancel = p1.OnCancel
	local var3 = tick()
	table2.Event = RunService.Heartbeat:Connect(function(p1)
		local delta = tick() - var3
		local var22 = Duration_2 <= delta
		if var22 then
			delta = Duration_2
		end
		if table2.OnUpdate then
			local var32 = delta / Duration_2
			if var32 ~= var32 then
				var32 = 1
			end
			table2.OnUpdate(p1, delta, var32)
		end
		if var22 then
			table2.Event:Disconnect()
			table2.Event = nil
			if table2.OnComplete then
				table2.OnComplete()
			end
		end
	end)
	return table2
end
function t.Destroy(p1)
	if p1.Event then
		p1.Event:Disconnect()
		p1.Event = nil
		if p1.OnCancel then
			p1.OnCancel()
		end
		return true
	else
		return false
	end
end
return t
