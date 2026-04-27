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
end, function(partToDestroy)
	partToDestroy:Destroy()
end)
instance:Populate(5000)
local function vec3Func(transformFunc, vector)
	local transformedX = transformFunc(vector.X)
	local transformedY = transformFunc(vector.Y)
	return Vector3.new(transformedX, transformedY, transformFunc(vector.Z))
end
local function slice(targetPart, cutPoint, sliceAxis)
	local Size = targetPart.Size
	local currentCFrame = targetPart.CFrame
	local rotationOnly = currentCFrame - currentCFrame.Position
	local axisExtent = sliceAxis:Dot(Size)
	local perpendiculars = Size - sliceAxis * axisExtent
	local halfExtent = axisExtent / 2
	local negHalfExtent = -axisExtent / 2
	local localCutPosition = sliceAxis:Dot(currentCFrame:PointToObjectSpace(cutPoint))
	local distanceAboveCut = halfExtent - localCutPosition
	local distanceBelowCut = localCutPosition - negHalfExtent
	if negHalfExtent <= localCutPosition and (localCutPosition <= halfExtent and (distanceAboveCut > 0.001 and distanceBelowCut > 0.001)) then
		targetPart.CFrame = CFrame.new(currentCFrame * (sliceAxis * (distanceAboveCut / 2 + localCutPosition))) * rotationOnly
		targetPart.Size = perpendiculars + sliceAxis * distanceAboveCut
		local clonedPart = targetPart:Clone()
		clonedPart.CFrame = CFrame.new(currentCFrame * (sliceAxis * (-distanceBelowCut / 2 + localCutPosition))) * rotationOnly
		clonedPart.Size = perpendiculars + sliceAxis * distanceBelowCut
		clonedPart.Parent = targetPart.Parent
		return targetPart, clonedPart
	else
		return nil, nil
	end
end
local function cut(cutFrame, sphereRadius, partsToSlice)
	local baseCFrame = partsToSlice[1].CFrame
	local processedParts = {}
	local radiusHalf = sphereRadius / 2
	local newParts = {}
	for i = 1, #partsToSlice do
		processedParts[partsToSlice[i]] = true
	end
	for axisIndex, axisEnum in Enum.Axis:GetEnumItems() do
		local axisDirection = Vector3.FromAxis(axisEnum)
		local localAxisDir = baseCFrame:VectorToObjectSpace(cutFrame:VectorToWorldSpace(axisDirection))
		local positiveCutPoint, axisAlignment, negativeCutPoint = cutFrame * (axisDirection * radiusHalf), Vector3.new(math.min(1, (math.abs(localAxisDir.X))), math.min(1, (math.abs(localAxisDir.Y))), (math.min(1, (math.abs(localAxisDir.Z))))), cutFrame * (-axisDirection * radiusHalf)
		for j = 1, #partsToSlice do
			local sliceResult1, sliceResult2 = slice(partsToSlice[j], positiveCutPoint, axisAlignment)
			if sliceResult1 == nil or sliceResult2 == nil then
				local sliceFromNeg1, sliceFromNeg2 = slice(partsToSlice[j], negativeCutPoint, axisAlignment)
				if sliceFromNeg1 ~= nil and sliceFromNeg2 ~= nil then
					partsToSlice[j] = sliceFromNeg1
					if not processedParts[sliceFromNeg2] then
						processedParts[sliceFromNeg2] = true
						table.insert(newParts, sliceFromNeg2)
					end
				end
			else
				if not processedParts[sliceResult2] then
					processedParts[sliceResult2] = true
					table.insert(newParts, sliceResult2)
				end
				local sliceFromResult2First, sliceFromResult2Second = slice(sliceResult2, negativeCutPoint, axisAlignment)
				if sliceFromResult2First == nil or sliceFromResult2Second == nil then
					partsToSlice[j] = sliceResult2
				else
					partsToSlice[j] = sliceFromResult2First
					if not processedParts[sliceFromResult2Second] then
						processedParts[sliceFromResult2Second] = true
						table.insert(newParts, sliceFromResult2Second)
					end
				end
			end
		end
	end
	return newParts
