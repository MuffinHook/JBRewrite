-- Reviewed by Claude
local TweenService = game:GetService("TweenService")
local function warnf(p1, ...)
	warn(string.format(p1, ...))
end
local module = script.Curve:FindFirstChild("CurveData") and require(script.Curve.CurveData)
local module2 = script:FindFirstChild("CatmullRomSpline") and require(script.CatmullRomSpline)
local GraphBezier = require(script.GraphBezier)
local module3 = script:FindFirstChild("Mathf") and require(script.Mathf)
local module4 = script.Curve:FindFirstChild("UpVectorData") and require(script.Curve.UpVectorData)
local module5 = script.Curve:FindFirstChild("TransformFunction") and require(script.Curve.TransformFunction)
local var6
if module.AnimationKeyframes then
	local t = {}
	t[1] = unpack(module.AnimationKeyframes)
	table.sort(t, function(p1, p2)
		return p1.pos.X < p2.pos.X
	end)
	if #t == 0 or t[1].pos.X > 0 then
		table.insert(t, 1, {
			pos = Vector2.new(0, 0),
			left = Vector2.new(-0.1, 0),
			right = Vector2.new(0.1, 0)
		})
	end
	if #t == 1 or t[#t].pos.X < 1 then
		table.insert(t, {
			pos = Vector2.new(1, 1),
			left = Vector2.new(-0.1, 0),
			right = Vector2.new(0.1, 0)
		})
	end
	var6 = GraphBezier.new(t)
else
	var6 = nil
end
local t = {}
local t2 = {}
local NumPoints = module.Attributes.NumPoints
function t2.GetCurveValueAt(p1, p2)
	return module3.Lerp(p1:_getAttribute("GraphMinSpeed") or 0, p1:_getAttribute("GraphMaxSpeed") or 1, (math.clamp(p1:_getCurveValueAt(p2), 0, 1)))
end
function t2.GetProgress(p1, p2, p3, p4)
	local module, module2, module3 = p1:_getProgress(p2, p3)
	local DeltaTime = p1.DeltaTime
	if not DeltaTime then
		DeltaTime = p4 or 1 / 60
	end
	return p1:_getTransformed(module, module2, module3, t, DeltaTime)
end
function t2.GetProgressRaw(p1, p2, p3, p4)
	local module, module2, module3 = p1:_getProgress(p2, p3)
	local DeltaTime = p1.DeltaTime
	if not DeltaTime then
		DeltaTime = p4 or 1 / 60
	end
	return p1:_getTransformedRaw(module, module2, module3, t, DeltaTime)
end
function t2.CreateTween(p1, p2, p3, p4)
	local module = Instance.new("NumberValue")
	local module2 = TweenService:Create(module, p2, {
		Value = 1
	})
	module2:GetPropertyChangedSignal("PlaybackState"):connect(function()
		if module2.PlaybackState == Enum.PlaybackState.Playing then
			p1.LastTick = os.clock()
		end
	end)
	module:GetPropertyChangedSignal("Value"):connect(function()
		local var12 = os.clock()
		p1.DeltaTime = var12 - p1.LastTick
		p1.LastTick = var12
		p4(p1:GetProgress(module.Value, p3))
	end)
	return module2
end
function t2.Generate(p1)
	local ControlPoints = module.ControlPoints
	local var12
	if module.Attributes.PathClosed == true then
		local t = {}
		for i = 1, #ControlPoints do
			table.insert(t, ControlPoints[i])
		end
		table.insert(t, ControlPoints[1])
		table.insert(t, ControlPoints[2])
		table.insert(t, ControlPoints[3])
		var12 = module2.new(t, module.Attributes.Tension)
	else
		var12 = module2.new(ControlPoints, module.Attributes.Tension)
	end
	var12.LengthIterations = module.Attributes.LengthIterations or 2000
	var12:UpdateLength()
	p1.Spline = var12
	p1:_generatePointData()
end
function t2._getAttribute(p1, p2)
	return module.Attributes[p2]
end
function t2._getCurveValueAt(p1, p2)
	if var6 then
		return var6:CalculateValueAt(p2)
	end
