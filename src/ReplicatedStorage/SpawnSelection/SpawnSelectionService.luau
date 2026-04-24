-- Reviewed by Claude
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
	waitForChild(ReplicatedStorage, "SpawnSelectionUpdateSpawnData"):andThen(function(p1)
		t._updateRemote = p1
		p1.OnClientEvent:Connect(t._receiveSpawns)
	end)
	waitForChild(ReplicatedStorage, "SpawnSelectionOffer"):andThen(function(p1)
		t._offerRemote = p1
		p1.OnClientEvent:Connect(function()
			store:dispatch({
				type = "setSpawnSelectionOfferVisible",
				visible = true
			})
		end)
	end)
	store.changed:connect(function(p1, p2)
		if p1.minimapSpawns ~= p2.minimapSpawns then
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
function t._receiveSpawns(p1)
	local v1 = Maid.new()
	t._maid.receiveSpawnsMaid = v1
	local v2 = ClanUtils.getCurrentClanId(Players.LocalPlayer)
	local t2 = {}
	for v3, v4 in p1 do
		local t3 = {}
		t3.name = assert(v4.name, "missing spawnData.name")
		t3.useParachute = v4.useParachute
		t3.locked = v4.locked
		t3.position = assert(v4.position, "missing spawnData.position")
		if PrivateServerUtils.getIsBattleServer() then
			local v5, v6 = Roact.createBinding(0)
			t3.numEnemies = v5
			v1:GiveTask(Interval.every(0.1):Connect(function()
				local count = 0
				for v1, v22 in Players:GetPlayers() do
					if ClanUtils.getCurrentClanId(v22) ~= v2 then
						local Character = v22.Character
						if Character then
							local v3 = CharacterUtil.getPositionFromCharacter(Character)
							if v3 and not ((v3 - t3.position).Magnitude > SpawnSelectionConsts.ENEMY_CHECK_RADIUS) then
								count = count + 1
							end
						end
					end
				end
				v6(count)
			end))
		end
		if v4.exclusiveTeamId then
			t3.backgroundColor = Settings.TeamColor[v4.exclusiveTeamId]
		else
			t3.backgroundColor = Color3.new(255/255, 255/255, 255/255)
		end
		table.insert(t2, t3)
	end
	store:dispatch({
		type = "minimapSetSpawns",
		spawns = t2
	})
	store:dispatch({
		type = "setSpawnSelectionReceivedAt",
		receivedAt = workspace:GetServerTimeNow()
	})
end
return t
