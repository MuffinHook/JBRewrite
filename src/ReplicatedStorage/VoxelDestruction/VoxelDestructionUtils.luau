-- Reviewed by Claude
local Terrain = workspace:FindFirstChild("Terrain")
local CollectionService = game:GetService("CollectionService")
game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Pool = require(ReplicatedStorage.Std.Debug.Pool)
local VoxelDestructionConsts = require(ReplicatedStorage.VoxelDestruction.VoxelDestructionConsts)
local instance = Pool.new(function()
	local Part = Instance.new("Part")
	Part.Anchored = true
	local SmoothNoOutlines = Enum.SurfaceType.SmoothNoOutlines
	local SmoothNoOutlines_2 = Enum.SurfaceType.SmoothNoOutlines
	Part.TopSurface = SmoothNoOutlines
	Part.BottomSurface = SmoothNoOutlines_2
	return Part
end, function(p1)
	p1:Destroy()
end)
instance:Populate(5000)
local function vec3Func(p1, p2)
	local instance = p1(p2.X)
	local vector2 = p1(p2.Y)
	return Vector3.new(instance, vector2, p1(p2.Z))
end
local function slice(p1, p2, p3)
	local Size = p1.Size
	local instance = p1.CFrame
	local vector2 = instance - instance.Position
	local var3 = p3:Dot(Size)
	local var4 = Size - p3 * var3
	local var5 = var3 / 2
	local var6 = -var3 / 2
	local var7 = p3:Dot(instance:PointToObjectSpace(p2))
	local var8 = var5 - var7
	local var9 = var7 - var6
	if var6 <= var7 and (var7 <= var5 and (var8 > 0.001 and var9 > 0.001)) then
		p1.CFrame = CFrame.new(instance * (p3 * (var8 / 2 + var7))) * vector2
		p1.Size = var4 + p3 * var8
		local var10 = p1:Clone()
		var10.CFrame = CFrame.new(instance * (p3 * (-var9 / 2 + var7))) * vector2
		var10.Size = var4 + p3 * var9
		var10.Parent = p1.Parent
		return p1, var10
	else
		return nil, nil
	end
end
local function cut(p1, p2, p3)
	local instance = p3[1].CFrame
	local t = {}
	local vector2 = p2 / 2
	local t2 = {}
	for i = 1, #p3 do
		t[p3[i]] = true
	end
	for var3, var4 in Enum.Axis:GetEnumItems() do
		local var5 = Vector3.FromAxis(var4)
		local var6 = instance:VectorToObjectSpace(p1:VectorToWorldSpace(var5))
		local v14, v15, v16 = p1 * (var5 * vector2), Vector3.new(math.min(1, (math.abs(var6.X))), math.min(1, (math.abs(var6.Y))), (math.min(1, (math.abs(var6.Z))))), p1 * (-var5 * vector2)
		for j = 1, #p3 do
			local vector17, vector18 = slice(p3[j], v14, v15)
			if vector17 == nil or vector18 == nil then
				local instance19, instance20 = slice(p3[j], v16, v15)
				if instance19 ~= nil and instance20 ~= nil then
					p3[j] = instance19
					if not t[instance20] then
						t[instance20] = true
						table.insert(t2, instance20)
					end
				end
			else
				if not t[vector18] then
					t[vector18] = true
					table.insert(t2, vector18)
				end
				local vector21, var22 = slice(vector18, v16, v15)
				if vector21 == nil or var22 == nil then
					p3[j] = vector18
				else
					p3[j] = vector21
					if not t[var22] then
						t[var22] = true
						table.insert(t2, var22)
					end
				end
			end
		end
	end
	return t2
end
local function voxelizeToXYZ(p1, p2, p3)
	local ceil = math.ceil
	local instance = p2 / p3
	local var5 = Vector3.new(ceil(instance.X), ceil(instance.Y), (ceil(instance.Z)))
	local function f()
		for i = 1, var5.X do
			for j = 1, var5.Y do
				for k = 1, var5.Z do
					coroutine.yield(i, j, k)
				end
			end
		end
	end
	return coroutine.wrap(f)
end
local function voxelizeToRelativeVoxelV3(p1, p2, p3)
	local ceil = math.ceil
	local instance = p2 / p3
	local var5 = Vector3.new(ceil(instance.X), ceil(instance.Y), (ceil(instance.Z)))
	local var6 = -(p3 + var5 * p3) / 2
	local function f()
		for i = 1, var5.X do
			for j = 1, var5.Y do
				for k = 1, var5.Z do
					coroutine.yield(Vector3.new(i, j, k) * p3 + var6)
				end
			end
		end
	end
	return coroutine.wrap(f)
