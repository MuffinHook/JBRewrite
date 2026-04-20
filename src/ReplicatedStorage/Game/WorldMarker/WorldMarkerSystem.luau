local module_upvr = {
    Gui = nil;
    _listGroup = {};
}
local WorldMarkerGroup_upvr = require(script.Parent.WorldMarkerGroup)
function module_upvr.addGroup(arg1) -- Line 10
    local var3
    if arg1.__ClassName ~= WorldMarkerGroup_upvr.__ClassName then
        var3 = false
    else
        var3 = true
    end
    assert(var3)
    var3 = module_upvr
    var3 = var3._listGroup
    table.insert(var3, arg1)
end
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local RunService_upvr = game:GetService("RunService")
function module_upvr.init() -- Line 14
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WorldMarkersGui"
    ScreenGui.Parent = LocalPlayer_upvr.PlayerGui
    ScreenGui.Enabled = true
    ScreenGui.IgnoreGuiInset = true
    module_upvr.gui = ScreenGui
    RunService_upvr.RenderStepped:Connect(function() -- Line 22
        debug.profilebegin("WorldMarkerSystem Update")
        for _, v in ipairs(module_upvr._listGroup) do
            if v._enabled then
                v:Update()
            end
        end
        debug.profileend()
    end)
end
return module_upvr