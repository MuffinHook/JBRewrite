-- Reviewed by Claude
local TweenService = game:GetService("TweenService")
local t = {}
local t2 = {}
function t.new(p1, p2)
	local t = {
		Tension = p2 or 0.5,
		Points = {},
		GlobalPoints = {},
		LengthIterations = 2000,
		LengthIndices = {},
		Length = 0,
		ConnectedSplines = {}
	}
	if p1 ~= nil then
		for k, v in pairs(p1) do
			t2.AddPoint(t, v)
		end
	end
	setmetatable(t, {
		__index = t2,
		__newindex = function(p1, p2, p3)
			error("Cannot add new indices to CatmullRomSplineObject!")
		end
	})
	return t
end
function t2.ChangeTension(p1, p2)
	if type(p2) ~= "number" then
		error("CatmullRomSpline:ChangeTension() expected a number as an input, got " .. tostring(p2) .. "!")
	end
	p1.Tension = p2
	t2.UpdateLength(p1)
end
function t2.ChangeAllSplineTensions(p1, p2)
	if type(p2) ~= "number" then
		error("CatmullRomSpline:ChangeAllSplineTensions() expected a number as an input, got " .. tostring(p2) .. "!")
	end
	for k, v in pairs((t2.GetSplines(p1))) do
		v:ChangeTension(p2)
	end
