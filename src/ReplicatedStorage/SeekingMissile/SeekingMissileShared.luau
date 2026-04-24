-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local RunService = game:GetService("RunService")
local SeekingMissileUtils = require(ReplicatedStorage.SeekingMissile.SeekingMissileUtils)
require(ReplicatedStorage.Std.Raycast)
local t = {
	_init = function(p1)
		p1._throttle = 1
		p1.forwardDrag = SeekingMissileUtils.getForwardDrag(p1.obj)
		p1.lateralDrag = SeekingMissileUtils.getLateralDrag(p1.obj)
		p1.ignoreList = { p1.obj }
		p1.raycastParams = RaycastParams.new()
		p1.raycastParams.FilterDescendantsInstances = p1.ignoreList
		p1._lastTargetPosition = nil
		p1._seeking = false
		p1._onFireExplodeRemote = Signal.new()
		p1.maid:GiveTask(p1._onFireExplodeRemote)
		p1.onExploded = Signal.new()
		p1.maid:GiveTask(p1.onExploded)
		p1.flagApplyingThrust = false
		p1.onApplyingThrustChanged = Signal.new()
		p1.maid:GiveTask(p1.onApplyingThrustChanged)
	end,
	_getTargetPosition = function(p1)
		local v1 = SeekingMissileUtils.getTargetPos(p1.obj)
		local targetPartObj = p1.targetPartObj.Value
		if targetPartObj then
			v1 = targetPartObj.Position
		end
		return v1
	end
}
function t._run(p1)
	p1.lastDistance = (1 / 0)
	p1.lastDistanceImprovement = 0
	local v1 = false
	local v2 = false
	local var3 = false
	local var4 = os.clock()
	local var5 = 0
	local Position = p1.obj.Position
	p1.runMaid:GiveTask(RunService.Heartbeat:Connect(function(p12)
		local var12 = os.clock()
		local obj = p1.obj
		local AssemblyMass = obj.AssemblyMass
		local var22 = t._getTargetPosition(p1)
		assert(var22 ~= nil, "missing targetPosition")
		local var42 = p1._lastTargetPosition or var22
		p1._lastTargetPosition = var22
		local cframe52 = obj.CFrame:VectorToObjectSpace(obj.AssemblyLinearVelocity)
		local vector6 = Vector3.new(0, 0, cframe52.Z)
		local var7 = cframe52 - vector6
		local var8 = math.abs(cframe52.Z)
		local Magnitude = cframe52.Magnitude
		local var9 = var22 - var42
		local Magnitude_2 = (var22 - obj.Position).Magnitude
		var5 = (var5 * 24 + var9.Magnitude / p12) / 25
		local _throttle = p1._throttle
		local var11 = 1
		local Position_2 = obj.Position
		local v122
		if var9.Magnitude > 0.1 then
			local var13 = var5
			local Unit = var9.Unit
			if Magnitude_2 < 500 then
				var11 = if math.max(400, var5 * 5 / 3) < Magnitude then _throttle * 0.95 else _throttle * 1.05
			end
			local var15 = GeomUtils.getTrajectoryInterceptTime(Position_2, var8, var22, var13, Unit) or 0
			v122 = if var15 > 0 then var22 + Unit * var13 * var15 else var22
		else
			v122 = var22
		end
		local var16 = math.clamp(_throttle + (var11 - _throttle) * 0.9, 0, 1)
		p1._throttle = var16
		if p1._seeking then
			p1.alignOrientation.CFrame = CFrame.lookAt(obj.Position, v122)
		else
			p1.alignOrientation.CFrame = obj.CFrame
		end
		local v17, v18
		if var12 - var4 > SeekingMissileUtils.getDropDuration(obj) then
			v17 = var16
			v18 = true
		else
			v17 = var16
			v18 = false
		end
		if v18 ~= p1.flagApplyingThrust then
			p1.flagApplyingThrust = v18
			p1.onApplyingThrustChanged:Fire(v18)
		end
		local v19
		if v18 then
			local var20 = -p1.lateralDrag * var7
			if not p1._currentLateralForce then
				p1._currentLateralForce = var20
			end
			p1._currentLateralForce = p1._currentLateralForce:Lerp(var20, if p12 <= 0.02 then 1 elseif p12 <= 0.05 then 0.3 else 0.1)
			local var23 = -p1.forwardDrag * vector6 * math.abs(vector6.Magnitude)
			v19 = Vector3.new(0, 0, -1) * AssemblyMass * 9.81 * 20 * SeekingMissileUtils.getAccel(obj) * v17 + var23 + p1._currentLateralForce
		else
			v19 = Vector3.new(0, 0, 0)
		end
		p1.vectorForce.Force = v19
		local Magnitude_3 = (var22 - obj.Position).Magnitude
		local var24 = SeekingMissileUtils.getLifeSpan(obj)
		if p1._seeking then
			if Magnitude_3 < p1.lastDistance - 0.1 then
				p1.lastDistanceImprovement = var12
			end
			if var12 - p1.lastDistanceImprovement > SeekingMissileUtils.getNoImprovementExplodeDuration(obj) then
				t._explode(p1)
			end
			p1.lastDistance = Magnitude_3
			local var27 = math.min(1, (var12 - var4) / var24)
			local var28 = var27 * 12 + (1 - var27) * 3
			if Magnitude_3 <= var28 then
				t._explode(p1)
			end
			if GeomUtils.calcRayIntersectSphere(Position, Position_2, var22, var28) then
				t._explode(p1)
			end
		end
		if not v1 and var24 <= var12 - var4 then
			v1 = true
			t._explode(p1)
		end
		if not v2 and var12 - var4 > SeekingMissileUtils.getConnectHitAfterDuration(obj) then
			v2 = true
			t._detectHit(p1)
		end
		if not var3 and var12 - var4 > SeekingMissileUtils.getSeekAfterDuration(obj) then
			var3 = true
			t._enableSeeking(p1)
		end
		Position = Position_2
	end))
	p1.alignOrientation.MaxTorque = 10000000000000
	p1.runMaid:GiveTask(function()
		p1.vectorForce.Force = Vector3.new()
		p1.alignOrientation.MaxTorque = 0
	end)
end
function t._explode(p1)
	if not p1._didExplode then
		p1._didExplode = true
		local targetPartObj = p1.targetPartObj.Value
		p1.onExploded:Fire(p1.obj.Position, targetPartObj, if targetPartObj then targetPartObj.CFrame:PointToObjectSpace(p1.obj.Position) else nil)
		task.defer(p1.runMaid.DoCleaning, p1.runMaid)
	end
end
function t._detectHit(p1)
	if not p1._didExplode then
		p1.runMaid:GiveTask(p1.obj.Touched:Connect(function(p12)
			if not (p12.Transparency > 0.5) then
				for v1, v2 in p1.ignoreList do
					if p12:IsDescendantOf(v2) then
						return false
					end
				end
				t._explode(p1)
			end
		end))
	end
end
function t._enableSeeking(p1)
	p1._seeking = true
end
return t