end
local function voxelizeToXYZ(partCFrame, partSize, voxelSize)
	local ceil = math.ceil
	local gridDimensions = partSize / voxelSize
	local voxelGridSize = Vector3.new(ceil(gridDimensions.X), ceil(gridDimensions.Y), (ceil(gridDimensions.Z)))
	local function f()
		for i = 1, voxelGridSize.X do
			for j = 1, voxelGridSize.Y do
				for k = 1, voxelGridSize.Z do
					coroutine.yield(i, j, k)
				end
			end
		end
	end
	return coroutine.wrap(f)
end
local function voxelizeToRelativeVoxelV3(partCFrame, partSize, voxelSize)
	local ceil = math.ceil
	local gridDimensions = partSize / voxelSize
	local voxelGridSize = Vector3.new(ceil(gridDimensions.X), ceil(gridDimensions.Y), (ceil(gridDimensions.Z)))
	local gridOffset = -(voxelSize + voxelGridSize * voxelSize) / 2
	local function f()
		for i = 1, voxelGridSize.X do
			for j = 1, voxelGridSize.Y do
				for k = 1, voxelGridSize.Z do
					coroutine.yield(Vector3.new(i, j, k) * voxelSize + gridOffset)
				end
			end
		end
	end
	return coroutine.wrap(f)
end
local function vec3Hash(vector)
	return (vector.X * 73856093 + vector.Y * 19351301 + vector.Z * 83492791) % 100000000
end
local function xyzHash(x, y, z)
	return (x * 73856093 + y * 19351301 + z * 83492791) % 100000000
end
local function greedyMesh(gridWidth, gridHeight, gridDepth, isFilled)
	local processedHashes = {}
	local function isXFilled(startX, endX, y, z)
		for i = startX, endX do
			local cellHash = (i * 73856093 + y * 19351301 + z * 83492791) % 100000000
			if processedHashes[cellHash] or not isFilled(cellHash, i, y, z) then
				return false
			end
		end
		return true
	end
	local function isXZFilled(startX, endX, y, startZ, endZ)
		for i = startZ, endZ do
			for j = startX, endX do
				local cellHash = (j * 73856093 + y * 19351301 + i * 83492791) % 100000000
				if processedHashes[cellHash] or not isFilled(cellHash, j, y, i) then
					return false
				end
			end
		end
		return true
	end
	local function getChunkSize(startCellX, startCellY, startCellZ)
		local gridHeightVal = gridHeight
		local gridDepthVal = gridDepth
		local chunkWidthX = 0
		local chunkDepthZ = 0
		local chunkHeightY = 0
		for i = startCellX + 1, gridWidth do
			local cellHash = (i * 73856093 + startCellY * 19351301 + startCellZ * 83492791) % 100000000
			if processedHashes[cellHash] or not isFilled(cellHash, i, startCellY, startCellZ) then
				break
			end
			processedHashes[cellHash] = true
			chunkWidthX = chunkWidthX + 1
		end
		local checkBelowHash = (startCellX * 73856093 + startCellY * 19351301 + (startCellZ + 1) * 83492791) % 100000000
		if not processedHashes[checkBelowHash] and isFilled(checkBelowHash, startCellX, startCellY, startCellZ + 1) then
			for j = startCellZ + 1, gridDepthVal do
				if not isXFilled(startCellX, startCellX + chunkWidthX, startCellY, j) then
					break
				end
				for k = startCellX, startCellX + chunkWidthX do
					processedHashes[(k * 73856093 + startCellY * 19351301 + j * 83492791) % 100000000] = true
				end
				chunkDepthZ = chunkDepthZ + 1
			end
		end
		local checkAboveHash = (startCellX * 73856093 + (startCellY + 1) * 19351301 + startCellZ * 83492791) % 100000000
		if not processedHashes[checkAboveHash] and isFilled(checkAboveHash, startCellX, startCellY + 1, startCellZ) then
			for n = startCellY + 1, gridHeightVal do
				if not isXZFilled(startCellX, startCellX + chunkWidthX, n, startCellZ, startCellZ + chunkDepthZ) then
					break
				end
				for m = startCellZ, startCellZ + chunkDepthZ do
					for i = startCellX, startCellX + chunkWidthX do
						processedHashes[(i * 73856093 + n * 19351301 + m * 83492791) % 100000000] = true
					end
				end
				chunkHeightY = chunkHeightY + 1
			end
		end
		return chunkWidthX, chunkHeightY, chunkDepthZ
	end
	local function f()
		for i = 1, gridWidth do
			for j = 1, gridHeight do
				for k = 1, gridDepth do
					local cellHash = (i * 73856093 + j * 19351301 + k * 83492791) % 100000000
					if not processedHashes[cellHash] and isFilled(cellHash, i, j, k) then
						local chunkX, chunkY, chunkZ = getChunkSize(i, j, k)
						coroutine.yield(i, j, k, chunkX + 1, chunkY + 1, chunkZ + 1)
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
local function tossDebris(damageOrigin, debrisPosition, debrisSize, sourceBlock)
	local debrisBlock = instance:Get()
	debrisBlock.CastShadow = false
	debrisBlock.Size = Vector3.new(math.min(debrisSize.X, sourceBlock.Size.X), math.min(debrisSize.Y, sourceBlock.Size.Y), (math.min(debrisSize.Z, sourceBlock.Size.Z)))
	debrisBlock.Material = sourceBlock.Material
	debrisBlock.Color = sourceBlock.Color
	debrisBlock.Transparency = sourceBlock.Transparency
	debrisBlock.CanTouch = false
	debrisBlock.CanCollide = math.random() < 0.1
	debrisBlock.CollisionGroup = "NoCollide"
	debrisBlock.CanQuery = false
	debrisBlock.Anchored = false
	debrisBlock.Position = debrisPosition
	debrisBlock.Parent = VoxelDestructionDebris
	debrisBlock.AssemblyLinearVelocity = ((debrisPosition - damageOrigin).Unit * 0.5 + GeomUtils.randomPointInSphere() * 0.5 + Vector3.new(0, 1, 0)) * 100
	debrisBlock.AssemblyAngularVelocity = GeomUtils.randomPointInSphere() * 100
	task.delay(math.random(), function()
		debrisBlock.Parent = nil
		instance:Free(debrisBlock)
	end)
