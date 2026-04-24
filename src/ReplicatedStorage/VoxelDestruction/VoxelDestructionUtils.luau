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
local v1 = Pool.new(function()
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
v1:Populate(5000)
local function vec3Func(p1, p2)
	local v1 = p1(p2.X)
	local v2 = p1(p2.Y)
	return Vector3.new(v1, v2, p1(p2.Z))
end
local function slice(p1, p2, p3)
	local Size = p1.Size
	local v1 = p1.CFrame
	local v2 = v1 - v1.Position
	local v3 = p3:Dot(Size)
	local v4 = Size - p3 * v3
	local v5 = v3 / 2
	local v6 = -v3 / 2
	local v7 = p3:Dot(v1:PointToObjectSpace(p2))
	local v8 = v5 - v7
	local v9 = v7 - v6
	if v6 <= v7 and (v7 <= v5 and (v8 > 0.001 and v9 > 0.001)) then
		p1.CFrame = CFrame.new(v1 * (p3 * (v8 / 2 + v7))) * v2
		p1.Size = v4 + p3 * v8
		local v10 = p1:Clone()
		v10.CFrame = CFrame.new(v1 * (p3 * (-v9 / 2 + v7))) * v2
		v10.Size = v4 + p3 * v9
		v10.Parent = p1.Parent
		return p1, v10
	else
		return nil, nil
	end
end
local function cut(p1, p2, p3)
	local v1 = p3[1].CFrame
	local t = {}
	local v2 = p2 / 2
	local t2 = {}
	for i = 1, #p3 do
		t[p3[i]] = true
	end
	for v3, v4 in Enum.Axis:GetEnumItems() do
		local v5 = Vector3.FromAxis(v4)
		local v6 = v1:VectorToObjectSpace(p1:VectorToWorldSpace(v5))
		local v14, v15, v16 = p1 * (v5 * v2), Vector3.new(math.min(1, (math.abs(v6.X))), math.min(1, (math.abs(v6.Y))), (math.min(1, (math.abs(v6.Z))))), p1 * (-v5 * v2)
		for j = 1, #p3 do
			local v17, v18 = slice(p3[j], v14, v15)
			if v17 == nil or v18 == nil then
				local v19, v20 = slice(p3[j], v16, v15)
				if v19 ~= nil and v20 ~= nil then
					p3[j] = v19
					if not t[v20] then
						t[v20] = true
						table.insert(t2, v20)
					end
				end
			else
				if not t[v18] then
					t[v18] = true
					table.insert(t2, v18)
				end
				local v21, v22 = slice(v18, v16, v15)
				if v21 == nil or v22 == nil then
					p3[j] = v18
				else
					p3[j] = v21
					if not t[v22] then
						t[v22] = true
						table.insert(t2, v22)
					end
				end
			end
		end
	end
	return t2
end
local function voxelizeToXYZ(p1, p2, p3)
	local ceil = math.ceil
	local v1 = p2 / p3
	local v5 = Vector3.new(ceil(v1.X), ceil(v1.Y), (ceil(v1.Z)))
	local function f()
		for i = 1, v5.X do
			for j = 1, v5.Y do
				for k = 1, v5.Z do
					coroutine.yield(i, j, k)
				end
			end
		end
	end
	return coroutine.wrap(f)
end
local function voxelizeToRelativeVoxelV3(p1, p2, p3)
	local ceil = math.ceil
	local v1 = p2 / p3
	local v5 = Vector3.new(ceil(v1.X), ceil(v1.Y), (ceil(v1.Z)))
	local v6 = -(p3 + v5 * p3) / 2
	local function f()
		for i = 1, v5.X do
			for j = 1, v5.Y do
				for k = 1, v5.Z do
					coroutine.yield(Vector3.new(i, j, k) * p3 + v6)
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
			local v1 = (i * 73856093 + p3 * 19351301 + p42 * 83492791) % 100000000
			if t[v1] or not p4(v1, i, p3, p42) then
				return false
			end
		end
		return true
	end
	local function isXZFilled(p1, p2, p3, p42, p5)
		for i = p42, p5 do
			for j = p1, p2 do
				local v1 = (j * 73856093 + p3 * 19351301 + i * 83492791) % 100000000
				if t[v1] or not p4(v1, j, p3, i) then
					return false
				end
			end
		end
		return true
	end
	local function getChunkSize(p12, p22, p32)
		local v1 = p2
		local v2 = p3
		local count = 0
		local count_2 = 0
		local count_3 = 0
		for i = p12 + 1, p1 do
			local v3 = (i * 73856093 + p22 * 19351301 + p32 * 83492791) % 100000000
			if t[v3] or not p4(v3, i, p22, p32) then
				break
			end
			t[v3] = true
			count = count + 1
		end
		local v4 = (p12 * 73856093 + p22 * 19351301 + (p32 + 1) * 83492791) % 100000000
		if not t[v4] and p4(v4, p12, p22, p32 + 1) then
			for j = p32 + 1, v2 do
				if not isXFilled(p12, p12 + count, p22, j) then
					break
				end
				for k = p12, p12 + count do
					t[(k * 73856093 + p22 * 19351301 + j * 83492791) % 100000000] = true
				end
				count_3 = count_3 + 1
			end
		end
		local v5 = (p12 * 73856093 + (p22 + 1) * 19351301 + p32 * 83492791) % 100000000
		if not t[v5] and p4(v5, p12, p22 + 1, p32) then
			for n = p22 + 1, v1 do
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
					local v1 = (i * 73856093 + j * 19351301 + k * 83492791) % 100000000
					if not t[v1] and p4(v1, i, j, k) then
						local v2, v3, v4 = getChunkSize(i, j, k)
						coroutine.yield(i, j, k, v2 + 1, v3 + 1, v4 + 1)
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
	local v12 = v1:Get()
	v12.CastShadow = false
	v12.Size = Vector3.new(math.min(p3.X, p4.Size.X), math.min(p3.Y, p4.Size.Y), (math.min(p3.Z, p4.Size.Z)))
	v12.Material = p4.Material
	v12.Color = p4.Color
	v12.Transparency = p4.Transparency
	v12.CanTouch = false
	v12.CanCollide = math.random() < 0.1
	v12.CollisionGroup = "NoCollide"
	v12.CanQuery = false
	v12.Anchored = false
	v12.Position = p2
	v12.Parent = VoxelDestructionDebris
	v12.AssemblyLinearVelocity = ((p2 - p1).Unit * 0.5 + GeomUtils.randomPointInSphere() * 0.5 + Vector3.new(0, 1, 0)) * 100
	v12.AssemblyAngularVelocity = GeomUtils.randomPointInSphere() * 100
	task.delay(math.random(), function()
		v12.Parent = nil
		v1:Free(v12)
	end)
end
local function decompose(p1, p2, p3, p4, p5, p6, p7)
	local t = {}
	local v1 = 0
	local round = math.round
	local v2 = p2 / p3
	local v6 = Vector3.new(round(v2.X), round(v2.Y), (round(v2.Z)))
	local v7 = -(p3 + v6 * p3) / 2
	local function hasVoxelAt(p12, p2, p32)
		local v1 = Vector3.new(p12, p2, p32) * p3 + v7
		return (p1 * v1 - p4).Magnitude > p5 + math.noise(v1.X * 10 + 3845.013130122367, v1.Y * 10 + 10782.895910767973, v1.Z * 10 + 6047.444858337303) * 0.5
	end
	local v8 = 0.2 * (p3.Magnitude * 0.5773502691896257)
	local function cachedHasVoxelAt(p12, p2, p32, p42)
		if t[p12] then
			return t[p12]
		else
			local v12 = hasVoxelAt(p2, p32, p42)
			t[p12] = v12
			if p7 and (not v12 and math.random() < v8) then
				local v2 = p1 * (Vector3.new(p2, p32, p42) * p3 + v7)
				task.delay(math.random() * 0.2, function()
					tossDebris(p4, v2, p3, p6)
				end)
			end
			if v12 then
				v1 = v1 + 1
			end
			return v12
		end
	end
	local Model = Instance.new("Model")
	Model.Parent = p6.Parent
	local v9 = p6:IsA("BasePart")
	local count = 0
	for v11, v12, v13, v14, v15, v16 in greedyMesh(v6.X, v6.Y, v6.Z, cachedHasVoxelAt) do
		local v10
		local v17 = Vector3.new(v14, v15, v16)
		local v18 = (Vector3.new(v11 - 0.5, v12 - 0.5, v13 - 0.5) + v17 * 0.5) * p3 + v7
		if v9 then
			local v19 = Instance.new(p6.ClassName)
			v19.Anchored = p6.Anchored
			v19.CanCollide = p6.CanCollide
			v19.CastShadow = false
			v19.Material = p6.Material
			v19.MaterialVariant = p6.MaterialVariant
			v19.Color = p6.Color
			v19.Transparency = p6.Transparency
			v19.Size = v17 * p3
			v19.CFrame = p1 * CFrame.new(v18)
			v19.TopSurface = p6.TopSurface
			v19.BottomSurface = p6.BottomSurface
			v10 = v19
		else
			v10 = nil
		end
		v10.Parent = Model
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
	local v1 = CollisionDetectionDummyPart.Touched:Connect(function()  end)
	local v2 = CollisionDetectionDummyPart:GetTouchingParts()
	v1:Disconnect()
	CollisionDetectionDummyPart:Destroy()
	return v2
end
local function alignToVoxelGrid(p1, p2, p3, p4)
	local round = math.round
	local v1 = (p1 * (-p2 / 2 + p3 / 2) + p4) / p3
	local v5 = Vector3.new(round(v1.X), round(v1.Y), (round(v1.Z))) * p3 - p4 - p3 / 2
	local round_2 = math.round
	local v6 = (p1 * (p2 / 2 - p3 / 2) + p4) / p3
	local v10 = Vector3.new(round_2(v6.X), round_2(v6.Y), (round_2(v6.Z))) * p3 - p4 + p3 / 2
	return CFrame.new((v5 + v10) / 2), v10 - v5
end
local function getVoxelSize(p1, p2)
	local v1 = p2:GetAttribute(VoxelDestructionConsts.VOXEL_SIZE_ATTR_NAME)
	if v1 then
		return v1
	elseif p1.voxelSize then
		return p1.voxelSize
	else
		return Vector3.new(1, 1, 1)
	end
end
local function isWaterAroundPosition(p1, p2)
	local v1 = Terrain:ReadVoxels(Region3.new(p1 - Vector3.new(1, 1, 1) * p2 * 4, p1 + Vector3.new(1, 1, 1) * p2 * 4), 4)
	local Size = v1.Size
	for i = 1, Size.X do
		for j = 1, Size.Y do
			for k = 1, Size.Z do
				if v1[i][j][k] == Enum.Material.Water then
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
		for v4, v5 in workspace:GetPartBoundsInRadius(p1.spherePosition, p1.sphereRadius, p1.overlapParams) do
			local v2, v3
			if not CollectionService:HasTag(v5, VoxelDestructionConsts.VOXEL_INDESTRUCTIBLE_TAG_NAME) and (not p1.partsOnly or v5:IsA("Part")) and (v5.CanCollide and v5.Transparency ~= 1) then
				v2 = v5:GetAttribute(VoxelDestructionConsts.VOXEL_SIZE_ATTR_NAME) or (p1.voxelSize or Vector3.new(1, 1, 1))
				if v5.Size.Magnitude <= v2.Magnitude + 0.1 then
					if p1.fx then
						tossDebris(p1.spherePosition, v5.Position, v2, v5)
					end
					if p1.copy then
						table.insert(t, { v5, v5.Parent })
						v5.Parent = nil
					else
						v5:Destroy()
					end
				else
					local v7 = v5.CFrame
					local round = math.round
					local v8 = v5.Size / v2
					local v12 = -(v2 + Vector3.new(round(v8.X), round(v8.Y), (round(v8.Z))) * v2) / 2
					local v15, v16 = alignToVoxelGrid(v7:ToObjectSpace(v7 - v7.Position + p1.spherePosition), Vector3.new(1, 1, 1) * p1.sphereRadius * 2 + v2 * 2, v2, v12)
					local v17 = v7:ToWorldSpace(v15)
					if p1.copy then
						local v18 = v5:Clone()
						v18.Parent = v5.Parent
						table.insert(t, { v5, v5.Parent })
						v5.Parent = nil
						v3 = v18
					else
						v3 = v5
					end
					local t3 = { v3 }
					local v19 = cut(v17, v16, t3)
					table.insert(t2, v3)
					TableUtils.concatInPlace(t2, v19)
					local v20 = OverlapParams.new()
					v20.FilterType = Enum.RaycastFilterType.Include
					v20.FilterDescendantsInstances = t3
					local v21 = workspace:GetPartBoundsInBox(v17, v16 - Vector3.new(0.1, 0.1, 0.1), v20)
					for i = 1, #v21 do
						local v22 = v21[i]
						local v24, v25 = alignToVoxelGrid(v7:ToObjectSpace(v22.CFrame), v22.Size, v2, v12)
						table.insert(t2, (decompose(v7:ToWorldSpace(v24), v25, v2, p1.spherePosition, p1.sphereRadius, v3, p1.fx)))
						v22:Destroy()
					end
				end
			end
		end
		return function()
			for v1, v2 in t do
				pcall(function()
					v2[1].Parent = v2[2]
				end)
			end
			for v3, v4 in t2 do
				v4:Destroy()
			end
		end
	end
}
local t2 = {}
local v2 = nil
function t.addToRestoreVoxelDestructionQueue(p1)
	if v2 then
		task.cancel(v2)
		v2 = nil
	end
	table.insert(t2, p1)
	local v22 = Players.LocalPlayer:GetNetworkPing()
	if RunService:IsStudio() then
		v22 = math.max(v22, 0.15)
	end
	v2 = task.delay(2 * v22 + 0.1, function()
		for i = #t2, 1, -1 do
			t2[i]()
		end
		table.clear(t2)
	end)
end
return t
