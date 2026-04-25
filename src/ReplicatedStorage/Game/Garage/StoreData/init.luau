-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local categoryLoaded = {}
local categoryModules = {}
for v1, child in script:GetChildren() do
	categoryLoaded[child.Name] = false
end
local function GetCategoryByName(categoryName)
	assert(categoryName)
	if not categoryLoaded[categoryName] then
		local foundScript = script:FindFirstChild(categoryName)
		if not foundScript then
			print(("No category module: %s"):format(categoryName))
			error("No category module")
		end
		categoryModules[categoryName] = require(foundScript)
		categoryLoaded[categoryName] = true
	end
	return categoryModules[categoryName]
end
local function GetItemByName(categoryName, itemName)
	assert(categoryName)
	assert(itemName)
	local categoryModule = GetCategoryByName(categoryName)
	if categoryModule then
		assert(categoryModule, categoryName)
		if categoryModule.GetItemByName then
			return categoryModule.GetItemByName(itemName)
		end
		for v3, item in if categoryModule.GetItems then categoryModule.GetItems() else categoryModule.Items do
			if item.Name == itemName then
				return item
			end
		end
	end
	local errorMessage = ("No CategoryName/ItemName: %s/%s"):format(categoryName, itemName)
	if RunService:IsServer() then
		warn(errorMessage)
	end
	return nil
end
return {
	GetCategoryByName = GetCategoryByName,
	GetItemByName = GetItemByName,
	GetMapFromSelection = function(selectionMap)
		assert(selectionMap)
		local result = {}
		for k, v in pairs(selectionMap) do
			result[k] = GetItemByName(k, v)
		end
		return result
	end
}
