local tbl_upvr = {
    ClassName = "Tree";
}
tbl_upvr.__index = tbl_upvr
function tbl_upvr.new() -- Line 28
    local setmetatable_result1 = setmetatable({}, tbl_upvr)
    setmetatable_result1.Root = true
    setmetatable_result1.Depth = 1
    setmetatable_result1.Branches = {}
    setmetatable_result1.Leaf = nil
    return setmetatable_result1
end
function tbl_upvr.AddBranch(arg1, arg2) -- Line 36
    local var3
    if arg2.ClassName ~= tbl_upvr.ClassName then
        var3 = false
    else
        var3 = true
    end
    assert(var3)
    var3 = arg2.Root
    assert(var3)
    arg2.Root = false
    var3 = arg1.Depth
    arg2.Depth = var3 + 1
    var3 = arg1.Branches
    table.insert(var3, arg2)
end
local function Complete(arg1) -- Line 43
    arg1.State = 4
    for i = 1, #arg1.Branches do
        arg1.Branches[i].State = 2
    end
end
tbl_upvr.Complete = Complete
local tbl_upvr_3 = {
    Welcome = tbl_upvr.new();
}
tbl_upvr_3.Welcome.Leaf = {
    Title = "Welcome to Jailbreak!";
    Body = "This tutorial will teach you the basics of Jailbreak.";
    Duration = 15;
}
tbl_upvr_3.Escape = tbl_upvr.new()
tbl_upvr_3.Escape.Leaf = {
    Title = "Getting Started";
    Body = "Figure out how to escape the prison.";
    Duration = 15;
    Team = 2;
}
tbl_upvr_3.GetCar = tbl_upvr.new()
tbl_upvr_3.GetCar.Leaf = {
    Title = "Life of a Criminal";
    Body = "You escaped! Look for a car to drive...";
    Duration = 15;
    Team = 2;
}
tbl_upvr_3.GetCarDone = tbl_upvr.new()
tbl_upvr_3.GetCarDone.Leaf = {
    Title = "Driving";
    Body = "This is your starter car. You can upgrade it, and buy other cars!";
    Duration = 15;
    Team = 2;
    OneShot = true;
}
tbl_upvr_3.BankRobbery = tbl_upvr.new()
tbl_upvr_3.BankRobbery.Leaf = {
    Title = "Robbery";
    Body = "Go to the bank in the city to rob it!";
    Duration = 15;
    Team = 2;
}
tbl_upvr_3.BankRobberyDone = tbl_upvr.new()
tbl_upvr_3.BankRobberyDone.Leaf = {
    Title = "Robbery Complete";
    Body = "Earn money by robbing the bank, jewelry store, train, museum, and more!";
    Duration = 15;
    Team = 2;
    OneShot = true;
}
tbl_upvr_3.CustomizeCar = tbl_upvr.new()
tbl_upvr_3.CustomizeCar.Leaf = {
    Title = "Customize Your Car";
    Body = "Go to the garage in the city to customize your car.";
    Duration = 15;
    Team = 2;
}
tbl_upvr_3.Welcome:AddBranch(tbl_upvr_3.Escape)
tbl_upvr_3.Escape:AddBranch(tbl_upvr_3.GetCar)
tbl_upvr_3.GetCar:AddBranch(tbl_upvr_3.GetCarDone)
tbl_upvr_3.GetCar:AddBranch(tbl_upvr_3.BankRobbery)
tbl_upvr_3.BankRobbery:AddBranch(tbl_upvr_3.BankRobberyDone)
tbl_upvr_3.GetCar:AddBranch(tbl_upvr_3.CustomizeCar)
local function _(arg1) -- Line 120, Named "CompleteTree"
    arg1.State = 4
    for i_2 = 1, #arg1.Branches do
        arg1.Branches[i_2].State = 2
    end
end
local function GetDeepestUnlocked_upvr(arg1) -- Line 126, Named "GetDeepestUnlocked"
    local var28 = true
    local var29
    if arg1.State ~= 4 then
        if arg1.State ~= 2 then
            var28 = false
        else
            var28 = true
        end
    end
    var29 = assert
    var29(var28)
    var29 = arg1.State
    if var29 == 2 then
        return arg1
    end
    var29 = arg1.State
    if var29 == 4 then
        var29 = #arg1.Branches
        for i_3 = 1, var29 do
            local var30 = arg1.Branches[i_3]
            if var30.State == 2 and var30.Leaf.OneShot then
                return var30
            end
        end
    end
    var29 = nil
    for i_4 = 1, #arg1.Branches do
        local var31 = arg1.Branches[i_4]
        if var31.State == 4 or var31.State == 2 then
            local GetDeepestUnlocked_upvr_result1_2 = GetDeepestUnlocked_upvr(var31)
            if GetDeepestUnlocked_upvr_result1_2 then
                if 0 < GetDeepestUnlocked_upvr_result1_2.Depth then
                    var29 = GetDeepestUnlocked_upvr_result1_2
                end
            end
        end
    end
    return var29
