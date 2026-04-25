-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
return function(textContent, textLabel, charsPerSecond, onProgressCallback)
	textLabel.Text = textContent
	textLabel.MaxVisibleGraphemes = 0
	local startTime = os.clock()
	local totalCharCount = utf8.len(textContent)
	local totalDuration = totalCharCount / (charsPerSecond or 25)
	local heartbeatConnection = nil
	heartbeatConnection = RunService.Heartbeat:Connect(function()
		local animationProgress = (os.clock() - startTime) / totalDuration
		if animationProgress > 1 then
			heartbeatConnection:Disconnect()
			animationProgress = 1
		end
		local visibleCharCount = animationProgress * totalCharCount
		textLabel.MaxVisibleGraphemes = visibleCharCount
		if onProgressCallback then
			onProgressCallback(visibleCharCount)
		end
	end)
	return heartbeatConnection
end
