-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local t = {}
local t2 = {}
function t2.init()
	waitForChild(ReplicatedStorage, "DisplayDamageDraw"):andThen(function(displayDamageRemote)
		displayDamageRemote.OnClientEvent:Connect(t2.draw)
	end)
end
function t2.draw(character, guiParent, damageAmount, options)
	local options = options or {}
	local isHeadshot = options.isHeadshot
	local isWallbang = options.isWallbang
	local isVehicleDamage = options.isVehicleDamage
	local didPopVehicleTires = options.didPopVehicleTires
	if isVehicleDamage then
		assert(if isHeadshot == nil then isWallbang == nil else false, "Vehicle damage cannot be headshot or wallbang")
	else
		assert(didPopVehicleTires == nil, "Non-vehicle damage cannot pop vehicle tires")
	end
	local damageState = t[character]
	local isNewDisplay
	if damageState then
		isNewDisplay = false
	else
		local arrowsGui = ReplicatedStorage.Resource.ItemSystem.Damage.Arrows:Clone()
		arrowsGui.Archivable = false
		arrowsGui.Parent = guiParent
		local billboardGui = ReplicatedStorage.Resource.ItemSystem.Damage.DamageBillboard:Clone()
		billboardGui.Archivable = false
		billboardGui.Parent = guiParent
		damageState = {
			promise = nil,
			arrowsGui = arrowsGui,
			billboardGui = billboardGui,
			totalDamageDealt = 0,
			firstDamageTime = os.clock(),
			realDamage = 0
		}
		t[character] = damageState
		isNewDisplay = true
	end
	local function displayDPS()
		local state = damageState
		state.realDamage = state.realDamage + damageAmount
		local elapsedTime = os.clock() - damageState.firstDamageTime
		print("real damage, time, dps: ", damageState.realDamage, elapsedTime, damageState.realDamage / elapsedTime)
	end
	damageState.totalDamageDealt = damageState.totalDamageDealt + math.floor(damageAmount + 0.5)
	damageState.arrowsGui:Emit(5)
	damageState.billboardGui.TextLabel.Text = tostring(damageState.totalDamageDealt)
	damageState.billboardGui.TextLabel.TextLabel.Text = damageState.billboardGui.TextLabel.Text
	if isVehicleDamage then
		if didPopVehicleTires then
			damageState.billboardGui.TextLabel.TextColor3 = GunSystemConsts.VEHICLE_TIRE_POP_DAMAGE_DISPLAY_COLOR
		elseif isNewDisplay then
			damageState.billboardGui.TextLabel.TextColor3 = GunSystemConsts.VEHICLE_DAMAGE_DISPLAY_COLOR
		end
		damageState.billboardGui.TextLabel.TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255)
		damageState.billboardGui.TextLabel.TextLabel.TextColor3 = Color3.new(0/255, 0/255, 0/255)
		damageState.billboardGui.TextLabel.TextLabel.TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255)
	elseif isHeadshot then
		damageState.billboardGui.TextLabel.TextColor3 = GunSystemConsts.HEADSHOT_DAMAGE_DISPLAY_COLOR
	elseif isWallbang then
		damageState.billboardGui.TextLabel.TextColor3 = GunSystemConsts.WALLBANG_DAMAGE_DISPLAY_COLOR
	else
		damageState.billboardGui.TextLabel.TextColor3 = GunSystemConsts.DEFAULT_DAMAGE_DISPLAY_COLOR
	end
	if damageState.promise then
		damageState.promise:cancel()
		damageState.promise = nil
	end
	damageState.promise = Promise.delay(1):andThen(function()
		damageState.arrowsGui:Destroy()
		damageState.billboardGui:Destroy()
		t[character] = nil
	end)
end
return t2
