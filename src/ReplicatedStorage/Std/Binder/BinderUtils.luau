local CollectionService = game:GetService("CollectionService")
local t = {
	findFirstAncestor = function(binder, instance)
		assert(type(binder) == "table", "Binder must be binder")
		assert(typeof(instance) == "Instance", "Child parameter must be instance")
		local currentParent = instance.Parent
		while currentParent do
			local boundClass = binder:Get(currentParent)
			if boundClass then
				return boundClass
			end
			currentParent = currentParent.Parent
		end
		return nil
	end,
	findFirstChild = function(binder, parent)
		assert(type(binder) == "table", "Binder must be binder")
		assert(typeof(parent) == "Instance", "Parent parameter must be instance")
		for k, v in pairs(parent:GetChildren()) do
			local boundClass = binder:Get(v)
			if boundClass then
				return boundClass
			end
		end
		return nil
	end,
	getChildren = function(binder, parent)
		assert(type(binder) == "table", "Binder must be binder")
		assert(typeof(parent) == "Instance", "Parent parameter must be instance")
		local results = {}
		for k, v in pairs(parent:GetChildren()) do
			local boundClass = binder:Get(v)
			if boundClass then
				table.insert(results, boundClass)
			end
		end
		return results
	end,
	mapBinderListToTable = function(bindersList)
		assert(type(bindersList) == "table", "bindersList must be a table of binders")
		local results = {}
		for k, v in pairs(bindersList) do
			results[v:GetTag()] = v
		end
		return results
	end,
	getMappedFromList = function(taggedBindersMap, instances)
		local results = {}
		for k, v in pairs(instances) do
			for k2, tagName in pairs(CollectionService:GetTags(v)) do
				local taggedBinder = taggedBindersMap[tagName]
				if taggedBinder then
					local boundInstanceValue = taggedBinder:Get(v)
					if boundInstanceValue then
						table.insert(results, boundInstanceValue)
					end
				end
			end
		end
		return results
	end
}
function t.getChildrenOfBinders(bindersList, parent)
	assert(type(bindersList) == "table", "bindersList must be a table of binders")
	assert(typeof(parent) == "Instance", "Parent parameter must be instance")
	return t.getMappedFromList(t.mapBinderListToTable(bindersList), parent:GetChildren())
end
function t.getLinkedChildren(binder, linkedPropertyName, parentInstance)
	local seenBoundInstances = {}
	local linkedChildren = {}
	for k, v in pairs(parentInstance:GetChildren()) do
		if v.Name == linkedPropertyName and (v:IsA("ObjectValue") and v.Value) then
			local boundClass = binder:Get(v.Value)
			if boundClass and seenBoundInstances[boundClass] then
				warn(("[BinderUtils.getLinkedChildren] - Double linked children at %q"):format(v:GetFullName()))
			elseif boundClass then
				seenBoundInstances[boundClass] = true
				table.insert(linkedChildren, boundClass)
			end
		end
	end
	return linkedChildren
end
function t.getDescendants(binder, parent)
	assert(type(binder) == "table", "Binder must be binder")
	assert(typeof(parent) == "Instance", "Parent parameter must be instance")
	local results = {}
	for k, v in pairs(parent:GetDescendants()) do
		local boundClass = binder:Get(v)
		if boundClass then
			table.insert(results, boundClass)
		end
	end
	return results
end
t.promiseBoundClass = require(script.Parent.promiseBoundClass)
return t
