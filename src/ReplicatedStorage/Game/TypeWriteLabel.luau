local RunService = game:GetService("RunService")
return function(p1, p2, p3, p4) --[[ Line: 3 | Upvalues: RunService (copy) ]]
	p2.Text = p1
	p2.MaxVisibleGraphemes = 0
	local v1 = os.clock()
	local v2 = utf8.len(p1)
	local v3 = v2 / (p3 or 25)
	local v4 = nil
	v4 = RunService.Heartbeat:Connect(function() --[[ Line: 19 | Upvalues: v1 (copy), v3 (copy), v4 (ref), v2 (copy), p2 (copy), p4 (copy) ]]
		local v12 = (os.clock() - v1) / v3
		if v12 > 1 then
			v4:Disconnect()
			v12 = 1
		end
		local v22 = v12 * v2
		p2.MaxVisibleGraphemes = v22
		if p4 then
			p4(v22)
		end
	end)
	return v4
end