local setUtils = {
	fromArray = function(firstSet)
		local resultSet = {}
		for i, element in ipairs(firstSet) do
			resultSet[element] = true
		end
		return resultSet
	end,
	subtract = function(firstSet, secondSet)
		if #firstSet ~= 0 then
			error("`first` has nonzero length, is it a set?")
		end
		if #secondSet ~= 0 then
			error("`second` has nonzero length, is it a set?")
		end
		local resultSet = {}
		for element in pairs(firstSet) do
			if not secondSet[element] then
				resultSet[element] = true
			end
		end
		return resultSet
	end,
	intersect = function(firstSet, secondSet)
		if #firstSet ~= 0 then
			error("`first` has nonzero length, is it a set?")
		end
		if #secondSet ~= 0 then
			error("`second` has nonzero length, is it a set?")
		end
		local resultSet = {}
		for element in pairs(firstSet) do
			if secondSet[element] then
				resultSet[element] = true
			end
		end
		return resultSet
	end,
	union = function(firstSet, secondSet)
		if #firstSet ~= 0 then
			error("`first` has nonzero length, is it a set?")
		end
		if #secondSet ~= 0 then
			error("`second` has nonzero length, is it a set?")
		end
		local resultSet = {}
		for element in pairs(firstSet) do
			resultSet[element] = true
		end
		for element in pairs(secondSet) do
			resultSet[element] = true
		end
		return resultSet
	end
}
function setUtils.symmetricDiff(firstSet, secondSet)
	if #firstSet ~= 0 then
		error("`first` has nonzero length, is it a set?")
	end
	if #secondSet ~= 0 then
		error("`second` has nonzero length, is it a set?")
	end
	return setUtils.union(setUtils.subtract(firstSet, secondSet), setUtils.subtract(secondSet, firstSet))
end
function setUtils.toArray(firstSet)
	if #firstSet ~= 0 then
		error("`set` has nonzero length, is it a set?")
	end
	local resultSet = {}
	for element in pairs(firstSet) do
		resultSet[#resultSet + 1] = element
	end
	return resultSet
end
return setUtils
