-- Reviewed by Claude
return {
	setDist = function(p1, p2)
		assert(p1:IsA("Model") or p1:IsA("BasePart"))
		assert(p1:HasTag("CircleAction"))
		p1:SetAttribute("CircleActionDist", p2)
	end,
	setDuration = function(p1, p2)
		assert(p1:IsA("Model") or p1:IsA("BasePart"))
		assert(p1:HasTag("CircleAction"))
		p1:SetAttribute("CircleActionDuration", p2)
	end,
	setText = function(p1, p2)
		assert(p1:IsA("Model") or p1:IsA("BasePart"))
		assert(p1:HasTag("CircleAction"))
		p1:SetAttribute("CircleActionText", p2)
	end,
	setDisabled = function(p1, p2)
		assert(p1:IsA("Model") or p1:IsA("BasePart"))
		assert(p1:HasTag("CircleAction"))
		p1:SetAttribute("CircleActionDisabled", p2)
	end,
	getDisabled = function(p1)
		assert(p1:IsA("Model") or p1:IsA("BasePart"))
		assert(p1:HasTag("CircleAction"))
		return p1:GetAttribute("CircleActionDisabled") == true
	end,
	getTagPart = function(p1)
		assert(p1:IsA("Model") or p1:IsA("BasePart"))
		assert(p1:HasTag("CircleAction"))
		if p1:IsA("Model") then
			return p1.PrimaryPart
		else
			assert(p1:IsA("BasePart"))
			return p1
		end
	end
}