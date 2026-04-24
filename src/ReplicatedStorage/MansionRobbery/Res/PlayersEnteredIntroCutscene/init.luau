-- Reviewed by Claude
local TweenService = game:GetService("TweenService")
local function warnf(p1, ...)
	warn(string.format(p1, ...))
end
local v1 = script.Curve:FindFirstChild("CurveData") and require(script.Curve.CurveData)
local v2 = script:FindFirstChild("CatmullRomSpline") and require(script.CatmullRomSpline)
local GraphBezier = require(script.GraphBezier)
local v3 = script:FindFirstChild("Mathf") and require(script.Mathf)
local v4 = script.Curve:FindFirstChild("UpVectorData") and require(script.Curve.UpVectorData)
local v5 = script.Curve:FindFirstChild("TransformFunction") and require(script.Curve.TransformFunction)
local v6
if v1.AnimationKeyframes then
	local t = {}
	t[1] = unpack(v1.AnimationKeyframes)
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
	v6 = GraphBezier.new(t)
else
	v6 = nil
end
local t = {}
local t2 = {}
local NumPoints = v1.Attributes.NumPoints
function t2.GetCurveValueAt(p1, p2)
	return v3.Lerp(p1:_getAttribute("GraphMinSpeed") or 0, p1:_getAttribute("GraphMaxSpeed") or 1, (math.clamp(p1:_getCurveValueAt(p2), 0, 1)))
end
function t2.GetProgress(p1, p2, p3, p4)
	local v1, v2, v3 = p1:_getProgress(p2, p3)
	local DeltaTime = p1.DeltaTime
	if not DeltaTime then
		DeltaTime = p4 or 1 / 60
	end
	return p1:_getTransformed(v1, v2, v3, t, DeltaTime)
end
function t2.GetProgressRaw(p1, p2, p3, p4)
	local v1, v2, v3 = p1:_getProgress(p2, p3)
	local DeltaTime = p1.DeltaTime
	if not DeltaTime then
		DeltaTime = p4 or 1 / 60
	end
	return p1:_getTransformedRaw(v1, v2, v3, t, DeltaTime)
end
function t2.CreateTween(p1, p2, p3, p4)
	local v1 = Instance.new("NumberValue")
	local v2 = TweenService:Create(v1, p2, {
		Value = 1
	})
	v2:GetPropertyChangedSignal("PlaybackState"):connect(function()
		if v2.PlaybackState == Enum.PlaybackState.Playing then
			p1.LastTick = os.clock()
		end
	end)
	v1:GetPropertyChangedSignal("Value"):connect(function()
		local v12 = os.clock()
		p1.DeltaTime = v12 - p1.LastTick
		p1.LastTick = v12
		p4(p1:GetProgress(v1.Value, p3))
	end)
	return v2
end
function t2.Generate(p1)
	local ControlPoints = v1.ControlPoints
	local v12
	if v1.Attributes.PathClosed == true then
		local t = {}
		for i = 1, #ControlPoints do
			table.insert(t, ControlPoints[i])
		end
		table.insert(t, ControlPoints[1])
		table.insert(t, ControlPoints[2])
		table.insert(t, ControlPoints[3])
		v12 = v2.new(t, v1.Attributes.Tension)
	else
		v12 = v2.new(ControlPoints, v1.Attributes.Tension)
	end
	v12.LengthIterations = v1.Attributes.LengthIterations or 2000
	v12:UpdateLength()
	p1.Spline = v12
	p1:_generatePointData()
end
function t2._getAttribute(p1, p2)
	return v1.Attributes[p2]
end
function t2._getCurveValueAt(p1, p2)
	if v6 then
		return v6:CalculateValueAt(p2)
	end
end
function t2._getProgress(p1, p2, p3)
	local v1 = p1:_getAttribute("PathClosed")
	local v2 = p1.Spline:CalculatePositionRelativeToLength(p2)
	local v3 = p1.Spline:CalculateDerivativeRelativeToLength(p2)
	local v42 = p1:_getUpVector(p2, v2, v3)
	if v4 then
		v42 = p1:_twistUpvector(v42, v1, p2, v3, v4)
	end
	return v2 + v42 * (p3 or 0), v3, v42