end
local function vec3Hash(p1)
	return (p1.X * 73856093 + p1.Y * 19351301 + p1.Z * 83492791) % 100000000
end
local function xyzHash(p1, p2, p3)
	return (p1 * 73856093 + p2 * 19351301 + p3 * 83492791) % 100000000
end
local function greedyMesh(p1, p2, p3, p4)
	local t = {}
	local function isXFilled(p1, p2, p3, p42)
		for i = p1, p2 do
			local instance = (i * 73856093 + p3 * 19351301 + p42 * 83492791) % 100000000
			if t[instance] or not p4(instance, i, p3, p42) then
				return false
			end
		end
		return true
	end
	local function isXZFilled(p1, p2, p3, p42, p5)
		for i = p42, p5 do
			for j = p1, p2 do
				local instance = (j * 73856093 + p3 * 19351301 + i * 83492791) % 100000000
				if t[instance] or not p4(instance, j, p3, i) then
					return false
				end
			end
		end
		return true
	end
	local function getChunkSize(p12, p22, p32)
		local instance = p2
		local vector2 = p3
		local count = 0
		local count_2 = 0
		local count_3 = 0
		for i = p12 + 1, p1 do
			local var3 = (i * 73856093 + p22 * 19351301 + p32 * 83492791) % 100000000
			if t[var3] or not p4(var3, i, p22, p32) then
				break
			end
			t[var3] = true
			count = count + 1
		end
		local var4 = (p12 * 73856093 + p22 * 19351301 + (p32 + 1) * 83492791) % 100000000
		if not t[var4] and p4(var4, p12, p22, p32 + 1) then
			for j = p32 + 1, vector2 do
				if not isXFilled(p12, p12 + count, p22, j) then
					break
				end
				for k = p12, p12 + count do
					t[(k * 73856093 + p22 * 19351301 + j * 83492791) % 100000000] = true
				end
				count_3 = count_3 + 1
			end
		end
		local var5 = (p12 * 73856093 + (p22 + 1) * 19351301 + p32 * 83492791) % 100000000
		if not t[var5] and p4(var5, p12, p22 + 1, p32) then
			for n = p22 + 1, instance do
				if not isXZFilled(p12, p12 + count, n, p32, p32 + count_3) then
					break
				end
				for m = p32, p32 + count_3 do
					for i = p12, p12 + count do
						t[(i * 73856093 + n * 19351301 + m * 83492791) % 100000000] = true
					end
				end
				count_2 = count_2 + 1
			end
		end
		return count, count_2, count_3
	end
	local function f()
		for i = 1, p1 do
			for j = 1, p2 do
				for k = 1, p3 do
					local instance = (i * 73856093 + j * 19351301 + k * 83492791) % 100000000
					if not t[instance] and p4(instance, i, j, k) then
						local vector2, var3, var4 = getChunkSize(i, j, k)
						coroutine.yield(i, j, k, vector2 + 1, var3 + 1, var4 + 1)
					end
				end
			end
		end
	end
	return coroutine.wrap(f)
end
local VoxelDestructionDebris = Instance.new("Model")
VoxelDestructionDebris.Name = "VoxelDestructionDebris"
VoxelDestructionDebris.Parent = workspace
local function tossDebris(p1, p2, p3, p4)
	local var12 = instance:Get()
	var12.CastShadow = false
	var12.Size = Vector3.new(math.min(p3.X, p4.Size.X), math.min(p3.Y, p4.Size.Y), (math.min(p3.Z, p4.Size.Z)))
	var12.Material = p4.Material
	var12.Color = p4.Color
	var12.Transparency = p4.Transparency
	var12.CanTouch = false
	var12.CanCollide = math.random() < 0.1
	var12.CollisionGroup = "NoCollide"
	var12.CanQuery = false
	var12.Anchored = false
	var12.Position = p2
	var12.Parent = VoxelDestructionDebris
	var12.AssemblyLinearVelocity = ((p2 - p1).Unit * 0.5 + GeomUtils.randomPointInSphere() * 0.5 + Vector3.new(0, 1, 0)) * 100
	var12.AssemblyAngularVelocity = GeomUtils.randomPointInSphere() * 100
	task.delay(math.random(), function()
		var12.Parent = nil
		instance:Free(var12)
	end)
