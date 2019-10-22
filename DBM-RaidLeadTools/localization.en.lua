local L

-- StickyIcons
L = DBM:GetModLocalization("StickyIcons")

L:SetOptionLocalization({
	Enabled			= "Always set Raidicons back to as they where on combat start",
	IconsUpdateTime	= "How frequent should it check for icon updates?"
})

-- WarnForLootmaster
L = DBM:GetModLocalization("WarnForLootmaster")

L:SetOptionLocalization({
	Enabled	= "Show a warning on combat start if Masterloot is not enabled"
})

L:SetMiscLocalization({
	WarningNoLootmaster	= "Lootmaster is currently disabled! - Please enable Lootmaster now!"
})

-- AutoInvite
L = DBM:GetModLocalization("AutoInvite")

L:SetOptionLocalization({
	Enabled				= "Enable auto invite by keyword", -- Bool
	AllowGuildMates		= "Allow auto-invite from guild mates", -- Bool
	AllowFriends 		= "Allow auto-invite from friends", -- Bool
	AllowOthers 		= "Allow auto-invite from everyone", -- Bool
	PromoteEveryone		= "Promote all new player (not recommended)", -- Bool
	AOEbyGuildRank		= "Invite all players at or above this rank", -- Dropdown
	PromoteGuildRank	= "Promote by guild rank", -- Dropdown
	KeyWord 			= "Keyword to whisper for invite", -- Textbox
	PromoteByNameList	= "Auto-promote the following players (separate by space)", -- Textbox
	Button_AOE_Invite	= "AoE guild invite" -- Button
})

L:SetMiscLocalization({
	WarnMsg_NoRaid			= "Please create a raid group before using AoE-invite",
	WarnMsg_NotLead			= "Sorry, you have to be leader or promoted to use this command",
	WarnMsg_InviteIncoming	= "<DBM> AoE-invite incoming! Please leave your groups now.",
	WhisperMsg_RaidIsFull 	= "Sorry, I can't invite you. The raid is full.",
	WhisperMsg_NotLeader 	= "Sorry, I can't invite you. I'm not the group leader.",
	DontPromoteAnyRank		= "No auto-promote by guild rank",
	InviteFailed 			= "Can't invite player %s",
	ConvertRaid 			= "Converting group to raid"
})

-- BidBot
L = DBM:GetModLocalization("BidBot")

L:SetOptionLocalization({
	Enabled				= "Enable BidBot (!bid [item])", -- Bool
	Button_ShowClients	= "Show clients", -- Bool
	ShowinRaidWarn		= "Show Item as Raid Warning", -- Bool
	PublicBids			= "Post bids to chat for public bidding", -- Bool
	PayWhatYouBid		= "Pay price of bid, (otherwise second bid + 1)", --Bool
	ChatChannel			= "Chat to use for output", -- Dropdown
	MinBid				= "Minimum bid", -- Textbox
	Duration			= "Time to bid in sec (default 30)", -- Textbox
	OutputBids			= "How many top biddings to output (default top 3)", -- Textbox
})

L:SetMiscLocalization({
	WarnMsg_ChanNotFound	= "Unknown channel for: %s",
	Whisper_Queue 			= "Another auction is currently running. Your Item has been queued.",
	Whisper_Bid_OK 			= "Your bid of %d DKP was accepted.",
	Whisper_Bid_DEL			= "Your bid has been removed!",
	Whisper_Bid_DEL_failed	= "You can't delete bids in open bidding mode",
	Whisper_InUse 			= "<remove me>",
	Message_StartRaidWarn	= "Bid now on %s - whisper to [%s]!",
	Message_StartBidding	= "Please bid on %s now by whispering to [%s]! Lowest possible bid: %d",
	Message_DoBidding		= "Time remaining for %s: %d seconds.",
	Message_ItemGoesTo		= "%2$s won %1$s for %3$d DKP!",
	Message_NoBidMade		= "There was no bid on %s.",
	Message_Biddings		= "%d. %s bid %d DKP.",
	Message_BiddingsVisible	= "%d players bid on this item.",
	Message_BidPubMessage	= "New bid: %s bids %d DKP",
	Disenchant				= "Disenchant",
	PopUpAcceptDKP			= "Save bid for %s. For disenchant please type in 0 DKP.",
	Local_NoRaid			= "You have to be in a raid group to use this function",
	Prefix					= "[BidBot]: ",
	Local					= "only local output",
	Guild					= "use guild chat",
	Raid					= "use raid chat",
	Party					= "use party chat",
	Officer					= "use officer chat"
})

-- DKP
L = DBM:GetModLocalization("DKP")

