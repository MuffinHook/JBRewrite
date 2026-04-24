-- Reviewed by Claude
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
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new()
	local v1 = BaseObject.new()
	setmetatable(v1, t)
	v1:_setup()
	v1:SetColor(Color3.fromRGB(255, 235, 141))
	return v1
end
function t.SetColor(p1, p2)
	p1.lineHandle.Color3 = p2
end
function t.SetThickness(p1, p2)
	p1.lineHandle.Thickness = p2
end
function t._setup(p1)
	local LineHandleAdornment = Instance.new("LineHandleAdornment")
	LineHandleAdornment.Adornee = TracerRoot
	LineHandleAdornment.Transparency = 0.1
	LineHandleAdornment.Thickness = 2
	LineHandleAdornment.SizeRelativeOffset = Vector3.new(0, 0, 0)
	LineHandleAdornment.Length = 0
	LineHandleAdornment.CFrame = CFrame.new()
	LineHandleAdornment.Parent = TracerLines
	p1.maid:GiveTask(LineHandleAdornment)
	p1.lineHandle = LineHandleAdornment
end
function t.Draw(p1, p2, p3)
	p1.lineHandle.Length = (p3 - p2).Magnitude
	p1.lineHandle.CFrame = CFrame.lookAt(p2, p3)
end
return t
