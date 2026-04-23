local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RunService = game:GetService("RunService")
return function(p1) --[[ Line: 5 | Upvalues: Maid (copy), RunService (copy) ]]
	local v1 = Maid.new()
	local AnimationsFolder = p1:FindFirstChild("AnimationsFolder")
	if not AnimationsFolder then
		AnimationsFolder = Instance.new("Folder")
		AnimationsFolder.Name = "AnimationsFolder"
		AnimationsFolder.Parent = p1
		for v2, v3 in script.Parent:FindFirstChild("Res"):FindFirstChild("DefaultAnimations"):GetChildren() do
			v3:Clone().Parent = AnimationsFolder
		end
	end
	local Humanoid = p1:FindFirstChild("Humanoid")
	local v4 = "Standing"
	local ScaleDampeningPercent = Humanoid:FindFirstChild("ScaleDampeningPercent")
	local v5 = 0
	local v6 = 0
	local t = {
		x = 0,
		y = 0
	}
	local v7 = 0
	local v8 = ""
	local v9 = nil
	local v10 = nil
	local v11 = nil
	local v12 = 1
	local t2 = {}
	local t3 = {}
	local tbl = {
		idle = {
			{
				id = "http://www.roblox.com/asset/?id=507766666",
				weight = 1
			},
			{
				id = "http://www.roblox.com/asset/?id=507766951",
				weight = 1
			},
			{
				id = "http://www.roblox.com/asset/?id=507766388",
				weight = 9
			}
		},
		walk = {
			{
				id = "http://www.roblox.com/asset/?id=507777826",
				weight = 10
			}
		},
		run = {
			{
				id = "http://www.roblox.com/asset/?id=507767714",
				weight = 10
			}
		},
		swim = {
			{
				id = "http://www.roblox.com/asset/?id=507784897",
				weight = 10
			}
		},
		swimidle = {
			{
				id = "http://www.roblox.com/asset/?id=507785072",
				weight = 10
			}
		},
		jump = {
			{
				id = "http://www.roblox.com/asset/?id=507765000",
				weight = 10
			}
		},
		fall = {
			{
				id = "http://www.roblox.com/asset/?id=507767968",
				weight = 10
			}
		},
		climb = {
			{
				id = "http://www.roblox.com/asset/?id=507765644",
				weight = 10
			}
		},
		sit = {
			{
				id = "http://www.roblox.com/asset/?id=2506281703",
				weight = 10
			}
		},
		toolnone = {
			{
				id = "http://www.roblox.com/asset/?id=507768375",
				weight = 10
			}
		},
		toolslash = {
			{
				id = "http://www.roblox.com/asset/?id=522635514",
				weight = 10
			}
		},
		toollunge = {
			{
				id = "http://www.roblox.com/asset/?id=522638767",
				weight = 10
			}
		},
		wave = {
			{
				id = "http://www.roblox.com/asset/?id=507770239",
				weight = 10
			}
		},
		point = {
			{
				id = "http://www.roblox.com/asset/?id=507770453",
				weight = 10
			}
		},
		dance = {
			{
				id = "http://www.roblox.com/asset/?id=507771019",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507771955",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507772104",
				weight = 10
			}
		},
		dance2 = {
			{
				id = "http://www.roblox.com/asset/?id=507776043",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507776720",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507776879",
				weight = 10
			}
		},
		dance3 = {
			{
				id = "http://www.roblox.com/asset/?id=507777268",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507777451",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507777623",
				weight = 10
			}
		},
		laugh = {
			{
				id = "http://www.roblox.com/asset/?id=507770818",
				weight = 10
			}
		},
		cheer = {
			{
				id = "http://www.roblox.com/asset/?id=507770677",
				weight = 10
			}
		}
	}
	local t4 = {}
	local t5 = {}
	local v13 = t4
	local t6 = {
		wave = false,
		point = false,
		dance = true,
		dance2 = true,
		dance3 = true,
		laugh = false,
		cheer = false
	}
	math.randomseed(tick())
	local function destroyWalkAnimations() --[[ Line: 122 | Upvalues: t4 (copy), t5 (copy), v6 (ref) ]]
		for k, v in pairs(t4) do
			if v.track then
				v.track:Stop()
				v.track:Destroy()
				v.track = nil
			end
		end
		for k, v in pairs(t5) do
			if v.track then
				v.track:Stop()
				v.track:Destroy()
				v.track = nil
			end
		end
		v6 = 0
	end
	local v14 = nil
	local v15 = nil
	local v16 = nil
	local v17 = nil
	local v18 = nil
	local function resetVelocityBounds(p1) --[[ Line: 144 | Upvalues: v16 (ref), v15 (ref), v18 (ref), v17 (ref) ]]
		v16 = 0
		v15 = 0
		v18 = 0
		v17 = 0
	end
	local function updateVelocityBounds(p1) --[[ Line: 151 | Upvalues: v15 (ref), v17 (ref), v16 (ref), v18 (ref) ]]
		if p1 then
			if v15 < p1.x then
				v15 = p1.x
			end
			if v17 < p1.y then
				v17 = p1.y
			end
			if p1.x < v16 then
				v16 = p1.x
			end
			if p1.y < v18 then
				v18 = p1.y
			end
		end
	end
	local function checkStrafingEnabled(p1) --[[ Line: 168 | Upvalues: v15 (ref), v16 (ref), v17 (ref), v18 (ref), v13 (ref), t4 (copy), t5 (copy) ]]
		if v15 ~= 0 and (v16 ~= 0 and (v17 ~= 0 and v18 ~= 0)) and (t4.run and t4.walk) then
			if v13 ~= t4 then
				v13 = t4
				warn("Strafing reenabled")
			end
			return
		elseif v15 ~= 0 and (v16 ~= 0 and (v17 ~= 0 and v18 ~= 0)) and v13 == t4 then
			warn("Strafe blending disabled.  Run and walk must be strafing-friendly.")
		end
		v13 = t5
	end
	local function setupWalkAnimations() --[[ Line: 187 | Upvalues: v16 (ref), v15 (ref), v18 (ref), v17 (ref), t4 (copy), checkStrafingEnabled (copy), v13 (ref), Humanoid (copy), t3 (copy) ]]
		v16 = 0
		v15 = 0
		v18 = 0
		v17 = 0
		for k, v in pairs(t4) do
			local lv = v.lv
			if lv then
				if v15 < lv.x then
					v15 = lv.x
				end
				if v17 < lv.y then
					v17 = lv.y
				end
				if lv.x < v16 then
					v16 = lv.x
				end
				if lv.y < v18 then
					v18 = lv.y
				end
			end
		end
		checkStrafingEnabled()
		for k, v in pairs(v13) do
			v.track = Humanoid:LoadAnimation(t3[k][1].anim)
			v.track.Priority = Enum.AnimationPriority.Core
		end
	end
	local function replaceLocomotionTrack(p1, p2) --[[ Line: 200 | Upvalues: v8 (ref), v13 (ref), destroyWalkAnimations (copy), t4 (copy), t5 (copy), setupWalkAnimations (copy), v7 (ref) ]]
		local v1
		if v8 == "walk" and v13[p1] then
			destroyWalkAnimations()
			v1 = true
		else
			v1 = false
		end
		if p2 then
			t4[p1] = {
				lv = p2,
				speed = p2.Magnitude
			}
		else
			t4[p1] = nil
		end
		if (p1 == "run" or p1 == "walk") and p2 then
			t5[p1] = t4[p1]
		elseif p1 == "run" or p1 == "walk" then
			local v2 = if p1 == "run" then 12.8 else 6.4
			t5[p1] = {
				lv = Vector2.new(0, v2),
				speed = v2
			}
			t4[p1] = nil
		end
		if v1 then
			setupWalkAnimations()
			v7 = 0
		end
	end
	local function v19(p1, p2) --[[ Line: 228 | Upvalues: t3 (copy), AnimationsFolder (ref), v19 (copy), replaceLocomotionTrack (copy), t2 (copy), Humanoid (copy) ]]
		if t3[p1] ~= nil then
			for k, v in pairs(t3[p1].connections) do
				v:disconnect()
			end
		end
		t3[p1] = {}
		t3[p1].count = 0
		t3[p1].totalWeight = 0
		t3[p1].connections = {}
		local v1 = AnimationsFolder:FindFirstChild(p1)
		if v1 ~= nil then
			local function f2(p12) --[[ Line: 244 | Upvalues: v19 (ref), p1 (copy), p2 (copy) ]]
				v19(p1, p2)
			end
			table.insert(t3[p1].connections, v1.ChildAdded:connect(f2))
			local function f3(p12) --[[ Line: 250 | Upvalues: v19 (ref), p1 (copy), p2 (copy) ]]
				v19(p1, p2)
			end
			table.insert(t3[p1].connections, v1.ChildRemoved:connect(f3))
			for k, v in pairs(v1:GetChildren()) do
				local v4
				if v:IsA("Animation") then
					local Weight = v:FindFirstChild("Weight")
					v4 = if Weight == nil then 1 else Weight.Value
					t3[p1].count = t3[p1].count + 1
					local count = t3[p1].count
					t3[p1][count] = {}
					t3[p1][count].anim = v
					t3[p1][count].weight = v4
					t3[p1].totalWeight = t3[p1].totalWeight + t3[p1][count].weight
					local function f5(p12) --[[ Line: 272 | Upvalues: v19 (ref), p1 (copy), p2 (copy) ]]
						v19(p1, p2)
					end
					table.insert(t3[p1].connections, v.Changed:connect(f5))
					local function f6(p12) --[[ Line: 278 | Upvalues: v19 (ref), p1 (copy), p2 (copy) ]]
						v19(p1, p2)
					end
					table.insert(t3[p1].connections, v.ChildAdded:connect(f6))
					local function f7(p12) --[[ Line: 284 | Upvalues: v19 (ref), p1 (copy), p2 (copy) ]]
						v19(p1, p2)
					end
					table.insert(t3[p1].connections, v.ChildRemoved:connect(f7))
					replaceLocomotionTrack(p1, (v:GetAttribute("LinearVelocity")))
				end
			end
		end
		if t3[p1].count <= 0 then
			for k, v in pairs(p2) do
				t3[p1][k] = {}
				t3[p1][k].anim = Instance.new("Animation")
				t3[p1][k].anim.Name = p1
				t3[p1][k].anim.AnimationId = v.id
				t3[p1][k].weight = v.weight
				t3[p1].count = t3[p1].count + 1
				t3[p1].totalWeight = t3[p1].totalWeight + v.weight
			end
		end
		for k, v in pairs(t3) do
			for i = 1, v.count do
				if t2[v[i].anim.AnimationId] == nil then
					Humanoid:LoadAnimation(v[i].anim)
					t2[v[i].anim.AnimationId] = true
				end
			end
		end
	end
	local function scriptChildModified(p1) --[[ Line: 319 | Upvalues: tbl (copy), v19 (copy) ]]
		local v1 = tbl[p1.Name]
		if v1 == nil then
			if p1:isA("StringValue") then
				tbl[p1.Name] = {}
				v19(p1.Name, tbl[p1.Name])
			end
		else
			v19(p1.Name, v1)
		end
	end
	v1:GiveTask(AnimationsFolder.ChildAdded:connect(scriptChildModified))
	v1:GiveTask(AnimationsFolder.ChildRemoved:connect(scriptChildModified))
	v1:GiveTask(function() --[[ Line: 333 | Upvalues: t3 (copy) ]]
		for v1, v2 in t3 do
			for v3, v4 in v2.connections do
				v4:Disconnect()
			end
		end
	end)
	local v20 = if Humanoid then Humanoid:FindFirstChildOfClass("Animator") else nil
	if not v20 and RunService:IsServer() then
		v20 = Instance.new("Animator")
		assert(v20).Parent = Humanoid
	elseif not v20 then
		v20 = Humanoid
	end
	if v20 then
		for i, v in ipairs((v20:GetPlayingAnimationTracks())) do
			v:Stop(0)
			v:Destroy()
		end
	end
	for k, v in pairs(tbl) do
		v19(k, v)
	end
	for v22, v23 in AnimationsFolder:GetChildren() do
		if v23:isA("StringValue") then
			tbl[v23.Name] = {}
			v19(v23.Name, tbl[v23.Name])
		end
	end
	local v24 = "None"
	local v25 = 0
	local v26 = 0
	local v27 = false
	local function stopAllAnimations() --[[ Line: 388 | Upvalues: v8 (ref), t6 (copy), v27 (ref), v9 (ref), v11 (ref), v10 (ref), v13 (ref) ]]
		local v1 = v8
		if t6[v1] ~= nil and t6[v1] == false then
			v1 = "idle"
		end
		if v27 then
			v1 = "idle"
			v27 = false
		end
		v8 = ""
		v9 = nil
		if v11 ~= nil then
			v11:disconnect()
		end
		if v10 ~= nil then
			v10:Stop()
			v10:Destroy()
			v10 = nil
		end
		for k, v in pairs(v13) do
			if v.track then
				v.track:Stop()
				v.track:Destroy()
				v.track = nil
			end
		end
		return v1
	end
	local function getHeightScale() --[[ Line: 424 | Upvalues: Humanoid (copy), ScaleDampeningPercent (ref) ]]
		if Humanoid and Humanoid.AutomaticScalingEnabled then
			local v1 = Humanoid.HipHeight / 2
			if ScaleDampeningPercent == nil then
				ScaleDampeningPercent = Humanoid:FindFirstChild("ScaleDampeningPercent")
			end
			if ScaleDampeningPercent ~= nil then
				v1 = 1 + (Humanoid.HipHeight - 2) * ScaleDampeningPercent.Value / 2
			end
			return v1
		else
			return 1
		end
	end
	local function signedAngle(p1, p2) --[[ Line: 445 ]]
		return -math.atan2(p1.x * p2.y - p1.y * p2.x, p1.x * p2.x + p1.y * p2.y)
	end
	local function get2DWeight(p1, p2, p3, p4, p5, p6) --[[ Line: 450 ]]
		local v1 = 0.5 * (p5 + p6)
		local t = {
			x = (p4 - p5) / v1
		}
		t.y = 2 * -math.atan2(p2.x * p1.y - p2.y * p1.x, p2.x * p1.x + p2.y * p1.y)
		local t2 = {
			x = (p6 - p5) / v1
		}
		t2.y = 2 * -math.atan2(p2.x * p3.y - p2.y * p3.x, p2.x * p3.x + p2.y * p3.y)
		return math.clamp(1 - (t.x * t2.x + t.y * t2.y) / (0.0001 + (t2.x * t2.x + t2.y * t2.y)), 0, 1)
	end
	local function blend2D(p1, p2) --[[ Line: 461 | Upvalues: v13 (ref), get2DWeight (copy), Humanoid (copy), ScaleDampeningPercent (ref) ]]
		local t = {}
		local sum = 0
		for k, v in pairs(v13) do
			if p1.x * v.lv.x < 0 or p1.y * v.lv.y < 0 then
				t[k] = 0
			else
				t[k] = (1 / 0)
				for k2, v2 in pairs(v13) do
					if not (p1.x * v2.lv.x < 0 or p1.y * v2.lv.y < 0) then
						t[k] = math.min(t[k], (get2DWeight(p1, v.lv, v2.lv, p2, v.speed, v2.speed)))
					end
				end
				sum = sum + t[k]
			end
		end
		local sum_2 = 0
		local sum_3 = 0
		local sum_4 = 0
		for k, v in pairs(v13) do
			if t[k] / sum > 0.1 then
				sum_2 = sum_2 + t[k]
				sum_3 = sum_3 + t[k] * v.lv.x
				sum_4 = sum_4 + t[k] * v.lv.y
			else
				t[k] = 0
			end
		end
		local v3 = sum_3 * sum_3 + sum_4 * sum_4
		local v4 = if v3 > 0.0001 then math.sqrt(p2 * p2 / v3) else 0
		local v6
		if Humanoid and Humanoid.AutomaticScalingEnabled then
			local v7 = Humanoid.HipHeight / 2
			if ScaleDampeningPercent == nil then
				ScaleDampeningPercent = Humanoid:FindFirstChild("ScaleDampeningPercent")
			end
			if ScaleDampeningPercent ~= nil then
				v7 = 1 + (Humanoid.HipHeight - 2) * ScaleDampeningPercent.Value / 2
			end
			v6 = v7
		else
			v6 = 1
		end
		local v8 = 0
		local v9 = v4 / v6
		for k, v in pairs(v13) do
			if v.track.IsPlaying then
				v8 = v.track.TimePosition
				break
			end
		end
		for k, v in pairs(v13) do
			if t[k] > 0 then
				if not v.track.IsPlaying then
					v.track:Play(0.2)
					v.track.TimePosition = v8
				end
				v.track:AdjustWeight(math.max(0.0001, t[k] / sum_2), 0.2)
				v.track:AdjustSpeed(v9)
			else
				v.track:Stop(0.2)
			end
		end
	end
	local function getWalkDirection() --[[ Line: 527 | Upvalues: Humanoid (copy) ]]
		local WalkToPoint = Humanoid.WalkToPoint
		local WalkToPart = Humanoid.WalkToPart
		if Humanoid.MoveDirection == Vector3.new(0, 0, 0) and (WalkToPart or WalkToPoint ~= Vector3.new(0, 0, 0)) then
			local v1 = if WalkToPart then WalkToPart.CFrame:PointToWorldSpace(WalkToPoint) else WalkToPoint
			local v3
			if Humanoid.RootPart then
				local v4 = v1 - Humanoid.RootPart.CFrame.Position
				local v5 = Vector3.new(v4.x, 0, v4.z)
				local Magnitude = v5.Magnitude
				v3 = if Magnitude > 0.01 then v5 / Magnitude else v5
			else
				v3 = Vector3.new(0, 0, 0)
			end
			return v3
		else
			return Humanoid.MoveDirection
		end
	end
	local function updateVelocity(p1) --[[ Line: 554 | Upvalues: v13 (ref), t4 (copy), getWalkDirection (copy), Humanoid (copy), v4 (ref), v5 (ref), t (ref), v6 (ref), v7 (ref), blend2D (copy) ]]
		if v13 == t4 then
			local v1 = getWalkDirection()
			if Humanoid.RootPart then
				local v2 = Humanoid.RootPart.CFrame
				if math.abs(v2.UpVector.Y) < 0.0001 or (v4 ~= "Running" or v5 < 0.001) then
					for k, v in pairs(v13) do
						if v.track then
							v.track:AdjustWeight(0.0001, 0.2)
						end
					end
				else
					local LookVector = v2.LookVector
					local v3 = Vector3.new(LookVector.X, 0, LookVector.Z)
					local v42 = v3 / v3.Magnitude
					local v52 = v1:Dot(v42)
					if v52 <= 0 and v52 > -0.05 then
						v52 = 0.0001
					end
					local v72 = Vector2.new(v42.X * v1.Z - v42.Z * v1.X, v52)
					local v8 = Vector2.new(v72.x - t.x, v72.y - t.y)
					if v8:Dot(v8) > 0.001 then
						t = v72
						v6 = v5
						v7 = p1
						blend2D(v72, v5)
						return
					end
					if math.abs(v5 - v6) > 0.01 or p1 - v7 > 1 then
						t = v72
						v6 = v5
						v7 = p1
						blend2D(v72, v5)
					end
				end
			end
		else
			if math.abs(v5 - v6) > 0.01 or p1 - v7 > 1 then
				v6 = v5
				v7 = p1
				blend2D(Vector2.yAxis, v5)
			end
		end
	end
	local function setAnimationSpeed(p1) --[[ Line: 604 | Upvalues: v8 (ref), v12 (ref), v10 (ref) ]]
		if v8 ~= "walk" and p1 ~= v12 then
			v12 = p1
			v10:AdjustSpeed(p1)
		end
	end
	local function keyFrameReachedFunc(p1) --[[ Line: 613 | Upvalues: v8 (ref), t6 (copy), v27 (ref), v10 (ref), v12 (ref), v14 (ref), Humanoid (copy) ]]
		if p1 == "End" then
			local v1 = v8
			if t6[v1] ~= nil and t6[v1] == false then
				v1 = "idle"
			end
			if v27 then
				if v10.Looped then
					return
				end
				v1 = "idle"
				v27 = false
			end
			local v2 = v12
			v14(v1, 0.15, Humanoid)
			if v8 ~= "walk" and v2 ~= v12 then
				v12 = v2
				v10:AdjustSpeed(v2)
			end
		end
	end
	local function rollAnimation(p1) --[[ Line: 637 | Upvalues: t3 (copy) ]]
		local sum = math.random(1, t3[p1].totalWeight)
		local count = 1
		while t3[p1][count].weight < sum do
			sum = sum - t3[p1][count].weight
			count = count + 1
		end
		return count
	end
	local function switchToAnim(p1, p2, p3, p4) --[[ Line: 648 | Upvalues: v9 (ref), v10 (ref), v11 (ref), v12 (ref), v8 (ref), setupWalkAnimations (copy), destroyWalkAnimations (copy), keyFrameReachedFunc (copy) ]]
		if p1 ~= v9 then
			if v10 ~= nil then
				v10:Stop(p3)
				v10:Destroy()
			end
			if v11 ~= nil then
				v11:disconnect()
			end
			v12 = 1
			v8 = p2
			v9 = p1
			if p2 == "walk" then
				setupWalkAnimations()
				return
			end
			destroyWalkAnimations()
			v10 = p4:LoadAnimation(p1)
			v10.Priority = Enum.AnimationPriority.Core
			v10:Play(p3)
			v11 = v10.KeyframeReached:connect(keyFrameReachedFunc)
		end
	end
	local function playAnimation(p1, p2, p3) --[[ Line: 680 | Upvalues: rollAnimation (copy), t3 (copy), switchToAnim (copy), v27 (ref) ]]
		switchToAnim(t3[p1][rollAnimation(p1)].anim, p1, p2, p3)
		v27 = false
	end
	local v28 = ""
	local v29 = nil
	local v30 = nil
	local v31 = nil
	local v32 = nil
	local function toolKeyFrameReachedFunc(p1) --[[ Line: 698 | Upvalues: v32 (ref), v28 (ref), Humanoid (copy) ]]
		if p1 == "End" then
			v32(v28, 0, Humanoid)
		end
	end
	v32 = function(p1, p2, p3, p4) --[[ Name: playToolAnimation | Line: 704 | Upvalues: rollAnimation (copy), t3 (copy), v30 (ref), v29 (ref), v28 (ref), v31 (ref), toolKeyFrameReachedFunc (copy) ]]
		local anim = t3[p1][rollAnimation(p1)].anim
		if v30 ~= anim then
			if v29 ~= nil then
				v29:Stop()
				v29:Destroy()
				p2 = 0
			end
			v29 = p3:LoadAnimation(anim)
			if p4 then
				v29.Priority = p4
			end
			v29:Play(p2)
			v28 = p1
			v30 = anim
			v31 = v29.KeyframeReached:connect(toolKeyFrameReachedFunc)
		end
	end
	local function stopToolAnimations() --[[ Line: 730 | Upvalues: v28 (ref), v31 (ref), v30 (ref), v29 (ref) ]]
		local v1 = v28
		if v31 ~= nil then
			v31:disconnect()
		end
		v28 = ""
		v30 = nil
		if v29 ~= nil then
			v29:Stop()
			v29:Destroy()
			v29 = nil
		end
		return v1
	end
	local function onRunning(p1) --[[ Line: 752 | Upvalues: v27 (ref), Humanoid (copy), v5 (ref), playAnimation (ref), v4 (ref), updateVelocity (copy), t6 (copy), v8 (ref) ]]
		v5 = p1
		if (v27 and Humanoid.MoveDirection == Vector3.new(0, 0, 0) and Humanoid.WalkSpeed or 0.75) < p1 then
			playAnimation("walk", 0.2, Humanoid)
			if v4 ~= "Running" then
				v4 = "Running"
				updateVelocity(0)
			end
		elseif t6[v8] == nil and not v27 then
			playAnimation("idle", 0.2, Humanoid)
			v4 = "Standing"
		end
	end
	local function onDied() --[[ Line: 770 | Upvalues: v4 (ref) ]]
		v4 = "Dead"
	end
	local function onJumping() --[[ Line: 774 | Upvalues: playAnimation (ref), Humanoid (copy), v26 (ref), v4 (ref) ]]
		playAnimation("jump", 0.1, Humanoid)
		v26 = 0.31
		v4 = "Jumping"
	end
	local function onClimbing(p1) --[[ Line: 780 | Upvalues: playAnimation (ref), Humanoid (copy), v8 (ref), v12 (ref), v10 (ref), v4 (ref) ]]
		playAnimation("climb", 0.1, Humanoid)
		local v1 = p1 / 5
		if v8 ~= "walk" and v1 ~= v12 then
			v12 = v1
			v10:AdjustSpeed(v1)
		end
		v4 = "Climbing"
	end
	local function onGettingUp() --[[ Line: 787 | Upvalues: v4 (ref) ]]
		v4 = "GettingUp"
	end
	local function onFreeFall() --[[ Line: 791 | Upvalues: v26 (ref), playAnimation (ref), Humanoid (copy), v4 (ref) ]]
		if v26 <= 0 then
			playAnimation("fall", 0.2, Humanoid)
		end
		v4 = "FreeFall"
	end
	local function onFallingDown() --[[ Line: 798 | Upvalues: v4 (ref) ]]
		v4 = "FallingDown"
	end
	local function onSeated() --[[ Line: 802 | Upvalues: v4 (ref) ]]
		v4 = "Seated"
	end
	local function onPlatformStanding() --[[ Line: 806 | Upvalues: v4 (ref) ]]
		v4 = "PlatformStanding"
	end
	local function onSwimming(p1) --[[ Line: 813 | Upvalues: playAnimation (ref), Humanoid (copy), v8 (ref), v12 (ref), v10 (ref), v4 (ref) ]]
		if p1 > 1 then
			playAnimation("swim", 0.4, Humanoid)
			local v1 = p1 / 10
			if v8 ~= "walk" and v1 ~= v12 then
				v12 = v1
				v10:AdjustSpeed(v1)
			end
			v4 = "Swimming"
		else
			playAnimation("swimidle", 0.4, Humanoid)
			v4 = "Standing"
		end
	end
	local function animateTool() --[[ Line: 825 | Upvalues: v24 (ref), v32 (ref), Humanoid (copy) ]]
		if v24 == "None" then
			v32("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle)
		elseif v24 == "Slash" then
			v32("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
		elseif v24 == "Lunge" then
			v32("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
		end
	end
	local function getToolAnim(p1) --[[ Line: 842 ]]
		for i, v in ipairs(p1:GetChildren()) do
			if v.Name == "toolanim" and v.className == "StringValue" then
				return v
			end
		end
		return nil
	end
	local v33 = 0
	local function stepAnimate(p12) --[[ Line: 853 | Upvalues: v33 (ref), v26 (ref), v4 (ref), playAnimation (ref), Humanoid (copy), updateVelocity (copy), stopAllAnimations (copy), p1 (copy), getToolAnim (copy), v24 (ref), v25 (ref), animateTool (copy), v28 (ref), v31 (ref), v30 (ref), v29 (ref) ]]
		local v1 = p12 - v33
		v33 = p12
		if v26 > 0 then
			v26 = v26 - v1
		end
		if v4 == "FreeFall" and v26 <= 0 then
			playAnimation("fall", 0.2, Humanoid)
		elseif v4 == "Seated" then
			playAnimation("sit", 0.5, Humanoid)
			return
		elseif v4 == "Running" then
			playAnimation("walk", 0.2, Humanoid)
			updateVelocity(p12)
		elseif v4 == "Dead" or (v4 == "GettingUp" or (v4 == "FallingDown" or (v4 == "Seated" or v4 == "PlatformStanding"))) then
			stopAllAnimations()
		end
		local Tool = p1:FindFirstChildOfClass("Tool")
		if Tool and Tool:FindFirstChild("Handle") then
			local v2 = getToolAnim(Tool)
			if v2 then
				v24 = v2.Value
				v2.Parent = nil
				v25 = p12 + 0.3
			end
			if v25 < p12 then
				v25 = 0
				v24 = "None"
			end
			animateTool()
		else
			if v31 ~= nil then
				v31:disconnect()
			end
			v28 = ""
			v30 = nil
			if v29 ~= nil then
				v29:Stop()
				v29:Destroy()
				v29 = nil
			end
			v24 = "None"
			v30 = nil
			v25 = 0
		end
	end
	v1:GiveTask(Humanoid.Died:connect(onDied))
	v1:GiveTask(Humanoid.Running:connect(onRunning))
	v1:GiveTask(Humanoid.Jumping:connect(onJumping))
	v1:GiveTask(Humanoid.Climbing:connect(onClimbing))
	v1:GiveTask(Humanoid.GettingUp:connect(onGettingUp))
	v1:GiveTask(Humanoid.FreeFalling:connect(onFreeFall))
	v1:GiveTask(Humanoid.FallingDown:connect(onFallingDown))
	v1:GiveTask(Humanoid.Seated:connect(onSeated))
	v1:GiveTask(Humanoid.PlatformStanding:connect(onPlatformStanding))
	v1:GiveTask(Humanoid.Swimming:connect(onSwimming))
	if p1.Parent ~= nil then
		playAnimation("idle", 0.1, Humanoid)
	end
	v1:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 932 | Upvalues: p1 (copy), v1 (copy), stepAnimate (copy) ]]
		if p1.Parent == nil then
			v1:DoCleaning()
		else
			stepAnimate(os.clock())
		end
	end))
	v1:GiveTask(function() --[[ Line: 940 | Upvalues: v20 (ref) ]]
		task.defer(function() --[[ Line: 941 | Upvalues: v20 (ref) ]]
			if v20 then
				for v1, v2 in v20:GetPlayingAnimationTracks() do
					v2:Stop(0)
					v2:Destroy()
				end
			end
		end)
	end)
	return {
		Destroy = function(p1) --[[ Name: Destroy | Line: 952 | Upvalues: v1 (copy) ]]
			v1:DoCleaning()
		end
	}
end