L:SetOptionLocalization({
	Enabled					= "Enable DKP system to track raid events",
	Button_StartDKPTracking	= "Start DKP tracking", -- Button
	Button_StopDKPTracking	= "Stop DKP tracking", -- Button
	Button_CreateEvent		= "Create special event", -- Button
	Button_ResetHistory		= "Reset History", -- Button
	Enable_StarEvent		= "Create event on raid start", -- Button
	Enable_TimeEvents		= "Create events based on time (e.g. 1 event per hour)", -- Button
	Enable_BossEvents		= "Create events on boss kills", -- Button
	Enable_SB_Users			= "Count players on standby as raid members", -- Button
	Enable_5ppl_tracking	= "Enable DKP Tracking in 5ppl Instances", -- Button
	CustomPoint				= "Points to award", -- Textbox
	CustomDescription		= "Description for this event", -- Textbox
	StartPoints				= "Points on raid start", -- Textbox
	StartDescription		= "Description for raid start", -- Textbox
	BossPoints				= "Points per boss kill", -- Textbox
	BossDescription			= "Description for boss kills (%s is name of the boss)", -- Textbox
	TimePoints				= "Points per time event (e.g. 10 DKP per hour)", -- Textbox
	TimeDescription			= "Description for time events", -- Textbox
	TimeToCount				= "every X min", -- Textbox
	ChatChannel				= nil, -- Dropdown, missing?
})

L:SetMiscLocalization({
	Local_NoRaidPresent			= "Please join a raid group before starting the DKP tracker",
	Local_EventCreated			= "Your event was successfully created",
	Local_Debug_NoRaid			= "There are no players, event NOT created! Please create the event manually!",
	Local_TimeReached 			= "A new time-based raid event was created",
	Local_StartRaid				= "Started a new raid",
	Local_NoInformation			= "Please specify the points and the name for this event",
	LocalError_AddItemNoRaid	= "There is no raid running to save this Item",
	Local_RaidSaved				= "Successfully closed the current raid",
	CustomDefault				= "well played, fast run, extra dkp",
	AllPlayers					= "all players",
	History_Line				= "[%s][%s]: %s (%d)" -- [date][zone] Hogger (playercount)
})

-- StandByBot
L = DBM:GetModLocalization("StandByBot")

L:SetOptionLocalization({
	Enabled				= "Enable standby-bot (!sb)",
	SendWhispers		= "Send information whisper on Raidleave to players", -- Button
	Button_ShowClients	= "Show clients", -- Button
	Button_ResetHistory	= "Reset history", -- Button
})

L:SetMiscLocalization({
	Local_NoRaid		= "You have to be in a raid group to use this function",
	InRaidGroup			= "Sorry, but you have to leave the raid group before going standby.",
	LeftRaidGroup 		= "You have left our raid group. Please don't forget to whisper me \"!sb\" if you wan't to be standby.",
	AddedSBUser			= "You are now standby. Please stay available until we need you or removed from the SB-list.",
	UserIsAllreadySB	= "Sorry, you are already standby. To remove yourself from the list please whisper me \"!sb off\".",
	NoLongerStandby		= "You are no longer standby. Your were standby for %d hours and %d minutes.",
	PostStandybyList	= "Currently on standby:",
	Local_AddedPlayer	= "[SB]: %s is now standby.",
	Local_RemovedPlayer	= "[SB]: %s is no longer standby.",
	Local_CantRemove	= "Sorry, can't remove player.",
	Local_CleanList		= "SB list cleaned because (requested by %s)",
	Current_StandbyTime	= "Standby times from %s:",
	DateTimeFormat		= "%c",
	History_OnJoin		= "[%s]: %s is now SB",
	History_OnLeave		= "[%s]: %s leaves SB after %s min",
	SB_History_Saved	= "The standby-list was saved as ID %s.",
	SB_History_NotSaved	= "No player was standby --> no history was saved",
	SB_History_Line		= "[ID=%d] Raid at %s with %d members",
	SB_Documentation	= [[This standby module allows raid leaders to manage players who currently can't raid because of a full raid or something like this. All listed commands can be used in the guildchat.

!sb               - shows a list of standby players
!sb times         - shows the current standby times
!sb add <nick>    - adds a player to standby
!sb del <nick>    - removes a player from standby
!sb save          - saves the current status
!sb reset         - clears the standby list
!sb history [id]  - shows the standby history

Players who want to be standby have to whisper '!sb' to the player who is running this mod. A confirmation will be send to that player. To get off the standby-list they have to whisper '!sb off'.]]
})

-- PLEASE NEVER ADD THIS LINES OUTSIDE OF THE EN TRANSLATION, ADDON WILL BE BROKEN
L.DateFormat			= "%m/%d/%y %H:%M:%S"
L.Local_Version			= "%s: %s"