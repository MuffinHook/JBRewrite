-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYB2NoZWNrZWQIc2V0U3RhdGUEaW5pdAlvbkNoZWNrZWQNY3JlYXRlRWxlbWVudARzaXplCHBvc2l0aW9uBXZhbHVlBVVEaW0yA25ldwVzdGF0ZQZyZW5kZXIHdW5tb3VudAlDb21wb25lbnQDQXBwBmV4dGVuZAdyZXF1aXJlCENoZWNrYm94BnNjcmlwdAZQYXJlbnQFbW91bnQERXpVaRFGaW5kRmlyc3RBbmNlc3RvcgVSb2FjdAAGBQEAAAAACOIDAQCpBAAAMAQDAgAAAAC8AQAqAgAAAJ8BAwGCAAEAAwMBBQEAAwIACAMBGAABAAD/AAADCQAAAAAEAQEAAAAI+wEAAOIDAQAwAAMCAAAAALwBASoCAAAAnwEDAYIAAQADAwEFAQADAgASBAEYAAABAP8AAAMTAAAAAAkBAgAAACP7AQAATQEBygAAAAD7AgEA4gMFAKQECAAAHGCAjAUAAIwGHgCMBwAAjAgeAJ8EBQIwBAMPAQAAAKQECAAAHGCAbwUJAIwGAABvBwoAjAgAAJ8EBQIwBAPbAgAAAE0EABgLAAAATQQEAgwAAAAwBAPMAwAAANkEAAASAAAAMAQDYAQAAACfAQMAggEAAA0DBQMGAwcDCAMEBQQBAgMEAwkDCgQAHGCAAgAAAAAAANA/AgAAAAAAAOA/AwsDAQEBDQwBGAAAAAAAAQAAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAQAAAPwADgAAAAACAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMNABsAARgAAAAAAAEcAAAAAAYBAQAAACb7AQAATQEBiAAAAABvAwEAvAEBnAIAAACfAQMCpAIEAAAAMECkBAcAAABgQE0EBCQIAAAATQME8AUAAACfAgICwAMJADADARMKAAAA2QMBABICAAASAAIAMAMBgAsAAAD7AwAATQMD5AwAAAD7BAAATQQEyg0AAABSBQEAnwQCAlIFAACfAwMC2QQCABICAAASAAMAggQCAA4DDgMPAxADEQQAADBAAxIDEwQAAGBAAxQGAAMDAwwDFQMFAwACAwUAARgAAAAAAAAAAQAAAAAAAAAAAQAABQAAAAANAAAAAAAAAAAAAQAAAAYAAAAAAwAAAQIAEaMAAACkAAEAAAAAQG8CAgC8AAB8AwAAAJ8AAwKkAQUAAABAQE0CACQGAAAATQICIQcAAACfAQICwAIIABIAAQCCAgIACQMTBAAAAEADFgMXAxEEAABAQAMUAxgGBAEEAQABGAABAAAAAAABAAAAAAAAAgAAAQAAAAAFfRRLwpKl2eCmAuw0KY1MuQ0MXLZP0CHD

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:36
-- Luau version 6, Types version 3
-- Time taken: 0.001794 seconds

local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(arg1) -- Line 5
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 8
        arg1_2:setState({
            checked = false;
        })
    end
    local Checkbox_upvr = require(script.Parent.Checkbox)
    function any_extend_result1.render(arg1_3) -- Line 13
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: Checkbox_upvr (readonly)
        ]]
        return Roact_upvr.createElement(Checkbox_upvr, {
            size = UDim2.new(0, 30, 0, 30);
            position = UDim2.new(0.25, 0, 0.5, 0);
            value = arg1_3.state.checked;
            onChecked = function(arg1_4) -- Line 18, Named "onChecked"
                --[[ Upvalues[1]:
                    [1]: arg1_3 (readonly)
                ]]
                local tbl = {}
                tbl.checked = arg1_4
                arg1_3:setState(tbl)
            end;
        })
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 27
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end