end
function t2.AddPoint(p1, p2, p3)
	local Points = p1.Points
	local function checkIfPointsMatch(p12)
		for k, v in pairs((t2._getPoints(p1))) do
			if typeof(v) ~= typeof(p12) then
				return false
			end
		end
		return true
	end
	if #Points == 4 then
		if typeof(p2) == "number" or (typeof(p2) == "Vector2" or typeof(p2) == "Vector3") then
			if checkIfPointsMatch(p2) then
				local instance = t2.GetSplines(p1)
				local table2 = instance[#instance]
				t2.ConnectSpline(p1, (t.new({
					table2.Points[2],
					table2.Points[3],
					table2.Points[4],
					p2
				}, table2.Tension)))
			end
		elseif p2:IsA("BasePart") and checkIfPointsMatch(p2.Position) then
			local var4 = t2.GetSplines(p1)
			local var5 = var4[#var4]
			t2.ConnectSpline(p1, (t.new({
				var5.Points[2],
				var5.Points[3],
				var5.Points[4],
				p2
			}, var5.Tension)))
		end
	elseif typeof(p2) == "number" or (typeof(p2) == "Vector2" or typeof(p2) == "Vector3") then
		if checkIfPointsMatch(p2) then
			table.insert(Points, p3 or #Points + 1, p2)
		end
	elseif p2:IsA("BasePart") then
		if checkIfPointsMatch(p2.Position) then
			table.insert(Points, p3 or #Points + 1, p2)
		end
	else
		error("Invalid input received for CatmullRomSpline:AddPoint(), expected Vector3 or BasePart, got " .. tostring(p2) .. "!")
	end
	if #Points == 4 then
		t2.UpdateLength(p1)
	end
end
function t2.RemovePoint(p1, p2)
	for k, v in pairs((t2.GetSplines(p1))) do
		local table2 = table.find(v.Points, p2)
		if table2 then
			table.remove(v.Points, table2)
		end
	end
end
function t2._getPoints(p1)
	local t = {}
	for i = 1, #p1.Points do
		t[i] = typeof(p1.Points[i]) == "Instance" and p1.Points[i].Position or p1.Points[i]
	end
	return t
end
function t2.ConnectSpline(p1, p2)
	local Points = p2.Points
	local instance = t2.GetSplines(p1)
	local Points_2 = instance[#instance].Points
	local function checkIfPointsMatch(p12)
		for k, v in pairs((t2._getPoints(p1))) do
			if typeof(v) ~= typeof(p12) then
				return false
			end
		end
		return true
	end
	local var3, var4
	if typeof(Points_2[1]) == "number" then
		var3 = Points_2[1]
		var4 = checkIfPointsMatch
		if not var3 then
			var3 = Points_2[1].Position
		end
	else
		if typeof(Points_2[1]) == "Vector3" then
			var3 = Points_2[1]
			if var3 then
				var3 = Points_2[1].Position
			end
		else
			var4 = checkIfPointsMatch
			var3 = Points_2[1].Position
		end
	end
	if not var4(var3) then
		error("Cannot connect the spline because the splines do not have the same types of points!")
	end
	if Points_2[2] == Points[1] and (Points_2[3] == Points[2] and Points_2[4] == Points[3]) then
		table.insert(p1.ConnectedSplines, p2)
		t2.UpdateLength(p1)
	else
		error("Cannot connect the spline because the splines do not share 3 common points!")
	end
end
function t2.GetSplines(p1)
	local t = { p1 }
	for i = 1, #p1.ConnectedSplines do
		table.insert(t, p1.ConnectedSplines[i])
	end
	return t
end
function t2.GetSplineAt(p1, p2)
	local instance = t2.GetSplines(p1)
	local function percentage(p1, p2, p3)
		local instance = 1 / (p3 - p2)
		return instance * p1 - instance * p3 + 1
	end
	if type(p2) ~= "number" then
		error("CatmullRomSpline:GetSplineAt() expected a number as an input, got " .. tostring(p2) .. "!")
	end
	if #instance == 1 then
		return p1, p2
	else
		local table2 = 1 / #instance
		if p2 <= 0 then
			return p1, p2 * table2
		elseif p2 >= 1 then
			return instance[#instance], (p2 - 1) * table2 + 1
		else
			local var3 = math.ceil(p2 * #instance)
			local var4 = var3 * table2
			local var5 = 1 / (var4 - (var3 - 1) * table2)
			return instance[var3], var5 * p2 - var5 * var4 + 1
		end
	end
end
function t2.UpdateLength(p1, p2)
	local t = {}
	local sum = 0
	for k, v in pairs((t2.GetSplines(p1))) do
		local table2 = t2._getPoints(v)
		if #table2 ~= 4 then
			error("Cannot get the length of the CatmullRomSpline object, expected 4 control points for all splines, got " .. tostring(#t) .. " points for spline " .. tostring(k) .. "!")
		end
		for k2, var3 in pairs(table2) do
			table.insert(t, var3)
		end
	end
	local LengthIterations = p1.LengthIterations
	local t3 = {}
	for i = 1, LengthIterations do
		if p2 and i % p2 == 0 then
			task.wait()
		end
		local var3 = t2.CalculateDerivativeAt(p1, (i - 1) / (LengthIterations - 1))
		sum = if typeof(var3) == "number" then sum + var3 * (1 / LengthIterations) else sum + var3.Magnitude * (1 / LengthIterations)
		table.insert(t3, { (i - 1) / (LengthIterations - 1), sum, var3 })
	end
	p1.Length = sum
	p1.LengthIndices = t3
end
function t2.CalculatePositionAt(p1, p2)
	if type(p2) ~= "number" then
		error("The given t value in CatmullRomSpline:CalculatePositionAt() was not between 0 and 1, got " .. tostring(p2) .. "!")
	end
	local instance, table2 = t2.GetSplineAt(p1, p2)
	local var3 = t2._getPoints(instance)
	if #var3 ~= 4 then
		error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#var3) .. "), expected 4 points!")
	end
	local Tension = instance.Tension
	return var3[2] + Tension * (var3[3] - var3[1]) * table2 + (3 * (var3[3] - var3[2]) - Tension * (var3[4] - var3[2]) - 2 * Tension * (var3[3] - var3[1])) * table2 ^ 2 + (-2 * (var3[3] - var3[2]) + Tension * (var3[4] - var3[2]) + Tension * (var3[3] - var3[1])) * table2 ^ 3
end
function t2.CalculatePositionRelativeToLength(p1, p2)
	if type(p2) ~= "number" then
		error("CatmullRomSpline:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(p2) .. "!")
	end
	local Points = p1.Points
	if #Points == 4 then
		local LengthIndices = p1.LengthIndices
		local LengthIterations = p1.LengthIterations
		t2._getPoints(p1)
		local instance = p1.Length * p2
		local table2 = nil
		local var3 = nil
		for i, v in ipairs(LengthIndices) do
			if instance - v[2] <= 0 or i == #LengthIndices then
				table2 = i
				var3 = v
				break
			end
		end
		local var4, var5
		if LengthIndices[table2 - 1] then
			local var6 = t2.CalculatePositionAt(p1, LengthIndices[table2 - 1][1])
			var4, var5 = var6, t2.CalculatePositionAt(p1, var3[1])
		else
			local var8 = t2.CalculatePositionAt(p1, var3[1])
			var4, var5 = var8, t2.CalculatePositionAt(p1, LengthIndices[table2 + 1][1])
		end
		if typeof(var4) == "number" and typeof(var5) == "number" then
			return var4 + (var5 - var4) * (1 - (var3[2] - instance) / (var5 - var4))
		else
			return var4 + (var5 - var4) * (1 - (var3[2] - instance) / (var5 - var4).Magnitude)
		end
	else
		error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#Points) .. "), expected 4 points!")
	end
end
function t2.CalculateDerivativeAt(p1, p2)
	if type(p2) ~= "number" then
		error("The given t value in CatmullRomSpline:CalculateDerivativeAt() was not between 0 and 1, got " .. tostring(p2) .. "!")
	end
	local instance, table2 = t2.GetSplineAt(p1, p2)
	local var3 = t2._getPoints(instance)
	if #var3 ~= 4 then
		error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#var3) .. "), expected 4 points!")
	end
	local Tension = instance.Tension
	return Tension * (var3[3] - var3[1]) + 2 * (3 * (var3[3] - var3[2]) - Tension * (var3[4] - var3[2]) - 2 * Tension * (var3[3] - var3[1])) * table2 + 3 * (-2 * (var3[3] - var3[2]) + Tension * (var3[4] - var3[2]) + Tension * (var3[3] - var3[1])) * table2 ^ 2
end
function t2.CalculateDerivativeRelativeToLength(p1, p2)
	if type(p2) ~= "number" then
		error("CatmullRomSpline:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(p2) .. "!")
	end
	local Points = p1.Points
	if #Points == 4 then
		local LengthIndices = p1.LengthIndices
		local LengthIterations = p1.LengthIterations
		t2._getPoints(p1)
		local instance = p1.Length * p2
		local table2 = nil
		local var3 = nil
		for i, v in ipairs(LengthIndices) do
			if instance - v[2] <= 0 or i == #LengthIndices then
				table2 = i
				var3 = v
				break
			end
		end
		local var4, var5
		if LengthIndices[table2 - 1] then
			local var6 = t2.CalculateDerivativeAt(p1, LengthIndices[table2 - 1][1])
			var4, var5 = var6, t2.CalculateDerivativeAt(p1, var3[1])
		else
			local var8 = t2.CalculateDerivativeAt(p1, var3[1])
			var4, var5 = var8, t2.CalculateDerivativeAt(p1, LengthIndices[table2 + 1][1])
		end
		return var4 + (var5 - var4) * (1 - if typeof(var4) == "number" and typeof(var5) == "number" then if math.abs(var5 - var4) > 0 then (var3[2] - instance) / (var5 - var4) else 0 elseif (var5 - var4).Magnitude > 0 then (var3[2] - instance) / (var5 - var4).Magnitude else 0)
	end
	error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#Points) .. "), expected 4 points!")
end
function t2.CreateTween(p1, p2, p3, p4, p5)
	if typeof(p2) ~= "Instance" then
		error("CatmullRomSplineObject:CreateTween() expected an instance as the first input, got " .. tostring(p2) .. "!")
	end
	if typeof(p3) ~= "TweenInfo" then
		error("CatmullRomSplineObject:CreateTween() expected a TweenInfo object as the second input, got " .. tostring(p3) .. "!")
	end
	local instance = true
	for k, v in pairs(p4) do
		local table2, var3 = pcall(function()
			return p2[v]
		end)
		if not table2 or var3 == nil then
			instance = false
		end
	end
	if not instance then
		error("CatmullRomSplineObject:CreateTween() was given properties in the property table that do not belong to the instance!")
	end
	local var4 = Instance.new("NumberValue")
	local var5 = TweenService:Create(var4, p3, {
		Value = 1
	})
	local var6 = nil
	var5.Changed:Connect(function(p12)
		if p12 == "PlaybackState" and var5.PlaybackState == Enum.PlaybackState.Playing then
			var6 = var4.Changed:Connect(function(p12)
				for k, v in pairs(p4) do
					local instance = p5 and t2.CalculatePositionRelativeToLength(p1, p12) or t2.CalculatePositionAt(p1, p12)
					local table2 = p5 and t2.CalculateDerivativeRelativeToLength(p1, p12) or t2.CalculateDerivativeAt(p1, p12)
					local var3 = typeof(instance) == "Vector3" and typeof(table2) == "Vector3" and CFrame.new(instance, instance + table2) or instance
					if typeof(p2[v]) == "number" or (typeof(p2[v] == "Vector2") or typeof(p2[v]) == "CFrame") then
						p2[v] = var3
					else
						if typeof(p2[v] == "Vector3") then
							p2[v] = var3.Position
						else
							error("CatmullRomSplineObject:CreateTween() could not set the value of the instance property " .. tostring(v) .. ", not a numerical value!")
						end
					end
				end
			end)
		elseif p12 == "PlaybackState" and var6 ~= nil then
			var6:Disconnect()
			var6 = nil
		end
	end)
	return var5
end
return t
