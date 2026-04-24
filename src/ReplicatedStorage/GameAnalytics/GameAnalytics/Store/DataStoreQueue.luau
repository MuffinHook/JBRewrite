-- Reviewed by Claude
local t = {
	QR = true,
	Queue = {},
	Process = 0
}
local t2 = {}
task.spawn(function()
	while t.QR do
		task.wait()
		if #t.Queue > 0 then
			local v1 = t.Queue[1]
			table.remove(t.Queue, 1)
			if not t2[v1.Key] then
				t2[v1.Key] = 0
			end
			local v2 = t
			v2.Process = v2.Process + 1
			local v3 = v1.Delay + t2[v1.Key] - DateTime.now().UnixTimestamp
			if v3 <= 0 then
				v3 = 0
			end
			task.delay(v3, function()
				while true do
					t2[v1.Key] = DateTime.now().UnixTimestamp
					local v12, v2, v3 = pcall(v1.Func)
					if not v12 then
						warn(v2)
					end
					local v4 = v2
					if v12 and v4 then
						local _2
						_ = v12
						_2 = v3
						break
					end
					if not v1.Delay then
						_ = v12
						break
					end
					task.wait(v1.Delay)
					if v12 and v4 then
						_ = v12
						break
					end
				end
			end)
		end
	end
end)
function t.AddRequest(p1, p2, p3)
	local v1 = Instance.new("BindableEvent")
	table.insert(t.Queue, {
		Key = p1,
		Delay = p3,
		Func = p2,
		Event = v1
	})
	local v2, v3, v4 = v1.Event:Wait()
	return v2, v3, v4
end
function t.RemoveKey(p1)
	t2[p1] = nil
end
return t
