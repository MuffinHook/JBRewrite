local function v1(p1) --[[ Line: 1 | Upvalues: v1 (copy) ]]
	if type(p1) == "table" then
		local t = {}
		for v12, v2 in next, p1 do
			t[v1(v12)] = v1(v2)
		end
		setmetatable(t, v1((getmetatable(p1))))
		return t
	else
		return p1
	end
end
return {
	DeepCopy = v1,
	Concat = function(p1, p2) --[[ Name: TableConcat | Line: 15 ]]
		for i = 1, #p2 do
			p1[#p1 + 1] = p2[i]
		end
		return p1
	end
}