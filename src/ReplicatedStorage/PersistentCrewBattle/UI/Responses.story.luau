-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(arg1)
	local local1 = Roact.Component:extend("App")
	local Responses = require(script.Parent.Responses)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	function local1.init(arg1)  end
	function local1.render(arg1)
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
	local local2 = Roact.mount(Roact.createElement(local1), arg1)
	return function()
		Roact.unmount(local2)
	end
end
