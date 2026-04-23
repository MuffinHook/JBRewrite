local LocalPlayer = game:GetService("Players").LocalPlayer
return function(p1) --[[ Line: 6 | Upvalues: LocalPlayer (copy) ]]
	local Util = p1.Util
	local Window = require(script:WaitForChild("Window"))
	Window.Cmdr = p1
	local v1 = require(script:WaitForChild("AutoComplete"))(p1)
	Window.AutoComplete = v1
	function Window.ProcessEntry(p12) --[[ Line: 16 | Upvalues: Util (copy), Window (copy), p1 (copy), LocalPlayer (ref) ]]
		local v1 = Util.TrimString(p12)
		if #v1 ~= 0 then
			Window:AddLine(Window:GetLabel() .. " " .. v1, Color3.fromRGB(255, 223, 93))
			Window:AddLine(p1.Dispatcher:EvaluateAndRun(v1, LocalPlayer, {
				IsHuman = true
			}))
		end
	end
	function Window.OnTextChanged(p12) --[[ Line: 31 | Upvalues: p1 (copy), LocalPlayer (ref), Util (copy), Window (copy), v1 (copy) ]]
		local v12 = p1.Dispatcher:Evaluate(p12, LocalPlayer, true)
		local v2 = Util.SplitString(p12)
		local v3 = table.remove(v2, 1)
		local v4
		if v12 then
			local v5 = Util.MashExcessArguments(v2, #v12.Object.Args)
			if #v5 == #v12.Object.Args then
				v2 = v5
				v4 = true
			else
				v2 = v5
				v4 = false
			end
		else
			v4 = false
		end
		local v6
		if p12:sub(#p12, #p12):match("%s") and not v4 then
			v2[#v2 + 1] = ""
			v6 = true
		end
		if v12 and v6 then
			local v7, v8 = v12:Validate()
			Window:SetIsValidInput(v7, ("Validation errors: %s"):format(v8 or ""))
			local t = {}
			local v9 = v12:GetArgument(#v2)
			if v9 then
				local TextSegmentInProgress = v9.TextSegmentInProgress
				local v10 = false
				if v9.RawSegmentsAreAutocomplete then
					for i, v in ipairs(v9.RawSegments) do
						t[i] = { v, v }
					end
				else
					local v11, v122 = v9:GetAutocomplete()
					v10 = (v122 or {}).IsPartial or false
					for k, v in pairs(v11) do
						t[k] = { TextSegmentInProgress, v }
					end
				end
				local v14
				if #TextSegmentInProgress > 0 then
					local v15, v16 = v9:Validate()
					v14 = v15
					v8 = v16
				else
					v14 = true
				end
				if not v4 and v14 then
					Window:HideInvalidState()
				end
				local t2 = {}
				local v18, v19
				if v4 then
					v18, v19 = #p12 - #TextSegmentInProgress + if p12:sub(#p12, #p12):match("%s") then -1 else 0, t
				else
					v18 = v4
					v19 = t
				end
				t2.at = v18
				t2.prefix = #v9.RawSegments == 1 and v9.Prefix or ""
				t2.isLast = if #v12.Arguments == #v12.ArgumentDefinitions then #TextSegmentInProgress > 0 else false
				t2.numArgs = #v2
				t2.command = v12
				t2.arg = v9
				t2.name = v9.Name .. if v9.Required then "" else "?"
				t2.type = v9.Type.DisplayName
				t2.description = if v14 == false and v8 then v8 else v9.Object.Description
				t2.invalid = not v14
				t2.isPartial = v10
				return v1:Show(v19, t2)
			end
		elseif v3 and #v2 == 0 then
			Window:SetIsValidInput(true)
			local v27 = p1.Registry:GetCommand(v3)
			local v28 = nil
			if v27 then
				local v29 = v27.Args and v27.Args[1]
				if type(v29) == "function" then
					v29 = v29(v12)
				end
				if v29 and (not v29.Optional and v29.Default == nil) then
					Window:SetIsValidInput(false, "This command has required arguments.")
					Window:HideInvalidState()
				end
				v28 = {
					v27.Name,
					v27.Name,
					options = {
						name = v27.Name,
						description = v27.Description
					}
				}
			else
				Window:SetIsValidInput(false, ("%q is not a valid command name. Use the help command to see all available commands."):format(v3))
			end
			local t = { v28 }
			for k, v in pairs(p1.Registry:GetCommandNames()) do
				if v3:lower() == v:lower():sub(1, #v3) and (v28 == nil or v28[1] ~= v3) then
					local v31 = p1.Registry:GetCommand(v)
					t[#t + 1] = {
						v3,
						v,
						options = {
							name = v31.Name,
							description = v31.Description
						}
					}
				end
			end
			return v1:Show(t)
		end
		Window:SetIsValidInput(false, "Use the help command to see all available commands.")
		v1:Hide()
	end
	Window:UpdateLabel()
	Window:UpdateWindowHeight()
	return {
		Window = Window,
		AutoComplete = v1
	}
end