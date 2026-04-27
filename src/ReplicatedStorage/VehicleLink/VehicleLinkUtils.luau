return {
	getPrimaryPart = function(vehicle)
		return vehicle:FindFirstChild("BoundingBox") or vehicle.PrimaryPart
	end,
	setMaxLinkLength = function(vehicle, value)
		vehicle:SetAttribute("MaxLinkLength", value)
	end,
	getMaxLinkLength = function(vehicle)
		return vehicle:GetAttribute("MaxLinkLength")
	end,
	setIsLinked = function(vehicle, value)
		vehicle:SetAttribute("IsLinked", value)
	end,
	getIsLinked = function(vehicle)
		return vehicle:GetAttribute("IsLinked")
	end,
	getIsLinkedChangedSignal = function(vehicle)
		return vehicle:GetAttributeChangedSignal("IsLinked")
	end,
	setDisabled = function(vehicle, value)
		vehicle:SetAttribute("LinkDisabled", value)
	end,
	getDisabled = function(vehicle)
		return vehicle:GetAttribute("LinkDisabled")
	end,
	getDisabledChangedSignal = function(vehicle)
		return vehicle:GetAttributeChangedSignal("LinkDisabled")
	end
}