end
function t2._getUpVector(p1, p2, p3, p4)
	if p1.PointData then
		local v3 = p1.PointData.points[math.floor(p2 * NumPoints)]
		if v3 then
			return CFrame.lookAt(p3, p3 + p4, v3.upVector).UpVector
		else
			return Vector3.new(0, 1, 0)
		end
	else
		return Vector3.new(0, 1, 0)
	end
end
function t2._getTwistAt(p1, p2, p3, p4)
	local v1 = nil
	local v2 = nil
	local v32 = nil
	local v4 = nil
	local v5 = nil
	local v6 = nil
	for k, v in pairs(p4.data) do
		local degrees = v.degrees
		local tValue = v.tValue
		if degrees ~= 0.00001 then
			v1 = v1 or v
			if not v32 then
				if tValue <= p3 then
					v6 = tValue
					v2 = degrees
				else
					v32 = degrees
					v4 = tValue
				end
				if v2 and v32 then
					v5 = v
					break
				end
			end
			v5 = v
		end
	end
	if p2 or (not v2 or v32) then
		if p2 and (v32 and not v2) then
			v2 = v5.degrees + (p1.PointData.LoopAngleDiff or 0)
			v6 = v5.tValue - 1
		elseif p2 and (v2 and not v32) then
			v32 = v1.degrees - (p1.PointData.LoopAngleDiff or 0)
			v4 = v1.tValue + 1
		end
		if v2 and v32 then
			return v3.Lerp(v2, v2 + (v32 - v2 + 180) % 360 - 180, v3.PercentBetween(p3, v6, v4))
		else
			return 0
		end
	else
		return v2
	end
end
function t2._twistUpvector(p1, p2, p3, p4, p5, p6)
	if p1.PointData then
		local v1 = p1:_getTwistAt(p3, p4, p6)
		if v1 == 0 then
			return p2
		else
			return CFrame.fromAxisAngle(p5, (math.rad(v1))) * p2
		end
	end
end
function t2._getTransformed(p1, ...)
	local t = { ... }
	local v1, v2, v3, _
	if v5 then
		local v4, v52 = pcall(function()
			return v5(unpack(t))
		end)
		if v4 then
			return v52
		else
			v1, v2, v3, _ = ...
			return CFrame.lookAt(v1, v1 + v2, v3)
		end
	else
		v1, v2, v3, _ = ...
		return CFrame.lookAt(v1, v1 + v2, v3)
	end
end
function t2._getTransformedRaw(p1, ...)
	local t = { ... }
	local v1, v2, v3, _
	if v5 then
		local v4, v52 = pcall(function()
			return v5(unpack(t))
		end)
		if v4 then
			return v52
		else
			v1, v2, v3, _ = ...
			return v1, v2, v3
		end
	else
		v1, v2, v3, _ = ...
		return v1, v2, v3
	end
end
function t2._generatePointData(p1)
	local v1 = Vector3.new(0, 1, 0)
	local t = {
		points = {}
	}
	for i = 1, NumPoints do
		local v2 = i / NumPoints
		local v3 = p1.Spline:CalculatePositionRelativeToLength(v2)
		local v4 = p1.Spline:CalculateDerivativeRelativeToLength(v2)
		local UpVector = CFrame.lookAt(v3, v3 + v4, v1).UpVector
		t.points[i] = {
			upVector = v1,
			pos = v3,
			dir = v4,
			t = v2
		}
		v1 = UpVector
	end
	local v5 = math.acos(v1.Y) / math.pi * 180
	t.LoopAngleDiff = v5 * if v1:Dot(t.points[#t.points].dir:Cross(Vector3.new(0, 1, 0))) < 0 then -1 else 1
	p1.PointData = t
end
return t2
