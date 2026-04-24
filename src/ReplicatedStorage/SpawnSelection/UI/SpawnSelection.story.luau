-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local SpawnSelection = require(script.Parent.SpawnSelection)
	function v1.init(p1)
		local v1, v2 = Roact.createBinding(Vector3.new(0, 0, 0))
		p1.worldPosition = v1
		p1.updateWorldPosition = v2
		local v3, v4 = Roact.createBinding((Vector3.new(1, 0, 1)).Unit)
		p1.worldDirection = v3
		p1.updateWorldDirection = v4
		store:dispatch({
			type = "minimapSetSpawns",
			spawns = {
				{
					name = "CrimePort",
					useParachute = true,
					position = Vector3.new(2428.203, 20.751, -3775.428),
					backgroundColor = Color3.fromRGB(252, 40, 47),
					numEnemies = {
						map = function(p1, p2)
							return p2(2)
						end
					}
				},
				{
					name = "CrimBase",
					position = Vector3.new(-428.203, 20.751, 1475.428),
					backgroundColor = Color3.fromRGB(252, 40, 47),
					numEnemies = {
						map = function(p1, p2)
							return p2(2)
						end
					}
				},
				{
					name = "Prison",
					locked = true,
					useParachute = true,
					markerColor = Color3.new(0/255, 0/255, 0/255),
					position = Vector3.new(-1315.371, 14.684, -1675.214),
					backgroundColor = Color3.fromRGB(253, 123, 49),
					numEnemies = {
						map = function(p1, p2)
							return p2(2)
						end
					}
				}
			}
		})
	end
	function v1.render(p1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(SpawnSelection, {
				mapImageId = 11205536277,
				mapWorldWidth = 9984,
				mapWorldHeight = 9984,
				mapWorldCenterX = 169,
				mapWorldCenterY = -1550,
				mapImageWidth = 1024,
				mapImageHeight = 1024,
				worldPosition = p1.worldPosition,
				worldDirection = p1.worldDirection,
				size = UDim2.new(1, 0, 0.75, 0),
				color = Color3.new(255/255, 0/255, 0/255),
				square = true
			}) })
	end
	function v1.willUnmount(p1)  end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
