local TweenService = game:GetService("TweenService")
local CatmullRomSpline = {}
local CatmullRomSplineMethods = {}
function CatmullRomSpline.new(initialPoints, initialTension)
	local newSpline = {
		Tension = initialTension or 0.5,
		Points = {},
		GlobalPoints = {},
		LengthIterations = 2000,
		LengthIndices = {},
		Length = 0,
		ConnectedSplines = {}
	}
	if initialPoints ~= nil then
		for k, v in pairs(initialPoints) do
			CatmullRomSplineMethods.AddPoint(newSpline, v)
		end
	end
	setmetatable(newSpline, {
		__index = CatmullRomSplineMethods,
		__newindex = function(tableSelf, indexName, newValue)
			error("Cannot add new indices to CatmullRomSplineObject!")
		end
	})
	return newSpline
end
function CatmullRomSplineMethods.ChangeTension(spline, newTension)
	if type(newTension) ~= "number" then
		error("CatmullRomSpline:ChangeTension() expected a number as an input, got " .. tostring(newTension) .. "!")
	end
	spline.Tension = newTension
	CatmullRomSplineMethods.UpdateLength(spline)
end
function CatmullRomSplineMethods.ChangeAllSplineTensions(spline, newTension)
	if type(newTension) ~= "number" then
		error("CatmullRomSpline:ChangeAllSplineTensions() expected a number as an input, got " .. tostring(newTension) .. "!")
	end
	for k, v in pairs((CatmullRomSplineMethods.GetSplines(spline))) do
		v:ChangeTension(newTension)
	end
