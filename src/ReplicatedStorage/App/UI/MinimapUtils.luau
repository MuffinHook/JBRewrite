local MinimapUtils = {
	computeOffsetXY = function(position, screenSize, rangeX, rangeY, centerX, centerZ, canvasWidth, canvasHeight, zoomScale)
		if not screenSize then
			screenSize = Vector2.new(512, 512)
		end
		local scaleFactor = zoomScale * screenSize.Y / canvasHeight
		local scaledCanvasWidth = screenSize.X * scaleFactor
		local scaledCanvasHeight = screenSize.Y * scaleFactor
		local offsetLeft = canvasWidth * scaleFactor - scaledCanvasWidth - (1 - scaleFactor) * screenSize.X
		local offsetTop = canvasHeight * scaleFactor - scaledCanvasHeight - (1 - scaleFactor) * screenSize.Y
		local offsetX = canvasWidth * scaleFactor * (0.5 + (position.X - centerX) / rangeX) - scaledCanvasWidth * 0.5 - 0.5 * (1 - scaleFactor) * screenSize.X
		local offsetY = canvasHeight * scaleFactor * (0.5 + (position.Z - centerZ) / rangeY) - scaledCanvasHeight * 0.5 - 0.5 * (1 - scaleFactor) * screenSize.Y
		if offsetLeft < offsetX then
			offsetX = offsetLeft
		end
		if offsetX < 0 then
			offsetX = 0
		end
		if offsetTop < offsetY then
			offsetY = offsetTop
		end
		if offsetY < 0 then
			offsetY = 0
		end
		return offsetX < 0 or (offsetY < 0 or offsetLeft < offsetX) or offsetTop < offsetY, offsetX, offsetY, scaleFactor
	end
}
function MinimapUtils.computeWorldXY(screenX, screenY, position, screenSize, rangeX, rangeY, centerX, centerZ, canvasWidth, canvasHeight, zoomScale)
	local _, offsetX, offsetY, scaleFactor = MinimapUtils.computeOffsetXY(position, screenSize, rangeX, rangeY, centerX, centerZ, canvasWidth, canvasHeight, zoomScale)
	return ((screenX + offsetX) / canvasWidth / scaleFactor - 0.5) * rangeX + centerX, ((screenY + offsetY) / canvasHeight / scaleFactor - 0.5) * rangeY + centerZ
end
function MinimapUtils.worldToScale(worldX, worldY, minX, minY, rangeX, rangeY)
	return UDim2.fromScale(0.5 + (worldX - minX) / rangeX, 0.5 + (worldY - minY) / rangeY)
end
function MinimapUtils.relativeWorldToScale(relativeX, relativeY, widthSize, heightSize)
	return UDim2.fromScale(relativeX / widthSize, relativeY / heightSize)
end
return MinimapUtils
