local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1) --[[ Line: 4 | Upvalues: Roact (copy) ]]
	local DamageIndicatorService = require(script.Parent.Parent.DamageIndicatorService)
	local v1 = DamageIndicatorService.add({
		worldPosition = Vector3.new(0, 0, 0),
		lifetime = 30
	})
	local v2 = DamageIndicatorService.add({
		worldPosition = Vector3.new(100, 0, 100),
		color = Color3.new(255/255, 255/255, 0/255),
		strength = 0.1,
		lifetime = 30
	})
	local DamageIndicators = require(script.Parent.DamageIndicators)
	local v3 = Roact.mount(Roact.createElement(DamageIndicators, {
		size = UDim2.new(0.95, 0, 0.95, 0)
	}), p1)
	return function() --[[ Line: 23 | Upvalues: v1 (copy), v2 (copy), Roact (ref), v3 (copy) ]]
		if v1 then
			v1()
		end
		if v2 then
			v2()
		end
		Roact.unmount(v3)
	end
end