end
function CatmullRomSplineMethods.AddPoint(spline, point, insertIndex)
	local Points = spline.Points
	local function checkIfPointsMatch(pointValue)
		for k, v in pairs((CatmullRomSplineMethods._getPoints(spline))) do
			if typeof(v) ~= typeof(pointValue) then
				return false
			end
		end
		return true
	end
	if #Points == 4 then
		if typeof(point) == "number" or (typeof(point) == "Vector2" or typeof(point) == "Vector3") then
			if checkIfPointsMatch(point) then
				local connectedSplines = CatmullRomSplineMethods.GetSplines(spline)
				local lastConnectedSpline = connectedSplines[#connectedSplines]
				CatmullRomSplineMethods.ConnectSpline(spline, (CatmullRomSpline.new({
					lastConnectedSpline.Points[2],
					lastConnectedSpline.Points[3],
					lastConnectedSpline.Points[4],
					point
				}, lastConnectedSpline.Tension)))
			end
		elseif point:IsA("BasePart") and checkIfPointsMatch(point.Position) then
			local connectedSplines = CatmullRomSplineMethods.GetSplines(spline)
			local lastConnectedSpline = connectedSplines[#connectedSplines]
			CatmullRomSplineMethods.ConnectSpline(spline, (CatmullRomSpline.new({
				lastConnectedSpline.Points[2],
				lastConnectedSpline.Points[3],
				lastConnectedSpline.Points[4],
				point
			}, lastConnectedSpline.Tension)))
		end
	elseif typeof(point) == "number" or (typeof(point) == "Vector2" or typeof(point) == "Vector3") then
		if checkIfPointsMatch(point) then
			table.insert(Points, insertIndex or #Points + 1, point)
		end
	elseif point:IsA("BasePart") then
		if checkIfPointsMatch(point.Position) then
			table.insert(Points, insertIndex or #Points + 1, point)
		end
	else
		error("Invalid input received for CatmullRomSpline:AddPoint(), expected Vector3 or BasePart, got " .. tostring(point) .. "!")
	end
	if #Points == 4 then
		CatmullRomSplineMethods.UpdateLength(spline)
	end
end
function CatmullRomSplineMethods.RemovePoint(spline, pointToRemove)
	for k, v in pairs((CatmullRomSplineMethods.GetSplines(spline))) do
		local foundIndex = table.find(v.Points, pointToRemove)
		if foundIndex then
			table.remove(v.Points, foundIndex)
		end
	end
end
function CatmullRomSplineMethods._getPoints(spline)
	local pointsList = {}
	for i = 1, #spline.Points do
		pointsList[i] = typeof(spline.Points[i]) == "Instance" and spline.Points[i].Position or spline.Points[i]
	end
	return pointsList
end
function CatmullRomSplineMethods.ConnectSpline(spline, newSpline)
	local Points = newSpline.Points
	local connectedSplines = CatmullRomSplineMethods.GetSplines(spline)
	local lastSplinePoints = connectedSplines[#connectedSplines].Points
	local function checkIfPointsMatch(pointValue)
		for k, v in pairs((CatmullRomSplineMethods._getPoints(spline))) do
			if typeof(v) ~= typeof(pointValue) then
				return false
			end
		end
		return true
	end
	local firstPointValue, pointTypeChecker
	if typeof(lastSplinePoints[1]) == "number" then
		firstPointValue = lastSplinePoints[1]
		pointTypeChecker = checkIfPointsMatch
		if not firstPointValue then
			firstPointValue = lastSplinePoints[1].Position
		end
	else
		if typeof(lastSplinePoints[1]) == "Vector3" then
			firstPointValue = lastSplinePoints[1]
			if firstPointValue then
				firstPointValue = lastSplinePoints[1].Position
			end
		else
			pointTypeChecker = checkIfPointsMatch
			firstPointValue = lastSplinePoints[1].Position
		end
	end
	if not pointTypeChecker(firstPointValue) then
		error("Cannot connect the spline because the splines do not have the same types of points!")
	end
	if lastSplinePoints[2] == Points[1] and (lastSplinePoints[3] == Points[2] and lastSplinePoints[4] == Points[3]) then
		table.insert(spline.ConnectedSplines, newSpline)
		CatmullRomSplineMethods.UpdateLength(spline)
	else
		error("Cannot connect the spline because the splines do not share 3 common points!")
	end
end
function CatmullRomSplineMethods.GetSplines(spline)
	local splinesList = { spline }
	for i = 1, #spline.ConnectedSplines do
		table.insert(splinesList, spline.ConnectedSplines[i])
	end
	return splinesList
end
function CatmullRomSplineMethods.GetSplineAt(spline, targetTime)
	local splinesList = CatmullRomSplineMethods.GetSplines(spline)
	local function percentage(value, minValue, maxValue)
		local reciprocal = 1 / (maxValue - minValue)
		return reciprocal * value - reciprocal * maxValue + 1
	end
	if type(targetTime) ~= "number" then
		error("CatmullRomSpline:GetSplineAt() expected a number as an input, got " .. tostring(targetTime) .. "!")
	end
	if #splinesList == 1 then
		return spline, targetTime
	else
		local splineSegmentSize = 1 / #splinesList
		if targetTime <= 0 then
			return spline, targetTime * splineSegmentSize
		elseif targetTime >= 1 then
			return splinesList[#splinesList], (targetTime - 1) * splineSegmentSize + 1
		else
			local splineIndex = math.ceil(targetTime * #splinesList)
			local splineStartTime = splineIndex * splineSegmentSize
			local normalizedTime = 1 / (splineStartTime - (splineIndex - 1) * splineSegmentSize)
			return splinesList[splineIndex], normalizedTime * targetTime - normalizedTime * splineStartTime + 1
		end
	end
end
function CatmullRomSplineMethods.UpdateLength(spline, yieldFrequency)
	local allPoints = {}
	local sum = 0
	for k, v in pairs((CatmullRomSplineMethods.GetSplines(spline))) do
		local splinePoints = CatmullRomSplineMethods._getPoints(v)
		if #splinePoints ~= 4 then
			error("Cannot get the length of the CatmullRomSpline object, expected 4 control points for all splines, got " .. tostring(#allPoints) .. " points for spline " .. tostring(k) .. "!")
		end
		for k2, pointValue in pairs(splinePoints) do
			table.insert(allPoints, pointValue)
		end
	end
	local LengthIterations = spline.LengthIterations
	local lengthIndexTable = {}
	for i = 1, LengthIterations do
		if yieldFrequency and i % yieldFrequency == 0 then
			task.wait()
		end
		local derivativeValue = CatmullRomSplineMethods.CalculateDerivativeAt(spline, (i - 1) / (LengthIterations - 1))
		sum = if typeof(derivativeValue) == "number" then sum + derivativeValue * (1 / LengthIterations) else sum + derivativeValue.Magnitude * (1 / LengthIterations)
		table.insert(lengthIndexTable, { (i - 1) / (LengthIterations - 1), sum, derivativeValue })
	end
	spline.Length = sum
	spline.LengthIndices = lengthIndexTable
end
function CatmullRomSplineMethods.CalculatePositionAt(spline, parameterT)
	if type(parameterT) ~= "number" then
		error("The given t value in CatmullRomSpline:CalculatePositionAt() was not between 0 and 1, got " .. tostring(parameterT) .. "!")
	end
	local targetSpline, normalizedT = CatmullRomSplineMethods.GetSplineAt(spline, parameterT)
	local controlPoints = CatmullRomSplineMethods._getPoints(targetSpline)
	if #controlPoints ~= 4 then
		error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#controlPoints) .. "), expected 4 points!")
	end
	local Tension = targetSpline.Tension
	return controlPoints[2] + Tension * (controlPoints[3] - controlPoints[1]) * normalizedT + (3 * (controlPoints[3] - controlPoints[2]) - Tension * (controlPoints[4] - controlPoints[2]) - 2 * Tension * (controlPoints[3] - controlPoints[1])) * normalizedT ^ 2 + (-2 * (controlPoints[3] - controlPoints[2]) + Tension * (controlPoints[4] - controlPoints[2]) + Tension * (controlPoints[3] - controlPoints[1])) * normalizedT ^ 3
end
function CatmullRomSplineMethods.CalculatePositionRelativeToLength(spline, targetLength)
	if type(targetLength) ~= "number" then
		error("CatmullRomSpline:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(targetLength) .. "!")
	end
	local Points = spline.Points
	if #Points == 4 then
		local LengthIndices = spline.LengthIndices
		local LengthIterations = spline.LengthIterations
		CatmullRomSplineMethods._getPoints(spline)
		local targetLengthValue = spline.Length * targetLength
		local foundIndexInTable = nil
		local correspondingLengthEntry = nil
		for i, v in ipairs(LengthIndices) do
			if targetLengthValue - v[2] <= 0 or i == #LengthIndices then
				foundIndexInTable = i
				correspondingLengthEntry = v
				break
			end
		end
		local startPosition, endPosition
		if LengthIndices[foundIndexInTable - 1] then
			local prevPosition = CatmullRomSplineMethods.CalculatePositionAt(spline, LengthIndices[foundIndexInTable - 1][1])
			startPosition, endPosition = prevPosition, CatmullRomSplineMethods.CalculatePositionAt(spline, correspondingLengthEntry[1])
		else
			local nextPosition = CatmullRomSplineMethods.CalculatePositionAt(spline, correspondingLengthEntry[1])
			startPosition, endPosition = nextPosition, CatmullRomSplineMethods.CalculatePositionAt(spline, LengthIndices[foundIndexInTable + 1][1])
		end
		if typeof(startPosition) == "number" and typeof(endPosition) == "number" then
			return startPosition + (endPosition - startPosition) * (1 - (correspondingLengthEntry[2] - targetLengthValue) / (endPosition - startPosition))
		else
			return startPosition + (endPosition - startPosition) * (1 - (correspondingLengthEntry[2] - targetLengthValue) / (endPosition - startPosition).Magnitude)
		end
	else
		error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#Points) .. "), expected 4 points!")
	end
end
function CatmullRomSplineMethods.CalculateDerivativeAt(spline, parameterT)
	if type(parameterT) ~= "number" then
		error("The given t value in CatmullRomSpline:CalculateDerivativeAt() was not between 0 and 1, got " .. tostring(parameterT) .. "!")
	end
	local targetSpline, normalizedT = CatmullRomSplineMethods.GetSplineAt(spline, parameterT)
	local controlPoints = CatmullRomSplineMethods._getPoints(targetSpline)
	if #controlPoints ~= 4 then
		error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#controlPoints) .. "), expected 4 points!")
	end
	local Tension = targetSpline.Tension
	return Tension * (controlPoints[3] - controlPoints[1]) + 2 * (3 * (controlPoints[3] - controlPoints[2]) - Tension * (controlPoints[4] - controlPoints[2]) - 2 * Tension * (controlPoints[3] - controlPoints[1])) * normalizedT + 3 * (-2 * (controlPoints[3] - controlPoints[2]) + Tension * (controlPoints[4] - controlPoints[2]) + Tension * (controlPoints[3] - controlPoints[1])) * normalizedT ^ 2
end
function CatmullRomSplineMethods.CalculateDerivativeRelativeToLength(spline, targetLength)
	if type(targetLength) ~= "number" then
		error("CatmullRomSpline:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(targetLength) .. "!")
	end
	local Points = spline.Points
	if #Points == 4 then
		local LengthIndices = spline.LengthIndices
		local LengthIterations = spline.LengthIterations
		CatmullRomSplineMethods._getPoints(spline)
		local targetLengthValue = spline.Length * targetLength
		local foundIndexInTable = nil
		local correspondingLengthEntry = nil
		for i, v in ipairs(LengthIndices) do
			if targetLengthValue - v[2] <= 0 or i == #LengthIndices then
				foundIndexInTable = i
				correspondingLengthEntry = v
				break
			end
		end
		local startDerivative, endDerivative
		if LengthIndices[foundIndexInTable - 1] then
			local prevDerivative = CatmullRomSplineMethods.CalculateDerivativeAt(spline, LengthIndices[foundIndexInTable - 1][1])
			startDerivative, endDerivative = prevDerivative, CatmullRomSplineMethods.CalculateDerivativeAt(spline, correspondingLengthEntry[1])
		else
			local nextDerivative = CatmullRomSplineMethods.CalculateDerivativeAt(spline, correspondingLengthEntry[1])
			startDerivative, endDerivative = nextDerivative, CatmullRomSplineMethods.CalculateDerivativeAt(spline, LengthIndices[foundIndexInTable + 1][1])
		end
		return startDerivative + (endDerivative - startDerivative) * (1 - if typeof(startDerivative) == "number" and typeof(endDerivative) == "number" then if math.abs(endDerivative - startDerivative) > 0 then (correspondingLengthEntry[2] - targetLengthValue) / (endDerivative - startDerivative) else 0 elseif (endDerivative - startDerivative).Magnitude > 0 then (correspondingLengthEntry[2] - targetLengthValue) / (endDerivative - startDerivative).Magnitude else 0)
	end
	error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#Points) .. "), expected 4 points!")
end
function CatmullRomSplineMethods.CreateTween(spline, targetObject, tweenInfo, propertyTable, useRelativeLength)
	if typeof(targetObject) ~= "Instance" then
		error("CatmullRomSplineObject:CreateTween() expected an instance as the first input, got " .. tostring(targetObject) .. "!")
	end
	if typeof(tweenInfo) ~= "TweenInfo" then
		error("CatmullRomSplineObject:CreateTween() expected a TweenInfo object as the second input, got " .. tostring(tweenInfo) .. "!")
	end
	local allPropertiesExist = true
	for k, v in pairs(propertyTable) do
		local propertyExists, propertyValue = pcall(function()
			return targetObject[v]
		end)
		if not propertyExists or propertyValue == nil then
			allPropertiesExist = false
		end
	end
	if not allPropertiesExist then
		error("CatmullRomSplineObject:CreateTween() was given properties in the property table that do not belong to the instance!")
	end
	local tweenProgress = Instance.new("NumberValue")
	local createdTween = TweenService:Create(tweenProgress, tweenInfo, {
		Value = 1
	})
	local valueChangedConnection = nil
	createdTween.Changed:Connect(function(propertyName)
		if propertyName == "PlaybackState" and createdTween.PlaybackState == Enum.PlaybackState.Playing then
			valueChangedConnection = tweenProgress.Changed:Connect(function(currentProgress)
				for k, v in pairs(propertyTable) do
					local calculatedPosition = useRelativeLength and CatmullRomSplineMethods.CalculatePositionRelativeToLength(spline, currentProgress) or CatmullRomSplineMethods.CalculatePositionAt(spline, currentProgress)
					local calculatedDerivative = useRelativeLength and CatmullRomSplineMethods.CalculateDerivativeRelativeToLength(spline, currentProgress) or CatmullRomSplineMethods.CalculateDerivativeAt(spline, currentProgress)
					local finalValue = typeof(calculatedPosition) == "Vector3" and typeof(calculatedDerivative) == "Vector3" and CFrame.new(calculatedPosition, calculatedPosition + calculatedDerivative) or calculatedPosition
					if typeof(targetObject[v]) == "number" or (typeof(targetObject[v] == "Vector2") or typeof(targetObject[v]) == "CFrame") then
						targetObject[v] = finalValue
					else
						if typeof(targetObject[v] == "Vector3") then
							targetObject[v] = finalValue.Position
						else
							error("CatmullRomSplineObject:CreateTween() could not set the value of the instance property " .. tostring(v) .. ", not a numerical value!")
						end
					end
				end
			end)
		elseif propertyName == "PlaybackState" and valueChangedConnection ~= nil then
			valueChangedConnection:Disconnect()
			valueChangedConnection = nil
		end
	end)
	return createdTween
end
return CatmullRomSpline
