local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local ActionButtonService_upvr = require(ReplicatedStorage.ActionButton.ActionButtonService)
return function(arg1) -- Line 6
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 10
        arg1_2._maid = Maid_upvr.new()
        local tbl_5 = {
            primary = true;
            priority = 1000;
            saturateTo = 0;
            useEvery = 5;
            title = "drive";
            image = "rbxassetid://7858765663";
            keyCodes = {Enum.KeyCode.W, Enum.KeyCode.Up};
        }
        local function onPressed() -- Line 20
            print("asdf")
            return true
        end
        tbl_5.onPressed = onPressed
        local function onReleased() -- Line 24
        end
        tbl_5.onReleased = onReleased
        arg1_2._maid:GiveTask(ActionButtonService_upvr.add(tbl_5))
        local tbl_2 = {
            primary = true;
            priority = 700;
            saturateTo = 0;
            title = "brake";
            image = "rbxassetid://7858764373";
            keyCodes = {Enum.KeyCode.S, Enum.KeyCode.Down};
        }
        local function onPressed() -- Line 33
            print("asdf2")
        end
        tbl_2.onPressed = onPressed
        local function onReleased() -- Line 36
        end
        tbl_2.onReleased = onReleased
        arg1_2._maid:GiveTask(ActionButtonService_upvr.add(tbl_2))
        local tbl = {
            priority = 900;
            image = "rbxassetid://4939735995";
            keyCodes = {Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonB};
            touchIsToggle = true;
            gamepadIsToggle = true;
        }
        local function onPressed() -- Line 45
        end
        tbl.onPressed = onPressed
        function tbl.onReleased() -- Line 46
        end
        arg1_2._maid:GiveTask(ActionButtonService_upvr.add(tbl))
        local tbl_4 = {
            priority = 950;
            image = "rbxassetid://4939759147";
            useEvery = 5;
            keyCodes = {Enum.KeyCode.C, Enum.KeyCode.Z, Enum.KeyCode.ButtonL3};
            allowPassThrough = true;
        }
        local function onPressed() -- Line 57
            return true
        end
        tbl_4.onPressed = onPressed
        arg1_2._maid:GiveTask(ActionButtonService_upvr.add(tbl_4))
        local tbl_3 = {
            priority = 975;
            image = "rbxassetid://4939740172";
            keyCodes = {Enum.KeyCode.F, Enum.KeyCode.ButtonR2};
        }
        local function onPressed() -- Line 67
        end
        tbl_3.onPressed = onPressed
        arg1_2._maid:GiveTask(ActionButtonService_upvr.add(tbl_3))
        arg1_2._maid:GiveTask(ActionButtonService_upvr.add({
            priority = 650;
            image = "rbxassetid://4970993126";
            keyCodes = {Enum.KeyCode.R};
            onPressed = function() -- Line 75, Named "onPressed"
            end;
        }))
    end
    local Runtime_upvr = require(script.Parent.Runtime)
    function any_extend_result1.render(arg1_3) -- Line 79
        return Roact_upvr.createElement(Runtime_upvr, {
            enabled = true;
            color = Color3.new(1, 0, 0);
            DEBUG_forceRadial = true;
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 86
        arg1_4._maid:Destroy()
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 91
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end