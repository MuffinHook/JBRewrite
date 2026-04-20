local CombatConsts_upvr = require(game:GetService("ReplicatedStorage").Combat.CombatConsts)
return {
    getRootPartHitRadius = function(arg1) -- Line 4, Named "getRootPartHitRadius"
        if arg1.Name ~= "HumanoidRootPart" then
            warn("HumanoidRootPart expected")
        end
        local attribute = arg1:GetAttribute(CombatConsts_upvr.ROOT_PART_HIT_RADIUS_ATTR_NAME)
        if not attribute then
            attribute = CombatConsts_upvr
            attribute = attribute.DEFAULT_ROOT_PART_HIT_RADIUS
        end
        return attribute
    end;
    setRootPartHitRadius = function(arg1, arg2) -- Line 11, Named "setRootPartHitRadius"
        if arg1.Name ~= "HumanoidRootPart" then
            warn("HumanoidRootPart expected")
        end
        arg1:SetAttribute(CombatConsts_upvr.ROOT_PART_HIT_RADIUS_ATTR_NAME, arg2)
    end;
}