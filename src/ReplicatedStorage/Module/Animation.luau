local RunService = game:GetService("RunService")
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 5 | Upvalues: t (copy), RunService (copy) ]]
	local v2 = setmetatable({}, t)
	assert(p1.Duration)
	local Duration_2 = p1.Duration
	v2.OnUpdate = p1.OnUpdate
	v2.OnComplete = p1.OnComplete
	v2.OnCancel = p1.OnCancel
	local v3 = tick()
	v2.Event = RunService.Heartbeat:Connect(function(p1) --[[ Line: 16 | Upvalues: v3 (copy), Duration_2 (copy), v2 (copy) ]]
		local v1 = tick() - v3
		local v22 = Duration_2 <= v1
		if v22 then
			v1 = Duration_2
		end
		if v2.OnUpdate then
			local v32 = v1 / Duration_2
			if v32 ~= v32 then
				v32 = 1
			end
			v2.OnUpdate(p1, v1, v32)
		end
		if v22 then
			v2.Event:Disconnect()
			v2.Event = nil
			if v2.OnComplete then
				v2.OnComplete()
			end
		end
	end)
	return v2
end
function t.Destroy(p1) --[[ Line: 40 ]]
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