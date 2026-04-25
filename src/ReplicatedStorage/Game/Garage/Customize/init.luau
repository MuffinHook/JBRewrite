-- Reviewed by Claude
-- variables reassigned
local next = next
local scriptChildren, scriptSecondChild = script:GetChildren()
local categories = {}
local api = {}
for _, child in next, scriptChildren, scriptSecondChild do
	categories[child.Name] = require(child)
end
local categoryHandlers = {}
for _, category in script.Parent:FindFirstChild("Category"):GetChildren() do
	categoryHandlers[category.Name] = require(category)
end
function api.Apply(customization, categoryName, value, extra1, extra2)
	local categoryFunc = categories[categoryName]
	if categoryFunc == nil then
		error("No category function exists on server for: " .. categoryName)
	end
	return categoryFunc(customization, value, extra1, extra2)
end
function api.ApplyAll(customization, value, extra)
	for categoryName in next, categories do
		local playerValue = customization[categoryName]
		local handler = categoryHandlers[categoryName]
		if not handler or handler(value) then
			api.Apply(playerValue, categoryName, value, extra)
		end
	end
	return true
end
return api
