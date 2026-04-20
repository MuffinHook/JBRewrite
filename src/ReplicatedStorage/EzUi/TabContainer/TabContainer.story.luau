local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(arg1) -- Line 5
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
            local tbl = {}
            tbl.currentPage = arg1_4
            arg1_3:setState(tbl)
        end
        return Roact_upvr.createElement(require(script.Parent), module)
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 50
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end