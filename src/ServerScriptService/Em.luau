-- Generic game event handlers.
-- OnServerEvent passes player first.
local Em = {}

-- Handles the open parachute request from a client.
function Em.openParachute(player)
end

-- Handles the close parachute request from a client.
function Em.closeParachute(player)
end

-- Handles the use glider request from a client.
function Em.useGlider(player)
end

-- Handles the open glider request from a client.
function Em.openGlider(player)
end

-- Handles the close glider request from a client.
function Em.closeGlider(player)
end

-- Handles the drop cash request from a client.
function Em.dropCash(player, dropAmount)
end

-- Handles the grab cash request from a client.
function Em.grabCash(player, cashDrop)
end

-- Handles the stash place item request from a client.
function Em.stashPlaceItem(player, stashRoot, itemObject)
end

-- Handles the stash grab item request from a client.
function Em.stashGrabItem(player, stashRoot)
end

-- Handles the stash inspect drawer request from a client.
function Em.stashInspectDrawer(player, stashRoot)
end

-- Handles the enter code request from a client.
function Em.enterCode(player, codeText)
end

-- Handles the start ragdoll request from a client.
function Em.startRagdoll(player)
end

-- Handles the end ragdoll request from a client.
function Em.endRagdoll(player)
end

-- Handles the fall damage request from a client.
function Em.fallDamage(player, fallDistance)
end

-- Handles the museum spotlight trigger request from a client.
function Em.museamSpotlightTrigger(player)
end

-- Handles the museum place dynamite request from a client.
function Em.museumPlaceDynamite(player, dynamitePart)
end

-- Handles the museum pull lever request from a client.
function Em.museumPullLever(player, leverPart)
end

-- Handles the grab museum item request from a client.
function Em.grabMuseumItem(player, itemPart)
end

-- Handles the nuke car explode request from a client.
function Em.nukeCarExplode(player)
end

-- Handles the nuke launch request from a client.
function Em.nukeLaunch(player)
end

-- Handles the vehicle touch roadspike request from a client.
function Em.vehicleTouchRoadspike(player, roadSpikePart)
end

-- Handles the switch teams request from a client.
function Em.switchTeams(player)
end

-- Handles the gun shop unequip request from a client.
function Em.gunshopUnequip(player, itemName)
end

-- Handles the gun shop equip request from a client.
function Em.gunshopEquip(player, itemName)
end

-- Handles the gun shop purchase request from a client.
function Em.gunshopPurchase(player, itemName)
end

-- Handles the swing baton or sword request from a client.
function Em.swingBatonOrSword(player, swingState)
end

-- Handles the throw c4 request from a client.
function Em.throwC4(player)
end

-- Handles the grab donut request from a client.
function Em.grabDonut(player)
end

-- Handles the spawn forcefield request from a client.
function Em.spawnForcefield(player, shellPosition, forcefieldId, serverTime)
end

-- Handles the equip gun skin request from a client.
function Em.equipGunSkin(player, inventoryItemValue, skinName)
end

-- Handles the damage vehicle request from a client.
function Em.damageVehicle(player, vehicleModel, weaponClassName)
end

-- Handles the shoot planet request from a client.
function Em.shootPlanet(player, hitPart, weaponClassName)
end

-- Handles the gun lean in request from a client.
function Em.gunLeanIn(player, isLeaning, isLeaningRight)
end

-- Handles the use juice request from a client.
function Em.useJuice(player)
end

-- Handles the clear road spike request from a client.
function Em.clearRoadSpike(player)
end

-- Handles the place road spike request from a client.
function Em.placeRoadSpike(player, startPosition, endPosition)
end

-- Handles the explode smoke grenade request from a client.
function Em.explodeSmokeGrenade(player)
end

-- Handles the draw taser line request from a client.
function Em.drawTaserLine(player, targetPosition)
end

-- Handles the taze player request from a client.
function Em.tazePlayer(player, targetHumanoid, hitInstance, targetPosition)
end

-- Handles the drop item request from a client.
function Em.dropItem(player)
end

