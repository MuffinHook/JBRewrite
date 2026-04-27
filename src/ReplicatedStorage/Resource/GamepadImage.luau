local spriteSheetCache = {}
local gamepadImageModule = {}
for spriteSheetName, spriteSheet in pairs(script.Spritesheets:GetChildren()) do
	spriteSheetCache[spriteSheet.Name] = {}
	for spriteName, spriteInstance in pairs(spriteSheet:GetChildren()) do
		spriteSheetCache[spriteSheet.Name][spriteInstance.Name] = require(spriteInstance).new()
	end
end
local function getImageInstance(elementType, enumOrName, gamepadStyle)
	if type(enumOrName) == "userdata" then
		enumOrName = string.sub(tostring(enumOrName), 14)
	end
	local spriteSheetStyle = spriteSheetCache.XboxOne[gamepadStyle]
	if spriteSheetStyle then
		return spriteSheetStyle:GetSprite(elementType, enumOrName)
	end
	warn("Could not find style: " .. gamepadStyle)
end
function gamepadImageModule.GetImageLabel(self, elementType, gamepadStyle, unused)
	return getImageInstance("ImageLabel", elementType, gamepadStyle)
end
function gamepadImageModule.GetImageButton(self, elementType, gamepadStyle, unused)
	return getImageInstance("ImageButton", elementType, gamepadStyle)
end
return gamepadImageModule
