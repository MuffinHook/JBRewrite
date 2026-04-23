local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local t = {}
local t2 = {}
function t2.init() --[[ Line: 8 | Upvalues: waitForChild (copy), ReplicatedStorage (copy), t2 (copy) ]]
	waitForChild(ReplicatedStorage, "DisplayDamageDraw"):andThen(function(p1) --[[ Line: 9 | Upvalues: t2 (ref) ]]
		p1.OnClientEvent:Connect(t2.draw)
	end)
end
function t2.draw(p1, p2, p3, p4) --[[ Line: 13 | Upvalues: t (copy), ReplicatedStorage (copy), GunSystemConsts (copy), Promise (copy) ]]
	local v1 = p4 or {}
	local isHeadshot = v1.isHeadshot
	local isWallbang = v1.isWallbang
	local isVehicleDamage = v1.isVehicleDamage
	local didPopVehicleTires = v1.didPopVehicleTires
	if isVehicleDamage then
		assert(if isHeadshot == nil then isWallbang == nil else false, "Vehicle damage cannot be headshot or wallbang")
	else
		assert(didPopVehicleTires == nil, "Non-vehicle damage cannot pop vehicle tires")
	end
	local v4 = t[p1]
	local v5
	if v4 then
		v5 = false
	else
		local v6 = ReplicatedStorage.Resource.ItemSystem.Damage.Arrows:Clone()
		v6.Archivable = false
		v6.Parent = p2
		local v7 = ReplicatedStorage.Resource.ItemSystem.Damage.DamageBillboard:Clone()
		v7.Archivable = false
		v7.Parent = p2
		v4 = {
			promise = nil,
			arrowsGui = v6,
			billboardGui = v7,
			totalDamageDealt = 0,
			firstDamageTime = os.clock(),
			realDamage = 0
		}
		t[p1] = v4
		v5 = true
	end
	local function displayDPS() --[[ Line: 48 | Upvalues: v4 (ref), p3 (copy) ]]
		local v1 = v4
		v1.realDamage = v1.realDamage + p3
		local v2 = os.clock() - v4.firstDamageTime
		print("real damage, time, dps: ", v4.realDamage, v2, v4.realDamage / v2)
	end
	v4.totalDamageDealt = v4.totalDamageDealt + math.floor(p3 + 0.5)
	v4.arrowsGui:Emit(5)
	v4.billboardGui.TextLabel.Text = tostring(v4.totalDamageDealt)
	v4.billboardGui.TextLabel.TextLabel.Text = v4.billboardGui.TextLabel.Text
	if isVehicleDamage then
		if didPopVehicleTires then
			v4.billboardGui.TextLabel.TextColor3 = GunSystemConsts.VEHICLE_TIRE_POP_DAMAGE_DISPLAY_COLOR
		elseif v5 then
			v4.billboardGui.TextLabel.TextColor3 = GunSystemConsts.VEHICLE_DAMAGE_DISPLAY_COLOR
		end
		v4.billboardGui.TextLabel.TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255)
		v4.billboardGui.TextLabel.TextLabel.TextColor3 = Color3.new(0/255, 0/255, 0/255)
		v4.billboardGui.TextLabel.TextLabel.TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255)
	elseif isHeadshot then
		v4.billboardGui.TextLabel.TextColor3 = GunSystemConsts.HEADSHOT_DAMAGE_DISPLAY_COLOR
	elseif isWallbang then
		v4.billboardGui.TextLabel.TextColor3 = GunSystemConsts.WALLBANG_DAMAGE_DISPLAY_COLOR
	else
		v4.billboardGui.TextLabel.TextColor3 = GunSystemConsts.DEFAULT_DAMAGE_DISPLAY_COLOR
	end
	if v4.promise then
		v4.promise:cancel()
		v4.promise = nil
	end
	v4.promise = Promise.delay(1):andThen(function() --[[ Line: 82 | Upvalues: v4 (ref), t (ref), p1 (copy) ]]
		v4.arrowsGui:Destroy()
		v4.billboardGui:Destroy()
		t[p1] = nil
	end)
end
return t2