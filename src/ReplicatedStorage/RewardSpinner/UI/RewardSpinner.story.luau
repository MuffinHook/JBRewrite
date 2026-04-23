local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local EnumRarity = require(ReplicatedStorage.RewardSpinner.EnumRarity)
return function(p1) --[[ Line: 6 | Upvalues: Roact (copy), ReplicatedStorage (copy), EnumRarity (copy), RoactRodux (copy) ]]
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
	function v1.init(p1) --[[ Line: 19 | Upvalues: store (copy), t (copy), v2 (ref) ]]
		local t2 = {
			type = "setRewardSpinnerConfig",
			items = t,
			duration = 5,
			winIndex = 77
		}
		t2.extraText = "Spin num: " .. tostring(v2)
		store:dispatch(t2)
	end
	function v1.render(p1) --[[ Line: 28 | Upvalues: Roact (ref), RoactRodux (ref), store (copy), RewardSpinner (copy), v2 (ref), t (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(RewardSpinner, {
				onFinished = function() --[[ Name: onFinished | Line: 33 | Upvalues: v2 (ref), store (ref), t (ref) ]]
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
	function v1.willUnmount(p1) --[[ Line: 46 ]] end
	local v4 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 49 | Upvalues: Roact (ref), v4 (copy) ]]
		Roact.unmount(v4)
	end
end