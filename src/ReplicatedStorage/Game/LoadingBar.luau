local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.new() -- Line 8
    local module = {}
    setmetatable(module, module_upvr)
    module.Maid = Maid_upvr.new()
    module.Gui = ReplicatedStorage_upvr.Resource.LoadingBar.LoadingBarGui:Clone()
    module.Gui.Parent = LocalPlayer_upvr.PlayerGui
    module.Gui.Enabled = true
    module.Maid:GiveTask(module.Gui)
    module:SetValue(0)
    return module
end
function module_upvr.SetValue(arg1, arg2) -- Line 22
    arg1.Gui.Background.Value.Size = UDim2.new(arg2, 0, 1, 0)
end
function module_upvr.SetPosition(arg1, arg2) -- Line 25
    arg1.Gui.Background.Position = arg2
end
function module_upvr.Destroy(arg1) -- Line 28
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr