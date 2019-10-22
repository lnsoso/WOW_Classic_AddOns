local default_settings = {
	AutoInvite = {
		enabled			= true,
		keywords		= {'invite', 'inv'},
		guildmates		= true,
		friends			= true,
		other			= false,
		lastaoerank		= 0,
		promote_all		= false,
		promote_rank	= 0,
		promote_names	= {}
	},
	BidBot = {
		chatchannel		= "GUILD",
		withraidwarn	= false,
		minGebot		= 10,
		duration		= 30,
		output			= 4,
		bidtyp_open		= false,
		bidtyp_payall	= false
	},
	DKP = {
		grpandraid		= false,
		sb_as_raid		= true,
		time_event		= false,
		time_to_count	= 60,
		time_points		= 10,
		time_desc		= "Raid Attendance",
		boss_event		= true,
		boss_points		= 10,
		boss_desc		= "%s",
		start_event		= true,
		start_points	= 10,
		start_desc		= "Raid Start",
		working_in		= 0,
		items			= {},
		history			= {},
		lastevent		= 0
	},
	StandByBot = {
		send_whisper	= false,
		sb_users		= {},
		sb_times		= {},
		history			= {},
		log				= {}
	}
}
