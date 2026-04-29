local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GunUtils = require(ReplicatedStorage.Game.GunShop.GunUtils)
local Audio = require(ReplicatedStorage.Std.Audio)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local Gun = require(script.Parent.Gun)
local randomGenerator = Random.new()
local function RandomBilateral()
	return randomGenerator:NextNumber() * 2 - 1
end
local function RandomVector()
	return GeomUtils.randomPointOnSphere()
end
local PlasmaGun = {
	__ClassName = "PlasmaGun"
}
PlasmaGun.__index = PlasmaGun
setmetatable(PlasmaGun, Gun)
function PlasmaGun.new(parent, equipmentInstance, sourceValue)
	local gun = Gun.new(parent, equipmentInstance, sourceValue)
	setmetatable(gun, PlasmaGun)
	gun.ListZap = {}
	return gun
end
function PlasmaGun.UpdateZap(self, zapConfig)
	local Origin = zapConfig.Origin
	local Target = zapConfig.Target
	local OffsetRadius = zapConfig.OffsetRadius
	local Width = zapConfig.Width
	local elapsedTime = tick() - zapConfig.BornAt
	local fireFreqCapped = math.min(1 / self.Config.FireFreq, 0.1)
	local totalSegments = math.ceil((Target - Origin).Magnitude / zapConfig.PerDistance)
	local progress = 1/3 + 2/3 * elapsedTime / fireFreqCapped
	local currentSegmentIndex = math.ceil(progress * totalSegments)
	local LastPositionIndex = zapConfig.LastPositionIndex
	for i = LastPositionIndex, currentSegmentIndex do
		if zapConfig.NextPosition == nil then
			local interpolationFactor = i / totalSegments
			local sum = Origin * (1 - interpolationFactor) + Target * interpolationFactor
			if i < totalSegments then
				sum = sum + GeomUtils.randomPointInSphere() * OffsetRadius
			end
			zapConfig.NextPosition = sum
			local LastPosition = zapConfig.LastPosition
			local Magnitude = (sum - LastPosition).Magnitude
			local Part = Instance.new("Part")
			Part.Anchored = true
			Part.CanCollide = false
			Part.Material = Enum.Material.Neon
			Part.Transparency = 0.1
			Part.Color = Color3.fromRGB(173, 110, 125)
			Part.TopSurface = 0
			Part.BottomSurface = 0
			Part.Size = Vector3.new(Width, Width, Magnitude)
			Part.CFrame = CFrame.new(LastPosition, sum) * CFrame.new(0, 0, -Magnitude * 0.5)
			Part.Parent = workspace.Items
			local SurfaceLight = Instance.new("SurfaceLight")
			SurfaceLight.Angle = 81
			SurfaceLight.Brightness = 2.5
			SurfaceLight.Color = Color3.fromRGB(173, 110, 125)
			SurfaceLight.Face = Enum.NormalId.Bottom
			SurfaceLight.Range = 16
			SurfaceLight.Shadows = false
			SurfaceLight.Parent = Part
			zapConfig.Part = Part
			table.insert(zapConfig.Parts, Part)
		end
		if i == LastPositionIndex then
			local fadeAlpha = math.clamp(progress * totalSegments - i + 1, 0, 1)
			local LastPosition = zapConfig.LastPosition
			local currentPosition = zapConfig.NextPosition * fadeAlpha + LastPosition * (1 - fadeAlpha)
			local Part = zapConfig.Part
			local Magnitude = (currentPosition - LastPosition).Magnitude
			Part.Size = Vector3.new(Width, Width, Magnitude)
			Part.CFrame = CFrame.new(LastPosition, currentPosition) * CFrame.new(0, 0, -Magnitude * 0.5)
		else
			zapConfig.LastPosition = zapConfig.NextPosition
			zapConfig.NextPosition = nil
		end
	end
	zapConfig.LastPositionIndex = currentSegmentIndex
	return progress >= 1
end
function PlasmaGun.DestroyZap(self, zapConfig)
	for i, part in ipairs(zapConfig.Parts) do
		part:Destroy()
	end
	zapConfig.Parts = nil
end
function PlasmaGun.DestroyZaps(self)
	for i = #self.ListZap, 1, -1 do
		table.remove(self.ListZap, i)
		self:DestroyZap(self.ListZap[i])
	end
