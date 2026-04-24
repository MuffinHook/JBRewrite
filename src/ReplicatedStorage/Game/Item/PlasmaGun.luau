-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GunUtils = require(ReplicatedStorage.Game.GunShop.GunUtils)
local Audio = require(ReplicatedStorage.Std.Audio)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local Gun = require(script.Parent.Gun)
local v2 = Random.new()
local function RandomBilateral()
	return v2:NextNumber() * 2 - 1
end
local function RandomVector()
	return GeomUtils.randomPointOnSphere()
end
local t = {
	__ClassName = "PlasmaGun"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1.ListZap = {}
	return v1
end
function t.UpdateZap(p1, p2)
	local Origin = p2.Origin
	local Target = p2.Target
	local OffsetRadius = p2.OffsetRadius
	local Width = p2.Width
	local v1 = tick() - p2.BornAt
	local v3 = math.min(1 / p1.Config.FireFreq, 0.1)
	local v5 = math.ceil((Target - Origin).Magnitude / p2.PerDistance)
	local v6 = 0.3333333333333333 + 0.6666666666666666 * v1 / v3
	local v7 = math.ceil(v6 * v5)
	local LastPositionIndex = p2.LastPositionIndex
	for i = LastPositionIndex, v7 do
		if p2.NextPosition == nil then
			local v8 = i / v5
			local sum = Origin * (1 - v8) + Target * v8
			if i < v5 then
				sum = sum + GeomUtils.randomPointInSphere() * OffsetRadius
			end
			p2.NextPosition = sum
			local LastPosition = p2.LastPosition
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
			p2.Part = Part
			table.insert(p2.Parts, Part)
		end
		if i == LastPositionIndex then
			local v9 = math.clamp(v6 * v5 - i + 1, 0, 1)
			local LastPosition = p2.LastPosition
			local v10 = p2.NextPosition * v9 + LastPosition * (1 - v9)
			local Part = p2.Part
			local Magnitude = (v10 - LastPosition).Magnitude
			Part.Size = Vector3.new(Width, Width, Magnitude)
			Part.CFrame = CFrame.new(LastPosition, v10) * CFrame.new(0, 0, -Magnitude * 0.5)
		else
			p2.LastPosition = p2.NextPosition
			p2.NextPosition = nil
		end
	end
	p2.LastPositionIndex = v7
	return v6 >= 1
end
function t.DestroyZap(p1, p2)
	for i, v in ipairs(p2.Parts) do
		v:Destroy()
	end
	p2.Parts = nil
end
function t.DestroyZaps(p1)
	for i = #p1.ListZap, 1, -1 do
		table.remove(p1.ListZap, i)
		p1:DestroyZap(p1.ListZap[i])
	end
end
function t.UpdateZaps(p1)
	for i = #p1.ListZap, 1, -1 do
		local v1 = p1.ListZap[i]
		if p1:UpdateZap(v1) then
			table.remove(p1.ListZap, i)
			p1:DestroyZap(v1)
		end
	end
end
function t.Heartbeat(p1)
	p1:UpdateZaps()
end
function t.Zap(p1, p2, p3, p4, p5, p6)
	local t = {
		Width = p4,
		OffsetRadius = p5,
		PerDistance = p6,
		Origin = p2,
		Target = p3
	}
	t.LastPosition = t.Origin
	t.NextPosition = nil
	t.LastPositionIndex = 1
	t.Parts = {}
	t.BornAt = tick()
	table.insert(p1.ListZap, t)
end
function t.ShootOther(p1)
	local Tip = p1.Tip
	p1.SpringItemOffset:Accelerate(Vector3.new(0, 0, 30) + GeomUtils.randomPointOnSphere() * 3)
	p1.SpringItemRotation:Accelerate((Vector3.new(-1, 2, 0)).Unit * 12 + GeomUtils.randomPointOnSphere() * 2)
	local v1 = RaycastParams.new()
	v1.FilterDescendantsInstances = p1.IgnoreList
	v1.FilterType = Enum.RaycastFilterType.Exclude
	local function collidableFunc(p1)
		if p1:GetAttribute("InvisibleToBullets") == true then
			return false
		elseif CharacterUtils.getAncestorPartHumanoid(p1) then
			return true
		else
			return p1.CanCollide
		end
	end
	for i = 1, p1.Config.BulletsPerShot or 1 do
		local v2
		local v4 = Tip.CFrame
		if not p1.TipDirection then
			warn("No cached tipDirection")
		end
		local v6 = GunUtils.getBulletDirection(v4, p1.TipDirection or v4.LookVector, p1.Config.BulletSpread or 0)
		local v7 = Raycast.collidable(Tip.Position, v6, p1.Config.Range, v1, collidableFunc)
		local v8 = nil
		if v7 then
			v8 = v7.Instance
			v2 = v7.Position
		else
			v2 = Tip.Position + v6 * p1.Config.Range
		end
		if (p1.Local or p1.SimulateLocal) and v8 then
			local v10 = CharacterUtils.getAncestorPartHumanoid(v8)
			if v10 then
				p1.inventoryItemValue:FindFirstChild(GunSystemConsts.DAMAGE_REMOTE_NAME):FireServer(v2, v10)
				if p1.CrossHair then
					p1.CrossHair:Flare()
				end
				if os.clock() - (p1.soundDebounce or 0) > 0.1 then
					Audio.ObjectLocal(p1.Tip, p1.Config.Sound.bullet_impact_bass, {
						TimePosition = 0,
						Volume = 1,
						Pitch = 1
					})
					p1.soundDebounce = os.clock()
				end
			end
		end
		p1:Zap(Tip.Position, v2, 0.2, 0.5, 6)
	end
	p1:Zap(Tip.Position, Tip.CFrame * Vector3.new(0, 0, -4) + GeomUtils.randomPointOnSphere() * 3, 0.06, 0.2, 1)
	p1:Zap(Tip.Position, Tip.CFrame * Vector3.new(0, 0, -4) + GeomUtils.randomPointOnSphere() * 3, 0.06, 0.2, 1)
	p1:Zap(Tip.Position, Tip.CFrame * Vector3.new(0, 0, -4) + GeomUtils.randomPointOnSphere() * 3, 0.06, 0.2, 1)
end
function t.ShootSound(p1, p2)
	if not p2 then
		Audio.ObjectLocal(p1.Tip, 4752401149)
	end
end
function t.ReloadDropAmmoVisual(p1)  end
function t.ReloadRefillAmmoVisual(p1)  end
function t.ReloadDropAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, 16652902841, {
		Volume = 1
	})
end
function t.ReloadRefillAmmoSound(p1)  end
function t.Unequip(p1)
	Gun.Unequip(p1)
	p1:DestroyZaps()
end
return t
