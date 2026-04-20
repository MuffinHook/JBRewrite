function GetItemByName(arg1) -- Line 7
    local module = {}
    module.Name = arg1
    return module
end
return {
    Items = {};
    GetItemByName = GetItemByName;
}