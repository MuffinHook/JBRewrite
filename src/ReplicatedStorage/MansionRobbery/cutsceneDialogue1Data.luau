local MansionRobberyConsts = require(script.Parent.MansionRobberyConsts)
local t = {
	{
		IsPlayer = true,
		Text = "There he is! Get him!",
		PauseDuration = 3,
		Events = { "IntroCurve" }
	},
	{
		IsBoss = true,
		Text = "CEO: Not so fast... you think you can stop me?",
		PauseDuration = 2,
		TURN_AROUND = true,
		GRAB_CAMERA = true
	},
	{
		IsPlayer = true,
		Text = "We have before, and we\'ll do it again!",
		PauseDuration = 2
	},
	{
		IsBoss = true,
		Text = "CEO: I\'ve rained meteors, volcano ash, even aliens onto your world. Now you\'ve walked right into my hands!",
		PauseDuration = 2.5
	},
	{
		IsPlayer = true,
		Text = "We\'ll never stop fighting for Jailbreak. Past, present, or future!",
		PauseDuration = 2.5
	},
	{
		IsBoss = true,
		Text = "CEO: You may have defeated my alien takeover...",
		PauseDuration = 2
	},
	{
		IsBoss = true,
		Text = "CEO: But you forgot to deal with me! Prepare to be eliminated!",
		PauseDuration = 2.5
	},
	{
		Text = "",
		PauseDuration = 0,
		NOW_END = true
	}
}
for v1, v2 in t do
	v2.Duration = v2.PauseDuration + utf8.len(v2.Text) / MansionRobberyConsts.CHAR_PER_SECOND
end
return t