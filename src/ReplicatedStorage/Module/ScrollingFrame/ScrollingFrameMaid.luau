-- Reviewed by Claude
local t = {}
local t2 = {
	GiveTask = function(p1, p2)
		local v1 = #p1.Tasks + 1
		p1.Tasks[v1] = p2
		return v1
	end,
	DoCleaning = function(p1)
		local Tasks = p1.Tasks
		for k, v in pairs(Tasks) do
			if type(v) == "function" then
				v()
			elseif typeof(v) == "RBXScriptConnection" then
				v:disconnect()
			else
				v:Destroy()
			end
			Tasks[k] = nil
		end
	end
}
t2.Destroy = t2.DoCleaning
local t3 = {
	__index = function(p1, p2)
		if t2[p2] then
			return t2[p2]
		else
			return p1.Tasks[p2]
		end
	end,
	__newindex = function(p1, p2, p3)
		local Tasks = p1.Tasks
		if p3 == nil then
			if type(Tasks[p2]) ~= "function" and Tasks[p2] then
				if typeof(Tasks[p2]) == "RBXScriptConnection" then
					Tasks[p2]:disconnect()
				else
					Tasks[p2]:Destroy()
				end
			end
		elseif Tasks[p2] then
			p1[p2] = nil
		end
		Tasks[p2] = p3
	end
}
local function MakeMaid()
	return setmetatable({
		Tasks = {},
		Instances = {}
	}, t3)
end
t.MakeMaid = MakeMaid
t.new = MakeMaid
return t
