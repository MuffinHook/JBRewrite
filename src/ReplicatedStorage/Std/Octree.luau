local t = {}
t.__index = t
t.ClassName = "Octree"
local t2 = {}
t2.__index = t2
local function Node_new(p1, p2, p3) --[[ Line: 24 | Upvalues: t2 (copy) ]]
	return setmetatable({
		center = p1,
		halfSize = p2,
		depth = p3,
		items = {},
		itemCount = 0,
		children = nil
	}, t2)
end
local function Node_getOctant(p1, p2) --[[ Line: 35 ]]
	local center = p1.center
	return if p2.X >= center.X then 4 else 0 + if p2.Y >= center.Y then 2 else 0 + if p2.Z >= center.Z then 1 else 0 + 1
end
local t3 = {
	Vector3.new(-1, -1, -1),
	Vector3.new(-1, -1, 1),
	Vector3.new(-1, 1, -1),
	Vector3.new(-1, 1, 1),
	Vector3.new(1, -1, -1),
	Vector3.new(1, -1, 1),
	Vector3.new(1, 1, -1),
	Vector3.new(1, 1, 1)
}
local function Node_subdivide(p1) --[[ Line: 54 | Upvalues: Node_new (copy), t3 (copy) ]]
	local v1 = p1.halfSize * 0.5
	local center = p1.center
	local v2 = table.create(8)
	for i = 1, 8 do
		v2[i] = Node_new(center + t3[i] * v1, v1, p1.depth + 1)
	end
	p1.children = v2
end
local function Node_containsPoint(p1, p2) --[[ Line: 64 ]]
	local center = p1.center
	local halfSize = p1.halfSize
	return if math.abs(p2.X - center.X) <= halfSize then if math.abs(p2.Y - center.Y) <= halfSize then math.abs(p2.Z - center.Z) <= halfSize else false else false
end
local function Node_intersectsSphere(p1, p2, p3) --[[ Line: 73 ]]
	local center = p1.center
	local halfSize = p1.halfSize
	local v3 = math.max(0, math.abs(p2.X - center.X) - halfSize)
	local v6 = math.max(0, math.abs(p2.Y - center.Y) - halfSize)
	local v9 = math.max(0, math.abs(p2.Z - center.Z) - halfSize)
	return v3 * v3 + v6 * v6 + v9 * v9 <= p3 * p3
end
function t.new(p1, p2, p3, p4) --[[ Line: 83 | Upvalues: t (copy), Node_new (copy) ]]
	local v2 = setmetatable({}, t)
	v2._maxDepth = p3 or 7
	v2._splitThreshold = p4 or 8
	v2._root = Node_new(p1 or Vector3.new(0, 50, 0), p2 or 4096, 0)
	v2._itemToNode = {}
	v2._itemToPos = {}
	return v2
end
function t.Insert(p1, p2, p3) --[[ Line: 93 ]]
	if p1._itemToNode[p2] then
		p1:Update(p2, p3)
	else
		p1._itemToPos[p2] = p3
		p1:_insertIntoNode(p1._root, p2, p3)
	end
end
function t._insertIntoNode(p1, p2, p3, p4) --[[ Line: 103 | Upvalues: Node_subdivide (copy) ]]
	if p2.children then
		local center = p2.center
		p1:_insertIntoNode(p2.children[if p4.X >= center.X then 4 else 0 + if p4.Y >= center.Y then 2 else 0 + if p4.Z >= center.Z then 1 else 0 + 1], p3, p4)
	else
		p2.items[p3] = true
		p2.itemCount = p2.itemCount + 1
		p1._itemToNode[p3] = p2
		if p2.itemCount > p1._splitThreshold and p2.depth < p1._maxDepth then
			Node_subdivide(p2)
			local items = p2.items
			p2.items = {}
			p2.itemCount = 0
			for v8 in items do
				local v5, v6, v7
				local v9 = p1._itemToPos[v8]
				local center = p2.center
				v5 = if v9.X >= center.X then 4 else 0
				v6 = if v9.Y >= center.Y then 2 else 0
				v7 = if v9.Z >= center.Z then 1 else 0
				local v11 = p2.children[v5 + v6 + v7 + 1]
				v11.items[v8] = true
				v11.itemCount = v11.itemCount + 1
				p1._itemToNode[v8] = v11
			end
		end
	end
end
function t.Remove(p1, p2) --[[ Line: 134 ]]
	local v1 = p1._itemToNode[p2]
	if v1 then
		v1.items[p2] = nil
		v1.itemCount = v1.itemCount - 1
		p1._itemToNode[p2] = nil
		p1._itemToPos[p2] = nil
	end
end
function t.Update(p1, p2, p3) --[[ Line: 145 ]]
	local v1 = p1._itemToNode[p2]
	if v1 then
		p1._itemToPos[p2] = p3
		local center = v1.center
		local halfSize = v1.halfSize
		if if math.abs(p3.X - center.X) <= halfSize then if math.abs(p3.Y - center.Y) <= halfSize then math.abs(p3.Z - center.Z) <= halfSize else false else false then
			return false
		else
			v1.items[p2] = nil
			v1.itemCount = v1.itemCount - 1
			p1._itemToNode[p2] = nil
			p1:_insertIntoNode(p1._root, p2, p3)
			return true
		end
	else
		return false
	end
end
function t.QueryRadius(p1, p2, p3) --[[ Line: 166 ]]
	local t = {}
	p1:_queryNode(p1._root, p2, p3, p3 * p3, t)
	return t
end
function t._queryNode(p1, p2, p3, p4, p5, p6) --[[ Line: 173 | Upvalues: Node_intersectsSphere (copy) ]]
	if Node_intersectsSphere(p2, p3, p4) then
		if p2.children then
			for i = 1, 8 do
				p1:_queryNode(p2.children[i], p3, p4, p5, p6)
			end
		else
			for v1 in p2.items do
				local v2 = p1._itemToPos[v1]
				if v2 then
					local v3 = v2 - p3
					if v3.X * v3.X + v3.Y * v3.Y + v3.Z * v3.Z <= p5 then
						table.insert(p6, v1)
					end
				end
			end
		end
	end
end
function t.Destroy(p1) --[[ Line: 195 ]]
	p1._root = nil
	p1._itemToNode = nil
	p1._itemToPos = nil
end
return t