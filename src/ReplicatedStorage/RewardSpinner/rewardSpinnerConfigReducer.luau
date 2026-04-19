-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTBWl0ZW1zBXRhYmxlBmluc2VydAhkdXJhdGlvbgh3aW5JbmRleAV0aXRsZQtpY29uSW1hZ2VJZAxwcmltYXJ5Q29sb3IFdG9waWMJZXh0cmFUZXh0FnNldFJld2FyZFNwaW5uZXJDb25maWcEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNUmV3YXJkU3Bpbm5lchpnZXRJdGVtUHJvcHNGcm9tUmV3YXJkRGF0YQ1jcmVhdGVSZWR1Y2VyAAIMAgEAAAA4TQIBGAAAAAArAgIAxgIAAIICAgD/AgAAAAAAAE0DARgAAAAAxgQAAMYFAABkAwoA+wgAAFIJBwCfCAICnjQCBQgAAABSCgIAUgsIAKQJAwAACBCAnwkDAW4D9f8CAAAA4gMLADACAxgAAAAATQQBxQQAAAAwBAPFBAAAAE0EAb8FAAAAMAQDvwUAAABNBAGaBgAAADAEA5oGAAAATQQB1QcAAAAwBAPVBwAAAE0EAWQIAAAAMAQDZAgAAABNBAGrCQAAADAEA6sJAAAATQQBaQoAAAAwBANpCgAAAIIDAgAMAwEDAgMDBAAIEIADBAMFAwYDBwMIAwkDCgUIAAQFBgcICQoABwsBGAAAAAEAAgABAAAAAAEAAAEAAAAAAAD+AAQBAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAAACAAAAAAHAAABAgAdowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIApwYAAACfAQICpAIFAAAAQEBNAwC3BwAAAE0DA+cIAAAAnwICAk0DAdYJAAAAxgQAAOIFCwDABgwAEgACADAGBeAKAAAAnwMDAIIDAAANAwwEAAAAQAMNAw4DDwQAAEBAAxADEQMSAxMDCwUBCgYAAQABAAEYAAAAAAAAAAEAAAAAAgAAAAAAAAIAAAABAAAA/wABAAAAAAGc1h5F9j76vYsxSOrzQDub7M4JMa4SdEQ=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:27
-- Luau version 6, Types version 3
-- Time taken: 0.002321 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local getItemPropsFromRewardData_upvr = require(ReplicatedStorage.RewardSpinner.getItemPropsFromRewardData)
function module.setRewardSpinnerConfig(arg1, arg2) -- Line 7
    --[[ Upvalues[1]:
        [1]: getItemPropsFromRewardData_upvr (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
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