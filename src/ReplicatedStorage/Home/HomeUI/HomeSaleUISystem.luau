local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {}
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Window_upvr = require(ReplicatedStorage_upvr.Module.Window.Window)
local GameUtil_upvr = require(ReplicatedStorage_upvr.Game.GameUtil)
function module_upvr.init() -- Line 11
    local HomeSaleGui = ReplicatedStorage_upvr.StarterGui:FindFirstChild("HomeSaleGui")
    HomeSaleGui.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.gui = HomeSaleGui
    local any_new_result1_2 = Window_upvr.new()
    any_new_result1_2:GetOnOpenedSignal():Connect(module_upvr._open)
    any_new_result1_2:GetOnClosedSignal():Connect(module_upvr._close)
    module_upvr._window = any_new_result1_2
    GameUtil_upvr.getCenterWindowGroup():Add(any_new_result1_2)
end
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local UIUtil_upvr = require(ReplicatedStorage_upvr.Game.UIUtil)
function module_upvr._open() -- Line 22
    local var10_upvr
    if module_upvr._maid ~= nil then
        var10_upvr = false
    else
        var10_upvr = true
    end
    assert(var10_upvr)
    local any_new_result1 = Maid_upvr.new()
    var10_upvr = module_upvr
    var10_upvr._maid = any_new_result1
    var10_upvr = module_upvr
    var10_upvr = var10_upvr.gui
    var10_upvr.Enabled = true
    any_new_result1:GiveTask(function() -- Line 29
        var10_upvr.Enabled = false
    end)
    UIUtil_upvr.selectIfGamepad(var10_upvr.Container.ButtonContainer.YesContainer.Button)
end
function module_upvr._close() -- Line 35
    local var13
    if module_upvr._maid == nil then
        var13 = false
    else
        var13 = true
    end
    assert(var13)
    var13 = module_upvr
    var13._maid = nil
    var13 = module_upvr._maid:Destroy
    var13()
end
function module_upvr.open() -- Line 41
    module_upvr._window:Open()
end
function module_upvr.close() -- Line 44
    module_upvr._window:Close()
end
function module_upvr.isOpen() -- Line 47
    return module_upvr._window:IsOpen()
end
function module_upvr.getOnClosedSignal() -- Line 50
    return module_upvr._window:GetOnClosedSignal()
end
function module_upvr.getOnClickYesSignal() -- Line 53
    return module_upvr.gui.Container.ButtonContainer.YesContainer.Button.MouseButton1Down
end
function module_upvr.getOnClickNoSignal() -- Line 57
    return module_upvr.gui.Container.ButtonContainer.NoContainer.Button.MouseButton1Down
end
local Format_upvr = require(ReplicatedStorage_upvr.Module.Format)
function module_upvr.setPrice(arg1) -- Line 61
    if arg1 == nil then
    else
    end
    assert(true)
    if type(arg1) ~= "number" then
    else
    end
    assert(true)
    module_upvr.gui.Container.PriceContainer.TextLabel.Text = Format_upvr.Currency(arg1)
end
return module_upvr