local InputUtilsModule = {
	isGamepadKeyCode = function(keyCode)
		local keycodeName = keyCode.Name
		return (keycodeName:find("Button") or (keycodeName:find("Thumbstick") or keycodeName:find("DPad"))) and true or false
	end
}
function InputUtilsModule.getBestKeyCode(keyCodes, inputType)
	if keyCodes and inputType then
		local _ = inputType == Enum.UserInputType.Touch
	end
end
return InputUtilsModule