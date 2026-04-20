local tbl_upvr = {}
for _, v in script:GetChildren() do
    tbl_upvr[v.Name] = false
end
local module_2_upvr = {}
local function GetCategoryByName_upvr(arg1) -- Line 8, Named "GetCategoryByName"
    assert(arg1)
    if not tbl_upvr[arg1] then
        local SOME = script:FindFirstChild(arg1)
        if not SOME then
            print(string.format("No category module: %s", arg1))
            error("No category module")
        end
        module_2_upvr[arg1] = require(SOME)
        tbl_upvr[arg1] = true
    end
    return module_2_upvr[arg1]
end
local RunService_upvr = game:GetService("RunService")
local function GetItemByName_upvr(arg1, arg2) -- Line 21, Named "GetItemByName"
    assert(arg1)
    assert(arg2)
    local GetCategoryByName_upvr_result1 = GetCategoryByName_upvr(arg1)
    local var17
    if GetCategoryByName_upvr_result1 then
        var17 = assert
        var17(GetCategoryByName_upvr_result1, arg1)
        var17 = GetCategoryByName_upvr_result1.GetItemByName
        if var17 then
            var17 = GetCategoryByName_upvr_result1.GetItemByName(arg2)
            return var17
        end
        if GetCategoryByName_upvr_result1.GetItems then
            var17 = GetCategoryByName_upvr_result1.GetItems()
        else
            var17 = GetCategoryByName_upvr_result1.Items
        end
        for _, v_2 in var17 do
            if v_2.Name == arg2 then
                return v_2
            end
        end
    end
    if RunService_upvr:IsServer() then
        warn(string.format("No CategoryName/ItemName: %s/%s", arg1, arg2))
    end
    return nil
end
return {
    GetCategoryByName = GetCategoryByName_upvr;
    GetItemByName = GetItemByName_upvr;
    GetMapFromSelection = function(arg1) -- Line 50, Named "GetMapFromSelection"
        assert(arg1)
        local module = {}
        for i_3, v_3 in pairs(arg1) do
            module[i_3] = GetItemByName_upvr(i_3, v_3)
        end
        return module
    end;
}