end
function t2._getProgress(p1, p2, p3)
	local module = p1:_getAttribute("PathClosed")
	local module2 = p1.Spline:CalculatePositionRelativeToLength(p2)
	local module3 = p1.Spline:CalculateDerivativeRelativeToLength(p2)
	local var42 = p1:_getUpVector(p2, module2, module3)
	if module4 then
		var42 = p1:_twistUpvector(var42, module, p2, module3, module4)
	end
	return module2 + var42 * (p3 or 0), module3, var42
end
function t2._getUpVector(p1, p2, p3, p4)
	if p1.PointData then
		local module3 = p1.PointData.points[math.floor(p2 * NumPoints)]
		if module3 then
			return CFrame.lookAt(p3, p3 + p4, module3.upVector).UpVector
		else
			return Vector3.new(0, 1, 0)
		end
	else
		return Vector3.new(0, 1, 0)
	end
end
function t2._getTwistAt(p1, p2, p3, p4)
	local module = nil
	local module2 = nil
	local var32 = nil
	local module4 = nil
	local module5 = nil
	local var6 = nil
	for k, v in pairs(p4.data) do
		local degrees = v.degrees
		local tValue = v.tValue
		if degrees ~= 0.00001 then
			module = module or v
			if not var32 then
				if tValue <= p3 then
					var6 = tValue
					module2 = degrees
				else
					var32 = degrees
					module4 = tValue
				end
				if module2 and var32 then
					module5 = v
					break
				end
			end
			module5 = v
		end
	end
	if p2 or (not module2 or var32) then
		if p2 and (var32 and not module2) then
			module2 = module5.degrees + (p1.PointData.LoopAngleDiff or 0)
			var6 = module5.tValue - 1
		elseif p2 and (module2 and not var32) then
			var32 = module.degrees - (p1.PointData.LoopAngleDiff or 0)
			module4 = module.tValue + 1
		end
		if module2 and var32 then
			return module3.Lerp(module2, module2 + (var32 - module2 + 180) % 360 - 180, module3.PercentBetween(p3, var6, module4))
		else
			return 0
		end
	else
		return module2
	end
end
function t2._twistUpvector(p1, p2, p3, p4, p5, p6)
	if p1.PointData then
		local module = p1:_getTwistAt(p3, p4, p6)
		if module == 0 then
			return p2
		else
			return CFrame.fromAxisAngle(p5, (math.rad(module))) * p2
		end
	end
end
function t2._getTransformed(p1, ...)
	local t = { ... }
	local module, module2, module3, _
	if module5 then
		local module4, v52 = pcall(function()
			return module5(unpack(t))
		end)
		if module4 then
			return v52
		else
			module, module2, module3, _ = ...
			return CFrame.lookAt(module, module + module2, module3)
		end
	else
		module, module2, module3, _ = ...
		return CFrame.lookAt(module, module + module2, module3)
	end
end
function t2._getTransformedRaw(p1, ...)
	local t = { ... }
	local module, module2, module3, _
	if module5 then
		local module4, v52 = pcall(function()
			return module5(unpack(t))
		end)
		if module4 then
			return v52
		else
			module, module2, module3, _ = ...
			return module, module2, module3
		end
	else
		module, module2, module3, _ = ...
		return module, module2, module3
	end
end
function t2._generatePointData(p1)
	local module = Vector3.new(0, 1, 0)
	local t = {
		points = {}
	}
	for i = 1, NumPoints do
		local module2 = i / NumPoints
		local module3 = p1.Spline:CalculatePositionRelativeToLength(module2)
		local module4 = p1.Spline:CalculateDerivativeRelativeToLength(module2)
		local UpVector = CFrame.lookAt(module3, module3 + module4, module).UpVector
		t.points[i] = {
			upVector = module,
			pos = module3,
			dir = module4,
			t = module2
		}
		module = UpVector
	end
	local module5 = math.acos(module.Y) / math.pi * 180
	t.LoopAngleDiff = module5 * if module:Dot(t.points[#t.points].dir:Cross(Vector3.new(0, 1, 0))) < 0 then -1 else 1
	p1.PointData = t
end
return t2
