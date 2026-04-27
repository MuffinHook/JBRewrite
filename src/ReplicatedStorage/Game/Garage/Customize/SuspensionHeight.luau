return function(suspensionData, targetModel)
	if suspensionData then
		targetModel.Model:SetAttribute("GarageSuspensionHeight", suspensionData.Height)
	else
		targetModel.Model:SetAttribute("GarageSuspensionHeight", 0)
	end
end
