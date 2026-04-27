local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local EnumRarity = require(ReplicatedStorage.RewardSpinner.EnumRarity)
return function(parent)
	local AppComponent = Roact.Component:extend("App")
	local RewardSpinner = require(script.Parent.RewardSpinner)
	local store = require(ReplicatedStorage.App.store)
	local rewardItems = {}
	local spinCount = 0
	for i = 1, 80 do
		local randomAmount
		local spinConfig = {
			Type = "Cash"
		}
		randomAmount = if math.random() > 0.5 then 1000 else 0
		spinConfig.Amount = randomAmount
		spinConfig.RarityId = EnumRarity.Epic
		table.insert(rewardItems, spinConfig)
	end
	function AppComponent.init(parent)
		local spinConfig = {
			type = "setRewardSpinnerConfig",
			items = rewardItems,
			duration = 5,
			winIndex = 77
		}
		spinConfig.extraText = "Spin num: " .. tostring(spinCount)
		store:dispatch(spinConfig)
	end
	function AppComponent.render(parent)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(RewardSpinner, {
				onFinished = function()
					spinCount = spinCount + 1
					local spinConfig = {
						type = "setRewardSpinnerConfig",
						items = rewardItems,
						duration = 5,
						winIndex = 77
					}
					spinConfig.extraText = "Spin num: " .. tostring(spinCount)
					store:dispatch(spinConfig)
				end
			}) })
	end
	function AppComponent.willUnmount(parent)  end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), parent)
	return function()
		Roact.unmount(mountedComponent)
	end
end
