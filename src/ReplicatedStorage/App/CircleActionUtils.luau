return {
	setDist = function(target, value)
		assert(target:IsA("Model") or target:IsA("BasePart"))
		assert(target:HasTag("CircleAction"))
		target:SetAttribute("CircleActionDist", value)
	end,
	setDuration = function(target, value)
		assert(target:IsA("Model") or target:IsA("BasePart"))
		assert(target:HasTag("CircleAction"))
		target:SetAttribute("CircleActionDuration", value)
	end,
	setText = function(target, value)
		assert(target:IsA("Model") or target:IsA("BasePart"))
		assert(target:HasTag("CircleAction"))
		target:SetAttribute("CircleActionText", value)
	end,
	setDisabled = function(target, value)
		assert(target:IsA("Model") or target:IsA("BasePart"))
		assert(target:HasTag("CircleAction"))
		target:SetAttribute("CircleActionDisabled", value)
	end,
	getDisabled = function(target)
		assert(target:IsA("Model") or target:IsA("BasePart"))
		assert(target:HasTag("CircleAction"))
		return target:GetAttribute("CircleActionDisabled") == true
	end,
	getTagPart = function(target)
		assert(target:IsA("Model") or target:IsA("BasePart"))
		assert(target:HasTag("CircleAction"))
		if target:IsA("Model") then
			return target.PrimaryPart
		else
			assert(target:IsA("BasePart"))
			return target
		end
	end
}
