local PIDController = {}
PIDController.__index = PIDController
function PIDController.new(initialTarget, proportionalGain, integralGain, derivativeGain)
	local target = initialTarget or 0
	local instance = setmetatable({}, PIDController)
	instance.target = target
	instance.kP = proportionalGain or 1
	instance.kI = integralGain or 0
	instance.kD = derivativeGain or 0
	instance._lastErr = target * 0
	instance._integralErr = target * 0
	return instance
end
function PIDController.Update(controller, measurement, deltaTime)
	local currentError = controller.target - measurement
	controller._integralErr = controller._integralErr + currentError * deltaTime
	local derivativeError = (currentError - controller._lastErr) / deltaTime
	controller._lastErr = currentError
	return controller.kP * currentError + controller.kI * controller._integralErr + controller.kD * derivativeError
end
function PIDController.SetTarget(controller, targetValue)
	controller.target = targetValue
end
function PIDController.Reset(controller)
	controller._lastErr = controller._lastErr * 0
	controller._integralErr = controller._integralErr * 0
end
return PIDController
