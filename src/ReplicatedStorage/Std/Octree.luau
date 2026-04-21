local Octree = {}
Octree.__index = Octree

function Octree.new(_, _, _, _)
    return setmetatable({
        _positions = {},
    }, Octree)
end

function Octree:Insert(object, position)
    self._positions[object] = position
    return object
end

function Octree:Update(object, position)
    if self._positions[object] == nil then
        return self:Insert(object, position)
    end
    self._positions[object] = position
    return object
end

function Octree:Remove(object)
    self._positions[object] = nil
end

function Octree:QueryRadius(position, radius)
    local results = {}
    local radiusSquared = radius * radius

    for object, objectPosition in pairs(self._positions) do
        if (objectPosition - position).Magnitude ^ 2 <= radiusSquared then
            table.insert(results, object)
        end
    end

    return results
end

return Octree
