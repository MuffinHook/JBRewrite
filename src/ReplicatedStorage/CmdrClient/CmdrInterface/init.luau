-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
return function(p1)
	local Util = p1.Util
	local Window = require(script:WaitForChild("Window"))
	Window.Cmdr = p1
	local AutoComplete = require(script:WaitForChild("AutoComplete"))(p1)
	Window.AutoComplete = AutoComplete
	function Window.ProcessEntry(inputText)
		local TrimmedInput = Util.TrimString(inputText)
		if #TrimmedInput ~= 0 then
			Window:AddLine(Window:GetLabel() .. " " .. TrimmedInput, Color3.fromRGB(255, 223, 93))
			Window:AddLine(p1.Dispatcher:EvaluateAndRun(TrimmedInput, LocalPlayer, {
				IsHuman = true
			}))
		end
	end
	function Window.OnTextChanged(inputText)
		local EvalResult = p1.Dispatcher:Evaluate(inputText, LocalPlayer, true)
		local Args = Util.SplitString(inputText)
		local CommandName = table.remove(Args, 1)
		local ArgsMatch
		if EvalResult then
			local MashedArgs = Util.MashExcessArguments(Args, #EvalResult.Object.Args)
			if #MashedArgs == #EvalResult.Object.Args then
				Args = MashedArgs
				ArgsMatch = true
			else
				Args = MashedArgs
				ArgsMatch = false
			end
		else
			ArgsMatch = false
		end
		local HasTrailingSpace
		if inputText:sub(#inputText, #inputText):match("%s") and not ArgsMatch then
			Args[#Args + 1] = ""
			HasTrailingSpace = true
		end
		if EvalResult and HasTrailingSpace then
			local IsValid, ErrorMsg = EvalResult:Validate()
			Window:SetIsValidInput(IsValid, ("Validation errors: %s"):format(ErrorMsg or ""))
			local Suggestions = {}
			local CurrentArg = EvalResult:GetArgument(#Args)
			if CurrentArg then
				local TextSegmentInProgress = CurrentArg.TextSegmentInProgress
				local IsPartial = false
				if CurrentArg.RawSegmentsAreAutocomplete then
					for i, v in ipairs(CurrentArg.RawSegments) do
						Suggestions[i] = { v, v }
					end
				else
					local AutocompleteData, AutocompleteFlags = CurrentArg:GetAutocomplete()
					IsPartial = (AutocompleteFlags or {}).IsPartial or false
					for k, v in pairs(AutocompleteData) do
						Suggestions[k] = { TextSegmentInProgress, v }
					end
				end
				local ArgIsValid
				if #TextSegmentInProgress > 0 then
					local ArgValid, ArgErrorMsg = CurrentArg:Validate()
					ArgIsValid = ArgValid
					ErrorMsg = ArgErrorMsg
				else
					ArgIsValid = true
				end
				if not ArgsMatch and ArgIsValid then
					Window:HideInvalidState()
				end
				local SuggestionConfig = {}
				local CursorPos, SuggestionList
				if ArgsMatch then
					CursorPos, SuggestionList = #inputText - #TextSegmentInProgress + if inputText:sub(#inputText, #inputText):match("%s") then -1 else 0, Suggestions
				else
					CursorPos = ArgsMatch
					SuggestionList = Suggestions
				end
				SuggestionConfig.at = CursorPos
				SuggestionConfig.prefix = #CurrentArg.RawSegments == 1 and CurrentArg.Prefix or ""
				SuggestionConfig.isLast = if #EvalResult.Arguments == #EvalResult.ArgumentDefinitions then #TextSegmentInProgress > 0 else false
				SuggestionConfig.numArgs = #Args
				SuggestionConfig.command = EvalResult
				SuggestionConfig.arg = CurrentArg
				SuggestionConfig.name = CurrentArg.Name .. if CurrentArg.Required then "" else "?"
				SuggestionConfig.type = CurrentArg.Type.DisplayName
				SuggestionConfig.description = if ArgIsValid == false and ErrorMsg then ErrorMsg else CurrentArg.Object.Description
				SuggestionConfig.invalid = not ArgIsValid
				SuggestionConfig.isPartial = IsPartial
				return AutoComplete:Show(SuggestionList, SuggestionConfig)
			end
		elseif CommandName and #Args == 0 then
			Window:SetIsValidInput(true)
			local FoundCommand = p1.Registry:GetCommand(CommandName)
			local FirstArgSuggestion = nil
			if FoundCommand then
				local FirstArg = FoundCommand.Args and FoundCommand.Args[1]
				if type(FirstArg) == "function" then
					FirstArg = FirstArg(EvalResult)
				end
				if FirstArg and (not FirstArg.Optional and FirstArg.Default == nil) then
					Window:SetIsValidInput(false, "This command has required arguments.")
					Window:HideInvalidState()
				end
				FirstArgSuggestion = {
					FoundCommand.Name,
					FoundCommand.Name,
					options = {
						name = FoundCommand.Name,
						description = FoundCommand.Description
					}
				}
			else
				Window:SetIsValidInput(false, ("%q is not a valid command name. Use the help command to see all available commands."):format(CommandName))
			end
			local Suggestions = { FirstArgSuggestion }
			for k, v in pairs(p1.Registry:GetCommandNames()) do
				if CommandName:lower() == v:lower():sub(1, #CommandName) and (FirstArgSuggestion == nil or FirstArgSuggestion[1] ~= CommandName) then
					local MatchedCommand = p1.Registry:GetCommand(v)
					Suggestions[#Suggestions + 1] = {
						CommandName,
						v,
						options = {
							name = MatchedCommand.Name,
							description = MatchedCommand.Description
						}
					}
				end
			end
			return AutoComplete:Show(Suggestions)
		end
		Window:SetIsValidInput(false, "Use the help command to see all available commands.")
		AutoComplete:Hide()
	end
	Window:UpdateLabel()
	Window:UpdateWindowHeight()
	return {
		Window = Window,
		AutoComplete = AutoComplete
	}
end
