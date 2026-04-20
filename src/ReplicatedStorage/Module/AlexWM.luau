local function WindowOpen_upvr(arg1) -- Line 28, Named "WindowOpen"
    local Group = arg1.Group
    if Group then
        for _, v_2 in next, Group.Windows do
            if v_2 ~= arg1 and v_2.IsOpen then
                v_2.IsOpen = false
                v_2.CloseFun()
            end
        end
    end
    arg1.IsOpen = true
    arg1.OpenFun()
end
return {
    MakeWindowGroup = function() -- Line 1, Named "MakeWindowGroup"
        return {
            Windows = {};
        }
    end;
    WindowGroupAdd = function(arg1, arg2) -- Line 6, Named "WindowGroupAdd"
        table.insert(arg1.Windows, arg2)
        arg2.Group = arg1
    end;
    MakeWindowGroupA = function(...) -- Line 10, Named "MakeWindowGroupA"
        local tbl = {
            Windows = {};
        }
        for _, v in next, {...} do
            table.insert(tbl.Windows, v)
            v.Group = tbl
        end
    end;
    MakeWindow = function() -- Line 16, Named "MakeWindow"
        return {
            IsOpen = false;
            OpenFun = nil;
            CloseFun = nil;
            Group = nil;
        }
    end;
    WindowOpen = WindowOpen_upvr;
    WindowClose = function(arg1) -- Line 24, Named "WindowClose"
        arg1.IsOpen = false
        arg1.CloseFun()
    end;
    WindowToggle = function(arg1) -- Line 42, Named "WindowToggle"
        arg1.IsOpen = not arg1.IsOpen
        if arg1.IsOpen then
            WindowOpen_upvr(arg1)
        else
            arg1.IsOpen = false
            arg1.CloseFun()
        end
    end;
}