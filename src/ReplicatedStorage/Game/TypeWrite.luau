local RunService = game:GetService("RunService")
return function(p1, p2, p3) --[[ Line: 3 | Upvalues: RunService (copy) ]]
	local v1 = tick()
	local v2 = utf8.len(p1)
	local v3 = v2 / (p3 or 25)
	p2("")
	local v4 = nil
	v4 = RunService.Heartbeat:Connect(function() --[[ Line: 10 | Upvalues: v1 (copy), v3 (copy), v4 (ref), p2 (copy), p1 (copy), v2 (copy) ]]
		local v12 = (tick() - v1) / v3
		if v12 > 1 then
			v4:Disconnect()
			v12 = 1
		end
		p2(utf8.char(utf8.codepoint(p1, 1, v12 * v2)))
	end)
	return v4
end