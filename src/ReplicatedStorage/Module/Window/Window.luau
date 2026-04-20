local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local module_upvr = {
    __ClassName = "Window";
}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr.new() -- Line 8
    local module = {}
    setmetatable(module, module_upvr)
    module._maid = Maid_upvr.new()
    module._isOpen = false
    module._beforeOpenFun = nil
    return module
end
function module_upvr.GetOnOpenedSignal(arg1) -- Line 19
    if not arg1._onOpened then
        arg1._onOpened = Signal_upvr.new()
        arg1._maid:GiveTask(arg1._onOpened)
    end
    return arg1._onOpened
end
function module_upvr.GetOnClosedSignal(arg1) -- Line 26
    if not arg1._onClosed then
        arg1._onClosed = Signal_upvr.new()
        arg1._maid:GiveTask(arg1._onClosed)
    end
    return arg1._onClosed
end
function module_upvr.Open(arg1) -- Line 33
    assert(not arg1._isOpen)
    arg1._isOpen = true
    if arg1._beforeOpenFun then
        arg1:_beforeOpenFun()
    end
    if arg1._onOpened then
        arg1._onOpened:Fire()
    end
end
function module_upvr.Close(arg1) -- Line 43
    assert(arg1._isOpen)
    arg1._isOpen = false
    if arg1._onClosed then
        arg1._onClosed:Fire()
    end
end
function module_upvr.IsOpen(arg1) -- Line 50
    return arg1._isOpen
end
function module_upvr.Destroy(arg1) -- Line 53
    assert(arg1._maid)
    if arg1:IsOpen() then
        arg1:Close()
    end
    arg1._maid = nil
    arg1._maid:Destroy()
end
return module_upvr