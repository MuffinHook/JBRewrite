-- Reviewed by Claude
-- variables reassigned
local CollectionService = game:GetService("CollectionService")
local t = {
	findFirstAncestor = function(p1, p2)
		assert(type(p1) == "table", "Binder must be binder")
		assert(typeof(p2) == "Instance", "Child parameter must be instance")
		local v3 = p2.Parent
		while v3 do
			local v4 = p1:Get(v3)
			if v4 then
				return v4
			end
			v3 = v3.Parent
		end
		return nil
	end,
	findFirstChild = function(p1, p2)
		assert(type(p1) == "table", "Binder must be binder")
		assert(typeof(p2) == "Instance", "Parent parameter must be instance")
		for k, v in pairs(p2:GetChildren()) do
			local v3 = p1:Get(v)
			if v3 then
				return v3
			end
		end
		return nil
	end,
	getChildren = function(p1, p2)
		assert(type(p1) == "table", "Binder must be binder")
		assert(typeof(p2) == "Instance", "Parent parameter must be instance")
		local t = {}
		for k, v in pairs(p2:GetChildren()) do
			local v3 = p1:Get(v)
			if v3 then
				table.insert(t, v3)
			end
		end
		return t
	end,
	mapBinderListToTable = function(p1)
		assert(type(p1) == "table", "bindersList must be a table of binders")
		local t = {}
		for k, v in pairs(p1) do
			t[v:GetTag()] = v
		end
		return t
	end,
	getMappedFromList = function(p1, p2)
		local t = {}
		for k, v in pairs(p2) do
			for k2, v2 in pairs(CollectionService:GetTags(v)) do
				local v1 = p1[v2]
				if v1 then
					local v22 = v1:Get(v)
					if v22 then
						table.insert(t, v22)
					end
				end
			end
		end
		return t
	end
}
function t.getChildrenOfBinders(p1, p2)
	assert(type(p1) == "table", "bindersList must be a table of binders")
	assert(typeof(p2) == "Instance", "Parent parameter must be instance")
	return t.getMappedFromList(t.mapBinderListToTable(p1), p2:GetChildren())
end
function t.getLinkedChildren(p1, p2, p3)
	local t = {}
	local t2 = {}
	for k, v in pairs(p3:GetChildren()) do
		if v.Name == p2 and (v:IsA("ObjectValue") and v.Value) then
			local v1 = p1:Get(v.Value)
			if v1 and t[v1] then
				warn(("[BinderUtils.getLinkedChildren] - Double linked children at %q"):format(v:GetFullName()))
			elseif v1 then
				t[v1] = true
				table.insert(t2, v1)
			end
		end
	end
	return t2
end
function t.getDescendants(p1, p2)
	assert(type(p1) == "table", "Binder must be binder")
	assert(typeof(p2) == "Instance", "Parent parameter must be instance")
	local t = {}
	for k, v in pairs(p2:GetDescendants()) do
		local v3 = p1:Get(v)
		if v3 then
			table.insert(t, v3)
		end
	end
	return t
end
t.promiseBoundClass = require(script.Parent.promiseBoundClass)
return t
