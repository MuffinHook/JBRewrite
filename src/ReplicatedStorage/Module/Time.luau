local function GetNowSync() --[[ Line: 1 ]]
	return workspace:GetServerTimeNow()
end
return {
	Init = function() --[[ Name: Init | Line: 4 ]] end,
	GetNowSync = GetNowSync
}