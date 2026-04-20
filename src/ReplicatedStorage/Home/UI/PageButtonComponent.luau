local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local ButtonComponent_upvr = require(script.Parent.ButtonComponent)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
return function(arg1) -- Line 6, Named "pageButtonComponent"
    local var5
    if arg1.selected then
        var5 = arg1.backgroundColor
    else
        var5 = ColorUtils_upvr
        var5 = var5.brightenBy(arg1.backgroundColor, -0.3)
    end
    return ButtonComponent_upvr(Dictionary_upvr.merge(arg1, {
        cornerRadius = UDim.new(1, 0);
        backgroundColor = var5;
    }))
end