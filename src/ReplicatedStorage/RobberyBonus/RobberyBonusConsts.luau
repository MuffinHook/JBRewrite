local module = {
    SPINNER_TOTAL_NUM_CARDS = 35;
    SPINNER_DURATION = 5;
    MANSION_SPIN_DURATION_MULTIPLIER = 1.5;
    FIREWORK_FX_REMOTE_NAME = "RobberyBonusFireworkFx";
    ROBBERY_BONUS_REWARD_SPINNER_TOPIC = "RobberyBonusReward";
    SPINNER_STOP_INDEX = module.SPINNER_TOTAL_NUM_CARDS - 3;
}
return require(game:GetService("ReplicatedStorage").Std.TableUtils).requireValidIndexAndFreeze(module)