end
local function decompose(partCFrame, partSize, voxelSize, sphereCenter, sphereRadius, sourceBlock, enableFx)
	local voxelLookup = {}
	local filledVoxelCount = 0
	local round = math.round
	local gridDimensions = partSize / voxelSize
	local voxelGridSize = Vector3.new(round(gridDimensions.X), round(gridDimensions.Y), (round(gridDimensions.Z)))
	local gridOffset = -(voxelSize + voxelGridSize * voxelSize) / 2
	local function hasVoxelAt(gridX, gridY, gridZ)
		local voxelWorldPos = Vector3.new(gridX, gridY, gridZ) * voxelSize + gridOffset
		return (partCFrame * voxelWorldPos - sphereCenter).Magnitude > sphereRadius + math.noise(voxelWorldPos.X * 10 + 3845.013130122367, voxelWorldPos.Y * 10 + 10782.895910767973, voxelWorldPos.Z * 10 + 6047.444858337303) * 0.5
	end
	local voxelErosionThreshold = 0.2 * (voxelSize.Magnitude * 0.5773502691896257)
	local function cachedHasVoxelAt(cellHash, gridX, gridY, gridZ)
		if voxelLookup[cellHash] then
			return voxelLookup[cellHash]
		else
			local hasVoxel = hasVoxelAt(gridY, gridZ, gridX)
			voxelLookup[cellHash] = hasVoxel
			if enableFx and (not hasVoxel and math.random() < voxelErosionThreshold) then
				local voxelWorldPos = partCFrame * (Vector3.new(gridY, gridZ, gridX) * voxelSize + gridOffset)
				task.delay(math.random() * 0.2, function()
					tossDebris(sphereCenter, voxelWorldPos, voxelSize, sourceBlock)
				end)
			end
			if hasVoxel then
				filledVoxelCount = filledVoxelCount + 1
			end
			return hasVoxel
		end
	end
	local DecomposedModel = Instance.new("Model")
	DecomposedModel.Parent = sourceBlock.Parent
	local isBasePart = sourceBlock:IsA("BasePart")
	local meshBlockCount = 0
	for gridX, gridY, gridZ, chunkWidth, chunkHeight, chunkDepth in greedyMesh(voxelGridSize.X, voxelGridSize.Y, voxelGridSize.Z, cachedHasVoxelAt) do
		local newMeshBlock
		local chunkSize = Vector3.new(chunkWidth, chunkHeight, chunkDepth)
		local chunkWorldPos = (Vector3.new(gridX - 0.5, gridY - 0.5, gridZ - 0.5) + chunkSize * 0.5) * voxelSize + gridOffset
		if isBasePart then
			local newBlock = Instance.new(sourceBlock.ClassName)
			newBlock.Anchored = sourceBlock.Anchored
			newBlock.CanCollide = sourceBlock.CanCollide
			newBlock.CastShadow = false
			newBlock.Material = sourceBlock.Material
			newBlock.MaterialVariant = sourceBlock.MaterialVariant
			newBlock.Color = sourceBlock.Color
			newBlock.Transparency = sourceBlock.Transparency
			newBlock.Size = chunkSize * voxelSize
			newBlock.CFrame = partCFrame * CFrame.new(chunkWorldPos)
			newBlock.TopSurface = sourceBlock.TopSurface
			newBlock.BottomSurface = sourceBlock.BottomSurface
			newMeshBlock = newBlock
		else
			newMeshBlock = nil
		end
		newMeshBlock.Parent = DecomposedModel
		meshBlockCount = meshBlockCount + 1
	end
	return DecomposedModel
