return {
    getPrimaryPart = function(arg1) -- Line 2, Named "getPrimaryPart"
        local BoundingBox = arg1:FindFirstChild("BoundingBox")
        if not BoundingBox then
            BoundingBox = arg1.PrimaryPart
        end
        return BoundingBox
    end;
    setMaxLinkLength = function(arg1, arg2) -- Line 5, Named "setMaxLinkLength"
        arg1:SetAttribute("MaxLinkLength", arg2)
    end;
    getMaxLinkLength = function(arg1) -- Line 8, Named "getMaxLinkLength"
        return arg1:GetAttribute("MaxLinkLength")
    end;
    setIsLinked = function(arg1, arg2) -- Line 11, Named "setIsLinked"
        arg1:SetAttribute("IsLinked", arg2)
    end;
    getIsLinked = function(arg1) -- Line 14, Named "getIsLinked"
        return arg1:GetAttribute("IsLinked")
    end;
    getIsLinkedChangedSignal = function(arg1) -- Line 17, Named "getIsLinkedChangedSignal"
        return arg1:GetAttributeChangedSignal("IsLinked")
    end;
    setDisabled = function(arg1, arg2) -- Line 20, Named "setDisabled"
        arg1:SetAttribute("LinkDisabled", arg2)
    end;
    getDisabled = function(arg1) -- Line 23, Named "getDisabled"
        return arg1:GetAttribute("LinkDisabled")
    end;
    getDisabledChangedSignal = function(arg1) -- Line 26, Named "getDisabledChangedSignal"
        return arg1:GetAttributeChangedSignal("LinkDisabled")
    end;
}