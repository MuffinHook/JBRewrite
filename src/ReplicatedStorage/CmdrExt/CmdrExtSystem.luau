local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Players_upvr = game:GetService("Players")
local var3_upvw
local var4_upvw
local var5_upvw = false
local any_new_result1_upvr = require(ReplicatedStorage_upvr.Std.Signal).new()
local module_upvr = {}
local CmdrGuiUtils_upvr = require(ReplicatedStorage_upvr.CmdrExt.CmdrGuiUtils)
function module_upvr.init() -- Line 15
    var3_upvw = CmdrGuiUtils_upvr.frame(Players_upvr.LocalPlayer)
    local ObjectValue = Instance.new("ObjectValue")
    ObjectValue.Name = "CmdrFrameValue"
    ObjectValue.Value = var3_upvw
    ObjectValue.Parent = Players_upvr.LocalPlayer
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 1000
    ScreenGui.Parent = Players_upvr.LocalPlayer.PlayerGui
    CmdrGuiUtils_upvr.autocomplete(ScreenGui)
    task.spawn(module_upvr._load, ScreenGui)
end
local CmdrPermission_upvr = require(script.Parent.CmdrPermission)
function module_upvr._load(arg1) -- Line 32
    local ObjectValue_2 = Instance.new("ObjectValue")
    ObjectValue_2.Name = "CmdrAutocompleteGuiValue"
    ObjectValue_2.Value = arg1
    ObjectValue_2.Parent = Players_upvr.LocalPlayer
    var4_upvw = require(ReplicatedStorage_upvr:WaitForChild("CmdrClient"))
    var4_upvw:SetActivationKeys({})
    var4_upvw:SetHideOnLostFocus(false)
    var4_upvw:SetPlaceName("jb")
    any_new_result1_upvr:Fire()
    var5_upvw = true
    local TextBox_upvr = var3_upvw.Entry.TextBox
    TextBox_upvr:GetPropertyChangedSignal("Text"):Connect(function() -- Line 47
        local var16
        if var16 and not TextBox_upvr.Text:gsub("^%s+", ""):sub(#var16.Name + 1, #var16.Name + 1):match("%s") then
            var16 = nil
        end
        if var16 and var16.Group and not CmdrPermission_upvr.groupAllowed(Players_upvr.LocalPlayer, var16.Group) then
            TextBox_upvr.Text = ""
        end
    end)
end
local Promise_upvr = require(ReplicatedStorage_upvr.Std.Promise)
function module_upvr.promiseCmdr() -- Line 62
    if var5_upvw then
        return Promise_upvr.resolve(var4_upvw, var3_upvw)
    end
    return Promise_upvr.fromEvent(any_new_result1_upvr):andThen(function() -- Line 66
        return var4_upvw, var3_upvw
    end)
end
function module_upvr.mount() -- Line 71
end
return module_upvr