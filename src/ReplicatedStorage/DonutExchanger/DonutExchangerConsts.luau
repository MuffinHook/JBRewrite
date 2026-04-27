local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local t = {
	TAG_NAME = "DonutExchanger",
	EXCHANGE_DONUT_REMOTE_NAME = "ExchangeDonutRemote",
	MAX_DONUTS_PER_PLAYER = 3,
	MAX_DONUTS_TIME_PERIOD = 300,
	POSSIBLE_REWARDS = {
		{
			Probability = 0.15,
			RewardName = "C4",
			Dialogue = { "There\'s a weak wall within the Yard..." }
		},
		{
			Probability = 0.1,
			RewardName = "Pistol",
			Dialogue = { "It took me a while to find one of these." }
		},
		{
			Probability = 0.2,
			RewardName = "Grenade",
			Dialogue = { "Hope these can create a diversion." }
		},
		{
			Probability = 0.15,
			RewardName = "SmokeGrenade",
			Dialogue = { "This might help in your escape." }
		},
		{
			Probability = 0.1,
			RewardName = "Sword",
			Dialogue = { "Snuck this one off a patrolling officer." }
		},
		{
			Probability = 0.05,
			RewardName = "Key",
			Dialogue = { "One of these can get you into anywhere." }
		},
		{
			Probability = 0.1,
			RewardName = "Juice",
			Dialogue = { "These things are craaaazy." }
		},
		{
			Probability = 0.15,
			RewardName = nil,
			Dialogue = { "I really needed this donut, been in here since 2017." }
		}
	}
}
local sum = 0
for rewardIndex, rewardData in t.POSSIBLE_REWARDS do
	local isProbabilityValid
	isProbabilityValid = rewardData.Probability > 0
	assert(isProbabilityValid, "Reward probabilities must be positive!")
	if rewardData.RewardName and not ReplicatedStorage.Game.Item:FindFirstChild(rewardData.RewardName) then
		error("Reward is not a valid item: " .. rewardData.RewardName)
	end
	sum = sum + rewardData.Probability
end
assert(math.abs(sum - 1) < 0.001, "Reward probabilities must sum to 1!")
return TableUtils.requireValidIndexAndFreeze(t)
