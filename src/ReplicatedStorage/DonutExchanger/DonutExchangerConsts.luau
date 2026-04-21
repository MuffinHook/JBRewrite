-- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
    TAG_NAME = "DonutExchanger";
    EXCHANGE_DONUT_REMOTE_NAME = "ExchangeDonutRemote";
    MAX_DONUTS_PER_PLAYER = 3;
    MAX_DONUTS_TIME_PERIOD = 300;
    POSSIBLE_REWARDS = {{
        Probability = 0.15;
        RewardName = "C4";
        Dialogue = {"There's a weak wall within the Yard..."};
    }, {
        Probability = 0.1;
        RewardName = "Pistol";
        Dialogue = {"It took me a while to find one of these."};
    }, {
        Probability = 0.2;
        RewardName = "Grenade";
        Dialogue = {"Hope these can create a diversion."};
    }, {
        Probability = 0.15;
        RewardName = "SmokeGrenade";
        Dialogue = {"This might help in your escape."};
    }, {
        Probability = 0.1;
        RewardName = "Sword";
        Dialogue = {"Snuck this one off a patrolling officer."};
    }, {
        Probability = 0.05;
        RewardName = "Key";
        Dialogue = {"One of these can get you into anywhere."};
    }, {
        Probability = 0.1;
        RewardName = "Juice";
        Dialogue = {"These things are craaaazy."};
    }, {
        Probability = 0.15;
        RewardName = nil;
        Dialogue = {"I really needed this donut, been in here since 2017."};
    }};
}
local var28 = 0
for _, v in module.POSSIBLE_REWARDS do
    local var29
    if 0 >= v.Probability then
        var29 = false
    else
        var29 = true
    end
    assert(var29, "Reward probabilities must be positive!")
    if v.RewardName and not ReplicatedStorage.Game.Item:FindFirstChild(v.RewardName) then
        var29 = "Reward is not a valid item: "..v.RewardName
        error(var29)
    end
    var28 += v.Probability
end
if math.abs(var28 - 1) >= 0.001 then
else
end
assert(true, "Reward probabilities must sum to 1!")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze(module)
