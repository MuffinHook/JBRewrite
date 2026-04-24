-- Reviewed by Claude
local function GetNowSync()
	return workspace:GetServerTimeNow()
end
return {
	Init = function()  end,
	GetNowSync = GetNowSync
}
