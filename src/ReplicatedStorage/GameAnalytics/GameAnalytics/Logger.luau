-- Reviewed by Claude
return {
	_infoLogEnabled = false,
	_infoLogAdvancedEnabled = false,
	_debugEnabled = game:GetService("RunService"):IsStudio(),
	setDebugLog = function(p1, p2)
		p1._debugEnabled = p2
	end,
	setInfoLog = function(p1, p2)
		p1._infoLogEnabled = p2
	end,
	setVerboseLog = function(p1, p2)
		p1._infoLogAdvancedEnabled = p2
	end,
	i = function(p1, p2)
		if p1._infoLogEnabled then
			print("Info/GameAnalytics: " .. p2)
		end
	end,
	w = function(p1, p2)
		warn("Warning/GameAnalytics: " .. p2)
	end,
	e = function(p1, p2)
		task.spawn(function()
			error("Error/GameAnalytics: " .. p2, 0)
		end)
	end,
	d = function(p1, p2)
		if p1._debugEnabled then
			print("Debug/GameAnalytics: " .. p2)
		end
	end,
	ii = function(p1, p2)
		if p1._infoLogAdvancedEnabled then
			print("Verbose/GameAnalytics: " .. p2)
		end
	end
}
