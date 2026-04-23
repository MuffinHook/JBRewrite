local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
require(ReplicatedStorage.Std.Signal)
local t = {
	_data = {},
	_observing = {}
}
function t.setCachedPlayerPolicyInfo(p1, p2) --[[ Line: 9 | Upvalues: t (copy) ]]
	t._data[p1.UserId] = p2
	local v1 = t._observing[p1.UserId]
	if v1 then
		t._observing[p1.UserId] = nil
		for v2, v3 in v1 do
			v3(p2)
		end
	end
end
function t.getCachedPlayerPolicyInfo(p1) --[[ Line: 19 | Upvalues: t (copy) ]]
	return t._data[p1.UserId]
end
function t.promiseCachedPlayerPolicyInfo(p1) --[[ Line: 22 | Upvalues: t (copy), Promise (copy) ]]
	local v1 = t.getCachedPlayerPolicyInfo(p1)
	if v1 then
		return Promise.resolve(v1)
	else
		return Promise.new(function(p12, p2, p3) --[[ Line: 27 | Upvalues: p1 (copy), t (ref) ]]
			local UserId = p1.UserId
			if not t._observing[UserId] then
				t._observing[UserId] = {}
			end
			if not p3(function() --[[ Line: 34 | Upvalues: t (ref), UserId (copy), p12 (copy) ]]
				if t._observing[UserId] then
					local v1 = table.find(t._observing[UserId], p12)
					if v1 then
						table.remove(t._observing[UserId], v1)
					end
				end
			end) then
				table.insert(t._observing[UserId], p12)
			end
		end)
	end
end
function t.removeCachedPlayerPolicyInfo(p1) --[[ Line: 48 | Upvalues: t (copy) ]]
	t._data[p1.UserId] = nil
end
return t