end
local function decompose(p1, p2, p3, p4, p5, p6, p7)
	local t = {}
	local instance = 0
	local round = math.round
	local vector2 = p2 / p3
	local var6 = Vector3.new(round(vector2.X), round(vector2.Y), (round(vector2.Z)))
	local var7 = -(p3 + var6 * p3) / 2
	local function hasVoxelAt(p12, p2, p32)
		local instance = Vector3.new(p12, p2, p32) * p3 + var7
		return (p1 * instance - p4).Magnitude > p5 + math.noise(instance.X * 10 + 3845.013130122367, instance.Y * 10 + 10782.895910767973, instance.Z * 10 + 6047.444858337303) * 0.5
	end
	local var8 = 0.2 * (p3.Magnitude * 0.5773502691896257)
	local function cachedHasVoxelAt(p12, p2, p32, p42)
		if t[p12] then
			return t[p12]
		else
			local var12 = hasVoxelAt(p2, p32, p42)
			t[p12] = var12
			if p7 and (not var12 and math.random() < var8) then
				local vector2 = p1 * (Vector3.new(p2, p32, p42) * p3 + var7)
				task.delay(math.random() * 0.2, function()
					tossDebris(p4, vector2, p3, p6)
				end)
			end
			if var12 then
				instance = instance + 1
			end
			return var12
		end
	end
	local Model = Instance.new("Model")
	Model.Parent = p6.Parent
	local var9 = p6:IsA("BasePart")
	local count = 0
	for v11, var12, v13, v14, v15, v16 in greedyMesh(var6.X, var6.Y, var6.Z, cachedHasVoxelAt) do
		local var10
		local vector17 = Vector3.new(v14, v15, v16)
		local vector18 = (Vector3.new(v11 - 0.5, var12 - 0.5, v13 - 0.5) + vector17 * 0.5) * p3 + var7
		if var9 then
			local instance19 = Instance.new(p6.ClassName)
			instance19.Anchored = p6.Anchored
			instance19.CanCollide = p6.CanCollide
			instance19.CastShadow = false
			instance19.Material = p6.Material
			instance19.MaterialVariant = p6.MaterialVariant
			instance19.Color = p6.Color
			instance19.Transparency = p6.Transparency
			instance19.Size = vector17 * p3
			instance19.CFrame = p1 * CFrame.new(vector18)
			instance19.TopSurface = p6.TopSurface
			instance19.BottomSurface = p6.BottomSurface
			var10 = instance19
		else
			var10 = nil
		end
		var10.Parent = Model
		count = count + 1
	end
	return Model
end
local function getBoundingBoxParts(p1, p2)
	local CollisionDetectionDummyPart = Instance.new("Part")
	CollisionDetectionDummyPart.Name = "CollisionDetectionDummyPart"
	CollisionDetectionDummyPart.Size = p2
	CollisionDetectionDummyPart.CFrame = p1
	CollisionDetectionDummyPart.Anchored = false
	CollisionDetectionDummyPart.CanCollide = true
	CollisionDetectionDummyPart.Parent = workspace
	local instance = CollisionDetectionDummyPart.Touched:Connect(function()  end)
	local vector2 = CollisionDetectionDummyPart:GetTouchingParts()
	instance:Disconnect()
	CollisionDetectionDummyPart:Destroy()
	return vector2
end
local function alignToVoxelGrid(p1, p2, p3, p4)
	local round = math.round
	local instance = (p1 * (-p2 / 2 + p3 / 2) + p4) / p3
	local var5 = Vector3.new(round(instance.X), round(instance.Y), (round(instance.Z))) * p3 - p4 - p3 / 2
	local round_2 = math.round
	local var6 = (p1 * (p2 / 2 - p3 / 2) + p4) / p3
	local var10 = Vector3.new(round_2(var6.X), round_2(var6.Y), (round_2(var6.Z))) * p3 - p4 + p3 / 2
	return CFrame.new((var5 + var10) / 2), var10 - var5
end
local function getVoxelSize(p1, p2)
	local instance = p2:GetAttribute(VoxelDestructionConsts.VOXEL_SIZE_ATTR_NAME)
	if instance then
		return instance
	elseif p1.voxelSize then
		return p1.voxelSize
	else
		return Vector3.new(1, 1, 1)
	end
