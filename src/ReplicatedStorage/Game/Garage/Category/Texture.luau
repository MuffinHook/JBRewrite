return function(props)
	local Model = props.Model
	if Model then
		return Model:FindFirstChild("Body", true)
	end
end
