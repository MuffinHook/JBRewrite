-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(target)
	local DamageIndicatorService = require(script.Parent.Parent.DamageIndicatorService)
	local removeIndicator1 = DamageIndicatorService.add({
		worldPosition = Vector3.new(0, 0, 0),
		lifetime = 30
	})
	local removeIndicator2 = DamageIndicatorService.add({
		worldPosition = Vector3.new(100, 0, 100),
		color = Color3.new(255/255, 255/255, 0/255),
		strength = 0.1,
		lifetime = 30
	})
	local DamageIndicators = require(script.Parent.DamageIndicators)
	local mountedComponent = Roact.mount(Roact.createElement(DamageIndicators, {
		size = UDim2.new(0.95, 0, 0.95, 0)
	}), target)
	return function()
		if removeIndicator1 then
			removeIndicator1()
		end
		if removeIndicator2 then
			removeIndicator2()
		end
		Roact.unmount(mountedComponent)
	end
end
