local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(rootContainer)
	local AppComponent = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local SpawnSelection = require(script.Parent.SpawnSelection)
	function AppComponent.init(rootContainer)
		local positionBinding, updatePosition = Roact.createBinding(Vector3.new(0, 0, 0))
		rootContainer.worldPosition = positionBinding
		rootContainer.updateWorldPosition = updatePosition
		local directionBinding, updateDirection = Roact.createBinding((Vector3.new(1, 0, 1)).Unit)
		rootContainer.worldDirection = directionBinding
		rootContainer.updateWorldDirection = updateDirection
		store:dispatch({
			type = "minimapSetSpawns",
			spawns = {
				{
					name = "CrimePort",
					useParachute = true,
					position = Vector3.new(2428.203, 20.751, -3775.428),
					backgroundColor = Color3.fromRGB(252, 40, 47),
					numEnemies = {
						map = function(index, mapArray)
							return mapArray(2)
						end
					}
				},
				{
					name = "CrimBase",
					position = Vector3.new(-428.203, 20.751, 1475.428),
					backgroundColor = Color3.fromRGB(252, 40, 47),
					numEnemies = {
						map = function(index, mapArray)
							return mapArray(2)
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
						map = function(index, mapArray)
							return mapArray(2)
						end
					}
				}
			}
		})
	end
	function AppComponent.render(rootContainer)
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
				worldPosition = rootContainer.worldPosition,
				worldDirection = rootContainer.worldDirection,
				size = UDim2.new(1, 0, 0.75, 0),
				color = Color3.new(255/255, 0/255, 0/255),
				square = true
			}) })
	end
	function AppComponent.willUnmount(rootContainer)  end
	local componentInstance = Roact.mount(Roact.createElement(AppComponent), rootContainer)
	return function()
		Roact.unmount(componentInstance)
	end
end
