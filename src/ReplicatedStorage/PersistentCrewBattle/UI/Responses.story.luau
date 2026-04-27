local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(containerElement)
	local AppComponent = Roact.Component:extend("App")
	local Responses = require(script.Parent.Responses)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	function AppComponent.init(self)  end
	function AppComponent.render(self)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement(Responses, {
				anchorPoint = Vector2.new(0.5, 0.5),
				position = UDim2.fromScale(0.5, 0.5),
				size = UDim2.fromScale(0.8, 1),
				aspectRatio = 2.7,
				verticalPaddingRatio = 64,
				numPlayersPerTeam = 5,
				clanColorOurs = Color3.fromHSV(0.6782, 0.6, 0.8),
				clanNameOurs = "BaBoyz!",
				clanOwnerOurs = 2025110,
				clanMembersOurs = {
					{
						UserId = 2025110,
						IsAdmin = true,
						RespondedAt = 0
					},
					{
						UserId = 2837719,
						IsAdmin = false
					},
					{
						UserId = 2829005475,
						IsAdmin = false
					},
					{
						UserId = 820499,
						IsAdmin = true
					}
				},
				clanMembersTheirs = {
					{
						RespondedAt = 0,
						IsAdmin = true
					},
					{
						RespondedAt = 0,
						IsAdmin = true
					},
					{
						RespondedAt = 0,
						IsAdmin = false
					}
				}
			}) })
	end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), containerElement)
	return function()
		Roact.unmount(mountedComponent)
	end
end
