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
			local currentQueueModule = queueModule
			currentQueueModule.Process = currentQueueModule.Process + 1
			local delayTime = queueEntry.Delay + timestampCache[queueEntry.Key] - DateTime.now().UnixTimestamp
			if delayTime <= 0 then
				delayTime = 0
			end
			task.delay(delayTime, function()
				while true do
					timestampCache[queueEntry.Key] = DateTime.now().UnixTimestamp
					local success, errorOrResult, callResult = pcall(queueEntry.Func)
					if not success then
						warn(errorOrResult)
					end
					local hasCallResult = errorOrResult
					if success and hasCallResult then
						local _2
						_ = success
						_2 = callResult
						break
					end
					if not queueEntry.Delay then
						_ = success
						break
					end
					task.wait(queueEntry.Delay)
					if success and hasCallResult then
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
	local result1, result2, result3 = event.Event:Wait()
	return result1, result2, result3
end
function queueModule.RemoveKey(key)
	timestampCache[key] = nil
end
return queueModule