end
function PlasmaGun.UpdateZaps(self)
	for i = #self.ListZap, 1, -1 do
		local currentZap = self.ListZap[i]
		if self:UpdateZap(currentZap) then
			table.remove(self.ListZap, i)
			self:DestroyZap(currentZap)
		end
	end
end
function PlasmaGun.Heartbeat(self)
	self:UpdateZaps()
end
function PlasmaGun.Zap(self, originPosition, targetPosition, width, offsetRadius, perDistance)
	local zapConfig = {
		Width = width,
		OffsetRadius = offsetRadius,
		PerDistance = perDistance,
		Origin = originPosition,
		Target = targetPosition
	}
	zapConfig.LastPosition = zapConfig.Origin
	zapConfig.NextPosition = nil
	zapConfig.LastPositionIndex = 1
	zapConfig.Parts = {}
	zapConfig.BornAt = tick()
	table.insert(self.ListZap, zapConfig)
end
function PlasmaGun.ShootOther(self)
	local Tip = self.Tip
	self.SpringItemOffset:Accelerate(Vector3.new(0, 0, 30) + GeomUtils.randomPointOnSphere() * 3)
	self.SpringItemRotation:Accelerate((Vector3.new(-1, 2, 0)).Unit * 12 + GeomUtils.randomPointOnSphere() * 2)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = self.IgnoreList
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	local function collidableFunc(part)
		if part:GetAttribute("InvisibleToBullets") == true then
			return false
		elseif CharacterUtils.getAncestorPartHumanoid(part) then
			return true
		else
			return part.CanCollide
		end
	end
	for i = 1, self.Config.BulletsPerShot or 1 do
		local bulletHitPosition
		local tipCFrame = Tip.CFrame
		if not self.TipDirection then
			warn("No cached tipDirection")
		end
		local bulletDirection = GunUtils.getBulletDirection(tipCFrame, self.TipDirection or tipCFrame.LookVector, self.Config.BulletSpread or 0)
		local raycastResult = Raycast.collidable(Tip.Position, bulletDirection, self.Config.Range, raycastParams, collidableFunc)
		local hitInstance = nil
		if raycastResult then
			hitInstance = raycastResult.Instance
			bulletHitPosition = raycastResult.Position
		else
			bulletHitPosition = Tip.Position + bulletDirection * self.Config.Range
		end
		if (self.Local or self.SimulateLocal) and hitInstance then
			local targetHumanoid = CharacterUtils.getAncestorPartHumanoid(hitInstance)
			if targetHumanoid then
				self.inventoryItemValue:FindFirstChild(GunSystemConsts.DAMAGE_REMOTE_NAME):FireServer(bulletHitPosition, targetHumanoid)
				if self.CrossHair then
					self.CrossHair:Flare()
				end
				if os.clock() - (self.soundDebounce or 0) > 0.1 then
					Audio.ObjectLocal(self.Tip, self.Config.Sound.bullet_impact_bass, {
						TimePosition = 0,
						Volume = 1,
						Pitch = 1
					})
					self.soundDebounce = os.clock()
				end
			end
		end
		self:Zap(Tip.Position, bulletHitPosition, 0.2, 0.5, 6)
	end
	self:Zap(Tip.Position, Tip.CFrame * Vector3.new(0, 0, -4) + GeomUtils.randomPointOnSphere() * 3, 0.06, 0.2, 1)
	self:Zap(Tip.Position, Tip.CFrame * Vector3.new(0, 0, -4) + GeomUtils.randomPointOnSphere() * 3, 0.06, 0.2, 1)
	self:Zap(Tip.Position, Tip.CFrame * Vector3.new(0, 0, -4) + GeomUtils.randomPointOnSphere() * 3, 0.06, 0.2, 1)
end
function PlasmaGun.ShootSound(self, shouldPlaySound)
	if not shouldPlaySound then
		Audio.ObjectLocal(self.Tip, 4752401149)
	end
end
function PlasmaGun.ReloadDropAmmoVisual(self)  end
function PlasmaGun.ReloadRefillAmmoVisual(self)  end
function PlasmaGun.ReloadDropAmmoSound(self)
	Audio.ObjectLocal(self.Tip, 16652902841, {
		Volume = 1
	})
end
function PlasmaGun.ReloadRefillAmmoSound(self)  end
function PlasmaGun.Unequip(self)
	Gun.Unequip(self)
	self:DestroyZaps()
end
return PlasmaGun
