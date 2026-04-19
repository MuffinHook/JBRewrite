-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:11
-- Luau version 6, Types version 3
-- Time taken: 0.003194 seconds

local PlaneConsts_upvr = require(game:GetService("ReplicatedStorage").Plane.PlaneConsts)
return {
    getOrigin = function(arg1) -- Line 5, Named "getOrigin"
        --[[ Upvalues[1]:
            [1]: PlaneConsts_upvr (readonly)
        ]]
        return arg1:GetAttribute(PlaneConsts_upvr.ORIGIN_ATTR_NAME)
    end;
    setOrigin = function(arg1, arg2) -- Line 8, Named "setOrigin"
        --[[ Upvalues[1]:
            [1]: PlaneConsts_upvr (readonly)
        ]]
        arg1:SetAttribute(PlaneConsts_upvr.ORIGIN_ATTR_NAME, arg2)
    end;
    getTarget = function(arg1) -- Line 11, Named "getTarget"
        --[[ Upvalues[1]:
            [1]: PlaneConsts_upvr (readonly)
        ]]
        return arg1:GetAttribute(PlaneConsts_upvr.TARGET_ATTR_NAME)
    end;
    setTarget = function(arg1, arg2) -- Line 14, Named "setTarget"
        --[[ Upvalues[1]:
            [1]: PlaneConsts_upvr (readonly)
        ]]
        arg1:SetAttribute(PlaneConsts_upvr.TARGET_ATTR_NAME, arg2)
    end;
    setTypeEnum = function(arg1, arg2) -- Line 17, Named "setTypeEnum"
        --[[ Upvalues[1]:
            [1]: PlaneConsts_upvr (readonly)
        ]]
        arg1:SetAttribute(PlaneConsts_upvr.AIR_DROP_TYPE_ENUM_ATTRIBUTE_NAME, arg2)
        return true
    end;
    getTypeEnum = function(arg1) -- Line 21, Named "getTypeEnum"
        --[[ Upvalues[1]:
            [1]: PlaneConsts_upvr (readonly)
        ]]
        local attribute = arg1:GetAttribute(PlaneConsts_upvr.AIR_DROP_TYPE_ENUM_ATTRIBUTE_NAME)
        assert(attribute, "Airdrop has no type")
        return attribute
    end;
    getBornAt = function(arg1) -- Line 26, Named "getBornAt"
        --[[ Upvalues[1]:
            [1]: PlaneConsts_upvr (readonly)
        ]]
        return arg1:GetAttribute(PlaneConsts_upvr.BORN_AT_ATTR_NAME)
    end;
    setBornAt = function(arg1, arg2) -- Line 29, Named "setBornAt"
        --[[ Upvalues[1]:
            [1]: PlaneConsts_upvr (readonly)
        ]]
        arg1:SetAttribute(PlaneConsts_upvr.BORN_AT_ATTR_NAME, arg2)
    end;
    getSpeed = function(arg1) -- Line 32, Named "getSpeed"
        --[[ Upvalues[1]:
            [1]: PlaneConsts_upvr (readonly)
        ]]
        return arg1:GetAttribute(PlaneConsts_upvr.SPEED_ATTR_NAME)
    end;
    setSpeed = function(arg1, arg2) -- Line 35, Named "setSpeed"
        --[[ Upvalues[1]:
            [1]: PlaneConsts_upvr (readonly)
        ]]
        arg1:SetAttribute(PlaneConsts_upvr.SPEED_ATTR_NAME, arg2)
    end;
    getDuration = function(arg1, arg2, arg3) -- Line 38, Named "getDuration"
        return (arg2 - arg1).Magnitude / arg3
    end;
    getPositionAt = function(arg1, arg2, arg3, arg4, arg5) -- Line 43, Named "getPositionAt"
        local var4 = arg3 - arg2
        return arg2 + (var4) * (arg1 / arg5) + var4.Unit:Cross(Vector3.new(0, 1, 0)) * arg4 * math.cos(arg1)
    end;
}