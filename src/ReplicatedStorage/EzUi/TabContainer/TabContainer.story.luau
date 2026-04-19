-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:51
-- Luau version 6, Types version 3
-- Time taken: 0.002693 seconds

local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(arg1) -- Line 5
    --[[ Upvalues[1]:
        [1]: Roact_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.PureComponent:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 10
        arg1_2:setState({
            currentPage = nil;
        })
    end
    local any_createRef_result1_upvr = Roact_upvr.createRef()
    local any_createRef_result1_upvr_2 = Roact_upvr.createRef()
    local any_createRef_result1_upvr_3 = Roact_upvr.createRef()
    function any_extend_result1.render(arg1_3) -- Line 15
        --[[ Upvalues[4]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_createRef_result1_upvr (readonly)
            [3]: any_createRef_result1_upvr_2 (readonly)
            [4]: any_createRef_result1_upvr_3 (readonly)
        ]]
        local module = {
            visible = true;
            size = UDim2.new(0.95, 0, 0.95, 0);
            anchorPoint = Vector2.new(0.5, 0.5);
            position = UDim2.new(0.5, 0, 0.5, 0);
            pages = {{
                title = "CONSOLE";
                layoutOrder = 1;
                backgroundTransparency = 0.5;
                [Roact_upvr.Ref] = any_createRef_result1_upvr;
            }, {
                title = "SETTINGS";
                layoutOrder = 2;
                [Roact_upvr.Ref] = any_createRef_result1_upvr_2;
            }, {
                title = "GAMEMODES";
                tabColor = Color3.new(0, 0, 1);
                layoutOrder = 3;
                [Roact_upvr.Ref] = any_createRef_result1_upvr_3;
            }};
            color = Color3.fromRGB(252, 40, 47);
            currentPage = arg1_3.state.currentPage;
        }
        function module.updatePage(arg1_4) -- Line 42
            --[[ Upvalues[1]:
                [1]: arg1_3 (readonly)
            ]]
            local tbl = {}
            tbl.currentPage = arg1_4
            arg1_3:setState(tbl)
        end
        return Roact_upvr.createElement(require(script.Parent), module)
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 50
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end