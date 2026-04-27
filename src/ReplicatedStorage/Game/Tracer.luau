local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local TracerRoot = Instance.new("Part")
TracerRoot.Name = "TracerRoot"
TracerRoot.Anchored = true
TracerRoot.CFrame = CFrame.new(0, 0, 0)
TracerRoot.CanCollide = false
TracerRoot.Transparency = 1
TracerRoot.Parent = workspace
local TracerLines = Instance.new("Folder")
TracerLines.Name = "TracerLines"
TracerLines.Parent = workspace
local TracerClass = {}
TracerClass.__index = TracerClass
setmetatable(TracerClass, BaseObject)
function TracerClass.new()
	local tracerInstance = BaseObject.new()
	setmetatable(tracerInstance, TracerClass)
	tracerInstance:_setup()
	tracerInstance:SetColor(Color3.fromRGB(255, 235, 141))
	return tracerInstance
end
function TracerClass.SetColor(self, color)
	self.lineHandle.Color3 = color
end
function TracerClass.SetThickness(self, thickness)
	self.lineHandle.Thickness = thickness
end
function TracerClass._setup(self)
	local LineHandleAdornment = Instance.new("LineHandleAdornment")
	LineHandleAdornment.Adornee = TracerRoot
	LineHandleAdornment.Transparency = 0.1
	LineHandleAdornment.Thickness = 2
	LineHandleAdornment.SizeRelativeOffset = Vector3.new(0, 0, 0)
	LineHandleAdornment.Length = 0
	LineHandleAdornment.CFrame = CFrame.new()
	LineHandleAdornment.Parent = TracerLines
	self.maid:GiveTask(LineHandleAdornment)
	self.lineHandle = LineHandleAdornment
end
function TracerClass.Draw(self, startPos, endPos)
	self.lineHandle.Length = (endPos - startPos).Magnitude
	self.lineHandle.CFrame = CFrame.lookAt(startPos, endPos)
end
return TracerClass
