-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpawnSelectionConsts = require(script.Parent.SpawnSelectionConsts)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local Settings = require(ReplicatedStorage.Resource.Settings)
local store = require(ReplicatedStorage.App.store)
local ClanUtils = require(ReplicatedStorage.Clan.ClanUtils)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local PrivateServerUtils = require(ReplicatedStorage.PrivateServer.PrivateServerUtils)
local Roact = require(ReplicatedStorage.Roact)
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local t = {
	_updateRemote = nil,
	_maid = Maid.new()
}
function t.init()
	waitForChild(ReplicatedStorage, "SpawnSelectionUpdateSpawnData"):andThen(function(updateRemote)
		t._updateRemote = updateRemote
		updateRemote.OnClientEvent:Connect(t._receiveSpawns)
	end)
	waitForChild(ReplicatedStorage, "SpawnSelectionOffer"):andThen(function(offerRemote)
		t._offerRemote = offerRemote
		offerRemote.OnClientEvent:Connect(function()
			store:dispatch({
				type = "setSpawnSelectionOfferVisible",
				visible = true
			})
		end)
	end)
	store.changed:connect(function(newState, oldState)
		if newState.minimapSpawns ~= oldState.minimapSpawns then
			t._maid.receiveSpawnsMaid = nil
		end
	end)
end
function t.requestShowSpawns()
	t._updateRemote:FireServer()
end
function t.attemptSelect(p1)
	ReplicatedStorage:FindFirstChild("SpawnSelectionSelect"):FireServer(p1)
end
function t._receiveSpawns(spawns)
	local maid = Maid.new()
	t._maid.receiveSpawnsMaid = maid
	local clanId = ClanUtils.getCurrentClanId(Players.LocalPlayer)
	local spawnsData = {}
	for index, spawnData in spawns do
		local spawnInfo = {}
		spawnInfo.name = assert(spawnData.name, "missing spawnData.name")
		spawnInfo.useParachute = spawnData.useParachute
		spawnInfo.locked = spawnData.locked
		spawnInfo.position = assert(spawnData.position, "missing spawnData.position")
		if PrivateServerUtils.getIsBattleServer() then
			local enemyCount, setEnemyCount = Roact.createBinding(0)
			spawnInfo.numEnemies = enemyCount
			maid:GiveTask(Interval.every(0.1):Connect(function()
				local count = 0
				for index2, player in Players:GetPlayers() do
					if ClanUtils.getCurrentClanId(player) ~= clanId then
						local Character = player.Character
						if Character then
							local characterPos = CharacterUtil.getPositionFromCharacter(Character)
							if characterPos and not ((characterPos - spawnInfo.position).Magnitude > SpawnSelectionConsts.ENEMY_CHECK_RADIUS) then
								count = count + 1
							end
						end
					end
				end
				setEnemyCount(count)
			end))
		end
		if spawnData.exclusiveTeamId then
			spawnInfo.backgroundColor = Settings.TeamColor[spawnData.exclusiveTeamId]
		else
			spawnInfo.backgroundColor = Color3.new(255/255, 255/255, 255/255)
		end
		table.insert(spawnsData, spawnInfo)
	end
	store:dispatch({
		type = "minimapSetSpawns",
		spawns = spawnsData
	})
	store:dispatch({
		type = "setSpawnSelectionReceivedAt",
		receivedAt = workspace:GetServerTimeNow()
	})
end
return t
