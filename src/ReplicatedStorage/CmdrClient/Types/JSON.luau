local HttpService = game:GetService("HttpService")
return function(typeRegistry)
	typeRegistry:RegisterType("json", {
		Validate = function(jsonString)
			return pcall(HttpService.JSONDecode, HttpService, jsonString)
		end,
		Parse = function(jsonString)
			return HttpService:JSONDecode(jsonString)
		end
	})
end
