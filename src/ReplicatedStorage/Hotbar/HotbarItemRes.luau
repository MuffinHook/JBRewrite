local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
local Players_upvr = game:GetService("Players")
local Utils_upvr = require(ReplicatedStorage.EzUi.Utils)
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
function module_upvr.init() -- Line 7
    local HotbarGui_upvr = script.Parent.Res.HotbarGui
    HotbarGui_upvr.Parent = Players_upvr.LocalPlayer.PlayerGui
    HotbarGui_upvr.DisplayOrder = 11
    module_upvr.gui = HotbarGui_upvr
    HotbarGui_upvr.Container.Item:Destroy()
    module_upvr.presetFrame = HotbarGui_upvr.Container.Item:Clone()
    local function updateSize() -- Line 17
        if Utils_upvr.isSmallScreen() then
            HotbarGui_upvr.Container.Size = UDim2.new(0.7, 0, 1, 0)
            HotbarGui_upvr.UIPadding.PaddingBottom = UDim.new(0.06, 0)
        else
            if InputUtils_upvr.isTouch() then
                HotbarGui_upvr.Container.Size = UDim2.new(0.7, 0, 1, 0)
                HotbarGui_upvr.UIPadding.PaddingBottom = UDim.new(0.01, 0)
                return
            end
            HotbarGui_upvr.Container.Size = UDim2.new(0.4, 0, 1, 0)
            HotbarGui_upvr.UIPadding.PaddingBottom = UDim.new(0.01, 0)
        end
    end
    Utils_upvr.getViewportSizeChangedSignal():Connect(updateSize)
    updateSize()
end
return module_upvr