end
local var34_upvw
local tbl_upvr_2 = {}
local var36_upvw = false
local function _(arg1) -- Line 163, Named "ProcessMessage"
    var34_upvw.Message.Inner.Title.Text = arg1.Title
    var34_upvw.Message.Inner.Body.Text = arg1.Body
end
local function ProcessQueue_upvr() -- Line 167, Named "ProcessQueue"
    var36_upvw = true
    if var34_upvw.Icon.Visible then
        var34_upvw.Icon:TweenPosition(UDim2.new(1, 0, 1, -266), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true, function() -- Line 176
            var34_upvw.Icon.Visible = false
        end)
        wait(0.5)
    else
        var34_upvw.Icon.Position = UDim2.new(1, 0, 1, -266)
    end
    var34_upvw.Message.Visible = true
    var34_upvw.Message:TweenPosition(UDim2.new(1, -200, 1, -300), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    while 0 < #tbl_upvr_2 do
        local popped = table.remove(tbl_upvr_2, 1)
        var34_upvw.Message.Inner.Title.Text = popped.Title
        var34_upvw.Message.Inner.Body.Text = popped.Body
        wait(popped.Duration)
    end
    var34_upvw.Message:TweenPosition(UDim2.new(1, 0, 1, -300), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true, function() -- Line 203
        var34_upvw.Message.Visible = false
    end)
    wait(0.5)
    var34_upvw.Icon.Visible = true
    var34_upvw.Icon:TweenPosition(UDim2.new(1, -40, 1, -266), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    var36_upvw = false
end
local function _(arg1) -- Line 218, Named "ShowMessage"
    table.insert(tbl_upvr_2, arg1)
    if not var36_upvw then
        var36_upvw = true
        spawn(ProcessQueue_upvr)
    end
end
local function _() -- Line 225, Named "ShowNextMessage"
    table.insert(tbl_upvr_2, GetDeepestUnlocked_upvr(tbl_upvr_3.Welcome).Leaf)
    if not var36_upvw then
        var36_upvw = true
        spawn(ProcessQueue_upvr)
    end
end
local function _(arg1) -- Line 229, Named "Complete"
    arg1:Complete()
    table.insert(tbl_upvr_2, GetDeepestUnlocked_upvr(tbl_upvr_3.Welcome).Leaf)
    if not var36_upvw then
        var36_upvw = true
        spawn(ProcessQueue_upvr)
    end
end
return {
    Init = function(arg1) -- Line 236, Named "Init"
        var34_upvw = arg1.GetScreenGui("Tutorial")
        table.insert(tbl_upvr_2, tbl_upvr_3.Welcome.Leaf)
        if not var36_upvw then
            var36_upvw = true
            spawn(ProcessQueue_upvr)
        end
        tbl_upvr_3.Welcome:Complete()
        table.insert(tbl_upvr_2, GetDeepestUnlocked_upvr(tbl_upvr_3.Welcome).Leaf)
        if not var36_upvw then
            var36_upvw = true
            spawn(ProcessQueue_upvr)
        end
        local tick_result1_2_upvw = tick()
        var34_upvw.Icon.InputBegan:Connect(function(arg1_2) -- Line 246, Named "IconInputBegan"
            if arg1_2.UserInputType == Enum.UserInputType.MouseButton1 then
                local tick_result1_3 = tick()
                if tick_result1_3 - tick_result1_2_upvw < 0.5 then
                    return false
                end
                tick_result1_2_upvw = tick_result1_3
                table.insert(tbl_upvr_2, GetDeepestUnlocked_upvr(tbl_upvr_3.Welcome).Leaf)
                if not var36_upvw then
                    var36_upvw = true
                    spawn(ProcessQueue_upvr)
                end
            end
        end)
        var34_upvw.Icon.MouseEnter:Connect(function(arg1_3) -- Line 256, Named "IconMouseEnter"
            local tick_result1 = tick()
            if tick_result1 - tick_result1_2_upvw < 0.5 then
                return false
            end
            tick_result1_2_upvw = tick_result1
            table.insert(tbl_upvr_2, GetDeepestUnlocked_upvr(tbl_upvr_3.Welcome).Leaf)
            if not var36_upvw then
                var36_upvw = true
                spawn(ProcessQueue_upvr)
            end
        end)
        arg1.em.c6z4isc9 = function(arg1_4, arg2) -- Line 267, Named "c6z4isc9"
            for i_5, _ in next, arg1_4 do
                local var45 = tbl_upvr_3[i_5]
                if var45 and var45.State ~= 4 then
                    if arg2 then
                        tbl_upvr:Complete()
                    else
                        tbl_upvr:Complete()
                        table.insert(tbl_upvr_2, GetDeepestUnlocked_upvr(tbl_upvr_3.Welcome).Leaf)
                        if not var36_upvw then
                            var36_upvw = true
                            spawn(ProcessQueue_upvr)
                        end
                    end
                end
            end
        end
    end;
}