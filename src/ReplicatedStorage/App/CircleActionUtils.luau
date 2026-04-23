return {
	setDist = function(p1, p2) --[[ Name: setDist | Line: 2 ]]
		assert(p1:IsA("Model") or p1:IsA("BasePart"))
		assert(p1:HasTag("CircleAction"))
		p1:SetAttribute("CircleActionDist", p2)
	end,
	setDuration = function(p1, p2) --[[ Name: setDuration | Line: 7 ]]
		assert(p1:IsA("Model") or p1:IsA("BasePart"))
		assert(p1:HasTag("CircleAction"))
		p1:SetAttribute("CircleActionDuration", p2)
	end,
	setText = function(p1, p2) --[[ Name: setText | Line: 12 ]]
		assert(p1:IsA("Model") or p1:IsA("BasePart"))
		assert(p1:HasTag("CircleAction"))
		p1:SetAttribute("CircleActionText", p2)
	end,
	setDisabled = function(p1, p2) --[[ Name: setDisabled | Line: 17 ]]
		assert(p1:IsA("Model") or p1:IsA("BasePart"))
		assert(p1:HasTag("CircleAction"))
		p1:SetAttribute("CircleActionDisabled", p2)
	end,
	getDisabled = function(p1) --[[ Name: getDisabled | Line: 22 ]]
		assert(p1:IsA("Model") or p1:IsA("BasePart"))
		assert(p1:HasTag("CircleAction"))
		return p1:GetAttribute("CircleActionDisabled") == true
	end,
	getTagPart = function(p1) --[[ Name: getTagPart | Line: 27 ]]
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