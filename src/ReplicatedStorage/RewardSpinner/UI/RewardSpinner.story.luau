-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local EnumRarity = require(ReplicatedStorage.RewardSpinner.EnumRarity)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local RewardSpinner = require(script.Parent.RewardSpinner)
	local store = require(ReplicatedStorage.App.store)
	local t = {}
	local v2 = 0
	for i = 1, 80 do
		local v3
		local t2 = {
			Type = "Cash"
		}
		v3 = if math.random() > 0.5 then 1000 else 0
		t2.Amount = v3
		t2.RarityId = EnumRarity.Epic
		table.insert(t, t2)
	end
	function v1.init(p1)
		local t2 = {
			type = "setRewardSpinnerConfig",
			items = t,
			duration = 5,
			winIndex = 77
		}
		t2.extraText = "Spin num: " .. tostring(v2)
		store:dispatch(t2)
	end
	function v1.render(p1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(RewardSpinner, {
				onFinished = function()
					v2 = v2 + 1
					local t2 = {
						type = "setRewardSpinnerConfig",
						items = t,
						duration = 5,
						winIndex = 77
					}
					t2.extraText = "Spin num: " .. tostring(v2)
					store:dispatch(t2)
				end
			}) })
	end
	function v1.willUnmount(p1)  end
	local v4 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v4)
	end
end
