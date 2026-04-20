local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local getItemPropsFromRewardData_upvr = require(ReplicatedStorage.RewardSpinner.getItemPropsFromRewardData)
function module.setRewardSpinnerConfig(arg1, arg2) -- Line 7
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if not arg2.items then
        return nil
    end
    for _, v in arg2.items do
        table.insert({}, getItemPropsFromRewardData_upvr(v))
        local var13
    end
    return {
        items = var13;
        duration = arg2.duration;
        winIndex = arg2.winIndex;
        title = arg2.title;
        iconImageId = arg2.iconImageId;
        primaryColor = arg2.primaryColor;
        topic = arg2.topic;
        extraText = arg2.extraText;
    }
end
return require(ReplicatedStorage.Rodux).createReducer(nil, module)