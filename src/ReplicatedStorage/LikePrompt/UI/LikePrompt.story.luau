-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMcB3Zpc2libGUIc2V0U3RhdGUEaW5pdAVwcmludA5jbGlja2VkIGRvbmUuLgtvbkNsaWNrRG9uZQlleHBpcmVkLi4Jb25FeHBpcmVkDGNvdW50ZG93blRpbAVzdGF0ZQl3b3Jrc3BhY2UQR2V0U2VydmVyVGltZU5vdwZyZW5kZXILd2lsbFVubW91bnQHdW5tb3VudAlDb21wb25lbnQDQXBwBmV4dGVuZAdyZXF1aXJlCkxpa2VQcm9tcHQGc2NyaXB0BlBhcmVudAVtb3VudA1jcmVhdGVFbGVtZW50BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdAAIBQEAAAAACOIDAQCpBAEAMAQDoAAAAAC8AQAqAgAAAJ8BAwGCAAEAAwMBBQEAAwIACAMBGAABAAD/AAADCQAAAAAEAAEAAAANpAABAAAAAEBvAQIAnwACAfsAAADiAgQAqQMAADADAqADAAAAvAAAKgUAAACfAAMBggABAAYDBAQAAABAAwUDAQUBAwMCABEGARgAAAAAAQABAAD/AAADEgAAAAAEAAEAAAANpAABAAAAAEBvAQIAnwACAfsAAADiAgQAqQMAADADAqADAAAAvAAAKgUAAACfAAMBggABAAYDBAQAAABAAwcDAQUBAwMCABcIARgAAAAAAQABAAD/AAADGAAAAAAHAQIAAAAb+wEAAPsCAQDiAwQATQQAGAUAAABNBASgAAAAADAEA6AAAAAApAUIAAAAcEC8BQW3CQAAAJ8FAgKVBAUGMAQD8wEAAADZBAAAEgAAADAEA1MCAAAA2QQBABIAAAAwBANhAwAAAJ8BAwCCAQAACgMBAwkDBgMIBQQAAQIDAwoCAAAAAAAANEADCwQAAHBAAwwCAQINDQEYAAAAAQAAAAAAAQAAAAAAAAABAAAABgAAAPcADgAAAAABAQAAAAABggABAAAAHw4BGAAfAAAAAAIAAgAAAAb7AAAATQAAEgAAAAD7AQEAnwACAYIAAQABAw8AIgABGAAAAAAAASMAAAAABgECAAAAKfsBAABNAQGIAAAAAG8DAQC8AQGcAgAAAJ8BAwKkAgQAAAAwQKQEBwAAAGBATQQEJAgAAABNAwSGBQAAAJ8CAgLAAwkAMAMBEwoAAADZAwEAEgIBABIAAgAwAwGACwAAAMADDAAwAwE0DQAAAPsDAABNAwPkDgAAAPsEAABNBATKDwAAAFIFAQCfBAICUgUAAJ8DAwLZBAMAEgIAABIAAwCCBAIAEAMQAxEDEgMTBAAAMEADFAMVBAAAYEADFgYAAwMDDQYEAw4DFwMYBAADBAUFAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAUAAAAAEgAAAgAAAAAAAAAAAAEAAAAGAAAAAAQAAAECABKjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAhBgAAAJ8BAgJNAgHKBwAAAMADCAASAAEAEgACAIIDAgAJAxkEAAAAQAMaAxsDEwQAAEBAAxwDGAYGAQYBAAEYAAAAAAAAAAEAAAAAAQACAAAAAQAAAAAHJN1p6XOQKyx70zBMHrzV4FTFfp0WGQPo

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:50
-- Luau version 6, Types version 3
-- Time taken: 0.002783 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
return function(arg1) -- Line 5
    --[[ Upvalues[2]:
        [1]: Roact_upvr (readonly)
        [2]: createElement_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 8
        arg1_2:setState({
            visible = true;
        })
    end
    local LikePrompt_upvr = require(script.Parent.LikePrompt)
    function any_extend_result1.render(arg1_3) -- Line 13
        --[[ Upvalues[2]:
            [1]: createElement_upvr (copied, readonly)
            [2]: LikePrompt_upvr (readonly)
        ]]
        return createElement_upvr(LikePrompt_upvr, {
            visible = arg1_3.state.visible;
            countdownTil = workspace:GetServerTimeNow() + 20;
            onClickDone = function() -- Line 17, Named "onClickDone"
                --[[ Upvalues[1]:
                    [1]: arg1_3 (readonly)
                ]]
                print("clicked done..")
                arg1_3:setState({
                    visible = false;
                })
            end;
            onExpired = function() -- Line 23, Named "onExpired"
                --[[ Upvalues[1]:
                    [1]: arg1_3 (readonly)
                ]]
                print("expired..")
                arg1_3:setState({
                    visible = false;
                })
            end;
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 31
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 34
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end