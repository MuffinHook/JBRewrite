local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local CursorClass = {}
CursorClass.__index = CursorClass
function CursorClass.new(graph, node)
	assert(graph)
	assert(node)
	local cursorInstance = {}
	setmetatable(cursorInstance, CursorClass)
	cursorInstance.Graph = graph
	cursorInstance.Node = node
	return cursorInstance
end
function CursorClass.GetOnWalkedSignal(self)
	if self._onWalkedSignal == nil then
		self._onWalkedSignal = Signal.new()
	end
	return self._onWalkedSignal
end
function CursorClass.WalkTo(self, targetNode)
	assert(targetNode)
	if self.Graph:HasEdge(self.Node, targetNode) then
		self.Node = targetNode
		if self._onWalkedSignal then
			self._onWalkedSignal:Fire(targetNode)
		end
		return true
	else
		return false
	end
end
return CursorClass
