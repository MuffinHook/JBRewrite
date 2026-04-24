-- Reviewed by Claude
return {
	getPrimaryPart = function(p1)
		return p1:FindFirstChild("BoundingBox") or p1.PrimaryPart
	end,
	setMaxLinkLength = function(p1, p2)
		p1:SetAttribute("MaxLinkLength", p2)
	end,
	getMaxLinkLength = function(p1)
		return p1:GetAttribute("MaxLinkLength")
	end,
	setIsLinked = function(p1, p2)
		p1:SetAttribute("IsLinked", p2)
	end,
	getIsLinked = function(p1)
		return p1:GetAttribute("IsLinked")
	end,
	getIsLinkedChangedSignal = function(p1)
		return p1:GetAttributeChangedSignal("IsLinked")
	end,
	setDisabled = function(p1, p2)
		p1:SetAttribute("LinkDisabled", p2)
	end,
	getDisabled = function(p1)
		return p1:GetAttribute("LinkDisabled")
	end,
	getDisabledChangedSignal = function(p1)
		return p1:GetAttributeChangedSignal("LinkDisabled")
	end
}
