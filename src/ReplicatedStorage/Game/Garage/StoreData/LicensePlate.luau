-- Reviewed by Claude
game:GetService("ReplicatedStorage")
function GetItemByName(p1)
	return {
		Name = p1
	}
end
return {
	Items = {},
	GetItemByName = GetItemByName
}