-- Handles the item input began request from a client.
function Em.itemInputBegan(player, userInputType, keyCode)
end

-- Handles the item input ended request from a client.
function Em.itemInputEnded(player, userInputType, keyCode)
end

-- Handles the equip jetpack server request from a client.
function Em.equipJetpackServer(player)
end

-- Handles the equip jetpack local request from a client.
function Em.equipJetpackLocal(player)
end

-- Handles the start jetpack thrust request from a client.
function Em.startJetpackThrust(player)
end

-- Handles the end jetpack thrust request from a client.
function Em.endJetpackThrust(player)
end

-- Applies environmental damage reported by a client-side hazard.
function Em.enviornmentDamage(player, damageAmount, damageSource)
end

-- Handles the explosion damage request from a client.
function Em.explosionDamage(player, damageAmount, owner, damageSource)
end

-- Handles a jet missile launch request.
function Em.launchJetMissle(player, jetModel)
end

-- Handles a request to buy jet missiles.
function Em.buyJetMissles(player)
end

-- Handles the update radio playlist request from a client.
function Em.updateRadioPlaylist(player, playlistTitle, songs)
end

-- Handles the play radio song request from a client.
function Em.playRadioSong(player, soundId, timePosition)
end

-- Handles the stop radio song request from a client.
function Em.stopRadioSong(player)
end

-- Handles the send plant grid request from a client.
function Em.sendPlantGrid(player, flowId, grid)
end

-- Handles the cargo plane pull lever request from a client.
function Em.cargoPlanePullLever(player)
end

-- Handles the cargo plane open hatch request from a client.
function Em.cargoPlaneOpenHatch(player)
end

-- Handles the cargo plane grab crate request from a client.
function Em.cargoPlaneGrabCrate(player, crateName)
end

-- Handles the open cargo train top door request from a client.
function Em.openCargoTrainTopDoor(player, systemId, carId)
end

-- Handles the open cargo train side door request from a client.
function Em.openCargoTrainSideDoor(player, systemId, carId)
end

-- Handles the open cargo train vault request from a client.
function Em.openCargoTrainVault(player, systemId, carId)
end

-- Handles the grab cargo train gold request from a client.
function Em.grabCargoTrainGold(player, systemId, carId)
end

-- Handles the exit cargo train request from a client.
function Em.exitCargoTrain(player, systemId, carId)
end

-- Handles the grab passenger train cash request from a client.
function Em.grabPassengerTrainCash(player, systemId, carId, spawnName, itemName)
end

-- Handles the break passenger glass request from a client.
function Em.breakPassengerGlass(player, systemId, carId, glassIndex)
end

-- Handles the open passenger door request from a client.
function Em.openPassengerDoor(player, systemId, carId, doorIndex)
end

-- Handles the cargo ship explosion request from a client.
function Em.cargoShipExplosion(player, explosionPosition)
end

-- Handles the bank place dynamite request from a client.
function Em.bankPlaceDynamite(player, doorPart)
end

-- Handles the get train data request from a client.
function Em.getTrainData(player, systemId)
end

-- Handles the detach from rope request from a client.
function Em.detachFromRope(player)
end

-- Handles the drop rope request from a client.
function Em.dropRope(player)
end

-- Handles the grab rope request from a client.
function Em.grabRope(player, ropePart)
end

-- Handles a helicopter missile fire request.
function Em.fireMissle(player, missileCFrame, missileVelocity, aimTarget, fireTime)
end

-- Handles the drop bomb request from a client.
function Em.dropBomb(player, dropCFrame, dropVelocity, dropTime)
end

-- Handles the toggle headlights request from a client.
function Em.toggleHeadlights(player, headlightMode)
end

-- Handles the jewelry store event request from a client.
function Em.jewelryStoreEvent(player, jewelryEventName)
end

-- Handles the vehicle update request from a client.
function Em.vehicleUpdate(player, updateType, value)
end

-- Handles a vehicle-mounted missile fire request.
function Em.vehicleFireMissle(player, missileCFrame, velocity, arg3, arg4, projectileName, arg6)
end