end
local function isWaterAroundPosition(p1, p2)
	local instance = Terrain:ReadVoxels(Region3.new(p1 - Vector3.new(1, 1, 1) * p2 * 4, p1 + Vector3.new(1, 1, 1) * p2 * 4), 4)
	local Size = instance.Size
	for i = 1, Size.X do
		for j = 1, Size.Y do
			for k = 1, Size.Z do
				if instance[i][j][k] == Enum.Material.Water then
					return true
				end
			end
		end
	end
	return false
end
local t = {
	subtractSphere = function(p1)
		if not p1.fx then
			p1.fx = false
		end
		assert(p1.fx ~= nil)
		if not p1.copy then
			p1.copy = false
		end
		if not (p1.terrainDamageDisabled or isWaterAroundPosition(p1.spherePosition, p1.sphereRadius * 0.4)) then
			Terrain:FillBall(p1.spherePosition, p1.sphereRadius, Enum.Material.Air)
		end
		local t = {}
		local t2 = {}
		for var4, var5 in workspace:GetPartBoundsInRadius(p1.spherePosition, p1.sphereRadius, p1.overlapParams) do
			local vector2, var3
			if not CollectionService:HasTag(var5, VoxelDestructionConsts.VOXEL_INDESTRUCTIBLE_TAG_NAME) and (not p1.partsOnly or var5:IsA("Part")) and (var5.CanCollide and var5.Transparency ~= 1) then
				vector2 = var5:GetAttribute(VoxelDestructionConsts.VOXEL_SIZE_ATTR_NAME) or (p1.voxelSize or Vector3.new(1, 1, 1))
				if var5.Size.Magnitude <= vector2.Magnitude + 0.1 then
					if p1.fx then
						tossDebris(p1.spherePosition, var5.Position, vector2, var5)
					end
					if p1.copy then
						table.insert(t, { var5, var5.Parent })
						var5.Parent = nil
					else
						var5:Destroy()
					end
				else
					local var7 = var5.CFrame
					local round = math.round
					local var8 = var5.Size / vector2
					local var12 = -(vector2 + Vector3.new(round(var8.X), round(var8.Y), (round(var8.Z))) * vector2) / 2
					local v15, v16 = alignToVoxelGrid(var7:ToObjectSpace(var7 - var7.Position + p1.spherePosition), Vector3.new(1, 1, 1) * p1.sphereRadius * 2 + vector2 * 2, vector2, var12)
					local vector17 = var7:ToWorldSpace(v15)
					if p1.copy then
						local vector18 = var5:Clone()
						vector18.Parent = var5.Parent
						table.insert(t, { var5, var5.Parent })
						var5.Parent = nil
						var3 = vector18
					else
						var3 = var5
					end
					local t3 = { var3 }
					local instance19 = cut(vector17, v16, t3)
					table.insert(t2, var3)
					TableUtils.concatInPlace(t2, instance19)
					local instance20 = OverlapParams.new()
					instance20.FilterType = Enum.RaycastFilterType.Include
					instance20.FilterDescendantsInstances = t3
					local vector21 = workspace:GetPartBoundsInBox(vector17, v16 - Vector3.new(0.1, 0.1, 0.1), instance20)
					for i = 1, #vector21 do
						local var22 = vector21[i]
						local v24, v25 = alignToVoxelGrid(var7:ToObjectSpace(var22.CFrame), var22.Size, vector2, var12)
						table.insert(t2, (decompose(var7:ToWorldSpace(v24), v25, vector2, p1.spherePosition, p1.sphereRadius, var3, p1.fx)))
						var22:Destroy()
					end
				end
			end
		end
		return function()
			for instance, vector2 in t do
				pcall(function()
					vector2[1].Parent = vector2[2]
				end)
			end
			for var3, var4 in t2 do
				var4:Destroy()
			end
		end
	end
}
local t2 = {}
local vector2 = nil
function t.addToRestoreVoxelDestructionQueue(p1)
	if vector2 then
		task.cancel(vector2)
		vector2 = nil
	end
	table.insert(t2, p1)
	local var22 = Players.LocalPlayer:GetNetworkPing()
	if RunService:IsStudio() then
		var22 = math.max(var22, 0.15)
	end
	vector2 = task.delay(2 * var22 + 0.1, function()
		for i = #t2, 1, -1 do
			t2[i]()
		end
		table.clear(t2)
	end)
end
return t
