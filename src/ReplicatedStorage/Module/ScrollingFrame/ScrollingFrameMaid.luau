local ScrollingFrameMaid = {}
local MaidMethods = {
	GiveTask = function(maid, task)
		local nextIndex = #maid.Tasks + 1
		maid.Tasks[nextIndex] = task
		return nextIndex
	end,
	DoCleaning = function(maid)
		local Tasks = maid.Tasks
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
MaidMethods.Destroy = MaidMethods.DoCleaning
local MaidMetatable = {
	__index = function(maid, key)
		if MaidMethods[key] then
			return MaidMethods[key]
		else
			return maid.Tasks[key]
		end
	end,
	__newindex = function(maid, key, value)
		local Tasks = maid.Tasks
		if value == nil then
			if type(Tasks[key]) ~= "function" and Tasks[key] then
				if typeof(Tasks[key]) == "RBXScriptConnection" then
					Tasks[key]:disconnect()
				else
					Tasks[key]:Destroy()
				end
			end
		elseif Tasks[key] then
			maid[key] = nil
		end
		Tasks[key] = value
	end
}
local function MakeMaid()
	return setmetatable({
		Tasks = {},
		Instances = {}
	}, MaidMetatable)
end
ScrollingFrameMaid.MakeMaid = MakeMaid
ScrollingFrameMaid.new = MakeMaid
return ScrollingFrameMaid
