local t = {}
local function isPointInPrism(point, prismCFrame, prismSize)
	local pointLocal = prismCFrame:pointToObjectSpace(point) + prismSize * 0.5
	return if pointLocal.x >= 0 and (pointLocal.x <= prismSize.x and (pointLocal.y >= 0 and (pointLocal.y <= prismSize.y and pointLocal.z >= 0))) then pointLocal.z <= prismSize.z else false
end
function t.isWithinBounds(itemPart, itemCFrame, surfaces)
	local itemSize = itemPart.Size
	for i = -4, 4 do
		for j = -4, 4 do
			local testPoint = itemCFrame * (Vector3.new(i / 4, -1, j / 4) * itemSize * 0.5)
			local isWithinAnyPrism = false
			for _, surface in ipairs(surfaces) do
				local isInPrism
				local surfaceCFrame, surfaceSize = surface:GetPlacementPrism()
				local expandedSize = surfaceSize * 1.001
				local pointLocal = surfaceCFrame:pointToObjectSpace(testPoint) + expandedSize * 0.5
				isInPrism = if pointLocal.x >= 0 and (pointLocal.x <= expandedSize.x and (pointLocal.y >= 0 and (pointLocal.y <= expandedSize.y and pointLocal.z >= 0))) then pointLocal.z <= expandedSize.z else false
				if isInPrism then
					isWithinAnyPrism = true
					break
				end
			end
			if not isWithinAnyPrism then
				return false
			end
		end
	end
	return true
end
return t
