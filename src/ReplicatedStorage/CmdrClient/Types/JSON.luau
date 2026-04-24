-- Reviewed by Claude
local HttpService = game:GetService("HttpService")
return function(p1)
	p1:RegisterType("json", {
		Validate = function(p1)
			return pcall(HttpService.JSONDecode, HttpService, p1)
		end,
		Parse = function(p1)
			return HttpService:JSONDecode(p1)
		end
	})
end
