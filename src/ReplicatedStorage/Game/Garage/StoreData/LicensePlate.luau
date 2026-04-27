game:GetService("ReplicatedStorage")
function GetItemByName(itemName)
	return {
		Name = itemName
	}
end
return {
	Items = {},
	GetItemByName = GetItemByName
}