end
local function getBoundingBoxParts(boundingCFrame, boundingSize)
	local CollisionDetectionDummyPart = Instance.new("Part")
	CollisionDetectionDummyPart.Name = "CollisionDetectionDummyPart"
	CollisionDetectionDummyPart.Size = boundingSize
	CollisionDetectionDummyPart.CFrame = boundingCFrame
	CollisionDetectionDummyPart.Anchored = false
	CollisionDetectionDummyPart.CanCollide = true
	CollisionDetectionDummyPart.Parent = workspace
	local touchConnection = CollisionDetectionDummyPart.Touched:Connect(function()  end)
	local touchingParts = CollisionDetectionDummyPart:GetTouchingParts()
	touchConnection:Disconnect()
	CollisionDetectionDummyPart:Destroy()
	return touchingParts
end
local function alignToVoxelGrid(partCFrame, partSize, voxelSize, gridOffset)
	local round = math.round
	local alignedMin = (partCFrame * (-partSize / 2 + voxelSize / 2) + gridOffset) / voxelSize
	local alignedMinSnapped = Vector3.new(round(alignedMin.X), round(alignedMin.Y), (round(alignedMin.Z))) * voxelSize - gridOffset - voxelSize / 2
	local round_2 = math.round
	local alignedMax = (partCFrame * (partSize / 2 - voxelSize / 2) + gridOffset) / voxelSize
	local alignedMaxSnapped = Vector3.new(round_2(alignedMax.X), round_2(alignedMax.Y), (round_2(alignedMax.Z))) * voxelSize - gridOffset + voxelSize / 2
	return CFrame.new((alignedMinSnapped + alignedMaxSnapped) / 2), alignedMaxSnapped - alignedMinSnapped
end
local function getVoxelSize(config, targetBlock)
	local storedVoxelSize = targetBlock:GetAttribute(VoxelDestructionConsts.VOXEL_SIZE_ATTR_NAME)
	if storedVoxelSize then
		return storedVoxelSize
	elseif config.voxelSize then
		return config.voxelSize
	else
		return Vector3.new(1, 1, 1)
	end
end
local function isWaterAroundPosition(checkPosition, searchRadius)
	local voxelData = Terrain:ReadVoxels(Region3.new(checkPosition - Vector3.new(1, 1, 1) * searchRadius * 4, checkPosition + Vector3.new(1, 1, 1) * searchRadius * 4), 4)
	local voxelGridSize = voxelData.Size
	for i = 1, voxelGridSize.X do
		for j = 1, voxelGridSize.Y do
			for k = 1, voxelGridSize.Z do
				if voxelData[i][j][k] == Enum.Material.Water then
					return true
				end
			end
		end
	end
	return false
