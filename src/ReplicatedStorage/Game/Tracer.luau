local BaseObject_upvr = require(game:GetService("ReplicatedStorage").Std.BaseObject)
local Part_upvr = Instance.new("Part")
Part_upvr.Name = "TracerRoot"
Part_upvr.Anchored = true
Part_upvr.CFrame = CFrame.new(0, 0, 0)
Part_upvr.CanCollide = false
Part_upvr.Transparency = 1
Part_upvr.Parent = workspace
local Folder_upvr = Instance.new("Folder")
Folder_upvr.Name = "TracerLines"
Folder_upvr.Parent = workspace
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
function module_upvr.new() -- Line 19
    local any_new_result1 = BaseObject_upvr.new()
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:_setup()
    any_new_result1:SetColor(Color3.fromRGB(255, 235, 141))
    return any_new_result1
end
function module_upvr.SetColor(arg1, arg2) -- Line 28
    arg1.lineHandle.Color3 = arg2
end
function module_upvr.SetThickness(arg1, arg2) -- Line 31
    arg1.lineHandle.Thickness = arg2
end
function module_upvr._setup(arg1) -- Line 34
    local LineHandleAdornment = Instance.new("LineHandleAdornment")
    LineHandleAdornment.Adornee = Part_upvr
    LineHandleAdornment.Transparency = 0.1
    LineHandleAdornment.Thickness = 2
    LineHandleAdornment.SizeRelativeOffset = Vector3.new(0, 0, 0)
    LineHandleAdornment.Length = 0
    LineHandleAdornment.CFrame = CFrame.new()
    LineHandleAdornment.Parent = Folder_upvr
    arg1.maid:GiveTask(LineHandleAdornment)
    arg1.lineHandle = LineHandleAdornment
end
function module_upvr.Draw(arg1, arg2, arg3) -- Line 46
    arg1.lineHandle.Length = (arg3 - arg2).Magnitude
    arg1.lineHandle.CFrame = CFrame.lookAt(arg2, arg3)
end
return module_upvr