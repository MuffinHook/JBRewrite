local Signal = {}
local listeners = {}
local random = math.random
local function GUID()
	return ("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", function(character)
		return ("%x"):format(character == "x" and random(0, 15) or random(8, 11))
	end)
end
local function MakeListener()
	return {
		listenerID = ("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", function(character)
			return ("%x"):format(character == "x" and random(0, 15) or random(8, 11))
		end),
		Callback = nil,
		SignalName = nil
	}
end
function Signal.Broadcast(signalName, ...)
	local args = { ... }
	for index, listener in next, listeners do
		if listener.SignalName == signalName then
			local success, errorMessage = pcall(function()
				listener:Callback(unpack(args))
			end)
			if not success then
				warn("SIGNAL ERROR: ", errorMessage)
			end
		end
	end
end
function Signal.Listen(signalName, callback)
	local newListener = {
		listenerID = ("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", function(character)
			return ("%x"):format(character == "x" and random(0, 15) or random(8, 11))
		end),
		SignalName = signalName,
		Callback = callback
	}
	table.insert(listeners, newListener)
	return newListener
end
function Signal.Close(listener)
	local listenerID = listener.listenerID
	for index, currentListener in next, listeners do
		if currentListener.listenerID == listenerID then
			return table.remove(listeners, index)
		end
	end
	return false
end
function Signal.Closeg(listenerID)
	for index, listener in next, listeners do
		if listener.listenerID == listenerID then
			return table.remove(listeners, index)
		end
	end
	return false
end
function Signal.Closef(callback)
	for index, listener in next, listeners do
		if listener.Callback == callback then
			return table.remove(listeners, index)
		end
	end
	return false
end
return Signal
