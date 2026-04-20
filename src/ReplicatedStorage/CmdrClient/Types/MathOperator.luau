return function(arg1) -- Line 1
    local tbl_2 = {}
    local tbl_4 = {
        Name = '+';
    }
    local function Perform(arg1_2, arg2) -- Line 7
        return arg1_2 + arg2
    end
    tbl_4.Perform = Perform
    local tbl = {
        Name = '-';
    }
    local function Perform(arg1_3, arg2) -- Line 13
        return arg1_3 - arg2
    end
    tbl.Perform = Perform
    local tbl_3 = {
        Name = '*';
    }
    local function Perform(arg1_4, arg2) -- Line 19
        return arg1_4 * arg2
    end
    tbl_3.Perform = Perform
    local tbl_5 = {
        Name = '/';
    }
    local function Perform(arg1_5, arg2) -- Line 25
        return arg1_5 / arg2
    end
    tbl_5.Perform = Perform
    local tbl_6 = {
        Name = "**";
    }
    local function Perform(arg1_6, arg2) -- Line 31
        return arg1_6 ^ arg2
    end
    tbl_6.Perform = Perform
    tbl_2[1] = tbl_4
    tbl_2[2] = tbl
    tbl_2[3] = tbl_3
    tbl_2[4] = tbl_5
    tbl_2[5] = tbl_6
    tbl_2[6] = {
        Name = '%';
        Perform = function(arg1_7, arg2) -- Line 37, Named "Perform"
            return arg1_7 % arg2
        end;
    }
    arg1:RegisterType("mathOperator", arg1.Cmdr.Util.MakeEnumType("Math Operator", tbl_2))
end