end
local t = {
	subtractSphere = function(destructionConfig)
		if not destructionConfig.fx then
			destructionConfig.fx = false
		end
		assert(destructionConfig.fx ~= nil)
		if not destructionConfig.copy then
			destructionConfig.copy = false
		end
		if not (destructionConfig.terrainDamageDisabled or isWaterAroundPosition(destructionConfig.spherePosition, destructionConfig.sphereRadius * 0.4)) then
			Terrain:FillBall(destructionConfig.spherePosition, destructionConfig.sphereRadius, Enum.Material.Air)
		end
		local originalParents = {}
		local destructibleParts = {}
		for boundsIndex, checkPart in workspace:GetPartBoundsInRadius(destructionConfig.spherePosition, destructionConfig.sphereRadius, destructionConfig.overlapParams) do
			local blockVoxelSize, processedPart
			if not CollectionService:HasTag(checkPart, VoxelDestructionConsts.VOXEL_INDESTRUCTIBLE_TAG_NAME) and (not destructionConfig.partsOnly or checkPart:IsA("Part")) and (checkPart.CanCollide and checkPart.Transparency ~= 1) then
				blockVoxelSize = checkPart:GetAttribute(VoxelDestructionConsts.VOXEL_SIZE_ATTR_NAME) or (destructionConfig.voxelSize or Vector3.new(1, 1, 1))
				if checkPart.Size.Magnitude <= blockVoxelSize.Magnitude + 0.1 then
					if destructionConfig.fx then
						tossDebris(destructionConfig.spherePosition, checkPart.Position, blockVoxelSize, checkPart)
					end
					if destructionConfig.copy then
						table.insert(originalParents, { checkPart, checkPart.Parent })
						checkPart.Parent = nil
					else
						checkPart:Destroy()
					end
				else
					local partCFrame = checkPart.CFrame
					local round = math.round
					local gridDimensions = checkPart.Size / blockVoxelSize
					local gridOffset = -(blockVoxelSize + Vector3.new(round(gridDimensions.X), round(gridDimensions.Y), (round(gridDimensions.Z))) * blockVoxelSize) / 2
					local cutCFrame, cutSize = alignToVoxelGrid(partCFrame:ToObjectSpace(partCFrame - partCFrame.Position + destructionConfig.spherePosition), Vector3.new(1, 1, 1) * destructionConfig.sphereRadius * 2 + blockVoxelSize * 2, blockVoxelSize, gridOffset)
					local cutCFrameWorld = partCFrame:ToWorldSpace(cutCFrame)
					if destructionConfig.copy then
						local copiedPart = checkPart:Clone()
						copiedPart.Parent = checkPart.Parent
						table.insert(originalParents, { checkPart, checkPart.Parent })
						checkPart.Parent = nil
						processedPart = copiedPart
					else
						processedPart = checkPart
					end
					local partsToDecompose = { processedPart }
					local newPiecesFromCut = cut(cutCFrameWorld, cutSize, partsToDecompose)
					table.insert(destructibleParts, processedPart)
					TableUtils.concatInPlace(destructibleParts, newPiecesFromCut)
					local decompositionParams = OverlapParams.new()
					decompositionParams.FilterType = Enum.RaycastFilterType.Include
					decompositionParams.FilterDescendantsInstances = partsToDecompose
					local partsInCutBox = workspace:GetPartBoundsInBox(cutCFrameWorld, cutSize - Vector3.new(0.1, 0.1, 0.1), decompositionParams)
					for i = 1, #partsInCutBox do
						local overlappingPart = partsInCutBox[i]
						local decomposedCFrame, decomposedSize = alignToVoxelGrid(partCFrame:ToObjectSpace(overlappingPart.CFrame), overlappingPart.Size, blockVoxelSize, gridOffset)
						table.insert(destructibleParts, (decompose(partCFrame:ToWorldSpace(decomposedCFrame), decomposedSize, blockVoxelSize, destructionConfig.spherePosition, destructionConfig.sphereRadius, processedPart, destructionConfig.fx)))
						overlappingPart:Destroy()
					end
				end
			end
		end
		return function()
			for originalPart, originalParent in originalParents do
				pcall(function()
					originalParent[1].Parent = originalParent[2]
				end)
			end
			for destroyIndex, destroyPart in destructibleParts do
				destroyPart:Destroy()
			end
		end
	end
}
local restoreQueue = {}
local restoreTask = nil
function t.addToRestoreVoxelDestructionQueue(restoreFunction)
	if restoreTask then
		task.cancel(restoreTask)
		restoreTask = nil
	end
	table.insert(restoreQueue, restoreFunction)
	local networkPing = Players.LocalPlayer:GetNetworkPing()
	if RunService:IsStudio() then
		networkPing = math.max(networkPing, 0.15)
	end
	restoreTask = task.delay(2 * networkPing + 0.1, function()
		for i = #restoreQueue, 1, -1 do
			restoreQueue[i]()
		end
		table.clear(restoreQueue)
	end)
end
return t
