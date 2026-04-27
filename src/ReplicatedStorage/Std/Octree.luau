local Octree = {}
Octree.__index = Octree
Octree.ClassName = "Octree"
local NodeMetatable = {}
NodeMetatable.__index = NodeMetatable
local function Node_new(nodeCenter, nodeHalfSize, nodeDepth)
	return setmetatable({
		center = nodeCenter,
		halfSize = nodeHalfSize,
		depth = nodeDepth,
		items = {},
		itemCount = 0,
		children = nil
	}, NodeMetatable)
end
local function Node_getOctant(node, position)
	local center = node.center
	return if position.X >= center.X then 4 else 0 + if position.Y >= center.Y then 2 else 0 + if position.Z >= center.Z then 1 else 0 + 1
end
local octantOffsets = {
	Vector3.new(-1, -1, -1),
	Vector3.new(-1, -1, 1),
	Vector3.new(-1, 1, -1),
	Vector3.new(-1, 1, 1),
	Vector3.new(1, -1, -1),
	Vector3.new(1, -1, 1),
	Vector3.new(1, 1, -1),
	Vector3.new(1, 1, 1)
}
local function Node_subdivide(node)
	local childHalfSize = node.halfSize * 0.5
	local center = node.center
	local children = table.create(8)
	for i = 1, 8 do
		children[i] = Node_new(center + octantOffsets[i] * childHalfSize, childHalfSize, node.depth + 1)
	end
	node.children = children
end
local function Node_containsPoint(node, position)
	local center = node.center
	local halfSize = node.halfSize
	return if math.abs(position.X - center.X) <= halfSize then if math.abs(position.Y - center.Y) <= halfSize then math.abs(position.Z - center.Z) <= halfSize else false else false
end
local function Node_intersectsSphere(node, sphereCenter, sphereRadiusSq)
	local center = node.center
	local halfSize = node.halfSize
	local distX = math.max(0, math.abs(sphereCenter.X - center.X) - halfSize)
	local distY = math.max(0, math.abs(sphereCenter.Y - center.Y) - halfSize)
	local distZ = math.max(0, math.abs(sphereCenter.Z - center.Z) - halfSize)
	return distX * distX + distY * distY + distZ * distZ <= sphereRadiusSq * sphereRadiusSq
end
function Octree.new(rootCenter, rootHalfSize, maxDepth, splitThreshold)
	local octree = setmetatable({}, Octree)
	octree._maxDepth = maxDepth or 7
	octree._splitThreshold = splitThreshold or 8
	octree._root = Node_new(rootCenter or Vector3.new(0, 50, 0), rootHalfSize or 4096, 0)
	octree._itemToNode = {}
	octree._itemToPos = {}
	return octree
end
function Octree.Insert(octree, item, itemPosition)
	if octree._itemToNode[item] then
		octree:Update(item, itemPosition)
	else
		octree._itemToPos[item] = itemPosition
		octree:_insertIntoNode(octree._root, item, itemPosition)
	end
end
function Octree._insertIntoNode(octree, node, item, itemPosition)
	if node.children then
		local center = node.center
		octree:_insertIntoNode(node.children[if itemPosition.X >= center.X then 4 else 0 + if itemPosition.Y >= center.Y then 2 else 0 + if itemPosition.Z >= center.Z then 1 else 0 + 1], item, itemPosition)
	else
		node.items[item] = true
		node.itemCount = node.itemCount + 1
		octree._itemToNode[item] = node
		if node.itemCount > octree._splitThreshold and node.depth < octree._maxDepth then
			Node_subdivide(node)
			local items = node.items
			node.items = {}
			node.itemCount = 0
			for currentItem in items do
				local octantX, octantY, octantZ
				local currentItemPos = octree._itemToPos[currentItem]
				local center = node.center
				octantX = if currentItemPos.X >= center.X then 4 else 0
				octantY = if currentItemPos.Y >= center.Y then 2 else 0
				octantZ = if currentItemPos.Z >= center.Z then 1 else 0
				local childNode = node.children[octantX + octantY + octantZ + 1]
				childNode.items[currentItem] = true
				childNode.itemCount = childNode.itemCount + 1
				octree._itemToNode[currentItem] = childNode
			end
		end
	end
end
function Octree.Remove(octree, item)
	local node = octree._itemToNode[item]
	if node then
		node.items[item] = nil
		node.itemCount = node.itemCount - 1
		octree._itemToNode[item] = nil
		octree._itemToPos[item] = nil
	end
end
function Octree.Update(octree, item, newPosition)
	local node = octree._itemToNode[item]
	if node then
		octree._itemToPos[item] = newPosition
		local center = node.center
		local halfSize = node.halfSize
		if if math.abs(newPosition.X - center.X) <= halfSize then if math.abs(newPosition.Y - center.Y) <= halfSize then math.abs(newPosition.Z - center.Z) <= halfSize else false else false then
			return false
		else
			node.items[item] = nil
			node.itemCount = node.itemCount - 1
			octree._itemToNode[item] = nil
			octree:_insertIntoNode(octree._root, item, newPosition)
			return true
		end
	else
		return false
	end
end
function Octree.QueryRadius(octree, queryCenter, queryRadius)
	local results = {}
	octree:_queryNode(octree._root, queryCenter, queryRadius, queryRadius * queryRadius, results)
	return results
end
function Octree._queryNode(octree, node, queryCenter, queryRadiusSq, radiusSqValue, results)
	if Node_intersectsSphere(node, queryCenter, queryRadiusSq) then
		if node.children then
			for i = 1, 8 do
				octree:_queryNode(node.children[i], queryCenter, queryRadiusSq, radiusSqValue, results)
			end
		else
			for item in node.items do
				local itemPosition = octree._itemToPos[item]
				if itemPosition then
					local distanceVector = itemPosition - queryCenter
					if distanceVector.X * distanceVector.X + distanceVector.Y * distanceVector.Y + distanceVector.Z * distanceVector.Z <= radiusSqValue then
						table.insert(results, item)
					end
				end
			end
		end
	end
end
function Octree.Destroy(octree)
	octree._root = nil
	octree._itemToNode = nil
	octree._itemToPos = nil
end
return Octree
