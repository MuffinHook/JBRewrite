local function tracebackReporter(p1) --[[ Line: 7 ]]
	return debug.traceback(p1)
end
return function(p1, p2) --[[ Name: thunkMiddleware | Line: 11 | Upvalues: tracebackReporter (copy) ]]
	return function(p12) --[[ Line: 12 | Upvalues: p2 (copy), tracebackReporter (ref), p1 (copy) ]]
		if typeof(p12) == "function" then
			local v1, v2 = xpcall(function() --[[ Line: 14 | Upvalues: p12 (copy), p2 (ref) ]]
				return p12(p2)
			end, tracebackReporter)
			if v1 then
				return v2
			else
				p2._errorReporter.reportReducerError(p2:getState(), p12, {
					message = "Caught error in thunk",
					thrownValue = v2
				})
				return nil
			end
		else
			return p1(p12)
		end
	end
end