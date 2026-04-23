game:GetService("ReplicatedStorage")
function GetItemByName(p1) --[[ Line: 7 ]]
	return {
		Name = p1
	}
end
return {
	Items = {},
	GetItemByName = GetItemByName
}