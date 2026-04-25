-- Reviewed by Claude
-- variables reassigned
local queueModule = {
	QR = true,
	Queue = {},
	Process = 0
}
local timestampCache = {}
task.spawn(function()
	while queueModule.QR do
		task.wait()
		if #queueModule.Queue > 0 then
			local queueEntry = queueModule.Queue[1]
			table.remove(queueModule.Queue, 1)
			if not timestampCache[queueEntry.Key] then
				timestampCache[queueEntry.Key] = 0
			end
			local v2 = queueModule
			v2.Process = v2.Process + 1
			local delayTime = queueEntry.Delay + timestampCache[queueEntry.Key] - DateTime.now().UnixTimestamp
			if delayTime <= 0 then
				delayTime = 0
			end
			task.delay(delayTime, function()
				while true do
					timestampCache[queueEntry.Key] = DateTime.now().UnixTimestamp
					local success, v2, v3 = pcall(queueEntry.Func)
					if not success then
						warn(v2)
					end
					local v4 = v2
					if success and v4 then
						local _2
						_ = success
						_2 = v3
						break
					end
					if not queueEntry.Delay then
						_ = success
						break
					end
					task.wait(queueEntry.Delay)
					if success and v4 then
						_ = success
						break
					end
				end
			end)
		end
	end
end)
function queueModule.AddRequest(key, func, delay)
	local event = Instance.new("BindableEvent")
	table.insert(queueModule.Queue, {
		Key = key,
		Delay = delay,
		Func = func,
		Event = event
	})
	local v2, v3, v4 = event.Event:Wait()
	return v2, v3, v4
end
function queueModule.RemoveKey(key)
	timestampCache[key] = nil
end
return queueModule
