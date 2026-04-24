-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
require(ReplicatedStorage.Std.Signal)
local t = {
	_data = {},
	_observing = {}
}
function t.setCachedPlayerPolicyInfo(p1, p2)
	t._data[p1.UserId] = p2
	local tbl = t._observing[p1.UserId]
	if tbl then
		t._observing[p1.UserId] = nil
		for v2, v3 in tbl do
			v3(p2)
		end
	end
end
function t.getCachedPlayerPolicyInfo(p1)
	return t._data[p1.UserId]
end
function t.promiseCachedPlayerPolicyInfo(p1)
	local tbl = t.getCachedPlayerPolicyInfo(p1)
	if tbl then
		return Promise.resolve(tbl)
	else
		return Promise.new(function(p12, p2, p3)
			local UserId = p1.UserId
			if not t._observing[UserId] then
				t._observing[UserId] = {}
			end
			if not p3(function()
				if t._observing[UserId] then
					local tbl = table.find(t._observing[UserId], p12)
					if tbl then
						table.remove(t._observing[UserId], tbl)
					end
				end
			end) then
				table.insert(t._observing[UserId], p12)
			end
		end)
	end
end
function t.removeCachedPlayerPolicyInfo(p1)
	t._data[p1.UserId] = nil
end
return t