-- Handles the move firetruck ladder request from a client.
function Em.moveFiretruckLadder(player, ladderPart)
end

-- Handles the flip vehicle request from a client.
function Em.flipVehicle(player)
end

-- Handles the lock vehicle request from a client.
function Em.lockVehicle(player, shouldLock)
end

-- Handles the eject passenger request from a client.
function Em.ejectPassenger(player, passenger)
end

-- Handles the attempt buy missiles request from a client.
function Em.attemptBuyMissiles(player)
end

-- Handles the switch team request from a client.
function Em.switchTeam(player, selectedTeam)
end

-- Handles the wire damage request from a client.
function Em.wireDamage(player, wirePart, damageSource)
end

-- Handles the update setting request from a client.
function Em.updateSetting(player, settingName, settingValue)
end

-- Handles the update sound playing request from a client.
function Em.updateSoundPlaying(player, sound, isPlaying)
end

-- Handles the attempt arrest request from a client.
function Em.attemptArrest(player, targetPlayer)
end

-- Handles the attempt pickpocket request from a client.
function Em.attemptPickpocket(player, targetName)
end

-- Handles the start attempt breakout request from a client.
function Em.startAttemptBreakout(player, targetName)
end

-- Handles the finish attempt breakout request from a client.
function Em.finishAttemptBreakout(player, targetName)
end

-- Handles the attempt vehicle hijack request from a client.
function Em.attemptVehicleHijack(player, vehicleModel, seatPart)
end

-- Handles the attempt vehicle eject request from a client.
function Em.attemptVehicleEject(player, seatPart)
end

-- Handles the nitro tick request from a client.
function Em.nitroTick(player, elapsedTime)
end

-- Handles the stop nitro request from a client.
function Em.stopNitro(player)
end

-- Handles the start nitro request from a client.
function Em.startNitro(player)
end

-- Handles the update character look request from a client.
function Em.updateCharacterLook(player, lookVector, lookPitch)
end

-- Handles the toggle horn request from a client.
function Em.toggleHorn(player, isPlaying)
end

-- Handles the attempt punch request from a client.
function Em.attemptPunch(player)
end

-- Handles the exit vehicle request from a client.
function Em.exitVehicle(player)
end

-- Handles the purchase item request from a client.
function Em.purchaseItem(player, itemName)
end

-- Handles the rent vehicle request from a client.
function Em.rentVehicle(player, vehicleName)
end

-- Handles the open door request from a client.
function Em.openDoor(player, doorObject)
end

-- Handles the item touch trigger request from a client.
function Em.itemTouchTrigger(player, triggerPart)
end

-- Handles the open sewer hatch request from a client.
function Em.openSewerHatch(player, hatchName, hatchPart)
end

-- Handles the run and echo event request from a client.
function Em.runAndEchoEvent(player, eventName)
end

-- Handles the attempt vehicle enter request from a client.
function Em.attemptVehicleEnter(player, vehicleModel, seatPart)
end

-- Handles the start small store rob request from a client.
function Em.startSmallStoreRob(player, storePart)
end

-- Handles the finish small store rob request from a client.
function Em.finishSmallStoreRob(player, storePart)
end

-- Handles the reset player request from a client.
function Em.resetPlayer(player)
end

-- Handles the anticheat report request from a client.
function Em.anticheatReport(player, reportName, isFatal)
end

function Em.dispatch(player, eventName, ...)
	if typeof(eventName) ~= "string" then
		warn("[Em] Ignoring GenericRemoteEvent with non-string event name", eventName)
		return nil
	end

	local handler = Em[eventName]
	if typeof(handler) ~= "function" then
		warn(("[Em] No handler for event %q"):format(eventName))
		return nil
	end

	return handler(player, ...)
end

function Em.bind(remoteEvent)
	return remoteEvent.OnServerEvent:Connect(function(player, eventName, ...)
		Em.dispatch(player, eventName, ...)
	end)
end

return Em
