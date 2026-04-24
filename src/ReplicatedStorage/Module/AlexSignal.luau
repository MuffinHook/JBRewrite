-- Reviewed by Claude
local t = {}
local t2 = {}
local random = math.random
local function GUID()
	return ("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", function(p1)
		return ("%x"):format(p1 == "x" and random(0, 15) or random(8, 11))
	end)
end
local function MakeListener()
	return {
		g = ("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", function(p1)
			return ("%x"):format(p1 == "x" and random(0, 15) or random(8, 11))
		end),
		Callback = nil,
		SignalName = nil
	}
end
function t.Broadcast(p1, ...)
	local t = { ... }
	for v1, v2 in next, t2 do
		if v2.SignalName == p1 then
			local v3, v4 = pcall(function()
				v2:Callback(unpack(t))
			end)
			if not v3 then
				warn("SIGNAL ERROR: ", v4)
			end
		end
	end
end
function t.Listen(p1, p2)
	local t = {
		g = ("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", function(p1)
			return ("%x"):format(p1 == "x" and random(0, 15) or random(8, 11))
		end),
		Callback = nil,
		SignalName = nil,
		SignalName = p1,
		Callback = p2
	}
	table.insert(t2, t)
	return t
end
function t.Close(p1)
	local g = p1.g
	for v1, v2 in next, t2 do
		if v2.g == g then
			return table.remove(t2, v1)
		end
	end
	return false
end
function t.Closeg(p1)
	for v1, v2 in next, t2 do
		if v2.g == p1 then
			return table.remove(t2, v1)
		end
	end
	return false
end
function t.Closef(p1)
	for v1, v2 in next, t2 do
		if v2.Callback == p1 then
			return table.remove(t2, v1)
		end
	end
	return false
end
return t
