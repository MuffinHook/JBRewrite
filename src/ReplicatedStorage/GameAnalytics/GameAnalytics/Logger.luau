return {
	_infoLogEnabled = false,
	_infoLogAdvancedEnabled = false,
	_debugEnabled = game:GetService("RunService"):IsStudio(),
	setDebugLog = function(logger, isEnabled)
		logger._debugEnabled = isEnabled
	end,
	setInfoLog = function(logger, isEnabled)
		logger._infoLogEnabled = isEnabled
	end,
	setVerboseLog = function(logger, isEnabled)
		logger._infoLogAdvancedEnabled = isEnabled
	end,
	info = function(logger, message)
		if logger._infoLogEnabled then
			print("Info/GameAnalytics: " .. message)
		end
	end,
	warnLog = function(logger, message)
		warn("Warning/GameAnalytics: " .. message)
	end,
	errorLog = function(logger, message)
		task.spawn(function()
			error("Error/GameAnalytics: " .. message, 0)
		end)
	end,
	debug = function(logger, message)
		if logger._debugEnabled then
			print("Debug/GameAnalytics: " .. message)
		end
	end,
	verboseInfo = function(logger, message)
		if logger._infoLogAdvancedEnabled then
			print("Verbose/GameAnalytics: " .. message)
		end
	end
}
