local RunService = game:GetService("RunService")
local AnimationModule = {}
AnimationModule.__index = AnimationModule
function AnimationModule.new(config)
	local animationInstance = setmetatable({}, AnimationModule)
	assert(config.Duration)
	local Duration_2 = config.Duration
	animationInstance.OnUpdate = config.OnUpdate
	animationInstance.OnComplete = config.OnComplete
	animationInstance.OnCancel = config.OnCancel
	local startTime = tick()
	animationInstance.Event = RunService.Heartbeat:Connect(function(elapsedTime)
		local delta = tick() - startTime
		local isComplete = Duration_2 <= delta
		if isComplete then
			delta = Duration_2
		end
		if animationInstance.OnUpdate then
			local progress = delta / Duration_2
			if progress ~= progress then
				progress = 1
			end
			animationInstance.OnUpdate(elapsedTime, delta, progress)
		end
		if isComplete then
			animationInstance.Event:Disconnect()
			animationInstance.Event = nil
			if animationInstance.OnComplete then
				animationInstance.OnComplete()
			end
		end
	end)
	return animationInstance
end
function AnimationModule.Destroy(animation)
	if animation.Event then
		animation.Event:Disconnect()
		animation.Event = nil
		if animation.OnCancel then
			animation.OnCancel()
		end
		return true
	else
		return false
	end
end
return AnimationModule
