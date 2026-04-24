-- Reviewed by Claude
-- variables reassigned
local function resultHandler(coroutineThread, resumeSuccess, ...)
	if not resumeSuccess then
 error(debug.traceback(coroutineThread, (...)), 2)
	end
	if coroutine.status(coroutineThread) ~= "dead" then
 error(debug.traceback(coroutineThread, "Attempted to yield inside changed event!"), 2)
	end
	return ...
end
return function(functionToRun, ...)
	local coroutineThread = coroutine.create(functionToRun)
	return resultHandler(coroutineThread, coroutine.resume(coroutineThread, ...))
end
