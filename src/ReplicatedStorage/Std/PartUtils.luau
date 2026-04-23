local t = {}
function t.setAnchored(p1, p2) --[[ Line: 5 | Upvalues: t (copy) ]]
	return t.setProperty(p1, "Anchored", p2)
end
function t.setCanCollide(p1, p2) --[[ Line: 8 | Upvalues: t (copy) ]]
	return t.setProperty(p1, "CanCollide", p2)
end
function t.setCanQuery(p1, p2) --[[ Line: 11 | Upvalues: t (copy) ]]
	return t.setProperty(p1, "CanQuery", p2)
end
function t.setCanTouch(p1, p2) --[[ Line: 14 | Upvalues: t (copy) ]]
	return t.setProperty(p1, "CanTouch", p2)
end
function t.setProperty(p1, p2, p3) --[[ Line: 17 ]]
	assert(p1 ~= nil, "missing root")
	if p1:IsA("BasePart") then
		p1[p2] = p3
	end
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			v[p2] = p3
		end
	end
end
local t2 = {}
function t.setPropertyWithRollback(p1, p2, p3) --[[ Line: 29 | Upvalues: t2 (copy) ]]
	local t = {}
	if p1:IsA("BasePart") then
		t[p1] = if p1[p2] == nil then t2 else p1[p2]
		p1[p2] = p3
	end
	for i, v in ipairs(p1:GetDescendants()) do
		local v2
		if v:IsA("BasePart") then
			v2 = if v[p2] == nil then t2 else v[p2]
			t[v] = v2
			v[p2] = p3
		end
	end
	return function() --[[ Line: 43 | Upvalues: t (copy), t2 (ref), p2 (copy) ]]
		for v1, v2 in t do
			if v2 == t2 then
				v1[p2] = nil
			else
				v1[p2] = v2
			end
		end
	end
end
return t