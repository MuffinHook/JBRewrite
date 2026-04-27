local RunService = game:GetService("RunService")
return function(text, callback, charsPerSecond)
	local startTime = tick()
	local textLength = utf8.len(text)
	local totalDuration = textLength / (charsPerSecond or 25)
	callback("")
	local heartbeatConnection = nil
	heartbeatConnection = RunService.Heartbeat:Connect(function()
		local progress = (tick() - startTime) / totalDuration
		if progress > 1 then
			heartbeatConnection:Disconnect()
			progress = 1
		end
		callback(utf8.char(utf8.codepoint(text, 1, progress * textLength)))
	end)
	return heartbeatConnection
end
